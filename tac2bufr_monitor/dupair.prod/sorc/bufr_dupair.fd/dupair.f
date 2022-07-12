C$$$  MAIN PROGRAM DOCUMENTATION BLOCK
C
C MAIN PROGRAM: BUFR_DUPAIR
C   PRGMMR: KEYSER           ORG: NP22        DATE: 2013-08-22
C
C ABSTRACT: PROCESSES ANY COMBINATION UP TO FIVE DUMP FILES
C   CONTAINING AIRCRAFT (BUFR MESSAGE TYPE 004) REPORTS IN AIREP
C   FORMAT (SUBTYPE 001), PIREP FORMAT (SUBTYPE 002), AMDAR FORMAT
C   (SUBTYPE 003), E-ADAS (EUROPEAN AMDAR,SUBTYPE 006) AND/OR CANADIAN
C   AMDAR (SUBTYPE 009), PERFORMING A CROSS SUBTYPE DUP-CHECK BETWEEN
C   THE DIFFERENT TYPES. DOES NOT INCLUDE MDCRS ACARS IN SUBTYPE 004 OR
C   TAMDAR IN SUBTYPES 008, 010, 012 AND 013.  INFORMATION IS READ
C   SEPARATELY FROM EACH FILE THAT IS PRESENT, AND IS THEN COMBINED
C   INTO TABLES USED FOR THE DUP-CHECK.  VARIOUS OPTIONS ARE EXERCISED
C   IN IDENTIFYING DUPLICATES DEPENDING ON THE COMBINATION OF SUBTYPES
C   BEING COMPARED.  THE WORKING FILE NAMES OF THE ONE, TWO, THREE OR
C   FOUR INPUT DUMP FILES (IN EITHER THE "NEW" FORM x_ttt.sss, WHERE
C   ttt IS BUFR TYPE, sss IS BUFR SUBTYPE, AND x IS AN ORDERING INDEX;
C   OR THE "OLD" FORM ttt.sss) ARE READ FROM STANDARD INPUT (UNIT 5) AT
C   THE START OF THIS PROGRAM. THE OUTPUT DUP-CHECKED FILES WILL BE
C   WRITTEN TO THE SAME FILE NAMES.  ALL OTHER FILE CONNECTIONS ARE
C   MADE THROUGH THE FORTRAN OPEN STATEMENT.
C
C PROGRAM HISTORY LOG:
C 1997-01-22  J. WOOLLEN  ORIGINAL VERSION FOR IMPLEMENTATION
C 1999-06-03  D. KEYSER   MODIFIED TO PORT TO IBM SP AND RUN IN 4 OR
C     8 BYTE STORAGE
C 2002-03-05  D. KEYSER   IMPROVED DOCUMENTATION; IMPROVED STANDARD
C     OUTPUT PRINT; ADDED CALL TO COMPRESS_CHECK TO INDICATE IF INPUT/
C     OUTPUT FILES ARE COMPRESSED OR UNCOMPRESSED; ACCOUNTS FOR CHANGE
C     FROM MNEMONIC "ICLI" TO "BORG" {FOR BULLETIN BEING MONITORED
C     "CCCC" (BULLETIN LOCATION IDENTIFIER)} IN INPUT 004.001, 004.002
C     AND 004.003 WORKING DUMP FILES AFTER 5/2002 (WILL STILL WORK
C     PROPERLY FOR DUMP FILES PRIOR TO 5/2002)
C 2002-11-14  B. FACEY    INCREASED MXTB FROM 50000 TO 60000 TO
C     HANDLE LARGER VOLUMES OF AIRCRAFT DATA
C 2002-11-14  D. KEYSER   ADDED INLINE VERSION OF BUFRLIB ROUTINE
C     UFBTAB WHICH WILL NOT ABORT WHEN THERE ARE TOO MANY REPORTS
C     (> MXTB) INPUT - RATHER IT WILL JUST PROCESS MXTB REPORTS BUT
C     PRINT A DIAGNOSTIC (NOTE: THIS IS A TEMPORARY CHANGE UNTIL THE
C     NEXT VERSION OF THE BUFRLIB IS IMPLEMENTED WITH THE UPDATED
C     UFBTAB); OTHER MODIFICATIONS TO MAIN PROGRAM TO PREVENT ARRAY
C     OVERFLOW WHEN THERE ARE > MXTB REPORTS; IMPROVED DIAGNOSTIC
C     PRINT, ESP. WHEN > MXTB REPORTS; ADDED STATUS FILE IN UNIT 60
C     THAT IS WRITTEN TO ONLY WHEN THIS PROGRAM COMPLETES SUCCESSFULLY
C     (TRANSF. TO DUMPJB SCRIPT)
C 2003-09-02  D. KEYSER   ADDED FLEXIBILITY IN READING AND CHECKING
C     INPUT FILE NAMES; ADDED A FOURTH DUMP FILE TO BE CHECKED,
C     CONTAINING E-ADAS AIRCRAFT (004.006) WHICH HAS HIGH-ACCURACY LAT/
C     LON (CLATH/CLONH); REMOVED INLINE VERSION OF UFBTAB (CHANGES
C     NOTED IN PREVIOUS IMPLEMENTATION ARE NOW IN BUFRLIB VERSION);
C     REPLACED CALL TO IN-LINE SUBROUTINE COMPRESS_CHECK WITH CALL TO
C     NEW BUFRLIB ROUTINE MESGBC
C 2003-12-15  D. KEYSER   NO LONGER TESTS A WHAT FILE A REPORT IS IN TO
C     SEE IF IT SHOULD KEY ON HI-ACCURACY LAT/LON (CLATH/CLONH) IN
C     DUPLICATE CHECKS, RATHER JUST CHECKS IF FIRST SUBSET HAS MISSING
C     LOW-ACCURACY LAT (CLAT) - IF SO ASSUMES ALL REPORTS ENCODE CLATH/
C     CLONH - GENERALIZES THIS CHECK AND ALLOWS FOR REPORT TYPES WHICH
C     MAY CHANGE FROM CLAT/CLON TO CLATH/CLONH AT SOME POINT IN TIME
C     (AND WILL STILL WORK FOR HISTORICAL RUNS PRIOR TO CHANGEOVER)
C 2006-03-02  D. KEYSER   CHECKS TO SEE IF INPUT BUFR FILE(S) CONTAIN
C     "DUMMY" MESSAGES CONTAINING DUMP CENTER TIME AND PROCESSING TIME,
C     RESP. IN FIRST TWO MESSAGES OF INPUT FILE (AFTER TABLE MSGS) BY
C     CHECKING THE VALUE OF DUMPJB SCRIPT VARIABLE "DUMMY_MSGS" (READ
C     IN VIA "GETENV") - IF NOT WILL NOT PROCESS INPUT BUFR MESSAGES
C     WITH ZERO SUBSETS AND WILL CALL BUFRLIB ROUTINE CLOSMG WITH A
C     NEGATIVE UNIT NUMBER ARGUMENT PRIOR TO ALL PROCESSING IN ORDER TO
C     SIGNAL IT THAT ANY OUTPUT BUFR MESSAGES WITH ZERO SUBSETS SHOULD
C     BE SKIPPED (NOT WRITTEN OUT) - CODE HAD BEEN HARDWIRED TO ALWAYS
C     ASSUME DUMMY MESSAGES WERE IN THE INPUT FILE; MODIFIED TO HANDLE
C     PROCESSING OF CANADIAN AMDAR REPORTS WITH MESSAGE TYPE NC004009
C 2007-03-23  D. KEYSER   INTRODUCED ALLOCATABLE ARRAYS TO AVOID ARRAY
C     OVERFLOW PROBLEMS, DETERMINES SIZE OF ARRAYS BY CALLING UFBTAB
C     WITH NEGATIVE UNIT NUMBER TO SIMPLY COUNT SUBSETS
C 2012-11-20  J. WOOLLEN  INITIAL PORT TO WCOSS -- ADAPTED IBM/AIX
C     GETENV SUBPROGRAM CALL TO INTEL/LINUX SYNTAX
C 2013-01-13  J. WHITING  FINAL WCOSS PORT - UPDATED DOC BLOCKS; 
C     REPLACED TESTS VS BMISS WITH IBFMS FUNCTION; REPLACED EXPLICIT
C     ASSIGNMENT OF BMISS W/ GETBMISS() FUNCTION
C 2013-08-22  D. KEYSER   EXITS GRACEFULLY IF A TOTAL OF ZERO INPUT
C     SUBSETS (REPORTS) ARE READ IN (BEFORE COULD SEG FAULT)
C
C USAGE:
C   INPUT FILES:
C     UNIT 05  - STANDARD INPUT - RECORDS CONTAINING THE WORKING INPUT
C                FILE NAMES FOR ALL AIRCRAFT TYPES EVENTUALLY BEING
C                COMBINED INTO A SINGLE DUMP FILE (usually called
C                "aircft") - THE ONLY FILES NAMES CONSIDERED BY THIS
C                PROGRAM ARE *004.001 (AIREP FORMAT), *004.002 (PIREP
C                FORMAT, *004.003 (AMDAR FORMAT), *004.006 (E-ADAS) AND
C                *004.009 (CANADIAN AMDAR) - OTHER FILES MAY BE
C                INCLUDED HERE, BUT THEY WILL NOT BE MODIFIED BY THIS
C                PROGRAM; THE OUTPUT FILE NAMES WILL BE THE SAME AS THE
C                INPUT NAMES HERE
C     UNIT 20  - UNCHECKED BUFR FILE(S)
C
C   OUTPUT FILES:
C     UNIT 20  - DUPLICATE CHECKED BUFR FILE(S)
C     UNIT 50  - WORKSPACE (SCRATCH) FILE(S)
C     UNIT 60  - STATUS FILE WHOSE PRESENCE INDICATES THIS PROGRAM
C                COMPLETED SUCCESSFULLY
C
C   SUBPROGRAMS CALLED:
C     LIBRARY:
C       W3NCO    - W3TAGB  W3TAGE ERREXIT
C       W3EMC    - ORDERS
C       BUFRLIB  - DATELEN OPENBF COPYMG UFBTAB OPENMB COPYBF STATUS
C                  COPYSB  CLOSMG CLOSBF NEMTAB MESGBC IBFMS  GETBMISS
C
C   EXIT STATES:
C     COND =   0 - SUCCESSFUL RUN
C            > 0 - ABNORMAL RUN
C
C REMARKS: NONE.
C
C ATTRIBUTES:
C   LANGUAGE: FORTRAN 90
C   MACHINE:  WCOSS
C
C$$$
      PROGRAM BUFR_DUPAIR
 
      PARAMETER (MXTS=11)
      PARAMETER (NFILES=5)  ! Number of input files being considered
 
      REAL(8),ALLOCATABLE :: TAB_8(:,:)
      INTEGER,ALLOCATABLE :: IWORK(:)
      INTEGER,ALLOCATABLE :: IORD(:)
      INTEGER,ALLOCATABLE :: JDUP(:)

      REAL(8) UFBTAB_8,TAB7_8,tab1_8
      CHARACTER*80 TSTR,TSTRH,TSTR_N,TSTR_O,TSTRH_N,TSTRH_O,
     $ FILI(NFILES),FILO,FILE
      CHARACTER*8  SUBSET,CTAB7,ctab1
      CHARACTER*3  DUMMY_MSGS
      CHARACTER*1  CDUMMY


      DIMENSION    IMST(9)
      DIMENSION    NDUP(0:4),IPTR(2,NFILES)

      LOGICAL      DUPES,PIREP,AIRCFT

      EQUIVALENCE  (TAB7_8,CTAB7)
      EQUIVALENCE  (TAB1_8,CTAB1)

      DATA TSTR_N
     $ /'RPID CLAT  CLON  DAYS HOUR MINU BORG PSAL FLVL HEIT HMSL '/
      DATA TSTRH_N
     $ /'ACRN CLATH CLONH DAYS HOUR MINU BORG PSAL FLVL HEIT HMSL '/
      DATA TSTR_O
     $ /'RPID CLAT  CLON  DAYS HOUR MINU ICLI PSAL FLVL HEIT HMSL '/
      DATA TSTRH_O
     $ /'ACRN CLATH CLONH DAYS HOUR MINU ICLI PSAL FLVL HEIT HMSL '/

      DATA DEXY  / 1.5/
      DATA DDAY  / 0.0/
      DATA DRHR  / 0.2/
      DATA DELV  /10.0/

      DATA IMST  /   1,   2,   3, -99, -99,   4, -99, -99,   5/
 
C-----------------------------------------------------------------------
C-----------------------------------------------------------------------
      CALL W3TAGB('BUFR_DUPAIR',2013,0234,0054,'NP22')

      print *
      print * ,'---> Welcome to BUFR_DUPAIR - Version 08-22-2013'
      print *

      CALL DATELEN(10)

ccccc CALL OPENBF(0,'QUIET',2) ! Uncomment for extra print from bufrlib
 
C  ASSIGN DEFAULT VALUE FOR 'MISSING' TO LOCAL BMISS VARIABLE
C  ----------------------------------------------------------

      BMISS = GETBMISS()     ! assign default value for "missing"

C  SET THE COUNTERS TO INITIAL VALUES
C  ----------------------------------

      LUBFI = 20
      LUBFJ = 50

C  STORE THE FILENAMES TO PROCESS FROM STANDARD INPUT
C  --------------------------------------------------
 
      FILI(1:NFILES)(1:4) = 'NONE'

      AIRCFT = .FALSE.
 
1     CONTINUE

      READ(5,'(A80)',END=2) FILE
      DO  I=1,10
         IF(FILE(I:I+3).EQ.'004.') THEN
            READ(FILE(I+4:I+6),'(I3)') MST
            IF(MST.LE.3.OR.MST.EQ.6.OR.MST.EQ.9) THEN
               FILI(IMST(MST)) = FILE
               AIRCFT = .TRUE.
               PRINT *, ' >> WILL CHECK ',FILE(I:I+6)
            ENDIF
            EXIT
         ENDIF
      ENDDO
      GOTO 1

2     CONTINUE
      IF(.NOT.AIRCFT) THEN
         PRINT *
         PRINT *,'BUFR_DUPAIR: NO AIRCRAFT TO CHECK'
         PRINT *
         CALL W3TAGE('BUFR_DUPAIR')
         STOP
      ELSE
         PRINT 200, DEXY,DDAY,DRHR,DELV
  200 FORMAT(/'BUFR_DUPAIR PARAMETERS:'/
     .        3X,'TOLERANCE FOR LAT/LON CHECKS (IN DEGREES) .. ',F7.3/
     .        3X,'TOLERANCE FOR DAY CHECK (IN DAYS) .......... ',F7.3/
     .        3X,'TOLERANCE FOR HOUR CHECK (IN HOURS) ........ ',F7.3/
     .        3X,'TOLERANCE FOR ELEVATION CHECK (IN METERS) .. ',F7.3/)
      ENDIF
 
C  COUNT THE NUMBER OF SUBSETS AMONGST ALL FILES TO ALLOCATE SPACE
C  ---------------------------------------------------------------

      MXTB = 0
      DO I=1,NFILES
         IF(FILI(I)(1:4).EQ.'NONE') CYCLE
         CALL CLOSBF(LUBFI)
         OPEN(LUBFI,FILE=FILI(I),FORM='UNFORMATTED')
         CALL OPENBF(0,'QUIET',1) ! will generate diagnostic print if
                                  ! an embedded BUFR table is read
         CALL UFBTAB(-LUBFI,UFBTAB_8,1,1,NUM_SUBSETS,' ')
         CALL OPENBF(0,'QUIET',0) ! return to default wrt degree of prnt
         MXTB = MXTB + NUM_SUBSETS
      ENDDO

      ISUB = 0
      NTAB = 0

      IF(MXTB.EQ.0) THEN
         PRINT *
         PRINt *, '### WARNING: A total of ZERO input aircraft reports'
         PRINT *
         GO TO 400
      ENDIF

      ALLOCATE(TAB_8(MXTS,MXTB),STAT=I);IF(I.NE.0) GOTO 901
      ALLOCATE(IWORK(MXTB)     ,STAT=I);IF(I.NE.0) GOTO 901
      ALLOCATE(IORD(MXTB)      ,STAT=I);IF(I.NE.0) GOTO 901
      ALLOCATE(JDUP(MXTB)      ,STAT=I);IF(I.NE.0) GOTO 901

      TAB_8 = BMISS

C  MAKE A TABLE OUT OF THE LATS, LONS, HEIGHTS, AND TIME COORDINATES
C  -----------------------------------------------------------------
 
      IPTR = 0
      IPT  = 1

      DO I=1,NFILES
         IF(FILI(I)(1:4).NE.'NONE') THEN
            CALL CLOSBF(LUBFI)
            OPEN(LUBFI,FILE=FILI(I),FORM='UNFORMATTED')

            CALL MESGBC(LUBFI,MSGT,ICOMP)
            IF(ICOMP.EQ.1) THEN
               PRINT'(/"INPUT BUFR FILE",I2," MESSAGES   '//
     .          'C O M P R E S S E D"/"FIRST MESSAGE TYPE FOUND IS",'//
     .          'I5/)', I,MSGT
               PRINT'("#####BUFR_DUPAIR (UFBTAB) CANNOT PROCESS '//
     .            'COMPRESSED BUFR MESSAGES -- FATAL ERROR")'
               CALL W3TAGE('BUFR_DUPAIR')
               CALL ERREXIT(99)
            ELSE  IF(ICOMP.EQ.0) THEN
               PRINT'(/"INPUT BUFR FILE",I2," MESSAGES   '//
     .          'U N C O M P R E S S E D"/"FIRST MESSAGE TYPE FOUND '//
     .          'IS",I5/)', I,MSGT
            ELSE IF(ICOMP.EQ.-1) THEN
               PRINT'(//"ERROR READING INPUT BUFR FILE",I2," - '//
     .          'MESSAGE COMPRESSION UNKNOWN"/)', I
            ELSE  IF(ICOMP.EQ.-3) THEN
               PRINT'(/"INPUT BUFR FILE",I2," DOES NOT EXIST"/)', I
            ELSE  IF(ICOMP.EQ.-2) THEN
               PRINT'(/"INPUT BUFR FILE",I2," HAS NO DATA MESSAGES"/'//
     .          '"FIRST MESSAGE TYPE FOUND IS",I5/)', I,MSGT
            ENDIF

            CALL OPENBF(LUBFI,'IN',LUBFI)

C  Check to see if the new (post 5/2002) version of the mnemonic
C   table is being used here
C  -------------------------------------------------------------
      
            CALL STATUS(LUBFI,LUN,IDUMMY1,IDUMMY2)
            CALL NEMTAB(LUN,'BORG',IDUMMY1,CDUMMY,IRET) ! "BORG" is only
                                                        !  in new table
            CALL CLOSBF(LUBFI)
            OPEN(LUBFI,FILE=FILI(I),FORM='UNFORMATTED')
            IF(IRET.GT.0) THEN
               TSTR  = TSTR_N
               TSTRH = TSTRH_N
            ELSE
               TSTR  = TSTR_O
               TSTRH = TSTRH_O
            ENDIF

            CALL UFBTAB(LUBFI,TAB_8(1,IPT),MXTS,MXTB-IPT+1,NTAB,TSTR)
            IF(IBFMS(TAB_8(2,IPT)).EQ.1) THEN             ! data missing
               OPEN(LUBFI,FILE=FILI(I),FORM='UNFORMATTED')
              CALL UFBTAB(LUBFI,TAB_8(1,IPT),MXTS,MXTB-IPT+1,NTAB,TSTRH)
            ENDIF
            IPTR(1,I) = IPT
            IPTR(2,I) = IPT+NTAB-1
            IPT = IPT+NTAB
            if(I.eq.1.or.I.eq.2) then
              print *,'Number of rpts from file',I,'=',ntab
            end if
         ENDIF
      ENDDO

      NTAB = IPT-1
 
C  INITIAL VALUES FOR MARKERS AND COUNTERS AND CORRECTION INDICATORS
C  -----------------------------------------------------------------
 
      JDUP = 0
      NDUP = 0
 
      DO N=1,NTAB

         TAB_8(3,N) = MOD(TAB_8(3,N)+360.,360._8)

         IF(IBFMS(TAB_8(6,N)).EQ.1) TAB_8(6,N) = 0    ! data missing
         TAB_8(5,N) = TAB_8(5,N)+TAB_8(6,N)/60.

C  Find the height and store back in what was "MINU" slot
C  ------------------------------------------------------

         IF(IBFMS(TAB_8(8,N)).EQ.0) THEN               ! data not missing
            TAB_8(6,N) = TAB_8(8,N) ! PSAL - Height for AMDAR format
         ELSE  IF(IBFMS(TAB_8(9,N)).EQ.0) THEN         ! data not missing
            TAB_8(6,N) = TAB_8(9,N) ! FLVL - Height for AIREP/PIREP fmt
         ELSE  IF(IBFMS(TAB_8(10,N)).EQ.0) THEN        ! data not missing
            TAB_8(6,N) = TAB_8(10,N)! HEIT - 1st choice height for
                                    !        E-EDAS/CAN-AMDAR
                                    !        (currently missing)
         ELSE
            TAB_8(6,N) = TAB_8(11,N)! HMSL - 2nd choice height for
                                    !        E-EDAS/CAN-AMDAR
                                    !        (available) -- or --
                                    !        default if all are missing
         ENDIF

C  Store input file index back in what was "FLVL" slot
C  ---------------------------------------------------

         DO I=1,NFILES
            IF(N.GE.IPTR(1,I) .AND. N.LE.IPTR(2,I)) THEN
               TAB_8(9,N) = I
               EXIT
            ENDIF
         ENDDO

C  Store Carswell/Tinker/AFWA ind. back in what was "ICLI"/"BORG" slot
C  -------------------------------------------------------------------

         TAB7_8 = TAB_8(7,N)
         TAB_8(7,N) = 0.
         IF(CTAB7.EQ.'KAWN'.OR.CTAB7(1:4).EQ.'PHWR') THEN
            TAB_8(7,N) = 1.  ! Carswell/Tinker/AFWA indicator
C        ELSE
C           TAB_8(7,N) = 0.
         ENDIF
         if(tab_8(9,n).eq.1.and.tab_8(7,n).eq.1) then
           print *,'carswell-airep'
         end if

C  Store input file index back in what was "FLVL" slot
C  ---------------------------------------------------

C        DO I=1,NFILES
C           IF(N.GE.IPTR(1,I) .AND. N.LE.IPTR(2,I)) THEN
C              TAB_8(9,N) = I
C              EXIT
C           ENDIF
C        ENDDO
      ENDDO
 
C  GET A SORTED INDEX OF THE REPORTS BY HEIGHT, OB TIME, AND LON/LAT
C  -----------------------------------------------------------------
 
      CALL ORDERS( 2,IWORK,TAB_8(6,1),IORD,NTAB,MXTS,8,2) ! height
      CALL ORDERS(12,IWORK,TAB_8(5,1),IORD,NTAB,MXTS,8,2) ! hour
      CALL ORDERS(12,IWORK,TAB_8(4,1),IORD,NTAB,MXTS,8,2) ! day
      CALL ORDERS(12,IWORK,TAB_8(3,1),IORD,NTAB,MXTS,8,2) ! lon
      CALL ORDERS(12,IWORK,TAB_8(2,1),IORD,NTAB,MXTS,8,2) ! lat
 
C  GO THROUGH THE REPORTS IN ORDER, MARKING DUPLICATES
C  ---------------------------------------------------
 
      LOOP1: DO L=1,NTAB-1
         K = L+1
         I = IORD(L)
         J = IORD(L+1)
C        DO WHILE(NINT(ABS(TAB_8(2,I)-TAB_8(2,J))*100.).LE.
C    .    NINT(DEXY*100.) .AND. JDUP(I).EQ.0)
         DO WHILE(NINT(ABS(TAB_8(2,I)-TAB_8(2,J))*10000.).LE.
     .    NINT(DEXY*10000.) .AND. JDUP(I).EQ.0)
            DELL = MAX(.05_8,DEXY*MAX(TAB_8(7,I),TAB_8(7,J)))
C     IF(NINT(ABS(TAB_8(2,I)-TAB_8(2,J))*100.).LE.NINT(DELL*100.) .AND.
C    .   NINT(ABS(TAB_8(3,I)-TAB_8(3,J))*100.).LE.NINT(DELL*100.) .AND.
C    .   NINT(ABS(TAB_8(4,I)-TAB_8(4,J))*100.).LE.NINT(DDAY*100.) .AND.
C    .   NINT(ABS(TAB_8(5,I)-TAB_8(5,J))*100.).LE.NINT(DRHR*100.) .AND.
C    .   NINT(ABS(TAB_8(6,I)-TAB_8(6,J))*100.).LE.NINT(DELV*100.)) THEN
      IF(NINT(ABS(TAB_8(2,I)-TAB_8(2,J))*10000.).LE.NINT(DELL*10000.)
     ..AND.NINT(ABS(TAB_8(3,I)-TAB_8(3,J))*10000.).LE.NINT(DELL*10000.)
     ..AND.NINT(ABS(TAB_8(4,I)-TAB_8(4,J))*100.).LE.NINT(DDAY*100.)
     ..AND.NINT(ABS(TAB_8(5,I)-TAB_8(5,J))*10000.).LE.NINT(DRHR*10000.)
     ..AND.NINT(ABS(TAB_8(6,I)-TAB_8(6,J))*100.).LE.NINT(DELV*100.))
     .THEN
C              IF(TAB_8(7,I).EQ.1) JDUP(I) = 1  ! If duplicates, always
               IF(TAB_8(7,I).EQ.1) then
                 JDUP(I) = 1
                 if(tab_8(9,i).eq.1) then
                   TAB1_8 = TAB_8(1,i)
                   if(ctab1.eq.'QFA95'.or.ctab1.eq.'QFA17') then
                     print *,'Toss airep carswell i: ',ctab1,tab_8(9,j)
                     TAB1_8 = TAB_8(1,j)
                     print *,'rpt-j:',ctab1
                     print *,DELL,tab_8(2,i),tab_8(2,j)
                     print *,DELL,tab_8(3,i),tab_8(3,j)
                     print *,DDAY,tab_8(4,i),tab_8(4,j)
                     print *,DRHR,tab_8(5,i),tab_8(5,j)
                     print *,DELV,tab_8(6,i),tab_8(6,j)
                   end if
                 end if
                 tab1_8 = tab_8(1,i)
                 if(ctab1.eq.'AU0078') then
                   print *,'Toss AU0078 i: ',ctab1
                   tab1_8 = tab_8(1,j)
                   print *,'j: ',ctab1
                   print *,DELL,tab_8(2,i),tab_8(2,j)
                   print *,DELL,tab_8(3,i),tab_8(3,j)
                   print *,DDAY,tab_8(4,i),tab_8(4,j)
                   print *,DRHR,tab_8(5,i),tab_8(5,j)
                   print *,DELV,tab_8(6,i),tab_8(6,j)
                 end if
               end if
C              IF(JDUP(I).EQ.0)    JDUP(J) = 1  !  throw out Carswell/
               IF(JDUP(I).EQ.0) then
                 JDUP(J) = 1
                 if(tab_8(9,j).eq.1) then
                   TAB1_8 = TAB_8(1,j)
                   if(ctab1.eq.'QFA95'.or.ctab1.eq.'QFA17') then
                     print *,'Toss airep j: ',ctab1,tab_8(9,i)
                     TAB1_8 = TAB_8(1,i)
                     print *,'rpt-i:',ctab1
                     print *,DELL,tab_8(2,i),tab_8(2,j)
                     print *,DELL,tab_8(3,i),tab_8(3,j)
                     print *,DDAY,tab_8(4,i),tab_8(4,j)
                     print *,DRHR,tab_8(5,i),tab_8(5,j)
                     print *,DELV,tab_8(6,i),tab_8(6,j)
                   end if
                 end if
                 tab1_8 = tab_8(1,j)
                 if(ctab1.eq.'AU0078') then
                   print *,'Toss AU0078 j: ',ctab1
                   tab1_8 = tab_8(1,i)
                   print *,'i: ',ctab1
                   print *,DELL,tab_8(2,i),tab_8(2,j)
                   print *,DELL,tab_8(3,i),tab_8(3,j)
                   print *,DDAY,tab_8(4,i),tab_8(4,j)
                   print *,DRHR,tab_8(5,i),tab_8(5,j)
                   print *,DELV,tab_8(6,i),tab_8(6,j)
                 end if
               end if
            ENDIF                               !  Tinker/AFWA
            IF(K+1.GT.NTAB) CYCLE LOOP1
            J = IORD(K+1)
            K = K+1
         ENDDO
      ENDDO LOOP1
 
C  WRITE BACK THE DUP-CHECKED FILE(S)
C  ----------------------------------
 
      CALL GETENV('DUMMY_MSGS',DUMMY_MSGS)

      DO I=1,NFILES
         IF(FILI(I)(1:4).NE.'NONE') THEN
cpppppppppp
cc    idate_last = -9999
cpppppppppp
            FILO = '.'//FILI(I)
            ISUB = IPTR(1,I)-1
            CALL CLOSBF(LUBFI)
            CALL CLOSBF(LUBFJ)
            OPEN(LUBFI,FILE=FILI(I),FORM='UNFORMATTED')
            OPEN(LUBFJ,FILE=FILO   ,FORM='UNFORMATTED')
            CALL OPENBF(LUBFI,'IN ',LUBFI)
            CALL OPENBF(LUBFJ,'OUT',LUBFI)
 
C  If input file doesn't contain dummy center and dump time messages 1
C   and 2 (after table messages), before doing anything call closmg
C   with a negative unit number to signal routine that it should not
C   write out ANY messages with zero subsets in them - this holds for
C   all subsequent calls to closmg in this routine, even those done
C   through other bufrlib routines (and even for those calls where the
C   sign of the unit number is positive)
C  --------------------------------------------------------------------

            IF(DUMMY_MSGS.NE.'YES') CALL CLOSMG(-LUBFJ)

            DO WHILE(IREADMG(LUBFI,SUBSET,IDATE).EQ.0)
               NSUBS = NMSUB(LUBFI)
cpppppppppp
cc       print *, 'New message read in , NSUBS, IDATE = ',nsubs,idate
cpppppppppp

C  If no subsets in msg & dummy msgs not expected loop to next input msg
C  ---------------------------------------------------------------------

               IF(NSUBS.LE.0.AND.DUMMY_MSGS.NE.'YES')  CYCLE

               DUPES = .FALSE.

               IF(NSUBS.GT.0)  THEN
                  DO N=1,NSUBS
                     IF(ISUB+N.GT.NTAB) THEN
                        IDUP = 4
                     ELSE
                        IDUP = JDUP(ISUB+N)
                     ENDIF
                     NDUP(IDUP) = NDUP(IDUP)+1
                     IF(ISUB+N.LE.NTAB) THEN
                        IF(TAB_8(7,ISUB+N).EQ.1) NDUP(3) = NDUP(3)+1
                     ENDIF
                     IF(IDUP.GT.0) DUPES = .TRUE.
                  ENDDO
               ENDIF

cpppppppppp
cc    print *, 'DUPES = ',dupes
cpppppppppp

               IF(DUPES) THEN
                  CALL OPENMB(LUBFJ,SUBSET,IDATE)
cpppppppppp
cc             if(idate.ne.idate_last)
cc   $         print *, 'NEW MESSAGE OPENED'
cc             idate_last = idate
cpppppppppp
                  DO WHILE(IFBGET(LUBFI).EQ.0)
                     ISUB = ISUB+1
                     IF(ISUB.GT.NTAB) THEN
                        IDUP = 4
                     ELSE
                        IDUP = JDUP(ISUB)
                     ENDIF
                     IF(IDUP.EQ.0) THEN
                        CALL COPYSB(LUBFI,LUBFJ,IRET) ! Copy non-dups
                     ELSE
                        IF(ISUB.LE.NTAB) THEN
                           IF(TAB_8(7,ISUB).EQ.1) NDUP(2) = NDUP(2) + 1
                        ENDIF
                        CALL COPYSB(LUBFI,00000,IRET) ! Skip dups
                     ENDIF
                  ENDDO
               ELSE

C  In the event that the input file contains dummy center and dump time
C    messages 1 and 2 (after table messages), call closmg with a
C    positive unit number to signal routine that it should write out
C    these messages even though they have zero subsets in them
C  If the input file does not contain dummy messages, a positive unit
C    number here is immaterial because closmg was already called with
C    a negative unit number immediately after the output file was
C    opened (and this holds for all subsequent calls to closmg
C    regardless of the sign of the unit number)
C  -------------------------------------------------------------------

                  CALL CLOSMG(LUBFJ)
                  CALL COPYMG(LUBFI,LUBFJ)
                  ISUB = ISUB+NSUBS
               ENDIF
            ENDDO

            CALL CLOSBF(LUBFI)
            CALL CLOSBF(LUBFJ)
            OPEN(LUBFI,FILE=FILI(I),FORM='UNFORMATTED')
            OPEN(LUBFJ,FILE=FILO   ,FORM='UNFORMATTED')
            CALL COPYBF(LUBFJ,LUBFI)
            OPEN(LUBFI,FILE=FILI(I),FORM='UNFORMATTED')

            CALL MESGBC(LUBFI,MSGT,ICOMP)
            IF(ICOMP.EQ.1) THEN
               PRINT'(/"OUTPUT BUFR FILE",I2," MESSAGES   '//
     .          'C O M P R E S S E D"/"FIRST MESSAGE TYPE FOUND IS",'//
     .          'I5/)', I,MSGT
            ELSE  IF(ICOMP.EQ.0) THEN
               PRINT'(/"OUTPUT BUFR FILE",I2," MESSAGES   '//
     .          'U N C O M P R E S S E D"/"FIRST MESSAGE TYPE FOUND '//
     .          'IS",I5/)', I,MSGT
            ELSE IF(ICOMP.EQ.-1) THEN
               PRINT'(//"ERROR READING OUTPUT BUFR FILE",I2," - '//
     .          'MESSAGE COMPRESSION UNKNOWN"/)', I
            ELSE  IF(ICOMP.EQ.-3) THEN
               PRINT'(/"OUTPUT BUFR FILE",I2," DOES NOT EXIST"/)', I
            ELSE  IF(ICOMP.EQ.-2) THEN
               PRINT'(/"OUTPUT BUFR FILE",I2," HAS NO DATA MESSAGES"/'//
     .          '"FIRST MESSAGE TYPE FOUND IS",I5/)', I,MSGT
            ENDIF

            CLOSE(LUBFI)
         ENDIF
      ENDDO

 400  CONTINUE

C  GENERATE REPORT
C  ---------------
 
      PRINT 300, ISUB,NDUP(4),MXTB,NTAB,NDUP(3),NDUP(0),NDUP(1),
     .           NDUP(2),NDUP(1)-NDUP(2)
  300 FORMAT(/'BUFR_DUPAIR READ IN A TOTAL OF',I8,' REPORTS'/
     .        ' A TOTAL OF ',I7,' REPORTS WERE SKIPPED DUE TO BEING ',
     .        'OVER THE LIMIT OF ',I7/
     .        'BUFR_DUPAIR CHECKED A TOTAL OF',I8,' REPORTS'/
     .        '   THESE INCLUDE ',I8,' CARSWELL/TINKER/AFWA REPORTS'//
     .        'NUMBER OF UNIQUE REPORTS WRITTEN OUT ...........',I7/
     .        'NUMBER OF REPORTS SKIPPED DUE TO:'/
     .        '   FAILING DUPLICATE CHECK (ALL SOURCES) .......',I7/
     .        '      CARSWELL/TINKER/AFWA .....................',I7/
     .        '      NON-CARSWELL/TINKER/AFWA .................',I7/)

C  END OF PROGRAM
C  --------------

      WRITE(60,'("ALL DONE")')
      CALL W3TAGE('BUFR_DUPAIR')
      STOP

C  ERROR EXITS
C  -----------

  901 CONTINUE

      PRINT *, '#####BUFR_DUPAIR - UNABLE TO ALLOCATE ARRAYS'
      CALL W3TAGE('BUFR_DUPAIR')
      CALL ERREXIT(99)

      END

