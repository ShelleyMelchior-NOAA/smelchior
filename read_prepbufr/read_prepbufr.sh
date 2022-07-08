
### TRANSITIONED TO WCOSS

###################################################################r
#
#  Driver script to list reports in PREPBUFR file
#
#  Takes 2 input arguments:
#      1 - Full path to PREPBUFR file you want to process
#      2 - Message type you want to process, choices are:
#           ADPUPA  -- process reports in ADPUPA message type (only)
#           AIRCAR  -- process reports in AIRCAR message type (only)
#           AIRCFT  -- process reports in AIRCFT message type (only)
#           SATWND  -- process reports in SATWND message type (only)
#           PROFLR  -- process reports in PROFLR message type (only)
#           VADWND  -- process reports in VADWND message type (only)
#           RASSDA  -- process reports in RASSDA message type (only)
#           SATEMP  -- process reports in SATEMP message type (only)
#           ADPSFC  -- process reports in ADPSFC message type (only)
#           SFCSHP  -- process reports in SFCSHP message type (only)
#           SFCBOG  -- process reports in SFCBOG message type (only)
#           MSONET  -- process reports in MSONET message type (only)
#           SPSSMI  -- process reports in SPSSMI message type (only)
#           SYNDAT  -- process reports in SYNDAT message type (only)
#           ERS1DA  -- process reports in ERS1DA message type (only)
#           GOESND  -- process reports in GOESND message type (only)
#           QKSWND  -- process reports in QKSWND message type (only)
#           WDSATR  -- process reports in WDSATR message type (only)
#           GPSIPW  -- process reports in GPSIPW message type (only)
#           ASCATW  -- process reports in ASCATW message type (only)
#           ALL     -- process reports in ALL message types
#
####################################################################

set -x

test $# -ne 2 && exit
stmp_root=/stmpp1
DATA=$stmp_root/$USER/read_prepbufr.$2
mkdir -p $DATA
cd $DATA
errcd=$?
[ $errcd -eq 0 ]  &&  rm *

#######################################################################

set +x
cat <<\inputEOF > read_prepbufr.f
C$$$  MAIN PROGRAM DOCUMENTATION BLOCK
C  
C MAIN PROGRAM:  READ_PREPBUFR
C   PRGMMR: KEYSER           ORG: NP22        DATE: 2013-02-01
C
C ABSTRACT: READS SUBSETS (REPORTS) FROM A PREPBUFR FILE, MERGING
C   MASS AND WIND SUBSETS FROM THE SAME ORIGINAL REPORT.  MERGED
C   REPORTS ARE PARSED ACCORDING TO THEIR BUFR MESSAGE TYPE AND
C   ARE LISTED IN OUTPUT TEXT FILES.
C
C PROGRAM HISTORY LOG:
C ????-??-??  WOOLLEN/GSC ORIGINAL AUTHOR
C ????-??-??  ATOR        STREAMLINED AND DOCUMENTED
C 2001-10-26  KEYSER      FURTHER DOCUMENTATION FOR WEB, UPDATED
C                         TO REPLACE OBSOLETE MESSAGE TYPE "SATBOG"
C                         WITH "QKSWND"; ADDED MORE VARAIBLES AND
C                         MANY OTHER UPDATES
C 2002-01-28  KEYSER      NOW THAT "PCAT" (PRECISION OF TEMPERATURE
C                         OBS.) HAS BEEN ADDED TO PREPBUFR FILE FOR
C                         "AIRCFT" AND "AIRCAR" MESSAGE TYPES, ADDED
C                         THIS TO LISTING
C 2003-07-11  KEYSER      ADDED MESONET DATA IN NEW MESSAGE TYPE
C                         "MSONET"; ADDED GPS-IPW DATA IN NEW MESSAGE
C                         TYPE "GPSIPW"; ADDED RASS DATA IN NEW MESSAGE
C                         TYPE "RASSDA"; NOW THAT "ACID" (AIRCRAFT
C                         FLIGHT NUMBER) HAS BEEN ADDED TO PREPBUFR
C                         FILE FOR "AIRCAR" MESSAGE TYPES, ADDED THIS
C                         TO LISTING; ADDED PRINT EACH TIME A NEW INPUT
C                         BUFR MESSAGE IS OPENED FOR SELECTED TYPE(S),
C                         WHICH INCLUDES SEC. 1 DATA CATEGORY AND
C                         SUB-CATEGORY; NOW THAT "RSRD" (RESTRICTIONS
C                         ON REDISTRIBUTION) AND "EXPRSRD" (EXPIRATION
C                         OF RESTRICTIONS ON REDISTRIBUTION) HAS BEEN
C                         ADDED TO PREPBUFR FILE, ADDED THIS TO LISTING
C                         (BUT ONLY IF THERE IS A RESTRICTION, I.E.,
C                         NOT ZERO OR NOT MISSING); MODIFIED LOCATION
C                         WHERE KEY AND NEW INPUT BUFR MESSAGE INFO
C                         IS PRINTED (IN NEW SUBROUTINE PRINT_KEY AND
C                         ITS ENTRY PRINT_READ)
C 2004-01-22  KEYSER      THE MESSAGE TYPE TO BE PROCESSED IS NOW READ
C                         IN FROM STANDARD INPUT (E.G., "ADPUPA" FOR
C                         ADPUPA MESSAGES TYPES), ALL MESSAGE TYPES
C                         ARE PROCESSED IF "ALL" IS READ IN FROM STDIN
C 2004-04-22  KEYSER      ADDED UNITS TO LISTING OF OBS. ERRORS;
C                         CHANGED MOISTURE OBS. ERROR TO BE WHOLE %
C                         (RH) INSTEAD OF % DIVIDED BY 10 AS IT IS
C                         IN PREPBUFR FILE
C 2005-12-14  KEYSER      NOW THAT "ACID" (AIRCRAFT FLIGHT NUMBER),
C                         "TRBX" (TURBULENCE INDEX) AND "ROLF"
C                         (AIRCRAFT ROLL ANGLE FLAG) HAVE BEEN ADDED TO
C                         PREPBUFR FILE FOR "AIRCFT" MESSAGE TYPES
C                         (SPECIFICALLY FOR TAMDAR), ADDED THESE TO
C                         LISTING
C 2013-02-01  KEYSER      TRANSITIONED TO WCOSS; UPDATED TO HANDLE NEW
C                         NRL VERSION OF PREPOBS_PREPACQC; OTHER
C                         EHANCEMENTS
C
C
C USAGE:
C   INPUT FILES:
C     UNIT 05  - STANDARD INPUT INDICATING WHICH MESSAGE TYPE TO
C                PROCESS:
C                    ADPUPA  -- PROCESS ONLY REPORTS IN ADPUPA
C                               MESSAGE TYPE
C                    ADPSFC  -- PROCESS ONLY REPORTS IN ADPSFC
C                               MESSAGE TYPE
C
C                       -- etc --
C
C                    ALL     -- PROCESS ALL MESSAGE TYPES
C
C     UNIT 11  - PREPBUFR FILE
C
C   OUTPUT FILES: 
C     UNIT 06  - UNIT 6 (STANDARD PRINTFILE)
C     UNIT 51  - LISTING OF REPORTS IN MESSAGE TYPE "ADPUPA"
C     UNIT 52  - LISTING OF REPORTS IN MESSAGE TYPE "AIRCAR"
C     UNIT 53  - LISTING OF REPORTS IN MESSAGE TYPE "AIRCFT"
C     UNIT 54  - LISTING OF REPORTS IN MESSAGE TYPE "SATWND"
C     UNIT 55  - LISTING OF REPORTS IN MESSAGE TYPE "PROFLR"
C     UNIT 56  - LISTING OF REPORTS IN MESSAGE TYPE "VADWND"
C     UNIT 57  - LISTING OF REPORTS IN MESSAGE TYPE "RASSDA"
C     UNIT 58  - LISTING OF REPORTS IN MESSAGE TYPE "SATEMP"
C     UNIT 59  - LISTING OF REPORTS IN MESSAGE TYPE "ADPSFC"
C     UNIT 60  - LISTING OF REPORTS IN MESSAGE TYPE "SFCSHP"
C     UNIT 61  - LISTING OF REPORTS IN MESSAGE TYPE "SFCBOG"
C     UNIT 62  - LISTING OF REPORTS IN MESSAGE TYPE "MSONET"
C     UNIT 63  - LISTING OF REPORTS IN MESSAGE TYPE "SPSSMI"
C     UNIT 64  - LISTING OF REPORTS IN MESSAGE TYPE "SYNDAT"
C     UNIT 65  - LISTING OF REPORTS IN MESSAGE TYPE "ERS1DA"
C     UNIT 66  - LISTING OF REPORTS IN MESSAGE TYPE "GOESND"
C     UNIT 67  - LISTING OF REPORTS IN MESSAGE TYPE "QKSWND"
C     UNIT 68  - LISTING OF REPORTS IN MESSAGE TYPE "GPSIPW"
C     UNIT 69  - LISTING OF REPORTS IN MESSAGE TYPE "WDSATR"
C     UNIT 70  - LISTING OF REPORTS IN MESSAGE TYPE "ASCATW"
C
C   SUBPROGRAMS CALLED:
C     UNIQUE:    - READPB     PRINT_KEY  PRINT_READ INDEXF
C     LIBRARY:
C       W3NCO    - ERREXIT
C       BUFR     - OPENBF     DATELEN    READNS     UFBINT     UFBEVN
C                  UFBEVN     UFBQCP     STATUS     IUPBS1     UPFTBV
C                  SETBMISS   GETBMISS   IBFMS      ICBFMS
C
C   EXIT STATES:
C     COND =   0 - SUCCESSFUL RUN
C             22 - ABORT, NUMBER OF PROFILE TIME/LOCATION (E.G.,
C                  BALLOON DRIFT) LEVELS RETURNED DOES NOT EQUAL NUMBER
C                  OF P/T/Z/Q/U/V LEVELS RETURNED (ADPUPA, AIRCAR AND
C                  AIRCFT MESSAGE TYPES ONLY) (UNLESS NUMBER OF PROFILE
C                  TIME/LOCATION LEVELS = 0 - ALLOWS FOR HISTORICAL
C                  CASES OR PRE-NRLACQC CASES TO RUN PROPERLY)
C             33 - ABORT, NUMBER OF VIRTUAL TEMP./DEWPOINT TEMP.
C                  LEVELS RETURNED DOES NOT EQUAL NUMBER OF
C                  P/T/Z/Q/U/V LEVELS RETURNED (ADPUPA MESSAGE
C                  TYPE ONLY)
C             44 - ABORT, NUMBER OF SUPPLEMENTAL OBS3 LEVELS
C                  RETURNED FROM MASS(WIND) PIECE DOES NOT EQUAL
C                  NUMBER RETURNED FROM WIND(MASS) PIECE OF SAME
C                  REPORT WHEN NEITHER ARE ZERO
C             55 - ABORT, NUMBER OF ANCILLARY AIRCAR LEVELS
C                  RETURNED DOES NOT EQUAL NUMBER OF P/T/Z/Q/U/V
C                  LEVELS RETURNED (AIRCAR MESSAGE TYPE ONLY)
C                  (UNLESS NUMBER OF ANCILLARY AIRCAR LEVELS = 0
C                  - ALLOWS FOR HISTORICAL CASES TO RUN PROPERLY)
C             66 - ABORT, NUMBER OF ANCILLARY AIRCFT LEVELS
C                  RETURNED DOES NOT EQUAL NUMBER OF P/T/Z/Q/U/V
C                  LEVELS RETURNED (AIRCFT MESSAGE TYPE ONLY)
C                  (UNLESS NUMBER OF ANCILLARY AIRCFT LEVELS = 0
C                  - ALLOWS FOR HISTORICAL CASES TO RUN PROPERLY)
C
C REMARKS: IN THIS PROGRAM, THE TERM "SUBSET" REFERS TO THE
C   COMPONENTS IN A BUFR MESSAGE.  THESE COULD BE CONSIDERED TO
C   BE "REPORTS" IN THE PREPBUFR FILE.  HERE, "REPORT" IS USED TO
C   REFER TO THE FINAL PRODUCT WHICH CONTAINS MERGED MASS AND WIND
C   SUBSETS FROM THE SAME ORIGINAL OBSERVATION.
C
C ATTRIBUTES:
C   LANGUAGE: FORTRAN 90
C   MACHINE:  NCEP WCOSS
C
C$$$

      PROGRAM   READ_PREPBUFR

      PARAMETER ( NHR8PM = 14 )    ! Actual number of BUFR parameters
                                   !  in header
      PARAMETER ( MXR8PM =  8 )    ! Maximum number of BUFR parameters
                                   !  in level data (non-radiance) or
                                   !  in channel data (radiance)
      PARAMETER ( MXR8LV = 255 )   ! Maximum number of BUFR levels/
                                   !                        channels
      PARAMETER ( MXR8VN = 10 )    ! Max. number of BUFR event sequences
                                   !  (non-radiance reports)
      PARAMETER ( MXR8VT = 17)     ! Max. number of BUFR variable types
                                   !  (non-radiance reports)

      REAL*8    hdr_8 ( NHR8PM ), obs2_8(61), aircar_hdr_8,
     +          aircft_hdr_8, adpupa_hdr_8, goesnd1_hdr_8(5),
     +          goesnd2_hdr_8(MXR8LV), adpsfc_hdr_8(4), sfcshp_hdr_8(2),
     +          msonet_hdr_8(2), satwnd_hdr_8(5), gpsipw_hdr_8,
     +          evns_8 ( MXR8PM, MXR8LV, MXR8VN, MXR8VT ),
     +          drft_8 ( 3, MXR8LV ), brts_8 ( MXR8PM, MXR8LV ),
     +          toth_8 ( 2, MXR8LV ), acars_sup_8( 8, MXR8LV ),
     +          aircft_sup_8( 7, MXR8LV ), obs3_8(5,MXR8LV,7)

      REAL(8)   BMISS,GETBMISS,xminimum_8

      INTEGER   indxvr1 ( 100:539 ),
     +          indxvr2 ( 100:539 ),
     +          nobs3(7), ibit(31)

      CHARACTER    msgtyp*8, qc_step*8
      CHARACTER*5  erruntp, errunt ( MXR8VT )
      CHARACTER*11 c_nrlqms
      CHARACTER*18 var ( MXR8VT )

      COMMON  / PREPBC /      hdr_8, obs2_8, obs3_8, evns_8, drft_8,
     +  toth_8, acars_sup_8, aircft_sup_8, brts_8, aircar_hdr_8,
     +  aircft_hdr_8, adpupa_hdr_8, goesnd1_hdr_8, goesnd2_hdr_8,
     +  adpsfc_hdr_8, sfcshp_hdr_8, msonet_hdr_8, satwnd_hdr_8,
     +  gpsipw_hdr_8, indxvr1, indxvr2, nlev, nchn, nobs3, c_nrlqms

      COMMON /BUFRLIB_MISSING/BMISS

      DATA         var /
     +  'PRESSURE (MB)     ','SP HUMIDITY(MG/KG)','TEMPERATURE (C)   ',
     +  'HEIGHT (METERS)   ','U-COMP WIND (M/S) ','V-COMP WIND (M/S) ',
     +  'WIND DIR (DEG)    ','WIND SPEED (KNOTS)','TOTAL PWATER (MM) ',
     +  'RAIN RATE (MM/HR) ','1.-.9 sig PWAT(MM)','.9-.7 sig PWAT(MM)',
     +  '.7-.3 sig PWAT(MM)','.3-0. sig PWAT(MM)','CLOUD-TOP PRES(MB)',
     +  'CLOUD-TOP TEMP (K)','TOT. CLD. COVER(%)' /
      DATA         errunt /
     +  'mb   ','%(RH)','C    ','m    ','m/s  ','m/s  ','     ','     ',
     +  'mm   ','     ','     ','     ','     ','     ','     ','     ',
     +  '     ' /

C-----------------------------------------------------------------------

C  On WCOSS should always set BUFRLIB missing (BMISS) to 10E8 to avoid
C   overflow when either an INTEGER*4 variable is set to BMISS or a
C   REAL*8 (or REAL*4) variable that is missing is NINT'd
C  -------------------------------------------------------------------
ccccc CALL SETBMISS(10E10_8)
      CALL SETBMISS(10E8_8)
      BMISS=GETBMISS()
      print *
      print *, 'BUFRLIB value for missing is: ',bmiss
      print *

C       Open the input PREPBUFR file.
C       -----------------------------

      OPEN  ( UNIT = 11, FILE = 'prepbufr.in', FORM = 'UNFORMATTED' )
      CALL OPENBF(11,'IN',11 )  ! BUFRLIB routine to open file
      CALL DATELEN(10)  ! BUFRLIB routine to use 10-digit date

C       Get the next subset from the input file.  Merge mass and
C        wind subsets for the same "true" report.
C       --------------------------------------------------------

  10  CONTINUE
      CALL READPB(11,iuno,msgtyp,ierrpb )
cppppppppppppppp
ccc   print *, 'ierrpb returned from READPB = ',ierrpb
cppppppppppppppp
      IF ( ierrpb .eq. -1 )  THEN
          print *, '1-All subsets read in and processed'
          STOP      ! All subsets read in and processed
      END IF

cppppppppppppppp
ccc      print *, 'HDR_8 :',hdr_8
cppppppppppppppp
      WRITE  ( UNIT = iuno,
     + FMT = '(/"SID=",A8,", YOB=",F6.2,", XOB=",F6.2,", ELV=",I5,' //
     + '", DHR=",F8.5,", RPT=",F10.5,", TCOR=",I1,", TYP=",I3,' //
     + '", TSB=",I5,", T29=",I3,", ITP=",I3/,"SQN=",I6,", PROCN=",I2,'//
     + '", SAID=",I3)')
     + (hdr_8(ii),ii=1,3),nint(hdr_8(4)),hdr_8(5),hdr_8(6),
     + (nint(hdr_8(ii)),ii=7,14)

      IF (msgtyp .eq. 'ADPUPA' .or. msgtyp .eq. 'AIRCFT') then
         IF (msgtyp .eq. 'ADPUPA' ) then
            WRITE  ( UNIT = iuno, FMT = '("SIRC=",I2)')
     +       nint(adpupa_hdr_8)
cxxxxxvvvvv
            xminimum_8 = MIN(obs2_8(1),obs2_8(2),obs2_8(4),obs2_8(41),
     +       obs2_8(24))
            IF(ibfms(xminimum_8).eq.0) write(iuno,1134)
     +       (NINT(obs2_8(I)),I=1,2),obs2_8(4),NINT(obs2_8(41)),
     +       NINT(obs2_8(24))
 1134 FORMAT(' RSRD=',I3,', EXPRSRD=',I3,', SST1=',F6.2,', SSTQM=',I2,
     +       ', HBLCS=',I2)
            xminimum_8 = MIN(obs2_8(27),obs2_8(28))
            IF(ibfms(xminimum_8).eq.0) write(iuno,1154)
     +       NINT(obs2_8(27)),obs2_8(28)
 1154 FORMAT(' WDIR1=',I3,', WSPD1=',F5.1)
cxxxxxaaaaa
         ELSE IF (msgtyp .eq. 'AIRCFT' ) then
            IF (obs2_8(1) .gt. 0 .and. ibfms(obs2_8(1)) .eq. 0 )  WRITE
     +       ( UNIT = iuno, FMT = '("RSRD=",I6,", EXPRSRD=",I6)')
     +       (nint(obs2_8(ii)),ii=1,2)
            WRITE  ( UNIT = iuno, FMT = '("ACID=",A8,", NRLQMS=''",A11,
     +       "''")')
     +        aircft_hdr_8,c_nrlqms
         END IF
cxxxxxvvvvv
         if(nobs3(2).gt.0) then
            if(nobs3(2).eq.1) then
               if(ibfms(obs3_8(1,1,2)).ne.0) go to 402
               JNDX = 1
               write(iuno,1136) (J,NINT(obs3_8(1,J,2)),J=1,1)
            ELSE
               DO K = 1,nobs3(2),8
                  DO L = 8,2,-1
                     IF(K+(L-1).LE.nobs3(2))  THEN
                        JNDX = L
                        write(iuno,1136)
     +                   (J,NINT(obs3_8(1,J,2)),J=K,K+(L-1))
                        EXIT
                     END IF
                  ENDDO
               ENDDO
            END IF
 1136 FORMAT(<JNDX>(' L',I1,': PRWE=',I3,' |'))
         end if
  402    continue
         if(nobs3(3).gt.0) then
            if(nobs3(3).eq.1) then
               xminimum_8 = min(obs3_8(2,1,3),obs3_8(3,1,3),
     +          obs3_8(4,1,3),obs3_8(5,1,3))
            if(ibfms(xminimum_8).ne.0) go to 403
            end if
            DO K = 1,nobs3(3),2
               IF(K+1.LE.nobs3(3))  THEN
                  JNDX = 2
                  write(iuno,1137) (J,(NINT(obs3_8(I,J,3)),I=2,5),
     +             J=K,K+1)
               ELSE
                  JNDX = 1
                  write(iuno,1137) (J,(NINT(obs3_8(I,J,3)),I=2,5),J=K,K)
               END IF
 1137 FORMAT(<JNDX>(' L',I1,': CLAM=',I2,', CLTP=',I2,', HOCB=',I5,
     + ', HOCT=',I5,' |'))
            ENDDO
         end if
  403    continue
         if(nobs3(6).gt.0) then
            if(nobs3(6).eq.1) then
               xminimum_8 = min(obs3_8(1,1,6),obs3_8(2,1,6),
     +         obs3_8(3,1,6))
               if(ibfms(xminimum_8).ne.0) go to 406
               JNDX = 1
               write(iuno,4136) (J,NINT(obs3_8(1,J,6)),
     +          NINT(obs3_8(2,J,6)),NINT(obs3_8(3,J,6)),J=1,1)
            ELSE
               DO K = 1,nobs3(6),3
                  DO L = 3,2,-1
                     IF(K+(L-1).LE.nobs3(6))  THEN
                        JNDX = L
                        write(iuno,4136)
     +                   (J,NINT(obs3_8(1,J,6)),NINT(obs3_8(2,J,6)),
     +                   NINT(obs3_8(3,J,6)),J=K,K+(L-1))
                        EXIT
                     END IF
                  ENDDO
               ENDDO
            END IF
 4136 FORMAT(<JNDX>(' L',I1,': AFIC=',I2,', HBOI=',I6,', HTOI=',I6,
     + ' |'))
         end if
  406    continue
         if(nobs3(7).gt.0) then
            if(nobs3(7).eq.1) then
               xminimum_8 = min(obs3_8(1,1,7),obs3_8(2,1,7),
     +         obs3_8(3,1,7))
               if(ibfms(xminimum_8).ne.0) go to 407
               JNDX = 1
               write(iuno,4137) (J,NINT(obs3_8(1,J,7)),
     +          NINT(obs3_8(2,J,7)),NINT(obs3_8(3,J,7)),J=1,1)
            ELSE
               DO K = 1,nobs3(7),3
                  DO L = 3,2,-1
                     IF(K+(L-1).LE.nobs3(7))  THEN
                        JNDX = L
                        write(iuno,4137)
     +                   (J,NINT(obs3_8(1,J,7)),NINT(obs3_8(2,J,7)),
     +                   NINT(obs3_8(3,J,7)),J=K,K+(L-1))
                        EXIT
                     END IF
                  ENDDO
               ENDDO
            END IF
 4137 FORMAT(<JNDX>(' L',I1,': DGOT=',I2,', HBOT=',I6,', HTOT=',I6,
     + ' |'))
         end if
  407    continue
cxxxxxaaaaa
      ELSE IF (msgtyp .eq. 'GOESND' .or.
     +         msgtyp .eq. 'SATEMP' ) then
         IF (obs2_8(1) .gt. 0 .and. ibfms(obs2_8(1)) .eq. 0 )  WRITE
     +    ( UNIT = iuno, FMT = '("RSRD=",I6,", EXPRSRD=",I6)')
     +    (nint(obs2_8(ii)),ii=1,2)
         IF (nlev.gt.0)  THEN
                         ! convert surface pressure from Pa to mb
            if(ibfms(goesnd2_hdr_8(1)).eq.0) goesnd2_hdr_8(1) =
     +       goesnd2_hdr_8(1)*0.01
            WRITE  ( UNIT = iuno, FMT = '("ACAV=",I3,", PRSS=",F6.1)')
     +       nint(obs2_8(42)),goesnd2_hdr_8(1)
         END IF
         IF (nchn.gt.0)  THEN
            WRITE  ( UNIT = iuno, FMT = '("ELEV=",F6.2,", SOEL=",' //
     +       'F6.2,", OZON=",I4,", TMSK=",F5.1,", CLAM=",I2)')
     +       goesnd1_hdr_8(1),goesnd1_hdr_8(2),nint(goesnd1_hdr_8(3)),
     +       goesnd1_hdr_8(4),nint(goesnd1_hdr_8(5))
         END IF
      ELSE IF (msgtyp .eq. 'QKSWND' ) then
         IF (obs2_8(1) .gt. 0 .and. ibfms(obs2_8(1)) .eq. 0 )  WRITE
     +    ( UNIT = iuno, FMT = '("RSRD=",I6,", EXPRSRD=",I6)')
     +    (nint(obs2_8(ii)),ii=1,2)
         WRITE  ( UNIT = iuno, FMT = '("ATRN=",I4,", CTCN=",I4,' //
     +   '", SPRR=",F6.3)') nint(obs2_8(44)),nint(obs2_8(43)),obs2_8(45)
      ELSE IF (msgtyp .eq. 'ASCATW' ) then
         IF (obs2_8(1) .gt. 0 .and. ibfms(obs2_8(1)) .eq. 0 )  WRITE
     +    ( UNIT = iuno, FMT = '("RSRD=",I6,", EXPRSRD=",I6)')
     +    (nint(obs2_8(ii)),ii=1,2)
         WRITE  ( UNIT = iuno, FMT = '("CTCN=",I4,", BSCD=",F6.1,' //
     +   '", LKCS=",F7.3)') nint(obs2_8(43)),obs2_8(60),obs2_8(61)
         IF(ibfms(obs2_8(59)) .eq. 0 ) then
            CALL UPFTBV(11,'WVCQ',obs2_8(59),31,ibit,nib)
            IF (nib .gt. 0) then
               WRITE(iuno,1245) nint(obs2_8(59)),(ibit(ii)-1,ii=1,nib)
 1245 FORMAT('WVCQ=',I10,', (',<nib>I3,')')
ccccc          WRITE  ( UNIT=iuno, FMT = '("WVCQ=",I10,", (",' //
ccccc+          '<nib>I3,")")') nint(obs2_8(59)),(ibit(ii),ii=1,nib)
            ELSE
               WRITE  ( UNIT=iuno, FMT = '("WVCQ=",I10)')
     +          nint(obs2_8(59))
            END IF
         END IF
      ELSE IF (msgtyp .eq. 'WDSATR' ) then
         IF (obs2_8(1) .gt. 0 .and. ibfms(obs2_8(1)) .eq. 0 )  WRITE
     +    ( UNIT = iuno, FMT = '("RSRD=",I6,", EXPRSRD=",I6)')
     +    (nint(obs2_8(ii)),ii=1,2)
         WRITE  ( UNIT = iuno, FMT = '("ACAV=",I2,", SST1=",F6.2,' //
     +   '", MRWVC=",F6.2,", MRLWC=",F5.2,", MWS10=",F6.2,' //
     +   '", MWD10=",F6.2,", WSEQC1=",I10,", CHSQ=",F5.2,", PHER=",' //
     +   'F5.1/"SPDE=",F5.2,", SSTE=",F6.2,", CLDE=",F6.3,' //
     +   '", VPRE=",F5.2,", REQV=",F9.4,", WSST=",I2)')
     +    nint(obs2_8(42)),obs2_8(4),obs2_8(46),obs2_8(47),obs2_8(50),
     +    obs2_8(49),nint(obs2_8(51)),obs2_8(52),obs2_8(53),obs2_8(54),
     +    obs2_8(55),obs2_8(56),obs2_8(57),obs2_8(58),nint(obs2_8(48))
      ELSE IF (msgtyp .eq. 'AIRCAR' ) then
         IF (obs2_8(1) .gt. 0 .and. ibfms(obs2_8(1)) .eq. 0 )  WRITE
     +    ( UNIT = iuno, FMT = '("RSRD=",I6,", EXPRSRD=",I6)')
     +    (nint(obs2_8(ii)),ii=1,2)
         WRITE  ( UNIT = iuno, FMT = '("ACID=",A8,", NRLQMS=''",A11,
     +    "''")')
     +    aircar_hdr_8,c_nrlqms
      ELSE IF (msgtyp .eq. 'ADPSFC' .or. msgtyp .eq. 'SFCSHP' .or.
     + msgtyp .eq. 'MSONET') then
         IF (msgtyp .eq. 'ADPSFC' ) then
            WRITE  ( UNIT = iuno, FMT = '("PMO=",F6.1,", PMQ=",I2,' //
     +       '", SOB=",F5.1,", SQM=",I2)')
     +      adpsfc_hdr_8(1),nint(adpsfc_hdr_8(2)),adpsfc_hdr_8(3),
     +      nint(adpsfc_hdr_8(4))
cxxxxxvvvvv
            IF(nint(hdr_8(10)).EQ.512) THEN ! Land METARs
               write(iuno,7012) (NINT(obs2_8(I)),I=38,39),
     +          NINT(obs2_8(3)),obs2_8(17),obs2_8(18),obs2_8(19),
     +          obs2_8(21)
 7012 FORMAT('CHPT=',I2,', 3HPC=',I5,', ALSE=',I6,', TP01=',F6.1,
     + ', TP03=',F6.1,', TP06=',F6.1,', TP24=',F6.1)
               xminimum_8 = MIN(obs2_8(1),obs2_8(2))
               if(ibfms(xminimum_8).eq.0)  write(iuno,1144)
     +          (NINT(obs2_8(I)),I=1,2)
 1144 FORMAT('RSRD=',I3,', EXPRSRD=',I3)
               IF(ibfms(obs2_8(22)).eq.0) write(iuno,1114)
     +          NINT(obs2_8(22))
 1114 FORMAT(' TOSS=',I4)
            ELSE ! Land SYNOPs
               write(iuno,7063) (NINT(obs2_8(I)),I=38,40),
     +          (obs2_8(I),NINT(obs2_8(I+1)),I=32,34,2)
 7063 FORMAT('CHPT=',I2,', 3HPC=',I5,', 24PC=',I6,', HOWV=',F5.1,
     + ', POWV=',I2,', HOWW=',F5.1,', POWW=',I2)
               xminimum_8 = MIN(obs2_8(1),obs2_8(2),obs2_8(17),
     +          obs2_8(18),obs2_8(19),obs2_8(20),obs2_8(21),obs2_8(23),
     +          obs2_8(24))
               if(ibfms(xminimum_8).eq.0) write(iuno,7164)
     +          (NINT(obs2_8(I)),I=1,2),(obs2_8(I),I=17,21),
     +          (NINT(obs2_8(I)),I=23,24)
 7164 FORMAT('RSRD=',I3,', EXPRSRD=',I3,', TP01=',F6.1,', TP03=',F6.1,
     + ', TP06=',F6.1,', TP12=',F6.1,', TP24=',F6.1,', TOCC=',I3,
     + ', HBLCS=',I2)
            END IF
              ! Land METARs and SYNOPs
            xminimum_8 = MIN(obs2_8(29),obs2_8(30),obs2_8(31))
            if(ibfms(xminimum_8).eq.0) write(iuno,8144)
     +       NINT(obs2_8(29)),(obs2_8(I),I=30,31)
 8144 FORMAT('.DTHDOFS=',I3,', DOFS=',F5.2,', TOSD=',F6.2)
            xminimum_8 = MIN(obs2_8(4),obs2_8(41),obs2_8(6),obs2_8(7),
     +       obs2_8(8),obs2_8(9),obs2_8(10),obs2_8(11),obs2_8(12),
     +       obs2_8(13),obs2_8(14),obs2_8(15))
            if(ibfms(xminimum_8).eq.0) write(iuno,7154) obs2_8(4),
     +       NINT(obs2_8(41)),(NINT(obs2_8(I)),I=6,11),obs2_8(12),
     +       (NINT(obs2_8(I)),I=13,14),obs2_8(15)
 7154 FORMAT('SST1=',F6.2,', SSTQM=',I2,', MSST=',I1,', .REHOVI=',I1,
     + ', HOVI=',I5,', VTVI=',I4,', PSW1=',I2,', PSW2=',I2,', PKWDSP=',
     + F5.1,', PKWDDR=',I3,', .DTMMXGS=',I2,', MXGS=',F5.1)
         ELSE IF (msgtyp .eq. 'SFCSHP' ) then
            WRITE  ( UNIT = iuno, FMT = '("PMO=",F6.1,", PMQ=",I2)')
     +       sfcshp_hdr_8(1),nint(sfcshp_hdr_8(2))
cxxxxxvvvvv
            IF(nint(hdr_8(10)).EQ.562) THEN ! drifting buoys
               write(iuno,9063) obs2_8(4),NINT(obs2_8(41)),obs2_8(5),
     +          (NINT(obs2_8(I)),I=38,39),obs2_8(32),NINT(obs2_8(33))
 9063 FORMAT('SST1=',F6.2,', SSTQM=',I2,', DBSS=',F4.1,', CHPT=',I2,
     + ', 3HPC=',I5,', HOWV=',F5.1,', POWV=',I2)
               xminimum_8 = MIN(obs2_8(1),obs2_8(2))
               if(ibfms(xminimum_8).eq.0)  write(iuno,1144)
     +          (NINT(obs2_8(I)),I=1,2)
            ELSE IF(nint(hdr_8(10)).EQ.522.OR.nint(hdr_8(10)).EQ.523)
     +       THEN
                                                           ! ships
               write(iuno,8063) obs2_8(4),NINT(obs2_8(41)),
     +          NINT(obs2_8(6)),(NINT(obs2_8(I)),I=38,39),
     +          NINT(obs2_8(24)),(NINT(obs2_8(I)),I=36,37)
 8063 FORMAT('SST1=',F6.2,', SSTQM=',I2,', MSST=',I1,', CHPT=',I2,
     + ', 3HPC=',I5,', HBLCS=',I2,', TDMP=',I2,', ASMP=',I2)
               xminimum_8 = MIN(obs2_8(1),obs2_8(2))
               if(ibfms(xminimum_8).eq.0)  write(iuno,1144)
     +          (NINT(obs2_8(I)),I=1,2)
               xminimum_8 = MIN(obs2_8(32),obs2_8(33),obs2_8(34),
     +          obs2_8(35),obs2_8(9),obs2_8(10),obs2_8(11),obs2_8(23),
     +          obs2_8(8),obs2_8(14),obs2_8(15),obs2_8(40))
               if(ibfms(xminimum_8).eq.0) write(iuno,56) (obs2_8(I),
     +          NINT(obs2_8(I+1)),I=32,34,2),(NINT(obs2_8(I)),I=9,11),
     +          NINT(obs2_8(23)),NINT(obs2_8(8)),NINT(obs2_8(14)),
     +          obs2_8(15),NINT(obs2_8(40))
   56 FORMAT('HOWV=',F5.1,', POWV=',I2,', HOWW=',F5.1,', POWW=',I2,
     + ', VTVI=',I4,', PSW1=',I2,', PSW2=',I2,', TOCC=',I3,', HOVI=',I5,
     + ', .DTMMXGS=',I2,', MXGS=',F5.1,', 24PC=',I6)
            ELSE ! all other marine
               write(iuno,8093) obs2_8(4),NINT(obs2_8(41)),
     +          NINT(obs2_8(6)),(NINT(obs2_8(I)),I=38,39),
     +          NINT(obs2_8(8)),NINT(obs2_8(14)),obs2_8(15)
 8093 FORMAT('SST1=',F6.2,', SSTQM=',I2,', MSST=',I1,', CHPT=',I2,
     + ', 3HPC=',I5,', HOVI=',I5,', .DTMMXGS=',I2,', MXGS=',F5.1)
               xminimum_8 = MIN(obs2_8(1),obs2_8(2))
               if(ibfms(xminimum_8).eq.0)  write(iuno,1144)
     +          (NINT(obs2_8(I)),I=1,2)
               xminimum_8 = MIN(obs2_8(32),obs2_8(33),obs2_8(34),
     +          obs2_8(35),obs2_8(10),obs2_8(11),obs2_8(12),obs2_8(13),
     +          obs2_8(25),obs2_8(26))
               if(ibfms(xminimum_8).eq.0) write(iuno,58) (obs2_8(I),
     +          NINT(obs2_8(I+1)),I=32,34,2),(NINT(obs2_8(I)),I=10,11),
     +          obs2_8(12),NINT(obs2_8(13)),obs2_8(25),obs2_8(26)
   58 FORMAT('HOWV=',F5.1,', POWV=',I2,', HOWW=',F5.1,', POWW=',I2,
     + ', PSW1=',I2,', PSW2=',I2,', PKWDSP=',F5.1,', PKWDDR=',I3,
     + ', XS10=',F5.1,', XS20=',F5.1)
            END IF
cxxxxxaaaaa
         ELSE IF (msgtyp .eq. 'MSONET' ) then
            WRITE  ( UNIT = iuno, FMT = '("PRVSTG=",A8,' //
     +       '", SPRVSTG=",A8)') msonet_hdr_8(1),msonet_hdr_8(2)
cxxxxxvvvvv
            write(iuno,8062) (NINT(obs2_8(I)),I=1,2),obs2_8(15),
     +       NINT(obs2_8(16)),NINT(obs2_8(3))
 8062 FORMAT('RSRD=',I3,', EXPRSRD=',I3,', MXGS=',F5.1,', MXGD=',I3,
     + ', ALSE=',I6)
cxxxxxaaaaa
         END IF
cxxxxxvvvvv
         if(nobs3(1).gt.0) then
            if(nobs3(1).eq.1) then
               xminimum_8 = min(obs3_8(1,1,1),obs3_8(2,1,1))
               if(ibfms(xminimum_8).ne.0) go to 401
               JNDX = 1
               write(iuno,1135) (J,NINT(obs3_8(1,J,1)),obs3_8(2,J,1),
     +          J=1,1)
            ELSE
               DO K = 1,nobs3(1),3
                  DO L = 3,2,-1
                     IF(K+(L-1).LE.nobs3(1))  THEN
                        JNDX = L
                        write(iuno,1135)
     +                   (J,NINT(obs3_8(1,J,1)),obs3_8(2,J,1),J=K,
     +                   K+(L-1))
                        EXIT
                     END IF
                  ENDDO
               ENDDO
            END IF
 1135 FORMAT(<JNDX>(' L',I1,': .DTHTOPC=',I3,', TOPC=',F6.1,' |'))
         end if
  401    continue
         if(nobs3(2).gt.0) then
            if(nobs3(2).eq.1) then
               if(ibfms(obs3_8(1,1,2)).ne.0) go to 492
               JNDX = 1
               write(iuno,1136) (J,NINT(obs3_8(1,J,2)),J=1,1)
            ELSE
               DO K = 1,nobs3(2),8
                  DO L = 8,2,-1
                     IF(K+(L-1).LE.nobs3(2))  THEN
                        JNDX = L
                        write(iuno,1136)
     +                   (J,NINT(obs3_8(1,J,2)),J=K,K+(L-1))
                        EXIT
                     END IF
                  ENDDO
               ENDDO
            END IF
         end if
  492    continue
         if(nobs3(3).gt.0) then
            if(nobs3(3).eq.1) then
               xminimum_8 = min(obs3_8(1,1,3),obs3_8(2,1,3),
     +          obs3_8(3,1,3),obs3_8(4,1,3),obs3_8(5,1,3))
            if(ibfms(xminimum_8).ne.0) go to 493
            end if
            DO K = 1,nobs3(3),2
               IF(K+1.LE.nobs3(3))  THEN
                  JNDX = 2
                  write(iuno,1197) (J,(NINT(obs3_8(I,J,3)),I=1,5),
     +             J=K,K+1)
               ELSE
                  JNDX = 1
                  write(iuno,1197) (J,(NINT(obs3_8(I,J,3)),I=1,5),J=K,K)
               END IF
 1197 FORMAT(<JNDX>(' L',I1,': VSSO=',I2,', CLAM=',I2,', CLTP=',I2,
     + ', HOCB=',I5,', HOCT=',I5,' |'))
            ENDDO
         end if
  493    continue
         if(nobs3(4).gt.0) then
            if(nobs3(4).eq.1) then
               xminimum_8 = min(obs3_8(1,1,4),obs3_8(2,1,4),
     +          obs3_8(3,1,4),obs3_8(4,1,4))
               if(ibfms(xminimum_8).ne.0) go to 404
            end if
            DO K = 1,nobs3(4),2
               IF(K+1.LE.nobs3(4))  THEN
                  JNDX = 2
                  write(iuno,1138)
     +             (J,(NINT(obs3_8(I,J,4)),obs3_8(I+1,J,4),I=1,3,2),
     +             J=K,K+1)
               ELSE
                  JNDX = 1
                  write(iuno,1138)
     +             (J,(NINT(obs3_8(I,J,4)),obs3_8(I+1,J,4),I=1,3,2),
     +             J=K,K)
               END IF
 1138 FORMAT(<JNDX>(' L',I1,': .DTHMXTM=',I3,', MXTM=',F6.2,
     + ', .DTHMITM=',I3,', MITM=',F6.2,' |'))
            ENDDO
         end if
  404    continue
         if(nobs3(5).gt.0) then
            if(nobs3(5).eq.1) then
               xminimum_8 = min(obs3_8(1,1,5),obs3_8(2,1,5))
               if(ibfms(xminimum_8).ne.0) go to 405
               JNDX = 1
               write(iuno,4135) (J,NINT(obs3_8(1,J,5)),obs3_8(2,J,5),
     +          NINT(obs3_8(3,J,5)),J=1,1)
            ELSE
               DO K = 1,nobs3(5),3
                  DO L = 3,2,-1
                     IF(K+(L-1).LE.nobs3(5))  THEN
                        JNDX = L
                        write(iuno,4135)
     +                   (J,NINT(obs3_8(1,J,5)),obs3_8(2,J,5),
     +                   NINT(obs3_8(3,J,5)),J=K,K+(L-1))
                        EXIT
                     END IF
                  ENDDO
               ENDDO
            END IF
 4135 FORMAT(<JNDX>(' L',I1,': DOSW=',I3,', HOSW=',F5.1,', POSW=',I2,
     + ' |'))
         end if
  405    continue
cxxxxxaaaaa
      ELSE IF (msgtyp .eq. 'SATWND' ) then
         IF (obs2_8(1) .gt. 0 .and. ibfms(obs2_8(1)) .eq. 0 )  WRITE
     +    ( UNIT = iuno, FMT = '("RSRD=",I6,", EXPRSRD=",I6)')
     +    (nint(obs2_8(ii)),ii=1,2)
         WRITE  ( UNIT = iuno, FMT = '("RFFL=",I3,", QIFY=",I3,
     +    ", QIFN=",I3,", EEQF=",I3,", SAZA=",F6.2)')
     +    (nint(satwnd_hdr_8(ii)),ii=1,4),satwnd_hdr_8(5)
      ELSE IF (msgtyp .eq. 'GPSIPW' ) then
         IF (obs2_8(1) .gt. 0 .and. ibfms(obs2_8(1)) .eq. 0 )  WRITE
     +    ( UNIT = iuno, FMT = '("RSRD=",I6,", EXPRSRD=",I6)')
     +    (nint(obs2_8(ii)),ii=1,2)
                         ! convert surface pressure from Pa to mb
            if(ibfms(gpsipw_hdr_8).eq.0) gpsipw_hdr_8 =gpsipw_hdr_8*0.01
            WRITE  ( UNIT = iuno, FMT = '("PRSS=",F6.1)') gpsipw_hdr_8
      END IF

      IF (nlev .gt. 0 )  THEN

C       Print the level (non-radiance) data for report (if separate
C        mass & wind pieces in PREPBUFR file, these have been merged).
C       --------------------------------------------------------------

         DO lv = 1, nlev  ! loop through the levels
            WRITE  ( UNIT = iuno, FMT = '( 94("-") )' )
            WRITE  ( UNIT = iuno,
     +               FMT = '( 10X,"level ", I4, 2X, A9,A8,A10,5A9 )' )
     +       lv, 'obs      ', 'qmark   ', 'qc_step   ', 'rcode    ',
     +       'fcst     ', 'anal     ', 'oberr    ', 'category '
            WRITE  ( UNIT = iuno, FMT = '( 94("-") )' )
            DO kk = indxvr1(nint(hdr_8(8))),indxvr2(nint(hdr_8(8)))
                             ! loop through the variables
               DO jj = 1, MXR8VN  ! loop through the events
                  IF( kk .eq. 15 ) then
                         ! convert cloud-top pressure from Pa to mb
                     if(ibfms(evns_8(1,lv,jj,kk)).eq.0)
     +                evns_8(1,lv,jj,kk) = evns_8(1,lv,jj,kk)*0.01
                  ELSE IF( kk .eq. 10 ) then
                         ! convert rain rate from mm/s to mm/hr
                     if(ibfms(evns_8(1,lv,jj,kk)).eq.0)
     +                evns_8(1,lv,jj,kk) = evns_8(1,lv,jj,kk)*3600.0_8
                  ELSE IF( kk .eq. 2 ) then
                         ! convert moisture ob error to whole % (RH)
                     if(ibfms(evns_8(7,lv,jj,kk)).eq.0)
     +                evns_8(7,lv,jj,kk) = evns_8(7,lv,jj,kk)*10.
                  END IF
cpppppppppppppppppppp
ccc               print *, 'EVENTS:'
ccc               print *, evns_8(1,lv,jj,kk),
ccc  +                     evns_8(2,lv,jj,kk),
ccc  +                     evns_8(3,lv,jj,kk),
ccc  +                     evns_8(2,lv,jj,kk),
ccc  +                     evns_8(3,lv,jj,kk),
ccc  +                     evns_8(4,lv,jj,kk),
ccc  +                     evns_8(5,lv,jj,kk),
ccc  +                     evns_8(6,lv,jj,kk),
ccc  +                     evns_8(7,lv,jj,kk)
cpppppppppppppppppppp
                  xminimum_8 = min(evns_8(1,lv,jj,kk),
     +             evns_8(2,lv,jj,kk),evns_8(3,lv,jj,kk),
     +             evns_8(4,lv,jj,kk),evns_8(5,lv,jj,kk),
     +             evns_8(6,lv,jj,kk),evns_8(7,lv,jj,kk))
                  if(ibfms(xminimum_8).eq.0) THEN
                     IF(ibfms(evns_8(3,lv,jj,kk)).eq.0) THEN

C       Copy forecast value, analyzed value, observation error and
C        PREPBUFR category from latest event sequence to all earlier
C        valid event sequences
C       --------------------------------------------------------------

                        evns_8(5:8,lv,jj,kk) = evns_8(5:8,lv,1,kk)
                        pcode = evns_8(3,lv,jj,kk)
                        CALL UFBQCP(11,pcode,QC_STEP)
                     ELSE
                        QC_STEP = '        '
                     END IF
                     erruntp = errunt(kk)
cpppppppppppppppppppp
ccc   print *, 'evns_8(7,lv,jj,kk) = ',evns_8(7,lv,jj,kk)
ccc   print *, 'ibfms(evns_8(7,lv,jj,kk)) = ',ibfms(evns_8(7,lv,jj,kk))
ccc   print *, 'BMISS here is: ',bmiss
ccc   print *, 'BUFRLIB value for missing is: ',GETBMISS()
cpppppppppppppppppppp
                     if(ibfms(evns_8(7,lv,jj,kk)) .ne. 0)
     +                erruntp = '     '
                     WRITE  ( UNIT = iuno,
     + FMT = '( A18,1X,F8.1,2X,F6.0,4X,A8,2X,F5.0,3(1X,F8.1),A5,F4.0)' )
     +               var (kk), ( evns_8 ( ii, lv, jj, kk ), ii = 1, 2 ),
     +               qc_step,  ( evns_8 ( ii, lv, jj, kk ), ii = 4, 7 ),
     +               erruntp,    evns_8 (  8, lv, jj, kk ) 
                  END IF
               END DO
            END DO
            IF ( msgtyp .eq. 'ADPUPA' )  THEN
               WRITE  ( UNIT = iuno,
     +    FMT = '( 10X,"BALLOON DRIFT: D-TIME(HRS)=",F7.3,", LAT(N)=",
     +             F6.2,", LON(E)=",F6.2)' ) ( drft_8 ( ii, lv),
     +             ii = 1,3)
               xminimum_8 = min(toth_8(1,lv),toth_8(2,lv))
               if(ibfms(xminimum_8).eq.0)  WRITE  ( UNIT = iuno,
     + FMT = '( 10X,"Through PREPRO STEP only: VIRTUAL TEMP (C)=",F8.1,
     +       ", DEWPOINT TEMP (C)=",F8.1)' ) toth_8 (1,lv),
     +       toth_8 (2,lv)
            ELSE IF ( msgtyp .eq. 'AIRCAR' )  THEN
               WRITE  ( UNIT = iuno,
     + FMT = '( 10X,"PCAT=",F5.2,", POAF=",I3,", TRBX10=",I3,
     +           ", TRBX21=",I3,", TRBX32=",I3,", TRBX43=",I3,", MSTQ=",
     +           I2,", IALR=",F6.3)')
     +           acars_sup_8(1,lv),(nint(acars_sup_8(ii,lv)),ii=2,7),
     +           acars_sup_8(8,lv)
               xminimum_8 = min(drft_8(1,lv),drft_8(2,lv),drft_8(3,lv))
               if(ibfms(xminimum_8).eq.0) WRITE  ( UNIT = iuno,
     +    FMT = '( 10X,"PROFILE TIME/LOCATION: D-TIME(HRS)=",F7.3,
     +             ", LAT(N)=",F6.2,", LON(E)=",F6.2)' )
     +             ( drft_8 ( ii, lv), ii = 1,3)
            ELSE IF ( msgtyp .eq. 'AIRCFT' )  THEN
               WRITE  ( UNIT = iuno,
     + FMT = '( 10X,"RCT=",F7.2,", PCAT=",F5.2,", POAF=",I3,", TRBX=",
     +           I2,", ROLF=",I1,", MSTQ=",I2,", IALR=",F6.3)')
     +           (aircft_sup_8(ii,lv),ii=1,2),
     +           (nint(aircft_sup_8(ii,lv)),ii=3,6),aircft_sup_8(7,lv)
               xminimum_8 = min(drft_8(1,lv),drft_8(2,lv),drft_8(3,lv))
               if(ibfms(xminimum_8).eq.0) WRITE  ( UNIT = iuno,
     +    FMT = '( 10X,"PROFILE TIME/LOCATION: D-TIME(HRS)=",F7.3,
     +             ", LAT(N)=",F6.2,", LON(E)=",F6.2)' )
     +             ( drft_8 ( ii, lv), ii = 1,3)
            END IF
         END DO
      END IF

      IF (nchn .gt. 0 )  THEN

C       Print the channel (radiance) data for report
C       --------------------------------------------

         WRITE  ( UNIT = iuno, FMT = '( 42("-") )' )
         WRITE  ( UNIT = iuno,
     +            FMT = '("BRIGHTNESS TEMP  channel  observation (K)")')
         WRITE  ( UNIT = iuno, FMT = '( 42("-") )' )
         DO lv = 1, nchn  ! loop through the channels
            xminimum_8 = min(brts_8(1,lv),brts_8(2,lv))
            if(ibfms(xminimum_8).eq.0) THEN
               WRITE  ( UNIT = iuno, FMT = '(19X,I3,7X,F6.2)' )
     +          nint(brts_8(1,lv)), brts_8(2,lv)
            END IF
         END DO
      END IF
cppppppppppppppp
ccc   print *, 'ierrpb prior goto10  = ',ierrpb
cppppppppppppppp

      IF  ( ierrpb .eq. 0 )  GO TO 10

      print *, '2-All subsets read in and processed'

      STOP      ! All subsets read in and processed

      END

C$$$  SUBPROGRAM DOCUMENTATION BLOCK
C
C SUBPROGRAM:    READPB
C   PRGMMR: KEYSER           ORG: NP12        DATE: 2005-12-14
C
C ABSTRACT: THIS SUBROUTINE READS IN SUBSETS FROM THE PREPBUFR
C   FILE.  SINCE ACTUAL OBSERVATIONS ARE SPLIT INTO MASS AND
C   WIND SUBSETS, THIS ROUTINE COMBINES THEM INTO A SINGLE
C   REPORT FOR OUTPUT.  IT IS STYLED AFTER BUFRLIB ENTRY POINT
C   READNS, AND IT ONLY REQUIRES THE PREPBUFR FILE TO BE OPENED
C   FOR READING WITH OPENBF.  THE COMBINED REPORT IS RETURNED TO
C   THE CALLER IN COMMON /PREPBC/.  THIS COMMON AREA CONTAINS
C   THE NUMBER OF LEVELS (NON-RADIANCES) IN THE REPORT, THE
C   NUMBER OF CHANNELS (RADIANCES) IN THE REPORT, A ONE
C   DIMENSIONAL ARRAY WITH THE HEADER INFORMATION, A FOUR
C   DIMENSIONAL ARRAY CONTAINING ALL EVENTS FROM ALL
C   NON-RADIANCE OBSERVATIONAL VARIABLE TYPES, AND A TWO
C   DIMENSIONAL ARRAY CONTAINING ALL CHANNELS OF BRIGHTNESS
C   TEMPERATURE FOR REPORTS CONTAINING RADIANCE DATA.
C
C PROGRAM HISTORY LOG:
C ????-??-??  WOOLLEN/GSC ORIGINAL AUTHOR
C ????-??-??  ATOR        STREAMLINED AND DOCUMENTED
C 2001-10-26  KEYSER      FURTHER DOCUMENTATION FOR WEB, UPDATED
C                         TO REPLACE OBSOLETE MESSAGE TYPE "SATBOG"
C                         WITH "QKSWND"; ADDED MORE VARAIBLES AND
C                         MANY OTHER UPDATES
C 2002-01-28  KEYSER      NOW THAT "PCAT" (PRECISION OF TEMPERATURE
C                         OBS.) HAS BEEN ADDED TO PREPBUFR FILE FOR
C                         "AIRCFT" AND "AIRCAR" MESSAGE TYPES, ADDED
C                         THIS TO LISTING
C 2002-08-27  KEYSER      ADDED MESONET DATA IN NEW MESSAGE TYPE
C                         "MSONET"; ADDED GPS-IPW DATA IN NEW MESSAGE
C                         TYPE "GPSIPW"
C 2004-04-22  KEYSER      CHANGED MOISTURE OBS. ERROR TO BE WHOLE %
C                         (RH) INSTEAD OF % DIVIDED BY 10 AS IT IS
C                         IN PREPBUFR FILE
C 2005-12-14  KEYSER      NOW THAT "ACID" (AIRCRAFT FLIGHT NUMBER),
C                         "TRBX" (TURBULENCE INDEX) AND "ROLF"
C                         (AIRCRAFT ROLL ANGLE FLAG) HAVE BEEN ADDED TO
C                         PREPBUFR FILE FOR "AIRCFT" MESSAGE TYPES
C                         (SPECIFICALLY FOR TAMDAR), ADDED THESE TO
C                         LISTING
C
C USAGE:    CALL READPB  (LUNIT, IUNO, MSGTYP, IRET)
C   INPUT ARGUMENT LIST:
C     LUNIT    - UNIT NUMBER OF INPUT PREPBUFR FILE
C
C   OUTPUT ARGUMENT LIST:
C     IUNO     - UNIT NUMBER OF OUTPUT LISTING FILE
C     MSGTYP   - BUFR MESSAGE TYPE (CHARACTER)
C     IRET     - ERROR RETURN CODE (0 - normal return; 1 - the report
C                within COMMON /PREPBC/ contains the last available
C                report from within the prepbufr file; -1 - there are
C                no more reports available from within the PREPBUFR
C                file, all subsets have been processed)
C
C REMARKS: 
C 
C   The header array hdr_8 contains the following list of mnemonics:
C         hdr_8(1)   Station identification (SID)
C         hdr_8(2)   Latitude  (YOB)
C         hdr_8(3)   Longitude (XOB)
C         hdr_8(4)   Elevation (ELV)
C         hdr_8(5)   Observation time minus cycle time (DHR)
C         hdr_8(6)   Reported observation time (RPT)
C         hdr_8(7)   Indicator whether observation time used to generate
C                    "DHR" was corrected (TCOR)
C         hdr_8(8)   PREPBUFR report type (TYP)
C         hdr_8(9)   PREPBUFR report subtype (TSB)
C         hdr_8(10)  Input report type (T29)
C         hdr_8(11)  Instrument type (ITP)
C         hdr_8(12)  Report sequence number (SQN)
C         hdr_8(13)  Process number for this MPI run (obtained from
C                    script (PROCN)
C         hdr_8(14)  Satellite identifier (SAID)
C
C   The array obs2_8 contains the following list of mnemonics:
C         obs2_8(1)  Restrictions on redistribution (RSRD)
C         obs2_8(2)  Expiration of restrictions on redistribution
C                    (EXPRSRD)
C         obs2_8(3)  Altimeter setting (ALSE)
C         obs2_8(4)  Sea-surface temperature (SST1)
C         obs2_8(5)  Depth at which sea-surface temperature measured
C                    (DBSS)
C         obs2_8(6)  Method of sea surface temperature measurement
C                    (MSST)
C         obs2_8(7)  Relationship to horizontal visibility (.REHOVI)
C         obs2_8(8)  Horizontal visibility (HOVI)
C         obs2_8(9)  Vertical visibility (VTVI)
C         obs2_8(10) Past weather - 1 (PSW1)
C         obs2_8(11) Past weather - 2 (PSW2)
C         obs2_8(12) Peak wind speed (PKWDSP)
C         obs2_8(13) Peak wind direction (PKWDDR)
C         obs2_8(14) Duration of time for max. wind speed (gust)
C                    (.DTMMXGS)
C         obs2_8(15) Maximum wind speed (gust) (MXGS)
C         obs2_8(16) Maximum wind gust direction (MXGD)
C         obs2_8(17) Total precipitation past  1-hr (TP01)
C         obs2_8(18) Total precipitation past  3-hr (TP03)
C         obs2_8(19) Total precipitation past  6-hr (TP06)
C         obs2_8(20) Total precipitation past 12-hr (TP12)
C         obs2_8(21) Total precipitation past 24-hr (TP24)
C         obs2_8(22) Total sunshine (TOSS)
C         obs2_8(23) Total cloud cover (TOCC)
C         obs2_8(24) Height above surface of base of lowest cloud seen
C                    (HBLCS)
C         obs2_8(25) 10 meter extrapolated wind speed (XS10)
C         obs2_8(26) 20 meter extrapolated wind speed (XS20)
C         obs2_8(27) Surface wind direction (WDIR1)
C         obs2_8(28) Surface wind speed (WSPD1)
C         obs2_8(29) Duration of time for depth of fresh snow (.DTHDOFS)
C         obs2_8(30) Depth of fresh snow (DOFS)
C         obs2_8(31) Total snow depth (TOSD)
C         obs2_8(32) Height of waves (HOWV)
C         obs2_8(33) Period of waves (POWV)
C         obs2_8(34) Height of wind waves (HOWW)
C         obs2_8(35) Period of wind waves (POWW)
C         obs2_8(36) True direction of ship past 3-hrs (TDMP)
C         obs2_8(37) Avg speed of ship past 3-hrs (ASMP)
C         obs2_8(38) Characteristic of pressure tendency (CHPT)
C         obs2_8(39) 03-hour pressure change (3HPC)
C         obs2_8(40) 24-hour pressure change (24PC)
C         obs2_8(41) Sea-surface temperature quality mark (SSTQM)
C         obs2_8(42) Total number (with respect to accumulation or
C                    average) (ACAV)
C         obs2_8(43) Across-swath cell number (CTCN)
C         obs2_8(44) Along-track row number (ATRN)
C         obs2_8(45) Seawinds probability of rain (SPRR)
C         obs2_8(46) Total water vapor (MRWVC)
C         obs2_8(47) Total cloud liquid water (MRLWC)
C         obs2_8(48) WINDSAT surface type (WSST)
C         obs2_8(49) Model wind direction at 10 meters (MWD10)
C         obs2_8(50) Model wind speed at 10 meters (MWS10)
C         obs2_8(51) WINDSAT EDR q.c. flag # 1 (WSEQC1)
C         obs2_8(52) Chi-squared (of the wind vector retrieval) (CHSQ)
C         obs2_8(53) Estimated error covariance for wind direction
C                    retrieval (PHER)
C         obs2_8(54) Estimated error covariance for wind speed
C                    retrieval (SPDE)
C         obs2_8(55) Estimated error covariance for sea surface
C                    temperature retrieval (SSTE)
C         obs2_8(56) Estimated error covariance for total cloud liquid
C                    water retrieval (CLDE)
C         obs2_8(57) Estimated error covariance for total water vapor
C                    retrieval (VPRE)
C         obs2_8(58) Rainfall (average rate) observation (REQV)
C         obs2_8(59) Wind vector cell quality (WVCQ)
C         obs2_8(60) Backscatter distance (BSCD)
C         obs2_8(61) Likelihood computed for solution (LKCS)
C
C   The 3-D array obs3_8 contains the following list of mnemonics:
C         obs3_8(1,A,1) Duration of time for total precipitation
C                       measurment (.DTHTOPC)
C         obs3_8(2,A,1) Total precipitation measurement (TOPC)
C         {where A ranges from 1 to NOBS3(1), the number of "levels"}
C
C         obs3_8(1,B,2) Present weather (PRWE)
C         {where B ranges from 1 to NOBS3(2), the number of "levels"}
C
C         obs3_8(1,C,3) Vertical significance (VSSO)
C         obs3_8(2,C,3) Cloud amount (CLAM)
C         obs3_8(3,C,3) Cloud type (CLTP)
C         obs3_8(4,C,3) Height of base of cloud (HOCB)
C         obs3_8(5,C,3) Height of top of cloud (HOCT)
C         {where C ranges from 1 to NOBS3(3), the number of "levels"}
C
C         obs3_8(1,D,4) Duration of time for maximum temperature
C                       (.DTHMXTM)
C         obs3_8(2,D,4) Maximum temperature (MXTM)
C         obs3_8(3,D,4) Duration of time for minimum temperature
C                       (.DTHMITM)
C         obs3_8(4,D,4) Minimum temperature (MITM)
C         {where D ranges from 1 to NOBS3(4), the number of "levels"}
C
C         obs3_8(1,E,5) Direction of swell waves (DOSW)
C         obs3_8(2,E,5) Height of swell waves (HOSW)
C         obs3_8(3,E,5) Period of swell waves (POSW)
C         {where E ranges from 1 to NOBS3(5), the number of "levels"}
C
C         obs3_8(1,F,6) Airframe icing (AFIC)
C         obs3_8(2,F,6) Height of base of icing (HBOI)
C         obs3_8(3,F,6) Height of top of icing (HTOI)
C         {where F ranges from 1 to NOBS3(6), the number of "levels"}
C
C         obs3_8(1,G,7) Degree of turbulence (DGOT)
C         obs3_8(2,G,7) Height of base of turbulence (HBOT)
C         obs3_8(3,G,7) Height of top of turbulence (HTOT)
C         {where G ranges from 1 to NOBS3(7), the number of "levels"}
C 
C   The 4-D array of non-radiance data, evns_8 (ii, lv, jj, kk), is
C    indexed as follows:
C     "ii" indexes the event data types; these consist of:
C         1) Observation       (e.g., POB, ZOB, UOB, VOB, TOB, QOB, PWO)
C         2) Quality mark      (e.g., PQM, ZRM, WQM, TQM, QQM, PWQ)
C         3) Program code      (e.g., PPC, ZPC, WPC, TPC, QPC, PWP)
C         4) Reason code       (e.g., PRC, ZRC, WRC, TRC, QRC, PWR)
C         5) Forecast value    (e.g., PFC, ZFC, UFC, VFC, TFC, QFC, PWF)
C         6) Analyzed value    (e.g., PAN, ZAN, UAN, VAN, TAN, QAN, PWA)
C         7) Observation error (e.g., POE, ZOE, WOE, TOE, QOE, PWO)
C         8) PREPBUFR data level category (CAT)
C     "lv" indexes the levels of the report
C         1) Lowest level
C     "jj" indexes the event stacks
C         1) N'th event
C         2) (N-1)'th event (if present)
C         3) (N-2)'th event (if present)
C                ...
C        10) (N-9)'th event (if present)
C     "kk" indexes the variable types
C         1) Pressure
C         2) Specific humidity
C         3) Temperature
C         4) Height
C         5) U-component wind
C         6) V-component wind
C         7) Wind direction
C         8) Wind speed
C         9) Total precipitable water
C        10) Rain rate
C        11) 1.0 to 0.9 sigma layer precipitable water
C        12) 0.9 to 0.7 sigma layer precipitable water
C        13) 0.7 to 0.3 sigma layer precipitable water
C        14) 0.3 to 0.0 sigma layer precipitable water
C        15) Cloud-top pressure
C        16) Cloud-top temperature
C        17) Total cloud cover
C 
C     Note that the structure of this array is identical to one
C      returned from BUFRLIB routine UFBEVN, with an additional (4'th)
C      dimension to include the 14 variable types into the same
C      array.
C 
C   The 2-D array of radiance data, brts_8 (ii, lv), is indexed
C    as follows:
C     "ii" indexes the event data types; these consist of:
C         1) Observation       (CHNM, TMBR)
C     "lv" indexes the channels (CHNM gives channel number)
C 
C     Note that this array is directly returned from BUFRLIB
C      routine UFBINT.
C
C
C ATTRIBUTES:
C   LANGUAGE: FORTRAN 90
C   MACHINE:  NCEP WCOSS
C
C$$$
      SUBROUTINE READPB  ( lunit, iuno, msgtyp, iret )

      PARAMETER ( NHR8PM = 14 )    ! Actual number of BUFR parameters
                                   !  in header
      PARAMETER ( MXR8PM =  8 )    ! Maximum number of BUFR parameters
                                   !  in level data (non-radiance) or
                                   !  in channel data (radiance)
      PARAMETER ( MXR8LV = 255 )   ! Maximum number of BUFR levels/
                                   !                        channels
      PARAMETER ( MXR8VN = 10 )    ! Max. number of BUFR event sequences
                                   !  (non-radiance reports)
      PARAMETER ( MXR8VT = 17)     ! Max. number of BUFR variable types
                                   !  (non-radiance reports)
      PARAMETER ( MXSTRL = 80 )    ! Maximum size of a string

      PARAMETER ( NFILO = 20 )     ! Number of message types in PREPBUFR
                                   !  file

      REAL*8    hdr_8 ( NHR8PM ), obs2_8(61), aircar_hdr_8,
     +          aircft_hdr_8, adpupa_hdr_8, goesnd1_hdr_8(5),
     +          goesnd2_hdr_8(MXR8LV), adpsfc_hdr_8(4), sfcshp_hdr_8(2),
     +          msonet_hdr_8(2), satwnd_hdr_8(5), gpsipw_hdr_8,
     +          evns_8 ( MXR8PM, MXR8LV, MXR8VN, MXR8VT ),
     +          drft_8 ( 3, MXR8LV ), brts_8 ( MXR8PM, MXR8LV ),
     +          toth_8 ( 2, MXR8LV ), acars_sup_8( 8, MXR8LV ),
     +          aircft_sup_8( 7, MXR8LV ), obs3_8(5,MXR8LV,7)
      REAL*8    hdr2_8 ( NHR8PM ), obs22_8(61), aircar_hdr2_8,
     +          aircft_hdr2_8, adpupa_hdr2_8, goesnd1_hdr2_8(5),
     +          goesnd2_hdr2_8(MXR8LV), adpsfc_hdr2_8(4),
     +          sfcshp_hdr2_8(2), msonet_hdr2_8(2), satwnd_hdr2_8(5),
     +          gpsipw_hdr2_8,
     +          evns2_8 ( MXR8PM, MXR8LV, MXR8VN, MXR8VT),
     +          drft2_8 ( 3, MXR8LV ), toth2_8 ( 2, MXR8LV ),
     +          acars_sup2_8( 8, MXR8LV ), aircft_sup2_8( 7, MXR8LV ),
     +          obs32_8(5,MXR8LV,7)
      REAL*8    hdr_save_8  ( NHR8PM ), obs2_save_8(61),
     +          adpsfc_hdr_save_8(4), sfcshp_hdr_save_8(2),
     +          msonet_hdr_save_8(2),
     +          evns_save_8 ( MXR8PM, MXR8LV, MXR8VN, MXR8VT ),
     +          drft_save_8 ( 3, MXR8LV ), toth_save_8 ( 2, MXR8LV ),
     +          acars_sup_save_8 ( 8, MXR8LV ),
     +          aircft_sup_save_8( 7, MXR8LV ), obs3_save_8(5,MXR8LV,7)
      REAL*8    r8sid_8, r8sid2_8, pob1_8, pob2_8, rmissing_8, r8acid_8,
     +          r8acid2_8

      REAL(8)   BMISS,xmaximum_8

      REAL      p ( MXR8LV )

      INTEGER  indr ( MXR8LV ), indxvr1 ( 100:539 ), indxvr2 ( 100:539 )
      INTEGER  nobs3 (7), nobs32 (7)

      CHARACTER    msgtyp*8, msgtyp_process*8
      CHARACTER*11 c_nrlqms,c_nrlqms2
      CHARACTER*8  csid, csid2, msgtp2, missing, acid, acid2
      CHARACTER*6  filo
      CHARACTER*(MXSTRL)      head1, head2, ostr ( MXR8VT ), dir2_1,
     +                        dir2_2, dir2_3, dir2_4, dir2_5, dir2_6,
     +                        dir2_7

      LOGICAL         match, seq_match, radiance, not_radiance,found

      EQUIVALENCE     ( r8sid_8, csid ), ( r8sid2_8, csid2 ),
     +                ( rmissing_8, missing ), (r8acid_8, acid ),
     +                ( r8acid2_8, acid2 )

      COMMON  / PREPBC /      hdr_8, obs2_8, obs3_8, evns_8, drft_8,
     +  toth_8, acars_sup_8, aircft_sup_8, brts_8, aircar_hdr_8,
     +  aircft_hdr_8, adpupa_hdr_8, goesnd1_hdr_8, goesnd2_hdr_8,
     +  adpsfc_hdr_8, sfcshp_hdr_8, msonet_hdr_8, satwnd_hdr_8,
     +  gpsipw_hdr_8, indxvr1, indxvr2, nlev, nchn, nobs3, c_nrlqms

      COMMON  /UNITS/         iunso ( NFILO ), filo (NFILO )

      COMMON /BUFRLIB_MISSING/BMISS

      DATA   head1
     +        / 'SID YOB XOB ELV DHR RPT TCOR TYP TSB T29 ITP SQN' /
      DATA   head2
     +        / 'PROCN SAID' /
      DATA   ostr
     +        / 'POB PQM PPC PRC PFC PAN POE CAT',
     +          'QOB QQM QPC QRC QFC QAN QOE CAT',
     +          'TOB TQM TPC TRC TFC TAN TOE CAT',
     +          'ZOB ZQM ZPC ZRC ZFC ZAN ZOE CAT',
     +          'UOB WQM WPC WRC UFC UAN WOE CAT',
     +          'VOB WQM WPC WRC VFC VAN WOE CAT',
     +          'DDO DFQ DFP DFR NUL NUL NUL CAT',
     +          'FFO DFQ DFP DFR NUL NUL NUL CAT',
     +          'PWO PWQ PWP PWR PWF PWA PWE CAT',
     +          'REQ6 RRTQM RRTPC RRTRC RRTFC RRTAN RRTOE CAT',
     +          'PW1O PW1Q PW1P PW1R PW1F PW1A PW1E CAT',
     +          'PW2O PW2Q PW2P PW2R PW2F PW2A PW2E CAT',
     +          'PW3O PW3Q PW3P PW3R PW3F PW3A PW3E CAT',
     +          'PW4O PW4Q PW4P PW4R PW4F PW4A PW4E CAT',
     +          'CDTP CTPQM CTPPC CTPRC CTPFC CTPAN CTPOE CAT',
     +          'GCDTT NUL NUL NUL NUL NUL NUL CAT' ,
     +          'TOCC  NUL NUL NUL NUL NUL NUL CAT' /
      DATA   dir2_1
     + / 'RSRD EXPRSRD ALSE SST1 DBSS MSST .REHOVI HOVI VTVI PSW1  ' /
      DATA   dir2_2
     + / 'PSW2 PKWDSP PKWDDR .DTMMXGS MXGS MXGD TP01 TP03 TP06 TP12' /
      DATA   dir2_3
     + / 'TP24 TOSS TOCC HBLCS XS10 XS20 WDIR1 WSPD1 .DTHDOFS DOFS ' /
      DATA   dir2_4
     + / 'TOSD HOWV POWV HOWW POWW TDMP ASMP CHPT 3HPC 24PC SSTQM  ' /
      DATA   dir2_5
     + / 'ACAV CTCN ATRN SPRR MRWVC MRLWC WSST MWD10 MWS10 WSEQC1  ' /
      DATA   dir2_6
     + / 'CHSQ PHER SPDE SSTE CLDE  VPRE  REQV                     ' /
      DATA   dir2_7
     + / 'WVCQ BSCD LKCS                                           ' /
      DATA            match / .true. /, seq_match / .false. /
      DATA            irec_last / -99 /, nfirst/0/

      SAVE            match, msgtp2, idate2, iuno2, missing,
     +                msgtyp_process
C-----------------------------------------------------------------------

C.......................................................................

      IF  ( nfirst .eq. 0 )  THEN
cpppppppppppppppppppp
ccc   print *, 'first time in READPB come here'
cpppppppppppppppppppp

C       The first and only time in, set up some things
C       ----------------------------------------------

C       Find out which message type should be processed
C        (or if ALL message types should be processed)
C       -----------------------------------------------

         read(5,'(A8)') msgtyp_process

C       Open the output files.
C       ----------------------

         DO nfile = 1, NFILO
             OPEN  ( UNIT = iunso ( nfile ),
     +               FILE = 'readpb.out.' // filo ( nfile ) )
         END DO

         NFIRST = 1
         missing = 'missing '

      END IF

C.......................................................................

 1000 continue

      iret = 0
cpppppppppppppppppppp
ccc   print *, 'this time in READPB, iret set to ',iret
cpppppppppppppppppppp

C       If the previous call to this subroutine did not yield matching
C        mass and wind subsets, then BUFRLIB routine READNS is already
C        pointing at an unmatched subset.  Otherwise, call READNS to
C        advance the subset pointer to the next subset.
C       --------------------------------------------------------------

      IF  ( match )  THEN
cpppppppppppppppppppp
ccc   print *, '1-MATCH = ',match,', call READNS'
cpppppppppppppppppppp
          CALL READNS(lunit,msgtyp,idate,jret) ! BUFRLIB routine to
                                               !  read in next subset
cpppppppppppppppppppp
ccc   print *, '1-return from READNS = ',jret
cpppppppppppppppppppp
          IF  ( jret .ne. 0 )  THEN
             iret = -1 ! there are no more subsets in the PREPBUFR file
                       !  and all subsets have been processed
cpppppppppppppppppppp
ccc   print *, 'return-1 to main program with iret = ',iret
cpppppppppppppppppppp
             RETURN
          END IF
cpppppppppppppppppppp
ccc   print *, 'msgtyp,msgtyp_process-1: ',msgtyp,msgtyp_process
cpppppppppppppppppppp
          if(msgtyp.ne.msgtyp_process .and. msgtyp_process.ne.
     +       'ALL     ') go to 1000

          CALL PRINT_KEY(iuno,msgtyp,idate,*1000)

          call ufbcnt(lunit,irec,isub)

          if(irec.ne.irec_last)  CALL PRINT_READ(iuno,irec)
          irec_last = irec

      ELSE
cpppppppppppppppppppp
ccc   print *, 'MATCH = false'
cpppppppppppppppppppp
          msgtyp = msgtp2
          idate = idate2
          iuno = iuno2  
      END IF

C       Read the report header based on mnemonic string "head" and
C        transfer 1 for 1 into array hdr_8 for the subset that is
C        currently being pointed to.
C       -----------------------------------------------------------

                       !BUFRLIB routine to read specific info from
                       ! report (no event info though)
      CALL UFBINT(lunit,hdr_8,           12,1,jret,head1)
      CALL UFBINT(lunit,hdr_8(13),NHR8PM-12,1,jret,head2)

C       Read supplemental data into array obs2_8
C       --------------------------------------

      obs2_8=BMISS
      CALL UFBINT(lunit,obs2_8( 1),10,1,jret,dir2_1)
      CALL UFBINT(lunit,obs2_8(11),10,1,jret,dir2_2)
      CALL UFBINT(lunit,obs2_8(21),10,1,jret,dir2_3)
      CALL UFBINT(lunit,obs2_8(31),11,1,jret,dir2_4)
      CALL UFBINT(lunit,obs2_8(42),10,1,jret,dir2_5)
      CALL UFBINT(lunit,obs2_8(52), 7,1,jret,dir2_6)
      CALL UFBINT(lunit,obs2_8(59), 3,1,jret,dir2_7)

C       Read supplemental data into array obs3_8
C       --------------------------------------

      obs3_8=BMISS
      nobs3=0
      CALL UFBINT(lunit,obs3_8(1,1,1),5,MXR8LV,jret,'.DTHTOPC TOPC')
      nobs3(1)=jret
      CALL UFBINT(lunit,obs3_8(1,1,2),5,MXR8LV,jret,'PRWE')
      nobs3(2)=jret
      CALL UFBINT(lunit,obs3_8(1,1,3),5,MXR8LV,jret,
     +                                       'VSSO CLAM CLTP HOCB HOCT')
      nobs3(3)=jret
      CALL UFBINT(lunit,obs3_8(1,1,4),5,MXR8LV,jret,
     +                                    '.DTHMXTM MXTM .DTHMITM MITM')
      nobs3(4)=jret
      CALL UFBINT(lunit,obs3_8(1,1,5),5,MXR8LV,jret,'DOSW HOSW POSW')
      nobs3(5)=jret
      CALL UFBINT(lunit,obs3_8(1,1,6),5,MXR8LV,jret,'AFIC HBOI HTOI')
      nobs3(6)=jret
      CALL UFBINT(lunit,obs3_8(1,1,7),5,MXR8LV,jret,'DGOT HBOT HTOT')
      nobs3(7)=jret

C       Read header information that is specific to the various
C        message types
C       -------------------------------------------------------

      aircar_hdr_8=BMISS
      aircft_hdr_8=BMISS
      adpupa_hdr_8=BMISS
      goesnd1_hdr_8=BMISS
      goesnd2_hdr_8=BMISS
      adpsfc_hdr_8=BMISS
      sfcshp_hdr_8=BMISS
      msonet_hdr_8=BMISS
      satwnd_hdr_8=BMISS
      gpsipw_hdr_8=BMISS
      c_nrlqms='missing    '

      IF( msgtyp .eq. 'AIRCAR')  THEN
         CALL UFBINT(lunit,aircar_hdr_8,1,1,jret,'ACID ')
         CALL READLC(lunit,c_nrlqms,'NRLQMS')
         if(icbfms(c_nrlqms,11).ne.0) c_nrlqms = 'missing    '
      ELSE IF( msgtyp .eq. 'AIRCFT')  THEN
         CALL UFBINT(lunit,aircft_hdr_8,1,1,jret,'ACID ')
         r8acid_8 = aircft_hdr_8
cpppppppppppppppppppp
ccc      print *, 'r8acid_8 = ',r8acid_8
ccc      print *, 'icbfms(acid,8) = ',icbfms(acid,8)
cpppppppppppppppppppp
         if(icbfms(acid,8).ne.0) aircft_hdr_8 = rmissing_8
C above line not working right - returns 0 when missing, so use next
C  two lines below temporarily until this is fixed (readlc will return
C  all blanks for acid when mnemonic "ACID" not found) - dak 2/1/13
            CALL READLC(lunit,acid,'ACID')
            if(acid.eq.'        ')  aircft_hdr_8 = rmissing_8
         CALL READLC(lunit,c_nrlqms,'NRLQMS')
         if(icbfms(c_nrlqms,11).ne.0) c_nrlqms = 'missing    '
      ELSE IF( msgtyp .eq. 'ADPUPA')  THEN
         CALL UFBINT(lunit,adpupa_hdr_8,1,1,jret,'SIRC ')
      ELSE IF( msgtyp .eq. 'GOESND' .or.  msgtyp .eq. 'SATEMP' )  THEN
         CALL UFBINT(lunit,goesnd1_hdr_8,5,1,jret,
     +               'ELEV SOEL OZON TMSK CLAM')
         IF( msgtyp .eq. 'GOESND' ) CALL UFBINT(lunit,goesnd2_hdr_8,1,
     +                                          MXR8LV,jret,'PRSS ')
      ELSE IF( msgtyp .eq. 'ADPSFC')  THEN
         CALL UFBINT(lunit,adpsfc_hdr_8,4,1,jret,'PMO PMQ SOB SQM ')
      ELSE IF( msgtyp .eq. 'SFCSHP')  THEN
         CALL UFBINT(lunit,sfcshp_hdr_8,2,1,jret,'PMO PMQ ')
      ELSE IF( msgtyp .eq. 'MSONET')  THEN
         CALL UFBINT(lunit,msonet_hdr_8,2,1,jret,'PRVSTG SPRVSTG ')
      ELSE IF( msgtyp .eq. 'SATWND')  THEN
         CALL UFBINT(lunit,satwnd_hdr_8,5,1,jret,
     +                                      'RFFL QIFY QIFN EEQF SAZA ')
      ELSE IF( msgtyp .eq. 'GPSIPW' ) THEN
         CALL UFBINT(lunit,gpsipw_hdr_8,1,1,jret,'PRSS ')
      END IF

C       From PREPBUFR report type, determine if this report contains
C        only non-radiance data, only radiance data, or both
C       ------------------------------------------------------------

      radiance = (  nint(hdr_8(8)) .eq. 102 .or.
     +            ( nint(hdr_8(8)) .ge. 160 .and. nint(hdr_8(8)) .le.
     +              179 ))
      not_radiance = ( .not.radiance .or. 
     +          ( nint(hdr_8(8)) .ge. 160 .and. nint(hdr_8(8))
     +            .le. 163 )
     +     .or. ( nint(hdr_8(8)) .ge. 170 .and. nint(hdr_8(8)) .le. 173
     + ))

cppppppppppppppp
ccc   print *, 'in subr. READPB, BMISS = ',bmiss
cppppppppppppppp
      evns_8 = BMISS
      brts_8 = BMISS
      nlev = 0
      nchn = 0

      IF ( not_radiance )  THEN

C       For reports with non-radiance data, read the report level data
C        for the variable types based on the variable-specific mnemonic
C        string "ostr(kk)" and transfer all levels, all events 1 for 1
C        into array evns_8 for the subset that is currently being
C        pointed to.
C       ---------------------------------------------------------------


         DO kk = indxvr1(nint(hdr_8(8))),indxvr2(nint(hdr_8(8)))
                                 ! loop through the variables
             CALL UFBEVN(lunit,evns_8(1,1,1,kk),MXR8PM,MXR8LV,MXR8VN,
     +        nlev, ostr(kk)) ! BUFRLIB routine to read specific info
                              ! from report, accounting for all
                              ! possible events
ccccc    call errexit(69)
         END DO
cccc     call errexit(69)  ! this is where code fails

         drft_8=BMISS
         toth_8=BMISS
         acars_sup_8=BMISS
         aircft_sup_8=BMISS
         IF( msgtyp .eq. 'ADPUPA')  THEN

C       Read balloon drift level data for message type ADPUPA
C       -----------------------------------------------------

            CALL UFBINT(lunit,drft_8,3,MXR8LV,nlevd,'HRDR YDR XDR ')
            if(nlevd .ne. nlev .and. nlevd .ne. 0)  CALL ERREXIT(22)

C       Read virtual temperature and dewpoint temperature (through
C        "PREPRO" step only) data for message type ADPUPA
C       ----------------------------------------------------------

            CALL UFBINT(lunit,toth_8,2,MXR8LV,nlevt,'TVO TDO ')
            if(nlevt .ne. nlev)  CALL ERREXIT(33)

         ELSE IF ( msgtyp .eq. 'AIRCAR')  THEN

C       Read ancillary level data for message type AIRCAR
C       -------------------------------------------------

            CALL UFBINT(lunit,acars_sup_8,8,MXR8LV,nlev_acar,
     +       'PCAT POAF TRBX10 TRBX21 TRBX32 TRBX43 MSTQ IALR ')
            if(nlev_acar .ne. nlev .and. nlev_acar .ne. 0)
     +        CALL ERREXIT(55)

C       Read profile level time/location data for message type AIRCAR
C       -------------------------------------------------------------

            CALL UFBINT(lunit,drft_8,3,MXR8LV,nlevd,'HRDR YDR XDR ')
            if(nlevd .ne. nlev .and. nlevd .ne. 0)  CALL ERREXIT(22)

         ELSE IF ( msgtyp .eq. 'AIRCFT')  THEN

C       Read ancillary level data for message type AIRCFT
C       -------------------------------------------------

            CALL UFBINT(lunit,aircft_sup_8,7,MXR8LV,nlev_aircft,
     +       'RCT PCAT POAF TRBX ROLF MSTQ IALR ')
            if(nlev_aircft .ne. nlev .and. nlev_aircft .ne. 0)
     +       CALL ERREXIT(66)

C       Read profile level time/location data for message type AIRCFT
C       -------------------------------------------------------------

            CALL UFBINT(lunit,drft_8,3,MXR8LV,nlevd,'HRDR YDR XDR ')
            if(nlevd .ne. nlev .and. nlevd .ne. 0)  CALL ERREXIT(22)
         END IF

      END IF

      IF ( radiance)  THEN

C       For reports with radiance data, read the report channel data
C        for the variable types based on the mnemonic string
C        "CHNM TMBR" and transfer all channels 1 for 1 into array brts_8
C        for the subset that is currently being pointed to.
C       --------------------------------------------------------------

          CALL UFBINT(lunit,brts_8,MXR8PM,MXR8LV,nchn,'CHNM TMBR')

      END IF

 2000 CONTINUE

C      Now, advance the subset pointer to the next subset and read
C       its report header.
C      -----------------------------------------------------------

cpppppppppppppppppppp
ccc   print *, '2-MATCH = ',match,', call READNS'
cpppppppppppppppppppp
      CALL READNS(lunit,msgtp2,idate2,jret)
cpppppppppppppppppppp
ccc   print *, '2-return from READNS = ',jret
cpppppppppppppppppppp
      IF  ( jret .ne. 0 )  THEN
         iret = 1 ! there are no more subsets in the PREPBUFR file
                  !  but we must still return and process the
                  !  previous report in common /PREPBC/
cpppppppppppppppppppp
ccc   print *, 'return-2 to main program with iret = ',iret
cpppppppppppppppppppp
         RETURN
      END IF
cpppppppppppppppppppp
ccc   print *, 'msgtp2,msgtyp_process-2: ',msgtp2,msgtyp_process
cpppppppppppppppppppp
      if(msgtp2.ne.msgtyp_process .and. msgtyp_process.ne.
     +   'ALL     ') go to 2000

      CALL PRINT_KEY(iuno2,msgtp2,idate2,*2000)

      call ufbcnt(lunit,irec,isub)

      if(irec.ne.irec_last)  CALL PRINT_READ(iuno2,irec)
      irec_last = irec

      CALL UFBINT(lunit,hdr2_8,           12,1,jret,head1)
      CALL UFBINT(lunit,hdr2_8(13),NHR8PM-12,1,jret,head2)

C       Next, check whether this subset and the previous one are
C        matching mass and wind components for a single "true" report.
C       --------------------------------------------------------------

      match = .true.
      seq_match = .false.

      xmaximum_8 = max(hdr_8(12),hdr2_8 (12))
      if(ibfms(xmaximum_8).eq.0)  THEN
         IF (ibfms(hdr_8(13)) .ne.0)  hdr_8 (13) = 0.
         IF (ibfms(hdr2_8(13)).ne.0)  hdr2_8(13) = 0.
         seq  = (hdr_8 (13) * 1000000.) + hdr_8 (12) ! combine seq.
                                                     ! nunmber and MPI
         seq2 = (hdr2_8(13) * 1000000.) + hdr2_8(12) ! proc. number
         IF  ( seq .ne. seq2 )  THEN
            match = .false.
cpppppppppppppppppppp
ccc   print *, 'return-3 to main program with iret = ',iret
cpppppppppppppppppppp
            RETURN  ! the two process/sequence numbers do not match,
                    !  return and process information in common /PREPBC/
         ELSE
            seq_match = .true.  ! the two process/sequence numbers match
         END IF
      END IF

      IF  ( msgtyp .ne. msgtp2 .or. msgtyp.eq.'GOESND')  THEN
          match = .false.
cpppppppppppppppppppp
ccc   print *, 'return-4 to main program with iret = ',iret
cpppppppppppppppppppp
          RETURN   ! the two message types do not match, or the message
                   !  type is GOESND (meaning radiance, sounding and/or
                   !  retrieval subsets with the same header info could
                   !  be in sequence), return and  process information
                   !  in common /PREPBC/
      END IF

      IF ( .not. seq_match )  THEN

C       The two process/sequence numbers are missing, so as a last
C        resort must check whether this subset and the previous one
C        have identical values for SID, YOB, XOB, ELV, and DHR in
C        which case they match.
C       -----------------------------------------------------------

         r8sid_8  = hdr_8 (1)
         r8sid2_8 = hdr2_8(1)
         IF  ( csid .ne. csid2 )  THEN
             match = .false.
cpppppppppppppppppppp
ccc   print *, 'return-5 to main program with iret = ',iret
cpppppppppppppppppppp
             RETURN   ! the two report id's do not match, return and
                      !  process information in common /PREPBC/
         END IF

         DO ii = 5, 2, -1
            IF  ( hdr_8 (ii) .ne. hdr2_8 (ii) )  THEN
               match = .false.
cpppppppppppppppppppp
ccc   print *, 'return-6 to main program with iret = ',iret
cpppppppppppppppppppp
               RETURN   ! the two headers do not match, return and
                        !  process information in common /PREPBC/
            END IF
         END DO
      END IF

C       The two headers match, read level data for the second subset.
C        (Note: This can only happen for non-radiance reports)
C       -------------------------------------------------------------

      DO kk = indxvr1(nint(hdr_8(8))),indxvr2(nint(hdr_8(8)))
                                 ! loop through the variables
          CALL UFBEVN(lunit,evns2_8 (1,1,1,kk),MXR8PM,MXR8LV,MXR8VN,
     +     nlev2,ostr(kk))
      ENDDO

      drft2_8=BMISS
      toth2_8=BMISS
      acars_sup2_8=BMISS
      aircft_sup2_8=BMISS
      IF( msgtp2 .eq. 'ADPUPA')  THEN

C       Read balloon drift level data for message type ADPUPA
C        for the second subset
C       -----------------------------------------------------

         CALL UFBINT(lunit,drft2_8,3,MXR8LV,nlev2d,'HRDR YDR XDR ')
         if(nlev2d .ne. nlev2 .and. nlevd .ne. 0)  CALL ERREXIT(22)

C       Read virtual temperature and dewpoint temperature (through
C        "PREPRO" step only) data for message type ADPUPA for the
C        second subset
C       ----------------------------------------------------------

         CALL UFBINT(lunit,toth2_8,2,MXR8LV,nlev2t,'TVO TDO ')
         if(nlev2t .ne. nlev2)  CALL ERREXIT(33)

      ELSE IF ( msgtp2 .eq. 'AIRCAR')  THEN

C       Read ancillary level data for message type AIRCAR
C        for the second subset
C       -------------------------------------------------

         CALL UFBINT(lunit,acars_sup2_8,8,MXR8LV,nlev2_acar,
     +    'PCAT POAF TRBX10 TRBX21 TRBX32 TRBX43 MSTQ IALR ')
         if(nlev2_acar .ne. nlev2 .and. nlev2_acar .ne. 0)
     +    CALL ERREXIT(55)

C       Read profile level time/location data for message type AIRCAR
C        for the second subset
C       -------------------------------------------------------------

         CALL UFBINT(lunit,drft2_8,3,MXR8LV,nlev2d,'HRDR YDR XDR ')
         if(nlev2d .ne. nlev2 .and. nlevd .ne. 0)  CALL ERREXIT(22)

      ELSE IF ( msgtp2 .eq. 'AIRCFT')  THEN

C       Read ancillary level data for message type AIRCFT
C        for the second subset
C       -------------------------------------------------

         CALL UFBINT(lunit,aircft_sup2_8,7,MXR8LV,nlev2_aircft,
     +    'RCT PCAT POAF TRBX ROLF MSTQ IALR ')
         if(nlev2_aircft .ne. nlev2 .and. nlev2_aircft .ne. 0)
     +    CALL ERREXIT(66)

C       Read profile level time/location data for message type AIRCFT
C        for the second subset
C       -------------------------------------------------------------

         CALL UFBINT(lunit,drft2_8,3,MXR8LV,nlev2d,'HRDR YDR XDR ')
         if(nlev2d .ne. nlev2 .and. nlevd .ne. 0)  CALL ERREXIT(22)
      END IF

C       Read supplemental data into array obs22_8 for 2nd subset
C       ------------------------------------------------------

      obs22_8=BMISS
      CALL UFBINT(lunit,obs22_8( 1),10,1,jret,dir2_1)
      CALL UFBINT(lunit,obs22_8(11),10,1,jret,dir2_2)
      CALL UFBINT(lunit,obs22_8(21),10,1,jret,dir2_3)
      CALL UFBINT(lunit,obs22_8(31),11,1,jret,dir2_4)
      CALL UFBINT(lunit,obs22_8(42),10,1,jret,dir2_5)
      CALL UFBINT(lunit,obs22_8(52), 7,1,jret,dir2_6)
      CALL UFBINT(lunit,obs22_8(59), 3,1,jret,dir2_7)

C       Read supplemental data into array obs32_8 for 2nd subset
C       ------------------------------------------------------

      obs32_8=BMISS
      nobs32=0
      CALL UFBINT(lunit,obs32_8(1,1,1),5,MXR8LV,jret,'.DTHTOPC TOPC')
      nobs32(1)=jret
      IF(min(nobs3(1),nobs32(1)).gt.0 .and. nobs3(1).ne.nobs32(1))
     + CALL ERREXIT(44)
      CALL UFBINT(lunit,obs32_8(1,1,2),5,MXR8LV,jret,'PRWE')
      nobs32(2)=jret
      IF(min(nobs3(2),nobs32(2)).gt.0 .and. nobs3(2).ne.nobs32(2))
     + CALL ERREXIT(44)
      CALL UFBINT(lunit,obs32_8(1,1,3),5,MXR8LV,jret,
     +                                       'VSSO CLAM CLTP HOCB HOCT')
      nobs32(3)=jret
      IF(min(nobs3(3),nobs32(3)).gt.0 .and. nobs3(3).ne.nobs32(3))
     + CALL ERREXIT(44)
      CALL UFBINT(lunit,obs32_8(1,1,4),5,MXR8LV,jret,
     +                                    '.DTHMXTM MXTM .DTHMITM MITM')
      nobs32(4)=jret
      IF(min(nobs3(4),nobs32(4)).gt.0 .and. nobs3(4).ne.nobs32(4))
     + CALL ERREXIT(44)
      CALL UFBINT(lunit,obs32_8(1,1,5),5,MXR8LV,jret,'DOSW HOSW POSW')
      nobs32(5)=jret
      IF(min(nobs3(5),nobs32(5)).gt.0 .and. nobs3(5).ne.nobs32(5))
     + CALL ERREXIT(44)
      CALL UFBINT(lunit,obs32_8(1,1,6),5,MXR8LV,jret,'AFIC HBOI HTOI')
      nobs32(6)=jret
      IF(min(nobs3(6),nobs32(6)).gt.0 .and. nobs3(6).ne.nobs32(6))
     + CALL ERREXIT(44)
      CALL UFBINT(lunit,obs32_8(1,1,7),5,MXR8LV,jret,'DGOT HBOT HTOT')
      nobs32(7)=jret
      IF(min(nobs3(7),nobs32(7)).gt.0 .and. nobs3(7).ne.nobs32(7))
     + CALL ERREXIT(44)

C       Read header information that is specific to the various
C        message types for the second supset
C       -------------------------------------------------------

      aircar_hdr2_8=BMISS
      aircft_hdr2_8=BMISS
      adpupa_hdr2_8=BMISS
      goesnd1_hdr2_8=BMISS
      goesnd2_hdr2_8=BMISS
      adpsfc_hdr2_8=BMISS
      sfcshp_hdr2_8=BMISS
      msonet_hdr2_8=BMISS
      satwnd_hdr2_8=BMISS
      gpsipw_hdr2_8=BMISS
      c_nrlqms2 = 'missing    '
      IF( msgtp2 .eq. 'AIRCAR')  THEN
         CALL UFBINT(lunit,aircar_hdr2_8,1,1,jret,'ACID ')
         CALL READLC(lunit,c_nrlqms2,'NRLQMS')
         if(icbfms(c_nrlqms2,11).ne.0) c_nrlqms2 = 'missing    '
      ELSE IF( msgtp2 .eq. 'AIRCFT')  THEN
         CALL UFBINT(lunit,aircft_hdr2_8,1,1,jret,'ACID ')
         r8acid2_8 = aircft_hdr2_8
         if(icbfms(acid2,8).ne.0) aircft_hdr2_8 = rmissing_8
         CALL READLC(lunit,c_nrlqms2,'NRLQMS')
         if(icbfms(c_nrlqms2,11).ne.0) c_nrlqms2 = 'missing    '
      ELSE IF( msgtp2 .eq. 'ADPUPA')  THEN
         CALL UFBINT(lunit,adpupa_hdr2_8,1,1,jret,'SIRC ')
      ELSE IF( msgtp2 .eq. 'GOESND' .or.  msgtp2 .eq. 'SATEMP' )  THEN
         CALL UFBINT(lunit,goesnd1_hdr2_8,5,1,jret,
     +               'ELEV SOEL OZON TMSK CLAM')
         IF( msgtp2 .eq. 'GOESND' ) CALL UFBINT(lunit,goesnd2_hdr2_8,1,
     +                                          MXR8LV,jret,'PRSS ')
      ELSE IF( msgtp2 .eq. 'ADPSFC')  THEN
         CALL UFBINT(lunit,adpsfc_hdr2_8,4,1,jret,'PMO PMQ SOB SQM ')
      ELSE IF( msgtp2 .eq. 'SFCSHP')  THEN
         CALL UFBINT(lunit,sfcshp_hdr2_8,2,1,jret,'PMO PMQ ')
      ELSE IF( msgtp2 .eq. 'MSONET')  THEN
         CALL UFBINT(lunit,msonet_hdr2_8,2,1,jret,'PRVSTG SPRVSTG ')
      ELSE IF( msgtp2 .eq. 'SATWND')  THEN
         CALL UFBINT(lunit,satwnd_hdr2_8,5,1,jret,
     +                                      'RFFL QIFY QIFN EEQF SAZA ')
      ELSE IF( msgtp2 .eq. 'GPSIPW' ) THEN
         CALL UFBINT(lunit,gpsipw_hdr2_8,1,1,jret,'PRSS ')
      END IF

      IF (nint(hdr_8(8)) .ge. 280)  THEN

C       If this is a surface report, the wind subset precedes the
C        mass subset - switch the subsets around in order to combine
C        the surface pressure properly
C       ------------------------------------------------------------

         evns_save_8 = evns2_8
         evns2_8 = evns_8
         evns_8 = evns_save_8
         hdr_save_8 = hdr2_8
         hdr2_8 = hdr_8
         hdr_8 = hdr_save_8
         obs2_save_8 = obs22_8
         obs22_8 = obs2_8
         obs2_8 = obs2_save_8
         obs3_save_8 = obs32_8
         obs32_8 = obs3_8
         obs3_8 = obs3_save_8
         adpsfc_hdr_save_8 = adpsfc_hdr2_8
         adpsfc_hdr2_8 = adpsfc_hdr_8
         adpsfc_hdr_8 = adpsfc_hdr_save_8
         sfcshp_hdr_save_8 = sfcshp_hdr2_8
         sfcshp_hdr2_8 = sfcshp_hdr_8
         sfcshp_hdr_8 = sfcshp_hdr_save_8
         msonet_hdr_save_8 = msonet_hdr2_8
         msonet_hdr2_8 = msonet_hdr_8
         msonet_hdr_8 = msonet_hdr_save_8
      END IF

C       Combine the message type-specific header data and the
C        restrictions on redistribution data for the two matching
C        subsets into a single array. 
C       ---------------------------------------------------------

      aircar_hdr_8 = min(aircar_hdr_8,aircar_hdr2_8)
      aircft_hdr_8 = min(aircft_hdr_8,aircft_hdr2_8)
      adpupa_hdr_8 = min(adpupa_hdr_8,adpupa_hdr2_8)
      goesnd1_hdr_8(:) = min(goesnd1_hdr_8(:),goesnd1_hdr2_8(:))
      goesnd2_hdr_8(:) = min(goesnd2_hdr_8(:),goesnd2_hdr2_8(:))
      adpsfc_hdr_8(:) = min(adpsfc_hdr_8(:),adpsfc_hdr2_8(:))
      sfcshp_hdr_8(:) = min(sfcshp_hdr_8(:),sfcshp_hdr2_8(:))
      msonet_hdr_8(:) = min(msonet_hdr_8(:),msonet_hdr2_8(:))
      satwnd_hdr_8(:) = min(satwnd_hdr_8(:),satwnd_hdr2_8(:))
      gpsipw_hdr_8 = min(gpsipw_hdr_8,gpsipw_hdr2_8)
      if(c_nrlqms.eq.'missing    ') c_nrlqms = c_nrlqms2

      obs2_8(:) = min(obs2_8(:),obs22_8(:))
      obs3_8(:,:,:) = min(obs3_8(:,:,:),obs32_8(:,:,:))

C       Combine the data for the two matching subsets into a single 4-D
C        array.  Do this by merging the evns2_8 array into the evns_8
C        array.
C       ---------------------------------------------------------------

      LOOP1: DO lv2 = 1, nlev2  ! loop through the levels of subset 2
         DO lv1 = 1, nlev  ! loop through the levels of subset 1
            pob1_8 = evns_8  ( 1, lv1, 1, 1 )
            pob2_8 = evns2_8 ( 1, lv2, 1, 1 )
            IF  ( pob1_8 .eq. pob2_8 )  THEN

C       This pressure level from the second subset also exists in the
C        first subset, so overwrite any "missing" piece of data for
C        this pressure level in the first subset with the corresponding
C        piece of data from the second subset (since this results in no
C        net loss of data!).
C       ---------------------------------------------------------------

               DO kk = indxvr1(nint(hdr_8(8))),indxvr2(nint(hdr_8(8)))
                                            ! loop through the variables
                  DO jj = 1,MXR8VN  ! loop through the events
                     DO ii = 1,MXR8PM-1 ! loop through BUFR parameters
                                            ! skip the CAT parameter
                        IF (ibfms(evns_8(ii,lv1,jj,kk )).ne.0) THEN
                           evns_8  ( ii, lv1, jj, kk ) =
     +                     evns2_8 ( ii, lv2, jj, kk )
                           IF (ibfms(evns2_8(ii,lv2,jj,kk)).eq.0) THEN

C       If any piece of data in the first subset is missing and the
C        corresponding piece of data is NOT missing in the second
C        subset, also overwrite the PREPBUFR category parameter in the
C        first subset with that from the second subset regardless of
C        its value in either subset
C       --------------------------------------------------------------

                             evns_8  (  8, lv1, jj, kk ) =
     +                        evns2_8 (  8, lv2, jj, kk )
                           END IF
                        END IF
                     END DO
                  END DO
               END DO
               CYCLE LOOP1
            ELSE IF  (  ( pob2_8 .gt. pob1_8 )  .or.
     +                  ( lv1  .eq. nlev )  )  THEN

C       Either all remaining pressure levels within the first subset
C        are less than this pressure level from the second subset
C        (since levels within each subset are guaranteed to be in
C        descending order wrt pressure!) *OR* there are more total
C        levels within the second subset than in the first subset.
C        In either case, we should now add this second subset level
C        to the end of the evns_8 array.
C       ------------------------------------------------------------

               nlev = nlev + 1
               evns_8  ( :, nlev, :, : ) = evns2_8 ( :, lv2,  :, : )
               drft_8  ( :, nlev ) = drft2_8 ( :, lv2 )
               toth_8  ( :, nlev ) = toth2_8 ( :, lv2 )
               acars_sup_8  ( :, nlev ) = acars_sup2_8 ( :, lv2 )
               aircft_sup_8  ( :, nlev ) = aircft_sup2_8 ( :, lv2 )
               CYCLE LOOP 1
               END IF
               END DO
      END DO  LOOP1

C       Sort combined report according to decreasing pressure.
C       ------------------------------------------------------

      p(:) = evns_8  ( 1, :, 1, 1)
      if(nlev .gt. 0)  call indexf(nlev,p,indr)
      evns_save_8 = evns_8
      drft_save_8 = drft_8
      toth_save_8 = toth_8
      acars_sup_save_8 = acars_sup_8
      aircft_sup_save_8 = aircft_sup_8
      do i = 1,nlev
         j = indr(nlev-i+1)
         evns_8 ( :, i, :, :) = evns_save_8 ( :, j, :, :)
         drft_8 ( :, i) = drft_save_8 ( :, j)
         toth_8 ( :, i) = toth_save_8 ( :, j)
         acars_sup_8 ( :, i) = acars_sup_save_8 ( :, j)
         aircft_sup_8 ( :, i) = aircft_sup_save_8 ( :, j)
      end do

C       Return to calling program with a complete report in common
C        /PREPBC/.
C       ----------------------------------------------------------

cpppppppppppppppppppp
ccc   print *, 'return-7 to main program with iret = ',iret
cpppppppppppppppppppp
      RETURN

      END

C$$$  SUBPROGRAM DOCUMENTATION BLOCK
C
C SUBPROGRAM:    PRINT_KEY
C   PRGMMR: D. A. KEYSER     ORG: NP22       DATE: 2003-07-11
C
C ABSTRACT: PRINTS "KEY" INFORMATION TO TOP OF THE APPROPRIATE OUTPUT
C   FILE.  ENTRY "PRINT_READ" PRINTS TO THE APPROPRIATE OUTPUT FILE
C   WHEN A NEW MESSAGE IS OPENED IN THE INPUT BUFR FILE.
C
C PROGRAM HISTORY LOG:
C 2003-07-11  KEYSER      ORIGINAL AUTHOR
C
C USAGE:    CALL PRINT_KEY (IUNO, MSGTYP, IDATE, *)
C
C   INPUT ARGUMENT LIST:
C     MSGTYP   - BUFR MESSAGE TYPE (CHARACTER)
C     IDATE    - BUFR MESSAGE DATE IN FORM YYYYMMDDHH
C
C   OUTPUT ARGUMENT LIST:
C     IUNO     - UNIT NUMBER OF OUTPUT LISTING FILE
C     *        - RETURN 1
C
C USAGE:    CALL PRINT_READ (IUNO, IREC)
C
C   INPUT ARGUMENT LIST:
C     IUNO     - UNIT NUMBER OF OUTPUT LISTING FILE
C     IREC     - RECORD NUMBER OF INPUT BUFR MESSAGE JUST READ
C
C REMARKS: NONE.
C
C ATTRIBUTES:
C   LANGUAGE: FORTRAN 90
C   MACHINE:  NCEP WCOSS
C
C$$$
      SUBROUTINE PRINT_KEY ( iuno, msgtyp , idate, * )

      PARAMETER ( NFILO = 20 )     ! Number of message types in PREPBUFR
                                   !  file

      INTEGER      ifirst ( NFILO )

      CHARACTER    msgtyp*8
      CHARACTER*6  filo

      LOGICAL      found

      COMMON  /UNITS/         iunso ( NFILO ), filo (NFILO )
      common /bitbuf/ maxbyt,ibit,ibay(5000),mbyt(32),mbay(5000,32)

      DATA         ifirst/NFILO*0/

C       Set the appropriate output file unit number based on the
C        BUFR message type the subset is in.
C       --------------------------------------------------------

      ifile = 1
      found = .false.
      DO WHILE  ( ( .not. found ) .and. ( ifile .le. NFILO ) )
          IF  ( msgtyp (1:6) .eq. filo ( ifile ) )  THEN
              found = .true.
              iuno = iunso ( ifile )
          ELSE
              ifile = ifile + 1
          END IF
      END DO
      IF  (  .not. found )  THEN
          RETURN 1
      END IF

      IF ( ifirst(ifile) .eq. 0 )  THEN

      WRITE  ( UNIT = iuno,
     + FMT = '("LISTING FOR MESSAGE TYPE ",A6//' //
     + '"Key for header:"/' //
     + '"SID  -- Station identification"/' //
     + '"YOB  -- Latitude (N+, S-)"/' //
     + '"XOB  -- Longitude (E)"/' //
     + '"ELV  -- Elevation (meters)"/' //
     + '"DHR  -- Observation time minus cycle time (hours)"/' //
     + '"RPT  -- Reported observation time (hours)"/' //
     + '"TCOR -- Indicator whether observation time used to ",' //
     +  '"generate DHR was corrected (0- Observation time is ",' //
     +  '"reported time, no"/9X,"correction, 1- Observation time ",' //
     +  '"corrected based on reported launch time, 2- Observation ",' //
     +  '"time corrected even though"/9X,"launch time is missing)"/' //
     + '"TYP  -- PREPBUFR report type"/' //
     + '"TSB  -- PREPBUFR report subtype"/' //
     + '"T29  -- Input report type"/' //
     + '"ITP  -- Instrument type (BUFR code table 0-02-001)"/' //
     + '"SQN  -- Report sequence number"/' //
     + '"PROCN - Process number for this MPI run (obtained from ",'//
     +  '"script)"/' //
     + '"SAID -- Satellite identifier (BUFR code table 0-01-007)"/'//
     + '"RSRD -- Restrictions on redistribution (BUFR flag table ",' //
     +  '"0-35-200) (if not printed there is no restriction - ",' //
     +  '"either zero or missing)"/' //
     + '"EXPRSRD -- Expiration of restrictions on redistribution ",' //
     +  '"(hours) (if not printed there is no restriction)")')
     +  msgtyp

      IF (msgtyp .eq. 'ADPUPA' ) then
         WRITE  ( UNIT = iuno, FMT =
     +    '("SIRC -- Rawinsonde solar & infrared radiation ",' //
     +     '"correction indicator (BUFR code table 0-02-013)"/' //
     +    '"SST1 -- Sea-surface temperature (Kelvin)"/' //
     +    '"SSTQM -- Sea-surface temperature quality mark (BUFR ",'//
     +     '"code table 0-22-246)"/' //
     +    '"HBLCS -- Height above surface of base of lowest cloud ",'//
     +     '"seen (BUFR code table 0-20-201)"/' //
     +    '"WDIR1 -- Surface wind direction (degrees)"/' //
     +    '"WSPD1 -- Surface wind speed (meters/sec)"/' //
     +    '"PRWE -- Present weather (BUFR code table 0-20-003)"/' //
     +    '"CLAM -- Cloud amount (BUFR code table 0-20-011)"/' //
     +    '"CLTP -- Cloud type (BUFR code table 0-20-012)"/' //
     +    '"HOCB -- Height of base of cloud (meters)"/' //
     +    '"HOCT -- Height of top of cloud (meters)"/' //
     +    '"AFIC -- Airframe icing (BUFR code table 0-20-041)"/' //
     +    '"HBOI -- Height of base of icing (meters)"/' //
     +    '"HTOI -- Height of top of icing (meters)"/' //
     +    '"DGOT -- Degree of turbulence (BUFR code table ",' //
     +     '"0-11-031)"/' //
     +    '"HBOT -- Height of base of turbulence (meters)"/' //
     +    '"HTOT -- Height of top of turbulence (meters)")')
      ELSE IF (msgtyp .eq. 'GOESND' .or. msgtyp .eq. 'SATEMP' ) then
         WRITE  ( UNIT = iuno, FMT =
     +    '("For reports with non-radiance data:"/' //
     +    '"  ACAV -- Total number with respect to accumulation or ",'//
     +     '"average"/' //
     +    '"  PRSS -- Surface pressure observation (mb)"/' //
     +    '"For reports with radiance data:"/' //
     +    '"  ELEV -- Satellite elevation (zenith angle - deg.)"/' //
     +    '"  SOEL -- Solar elevation (zenith angle - deg.)"/' //
     +    '"  OZON -- Total ozone (Dobson units)"/' //
     +    '"  TMSK -- Skin temperature (Kelvin)"/' //
     +    '"  CLAM -- Cloud Amount (BUFR code table 0-20-011)")')
      ELSE IF (msgtyp .eq. 'QKSWND' ) then
         WRITE  ( UNIT = iuno, FMT =
     +    '("ATRN -- Along track row number"/' //
     +    '"CTCN -- Cross track cell number"/' //
     +    '"SPRR -- Seawinds probability of rain (per cent)")')
      ELSE IF (msgtyp .eq. 'ASCATW' ) then
         WRITE  ( UNIT = iuno, FMT =
     +    '("CTCN -- Cross track cell number"/' //
     +    '"WVCQ -- Wind vector cell quality (BUFR flag table ",'//
     +     '"0-21-155)"/' //
     +    '"BSCD -- Backscatter distance"/' //
     +    '"LKCS -- Likelihood computed for solution")')
      ELSE IF (msgtyp .eq. 'WDSATR' ) then
         WRITE  ( UNIT = iuno, FMT =
     +    '("ACAV -- Total number with respect to accumulation or ",'//
     +     '"average"/' //
     +    '"MRWVC -- Total water vapor"/' //
     +    '"MRLWC -- Total cloud liquid water"/' //
     +    '"WSST -- WINDSAT surface type"/' //
     +    '"MWD10 -- Model wind direction at 10 meters"/' //
     +    '"MWS10 -- Model wind speed at 10 meters"/' //
     +    '"WSEQC1 -- WINDSAT EDR q.c. flag # 1"/' //
     +    '"CHSQ -- Chi-squared (of the wind vector retrieval)"/' //
     +    '"PHER -- Estimated error covariance for wind direction ",'//
     +     '"retrieval"/' //
     +    '"SPDE -- Estimated error covariance for wind speed ",'//
     +     '"retrieval"/' //
     +    '"SSTE -- Estimated error covariance for sea surface ",'//
     +     '"temperature retrieval"/' //
     +    '"CLDE -- Estimated error covariance for total cloud ",'//
     +     '"liquid water retrieval"/' //
     +    '"VPRE -- Estimated error covariance for total water ",'//
     +     '"vapor retrieval"/' //
     +    '"REQV -- Rainfall (average rate) observation")')
      ELSE IF (msgtyp .eq. 'AIRCAR' ) then
         WRITE  ( UNIT = iuno, FMT =
     +    '("ACID -- Aircraft flight number"/' //
     +    '"PCAT -- Precision of temperature obs. (Kelvin)"/' //
     +    '"POAF -- Phase of aircraft flight (BUFR code table ",' //
     +     '"0-08-004)"/' //
     +    '"TRBX10 -- Turbulence index for period TOB-1 min to ",' //
     +     '"TOB"/' //
     +    '"TRBX21 -- Turbulence index for period TOB-2 min to ",' //
     +     '"TOB-1 min"/' //
     +    '"TRBX32 -- Turbulence index for period TOB-3 min to ",' //
     +     '"TOB-2 min"/' //
     +    '"TRBX43 -- Turbulence index for period TOB-4 min to ",' //
     +     '"TOB-3 min"/' //
     +    '"MSTQ -- Moisture quality (BUFR code table 0-33-026)"/' //
     +    '"IALR -- Instantaneous altitude rate (meters/sec)"/' //
     +    '"NRLQMS -- NRL aircraft quality control mark (character)")')
      ELSE IF (msgtyp .eq. 'AIRCFT' ) then
         WRITE  ( UNIT = iuno, FMT =
     +    '("ACID -- Aircraft flight number"/' //
     +    '"RCT  -- Receipt time (hours)"/' //
     +    '"PCAT -- Precision of temperature obs. (Kelvin)"/' //
     +    '"POAF -- Phase of aircraft flight (BUFR code table ",' //
     +     '"0-08-004)"/' //
     +    '"TRBX -- Turbulence index (BUFR code table 0-11-235)"/' //
     +    '"ROLF -- Aircraft roll angle flag (BUFR code table ",' //
     +     '"0-02-199)"/' //
     +    '"MSTQ -- Moisture quality (BUFR code table 0-33-026)"/' //
     +    '"IALR -- Instantaneous altitude rate (meters/sec)"/' //
     +    '"PRWE -- Present weather (BUFR code table 0-20-003)"/' //
     +    '"CLAM -- Cloud amount (BUFR code table 0-20-011)"/' //
     +    '"CLTP -- Cloud type (BUFR code table 0-20-012)"/' //
     +    '"HOCB -- Height of base of cloud (meters)"/' //
     +    '"HOCT -- Height of top of cloud (meters)"/' //
     +    '"AFIC -- Airframe icing (BUFR code table 0-20-041)"/' //
     +    '"HBOI -- Height of base of icing (meters)"/' //
     +    '"HTOI -- Height of top of icing (meters)"/' //
     +    '"DGOT -- Degree of turbulence (BUFR code table ",' //
     +     '"0-11-031)"/' //
     +    '"HBOT -- Height of base of turbulence (meters)"/' //
     +    '"HTOT -- Height of top of turbulence (meters)"/' //
     +    '"NRLQMS -- NRL aircraft quality control mark (character)")')
      ELSE IF (msgtyp .eq. 'ADPSFC' ) then
         WRITE  ( UNIT = iuno, FMT =
     +    '("PMO  -- Mean sea-level pressure observation (mb)"/' //
     +    '"PMQ  -- Mean sea-level pressure quality marker"/' //
     +    '"SST1 -- Sea-surface temperature (Kelvin)"/' //
     +    '"SSTQM -- Sea-surface temperature quality mark (BUFR ",'//
     +     '"code table 0-22-246)"/' //
     +    '"MSST -- Method of sea-surface temperature measurement"/' //
     +    '"ALSE -- Altimeter setting observation (Pascals)"/' //
     +    '"SOB  -- Wind speed observation (stored when direction ",' //
     +     '"is missing) (meters/sec)"/' //
     +    '"SQM  -- Wind speed quality marker (stored when ",' //
     +     '"direction is missing)"/' //
     +    '".REHOVI -- Relationship to horizontal visibility (BUFR",' //
     +     '" code table 0-08-201)"/' //
     +    '"HOVI -- Horizontal visibility (meters)"/' //
     +    '"VTVI -- Vertical visibility (meters)"/' //
     +    '"PSW1 -- Past weather-1 (BUFR code table 0-20-004)"/' //
     +    '"PSW2 -- Past weather-2 (BUFR code table 0-20-005)"/' //
     +    '"PKWDSP -- Peak wind speed (meters/sec)"/' //
     +    '"PKWDDR -- Peak wind direction (degrees)"/' //
     +    '".DTMMXGS -- Duration in time over which maximum wind ",'//
     +     '"speed (gust) meanured (minutes)"/' //
     +    '"MXGS -- Maximum wind speed (gust) (meters/sec)"/' //
     +  '"TP01 -- Total precipitation past  1-hour  (kg/meters**2)"/' //
     +  '"TP03 -- Total precipitation past  3-hours (kg/meters**2)"/' //
     +  '"TP06 -- Total precipitation past  6-hours (kg/meters**2)"/' //
     +  '"TP12 -- Total precipitation past 12-hours (kg/meters**2)"/' //
     +  '"TP24 -- Total precipitation past 24-hours (kg/meters**2)"/' //
     +    '"TOSS -- Total sunshine (minutes)"/' //
     +    '"TOCC -- Total cloud cover (per cent)"/' //
     +    '"HBLCS -- Height above surface of base of lowest cloud ",' //
     +     '"seen (BUFR code table 0-20-201)"/' //
     +    '".DTHDOFS -- Duration of time over which depth of fresh ",'//
     +     '"snow measured (hours)"/' //
     +    '"DOFS -- Depth of fresh snow (meters)"/' //
     +    '"TOSD -- Total snow depth (meters)"/' //
     +    '"HOWV -- Height of waves (meters)"/' //
     +    '"POWV -- Period of waves (seconds)"/' //
     +    '"HOWW -- Height of wind waves (meters)"/' //
     +    '"POWW -- Period of wind waves (seconds)"/' //
     +    '"CHPT -- Characteristic of pressure tendency (BUFR ",' //
     +     '"code table 0-10-063)"/' //
     +    '"3HPC --  3-hour pressure change (Pascals)"/' //
     +    '"24PC -- 24-hour pressure change (Pascals)"/' //
     +    '".DTHTOPC -- Duration of time over which total precip./",'//
     +     '"total water equivalent measured (hours)"/' //
     +    '"TOPC -- Total precip./total water equivalent ",' //
     +     '"(kg/meters**2)"/' //
     +    '"PRWE -- Present weather (BUFR code table 0-20-003)"/' //
     +    '"VSSO -- Vertical significance (surface observations)",' //
     +     '" (BUFR code table 0-08-002)"/' //
     +    '"CLAM -- Cloud amount (BUFR code table 0-20-011)"/' //
     +    '"CLTP -- Cloud type (BUFR code table 0-20-012)"/' //
     +    '"HOCB -- Height of base of cloud (meters)"/' //
     +    '"HOCT -- Height of top of cloud (meters)"/' //
     +    '".DTHMXTM -- Duration of time over which maximum ",' //
     +     '"temperature is measured (hours)"/' //
     +    '"MXTM -- Maximum temperature (Kelvin)"/' //
     +    '".DTHMITM -- Duration of time over which minimum ",' //
     +     '"temperature is measured (hours)"/' //
     +    '"MITM -- Minimum temperature (Kelvin)"/' //
     +    '"DOSW -- Direction of swell waves (degrees)"/' //
     +    '"HOSW -- Height of swell waves (meters)"/' //
     +    '"POSW -- Period of swell waves (seconds)")')
      ELSE IF (msgtyp .eq. 'SFCSHP' ) then
         WRITE  ( UNIT = iuno, FMT =
     +    '("PMO  -- Mean sea-level pressure observation (mb)"/' //
     +    '"PMQ  -- Mean sea-level pressure quality marker"/' //
     +    '"SST1 -- Sea-surface temperature (Kelvin)"/' //
     +    '"SSTQM -- Sea-surface temperature quality mark (BUFR ",'//
     +     '"code table 0-22-246)"/' //
     +    '"DBSS -- Depth below sea surface for sea-surface ",' //
     +     '"temperature measurement (meters)"/' //
     +    '"MSST -- Method of sea-surface temperature measurement"/' //
     +    '"HOVI -- Horizontal visibility (meters)"/' //
     +    '"VTVI -- Vertical visibility (meters)"/' //
     +    '"PSW1 -- Past weather-1 (BUFR code table 0-20-004)"/' //
     +    '"PSW2 -- Past weather-2 (BUFR code table 0-20-005)"/' //
     +    '"PKWDSP -- Peak wind speed (meters/sec)"/' //
     +    '"PKWDDR -- Peak wind direction (degrees)"/' //
     +    '".DTMMXGS -- Duration in time over which maximum wind ",' //
     +     '"speed (gust) meanured (minutes)"/' //
     +    '"MXGS -- Maximum wind speed (gust) (meters/sec)"/' //
     +    '"TOCC -- Total cloud cover (per cent)"/' //
     +    '"HBLCS -- Height above surface of base of lowest cloud ",' //
     +     '"seen (BUFR code table 0-20-201)"/' //
     +    '"XS10 -- 10 meter extrapolated wind speed (meters/sec)"/' //
     +    '"XS20 -- 20 meter extrapolated wind speed (meters/sec)"/' //
     +    '"HOWV -- Height of waves (meters)"/' //
     +    '"POWV -- Period of waves (second)"/' //
     +    '"HOWW -- Height of wind waves (meters)"/' //
     +    '"POWW -- Period of wind waves (second)"/' //
     +    '"TDMP -- Direction of motion of ship during past ",' //
     +     '"3-hours (BUFR code table 0-01-193)"/' //
     +    '"ASMP -- Average speed of motion of ship during past ",' //
     +     '"3-hours (BUFR code table 0-01-200)"/' //
     +    '"CHPT -- Characteristic of pressure tendency (BUFR ",' //
     +     '"code table 0-10-063)"/' //
     +    '"3HPC --  3-hour pressure change (Pascals)"/' //
     +    '"24PC -- 24-hour pressure change (Pascals)"/' //
     +    '"PRWE -- Present weather (BUFR code table 0-20-003)"/' //
     +    '"VSSO -- Vertical significance (surface observations)",' //
     +     '" (BUFR code table 0-08-002)"/' //
     +    '"CLAM -- Cloud amount (BUFR code table 0-20-011)"/' //
     +    '"CLTP -- Cloud type (BUFR code table 0-20-012)"/' //
     +    '"HOCB -- Height of base of cloud (meters)"/' //
     +    '"HOCT -- Height of top of cloud (meters)")')
      ELSE IF (msgtyp .eq. 'MSONET' ) then
         WRITE  ( UNIT = iuno, FMT =
     +    '("ALSE -- Altimeter setting observation (Pascals)"/' //
     +    '"PRVSTG -- Mesonet provider ID string"/' //
     +    '"SPRVSTG - Mesonet subprovider ID string"/' //
     +    '"MXGS -- Maximum wind speed (gust) (meters/sec)"/' //
     +    '"MXGD -- Maximum wind gust direction (degrees)"/' //
     +    '".DTHTOPC -- Duration of time over which total precip./",'//
     +     '"total water equivalent measured (hours)"/' //
     +    '"TOPC -- Total precip./total water equivalent ",' //
     +     '"(kg/meters**2)")')
      ELSE IF (msgtyp .eq. 'SATWND' ) then
         WRITE  ( UNIT = iuno, FMT =
     +    '("RFFL -- Per cent confidence based on NESDIS recursive",' //
     +     '" filter function"/' //
     +    '"QIFY -- Per cent confidence based on EUMETSAT quality ",' //
     +     '"index with forecast consistency test"/' //
     +    '"QIFN -- Per cent confidence based on EUMETSAT quality ",' //
     +     '"index without forecast consistency test"/' //
     +    '"EEQF -- Per cent confidence based on NESDIS expected ",' //
     +     '"error"/' //
     +    '"SAZA -- Satellite zenith angle (degrees)")')
      ELSE IF (msgtyp .eq. 'GPSIPW' ) then
         WRITE  ( UNIT = iuno, FMT =
     +    '("PRSS -- Surface pressure observation (mb)")')
      END IF

      WRITE  ( UNIT = iuno, FMT = '(//"PREPBUFR FILE DATE IS: ",I10/)')
     +  idate

      END IF

      ifirst(ifile)=1

      RETURN

         ENTRY  PRINT_READ  ( iuno, irec )

         call status(11,lun,idummy1,idummy2)
         icat = iupbs01(mbay(1,lun),'MTYP')
         jcat = iupbs01(mbay(1,lun),'MSBT')
         write  ( unit = iuno,
     +    fmt = '(/"===> NEW BUFR MESSAGE READ IN - DATA CATEGORY",' //
     +    'I4,", SUB-CATEGORY",I4," (REC. #",I8,")")') icat,jcat,irec

         RETURN

      END

C$$$  SUBPROGRAM DOCUMENTATION BLOCK
C                .      .    .                                       .
C SUBPROGRAM:    INDEXF      GENERAL SORT ROUTINE FOR REAL ARRAY
C   PRGMMR: D. A. KEYSER     ORG: NP22       DATE: 1995-05-30
C
C ABSTRACT: USES EFFICIENT SORT ALGORITHM TO PRODUCE INDEX SORT LIST
C   FOR AN REAL ARRAY.  DOES NOT REARRANGE THE FILE.
C
C PROGRAM HISTORY LOG:
C 1993-06-05  R  KISTLER -- FORTRAN VERSION OF C-PROGRAM
C 1995-05-30  D. A. KEYSER - TESTS FOR < 2 ELEMENTS IN SORT LIST,
C             IF SO RETURNS WITHOUT SORTING (BUT FILLS INDX ARRAY)
C
C USAGE:    CALL INDEXF(N,ARRIN,INDX)
C   INPUT ARGUMENT LIST:
C     N        - SIZE OF ARRAY TO BE SORTED
C     ARRIN    - REAL ARRAY TO BE SORTED
C
C   OUTPUT ARGUMENT LIST:
C     INDX     - ARRAY OF POINTERS GIVING SORT ORDER OF ARRIN IN
C              - ASCENDING ORDER {E.G., ARRIN(INDX(I)) IS SORTED IN
C              - ASCENDING ORDER FOR ORIGINAL I = 1, ... ,N}
C
C REMARKS: NONE.
C
C ATTRIBUTES:
C   LANGUAGE: FORTRAN 90
C   MACHINE:  NCEP WCOSS
C
C$$$
      SUBROUTINE INDEXF(N,ARRIN,INDX)
      INTEGER  INDX(N)
      REAL  ARRIN(N)
      DO J = 1,N
         INDX(J) = J
      ENDDO
C MUST BE > 1 ELEMENT IN SORT LIST, ELSE RETURN
      IF(N.LE.1)  RETURN
      L = N/2 + 1
      IR = N
   33 CONTINUE
      IF(L.GT.1)  THEN
         L = L - 1
         INDXT = INDX(L)
         AA = ARRIN(INDXT)
      ELSE
         INDXT = INDX(IR)
         AA = ARRIN(INDXT)
         INDX(IR) = INDX(1)
         IR = IR - 1
         IF(IR.EQ.1)  THEN
            INDX(1) = INDXT
            RETURN
         END IF
      END IF
      I = L
      J = L * 2
   30 CONTINUE
      IF(J.LE.IR)  THEN
         IF(J.LT.IR)  THEN
            IF(ARRIN(INDX(J)).LT.ARRIN(INDX(J+1)))  J = J + 1
         END IF
         IF(AA.LT.ARRIN(INDX(J)))  THEN
            INDX(I) = INDX(J)
            I = J
            J = J + I
         ELSE
            J = IR + 1
         END IF
      END IF
      IF(J.LE.IR)  GO TO 30
      INDX(I) = INDXT
      GO TO 33
      END
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
      BLOCK DATA

      PARAMETER ( NHR8PM = 14 )    ! Actual number of BUFR parameters
                                   !  in header
      PARAMETER ( MXR8PM =  8 )    ! Maximum number of BUFR parameters
                                   !  in level data (non-radiance) or
                                   !  in channel data (radiance)
      PARAMETER ( MXR8LV = 255 )   ! Maximum number of BUFR levels/
                                   !                        channels
      PARAMETER ( MXR8VN = 10 )    ! Max. number of BUFR event sequences
                                   !  (non-radiance reports)
      PARAMETER ( MXR8VT = 17)     ! Max. number of BUFR variable types
                                   !  (non-radiance reports)
      PARAMETER ( NFILO = 20 )     ! Number of message types in PREPBUFR
                                   !  file

      REAL*8    hdr_8 ( NHR8PM ), obs2_8(61), aircar_hdr_8,
     +          aircft_hdr_8, adpupa_hdr_8, goesnd1_hdr_8(5),
     +          goesnd2_hdr_8(MXR8LV), adpsfc_hdr_8(4), sfcshp_hdr_8(2),
     +          msonet_hdr_8(2), satwnd_hdr_8(5), gpsipw_hdr_8,
     +          evns_8 ( MXR8PM, MXR8LV, MXR8VN, MXR8VT ),
     +          drft_8 ( 3, MXR8LV ), brts_8 ( MXR8PM, MXR8LV ),
     +          toth_8 ( 2, MXR8LV ),  acars_sup_8( 8, MXR8LV ),
     +          aircft_sup_8( 7, MXR8LV ), obs3_8(5,MXR8LV,7)

      INTEGER   indxvr1 ( 100:539 ), indxvr2 ( 100:539 ), nobs3(7)

      CHARACTER*11 c_nrlqms
      CHARACTER*6  filo

      COMMON  / PREPBC /      hdr_8, obs2_8, obs3_8, evns_8, drft_8,
     +  toth_8, acars_sup_8, aircft_sup_8, brts_8, aircar_hdr_8,
     +  aircft_hdr_8, adpupa_hdr_8, goesnd1_hdr_8, goesnd2_hdr_8,
     +  adpsfc_hdr_8, sfcshp_hdr_8, msonet_hdr_8, satwnd_hdr_8,
     +  gpsipw_hdr_8, indxvr1, indxvr2, nlev, nchn, nobs3, c_nrlqms

      COMMON  /UNITS/         iunso ( NFILO ), filo ( NFILO )

      DATA      nlev /0/, nchn /0/

      DATA      indxvr1
     + /  20*1,    30*1,   10,  15,   9,   9,    2*1,    4*11,    40*1 ,
C        100-119  120-149  150  151  152  153  154-155  156-159  160-199
     +    20*1,    40*1,    25*1,    1,   1,   13*1,  240*1    /
C        200-219  220-259  260-284  285  286  287-299 300-539

      DATA      indxvr2
     + /  20*4,    30*8,   10,  17,   9,   9,    2*6,    4*14,    40*6 ,
C        100-119  120-149  150  151  152  153  154-155  156-159  160-299
     +    20*6,    40*8,    25*6,    8,   8,   13*6,  240*8    /
C        200-219  220-259  260-284  285  286  287-299 300-539

      DATA      iunso
     +        /   51,   52,   53,   54,   55,
     +            56,   57,   58,   59,   60,
     +            61,   62,   63,   64,   65,
     +            66,   67,   68,   69,   70  /

      DATA         filo
     +        / 'ADPUPA', 'AIRCAR', 'AIRCFT', 'SATWND', 'PROFLR',
     +          'VADWND', 'RASSDA', 'SATEMP', 'ADPSFC', 'SFCSHP',
     +          'SFCBOG', 'MSONET', 'SPSSMI', 'SYNDAT', 'ERS1DA',
     +          'GOESND', 'QKSWND', 'GPSIPW', 'WDSATR', 'ASCATW'/

      END

inputEOF
set -x
#######################################################################

DEBUG="-ftrapuv -check all -check nooutput_conversion -fp-stack-check -fstack-protector"
##DEBUG=" "

ifort -c -O2 -convert big_endian -list -assume noold_ldout_format -auto -g -traceback ${DEBUG} read_prepbufr.f

ifort read_prepbufr.o /nwprod/lib/libbufr_v10.2.3_4_64.a \
 /nwprod/lib/libw3nco_4.a -o read_prepbufr.x

rm fort.*
cp $1  prepbufr.in
echo $2 > stdin
time -p ./read_prepbufr.x <stdin >read_prepbufr.out 2> errfile
err=$?

cat errfile >> read_prepbufr.out

if test "$err" -ne '0'
then
     echo "read_prepbufr failed - abnormal stop"

else
     echo "read_prepbufr successful - all done"
fi
rm fort.*
##cat read_prepbufr.out
