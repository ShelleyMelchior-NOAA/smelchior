<!doctype html public "-//w3c//dtd html 4.0 transitional//en">
<html>
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=us-ascii">
   <meta name="GENERATOR" content="Mozilla/4.7 [en] (Win98; U) [Netscape]">
   <meta name="Author" content="Dennis Keyser">
   <title>Sample Program to Decode Reports from PREPBUFR file</title>
</head>
<body>

<pre>C$$$&nbsp; MAIN PROGRAM DOCUMENTATION BLOCK
C&nbsp;&nbsp;
C MAIN PROGRAM:&nbsp; READ_PREPBUFR
C&nbsp;&nbsp; PRGMMR: KEYSER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ORG: NP22&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DATE: 2002-01-28
C
C ABSTRACT: READS SUBSETS (REPORTS) FROM A PREPBUFR FILE, MERGING
C&nbsp;&nbsp; MASS AND WIND SUBSETS FROM THE SAME ORIGINAL REPORT.&nbsp; MERGED
C&nbsp;&nbsp; REPORTS ARE PARSED ACCORDING TO THEIR BUFR MESSAGE TYPE AND
C&nbsp;&nbsp; ARE LISTED IN OUTPUT TEXT FILES.
C
C PROGRAM HISTORY LOG:
C ????-??-??&nbsp; WOOLLEN/GSC ORIGINAL AUTHOR
C ????-??-??&nbsp; ATOR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; STREAMLINED AND DOCUMENTED
C 2001-10-26&nbsp; KEYSER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FURTHER DOCUMENTATION FOR WEB, UPDATED
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TO REPLACE OBSOLETE MESSAGE TYPE "SATBOG"
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WITH "QKSWND"; ADDED MORE VARAIBLES AND
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MANY OTHER UPDATES
C 2002-01-28&nbsp; KEYSER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NOW THAT "PCAT" (PRECISION OF TEMPERATURE
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OBS.) HAS BEEN ADDED TO PREPBUFR FILE FOR
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "AIRCFT" AND "AIRCAR" MESSAGE TYPES, ADDED
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; THIS TO LISTING
C
C USAGE:
C&nbsp;&nbsp; INPUT FILES:
C&nbsp;&nbsp;&nbsp;&nbsp; UNIT 11&nbsp; - PREPBUFR FILE
C
C&nbsp;&nbsp; OUTPUT FILES:&nbsp;
C&nbsp;&nbsp;&nbsp;&nbsp; UNIT 06&nbsp; - UNIT 6 (STANDARD PRINTFILE)
C&nbsp;&nbsp;&nbsp;&nbsp; UNIT 51&nbsp; - LISTING OF REPORTS IN MESSAGE TYPE "ADPUPA"
C&nbsp;&nbsp;&nbsp;&nbsp; UNIT 52&nbsp; - LISTING OF REPORTS IN MESSAGE TYPE "AIRCAR"
C&nbsp;&nbsp;&nbsp;&nbsp; UNIT 53&nbsp; - LISTING OF REPORTS IN MESSAGE TYPE "AIRCFT"
C&nbsp;&nbsp;&nbsp;&nbsp; UNIT 54&nbsp; - LISTING OF REPORTS IN MESSAGE TYPE "SATWND"
C&nbsp;&nbsp;&nbsp;&nbsp; UNIT 55&nbsp; - LISTING OF REPORTS IN MESSAGE TYPE "PROFLR"
C&nbsp;&nbsp;&nbsp;&nbsp; UNIT 56&nbsp; - LISTING OF REPORTS IN MESSAGE TYPE "VADWND"
C&nbsp;&nbsp;&nbsp;&nbsp; UNIT 57&nbsp; - LISTING OF REPORTS IN MESSAGE TYPE "SATEMP"
C&nbsp;&nbsp;&nbsp;&nbsp; UNIT 58&nbsp; - LISTING OF REPORTS IN MESSAGE TYPE "ADPSFC"
C&nbsp;&nbsp;&nbsp;&nbsp; UNIT 59&nbsp; - LISTING OF REPORTS IN MESSAGE TYPE "SFCSHP"
C&nbsp;&nbsp;&nbsp;&nbsp; UNIT 60&nbsp; - LISTING OF REPORTS IN MESSAGE TYPE "SFCBOG"
C&nbsp;&nbsp;&nbsp;&nbsp; UNIT 61&nbsp; - LISTING OF REPORTS IN MESSAGE TYPE "SPSSMI"
C&nbsp;&nbsp;&nbsp;&nbsp; UNIT 62&nbsp; - LISTING OF REPORTS IN MESSAGE TYPE "SYNDAT"
C&nbsp;&nbsp;&nbsp;&nbsp; UNIT 63&nbsp; - LISTING OF REPORTS IN MESSAGE TYPE "ERS1DA"
C&nbsp;&nbsp;&nbsp;&nbsp; UNIT 64&nbsp; - LISTING OF REPORTS IN MESSAGE TYPE "GOESND"
C&nbsp;&nbsp;&nbsp;&nbsp; UNIT 65&nbsp; - LISTING OF REPORTS IN MESSAGE TYPE "QKSWND"
C
C&nbsp;&nbsp; SUBPROGRAMS CALLED:
C&nbsp;&nbsp;&nbsp;&nbsp; UNIQUE:&nbsp;&nbsp;&nbsp; - READPB&nbsp;&nbsp; INDEXF
C&nbsp;&nbsp;&nbsp;&nbsp; LIBRARY:
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; W3LIB&nbsp;&nbsp;&nbsp; - ERREXIT
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUFR&nbsp;&nbsp;&nbsp;&nbsp; - OPENBF&nbsp;&nbsp; DATELEN&nbsp; READNS&nbsp;&nbsp; UFBINT&nbsp;&nbsp; UFBEVN
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UFBQCP
C
C&nbsp;&nbsp; EXIT STATES:
C&nbsp;&nbsp;&nbsp;&nbsp; COND =&nbsp;&nbsp; 0 - SUCCESSFUL RUN
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 22 - ABORT, NUMBER OF BALLOON DRIFT LEVELS RETURNED
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DOES NOT EQUAL NUMBER OF P/T/Z/Q/U/V LEVELS
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RETURNED (ADPUPA MESSAGE TYPE ONLY)
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 33 - ABORT, NUMBER OF VIRTUAL TEMP./DEWPOINT TEMP.
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LEVELS RETURNED DOES NOT EQUAL NUMBER OF
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; P/T/Z/Q/U/V LEVELS RETURNED (ADPUPA MESSAGE
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TYPE ONLY)
C
C REMARKS: IN THIS PROGRAM, THE TERM "SUBSET" REFERS TO THE
C&nbsp;&nbsp; COMPONENTS IN A BUFR MESSAGE.&nbsp; THESE COULD BE CONSIDERED TO
C&nbsp;&nbsp; BE "REPORTS" IN THE PREPBUFR FILE.&nbsp; HERE, "REPORT" IS USED TO
C&nbsp;&nbsp; REFER TO THE FINAL PRODUCT WHICH CONTAINS MERGED MASS AND WIND
C&nbsp;&nbsp; SUBSETS FROM THE SAME ORIGINAL OBSERVATION.
C
C ATTRIBUTES:
C&nbsp;&nbsp; LANGUAGE: FORTRAN 90
C&nbsp;&nbsp; MACHINE:&nbsp; IBM SP, SGI
C
C$$$

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PROGRAM&nbsp;&nbsp; READ_PREPBUFR

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REAL*8&nbsp;&nbsp;&nbsp; R8BFMS

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PARAMETER ( R8BFMS = 9.0E08 )! Missing value threshhold for BUFR
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PARAMETER ( NHR8PM = 14 )&nbsp;&nbsp;&nbsp; ! Actual number of BUFR parameters
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !&nbsp; in header
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PARAMETER ( MXR8PM =&nbsp; 8 )&nbsp;&nbsp;&nbsp; ! Maximum number of BUFR parameters
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !&nbsp; in level data (non-radiance) or
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !&nbsp; in channel data (radiance)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PARAMETER ( MXR8LV = 255 )&nbsp;&nbsp; ! Maximum number of BUFR levels/
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; channels
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PARAMETER ( MXR8VN = 10 )&nbsp;&nbsp;&nbsp; ! Max. number of BUFR event sequences
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !&nbsp; (non-radiance reports)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PARAMETER ( MXR8VT = 17)&nbsp;&nbsp;&nbsp;&nbsp; ! Max. number of BUFR variable types
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !&nbsp; (non-radiance reports)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PARAMETER ( NFILO = 15 )

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REAL*8&nbsp;&nbsp;&nbsp; hdr ( NHR8PM ), qkswnd_hdr(3), aircar_hdr(6),
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aircft_hdr(4),&nbsp; adpupa_hdr(1), goesnd1_hdr(6),
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goesnd2_hdr(MXR8LV), adpsfc_hdr(5), sfcshp_hdr(2),
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; satwnd_hdr(1), evns ( MXR8PM, MXR8LV, MXR8VN, MXR8VT ),
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drft ( 3, MXR8LV ), brts ( MXR8PM, MXR8LV ),
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; toth ( 2, MXR8LV )

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INTEGER&nbsp;&nbsp; ifirst ( NFILO ), iunso ( NFILO ), indxvr1 ( 100:299 ),
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; indxvr2 ( 100:299 )

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHARACTER&nbsp;&nbsp;&nbsp; msgtyp*8, qc_step*8
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHARACTER*18 var ( MXR8VT )
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHARACTER*6&nbsp; filo ( NFILO )

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LOGICAL&nbsp;&nbsp; found

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; COMMON&nbsp; / PREPBC /&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdr, evns, drft, toth, brts, qkswnd_hdr,
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp; aircar_hdr, aircft_hdr, adpupa_hdr, goesnd1_hdr, goesnd2_hdr,
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp; adpsfc_hdr, sfcshp_hdr, satwnd_hdr, indxvr1, indxvr2, nlev, nchn

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DATA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iunso
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /&nbsp;&nbsp; 51,&nbsp;&nbsp; 52,&nbsp;&nbsp; 53,&nbsp;&nbsp; 54,&nbsp;&nbsp; 55,
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 56,&nbsp;&nbsp; 57,&nbsp;&nbsp; 58,&nbsp;&nbsp; 59,&nbsp;&nbsp; 60,
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 61,&nbsp;&nbsp; 62,&nbsp;&nbsp; 63,&nbsp;&nbsp; 64,&nbsp;&nbsp; 65&nbsp; /
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DATA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; var /
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp; 'PRESSURE (MB)&nbsp;&nbsp;&nbsp;&nbsp; ','SP HUMIDITY(MG/KG)','TEMPERATURE (C)&nbsp;&nbsp; ',
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp; 'HEIGHT (METERS)&nbsp;&nbsp; ','U-COMP WIND (M/S) ','V-COMP WIND (M/S) ',
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp; 'WIND DIR (DEG)&nbsp;&nbsp;&nbsp; ','WIND SPEED (KNOTS)','TOTAL PWATER (MM) ',
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp; 'RAIN RATE (MM/HR) ','1.-.9 sig PWAT(MM)','.9-.7 sig PWAT(MM)',
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp; '.7-.3 sig PWAT(MM)','.3-0. sig PWAT(MM)','CLOUD-TOP PRES(MB)',
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp; 'CLOUD-TOP TEMP (K)','TOT. CLD. COVER(%)' /
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DATA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; filo
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; / 'ADPUPA', 'AIRCAR', 'AIRCFT', 'SATWND', 'PROFLR',
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'VADWND', 'SATEMP', 'ADPSFC', 'SFCSHP', 'SFCBOG',
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'SPSSMI', 'SYNDAT', 'ERS1DA', 'GOESND', 'QKSWND'/

C-----------------------------------------------------------------------

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IFIRST = 0

C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Open the output files.
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ----------------------

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DO ifile = 1, NFILO
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OPEN&nbsp; ( UNIT = iunso ( ifile ),
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FILE = 'readpb.out.' // filo ( ifile ) )
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END DO

C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Open the input PREPBUFR file.
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -----------------------------

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OPEN&nbsp; ( UNIT = 11, FILE = 'prepbufr.in', FORM = 'UNFORMATTED' )
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CALL OPENBF(11,'IN',11 )&nbsp; ! BUFRLIB routine to open file
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CALL DATELEN(10)&nbsp; ! BUFRLIB routine to use 10-digit date

C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Get the next subset from the input file.&nbsp; Merge mass and
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wind subsets for the same "true" report.
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --------------------------------------------------------

&nbsp; 10&nbsp; CALL READPB(11,msgtyp,idate,ierrpb )
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF ( ierrpb .eq. -1 )&nbsp; THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; print *, '1-All subsets read in and processed'
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; STOP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ! All subsets read in and processed
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END IF

C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Set the appropriate output file unit number based on the
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUFR message type the subset is in.
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --------------------------------------------------------

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ifile = 1
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; found = .false.
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DO WHILE&nbsp; ( ( .not. found ) .and. ( ifile .le. NFILO ) )
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF&nbsp; ( msgtyp (1:6) .eq. filo ( ifile ) )&nbsp; THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; found = .true.
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iuno = iunso ( ifile )
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELSE
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ifile = ifile + 1
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END IF
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END DO
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF&nbsp; ( ( .not. found ) .and. ( ierrpb .eq. 0 ) )&nbsp; THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GO TO 10
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END IF

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF ( ifirst(ifile) .eq. 0 )&nbsp; THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE&nbsp; ( UNIT = iuno,
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; FMT = '("LISTING FOR MESSAGE TYPE ",A6//' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; '"Key for header:"/' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; '"SID&nbsp; -- Station identification"/' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; '"YOB&nbsp; -- Latitude (N+, S-)"/' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; '"XOB&nbsp; -- Longitude (E)"/' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; '"ELV&nbsp; -- Elevation (meters)"/' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; '"DHR&nbsp; -- Observation time minus cycle time (hours)"/' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; '"RPT&nbsp; -- Reported observation time (hours)"/' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; '"TCOR -- Indicator whether observation time used to ",' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp; '"generate DHR was corrected (0- Observation time ",' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp; '"is reported time, no"/9X,"correction, 1- Observation ",' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp; '"time corrected based on reported launch time, 2- ",' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp; '"Observation time corrected even though"/9X,"launch ", ' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp; '"time is missing)"/' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; '"TYP&nbsp; -- PREPBUFR report type"/' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; '"TSB&nbsp; -- PREPBUFR report subtype"/' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; '"T29&nbsp; -- Input report type"/' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; '"ITP&nbsp; -- Instrument type (BUFR code table 0-02-001)"/' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; '"SQN&nbsp; -- Report sequence number"/' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; '"PROCN - Process number for this MPI run (obtained from ",'//
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp; '"script)"/' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; '"SAID -- Satellite identifier (BUFR code table 0-01-007)")')
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; filo(ifile)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF (filo(ifile) .eq. 'ADPUPA' ) then
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE&nbsp; ( UNIT = iuno, FMT =
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '("SIRC -- Rawinsonde solar &amp; infrared radiation ",' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '"correction indicator (BUFR code table 0-02-013)")')
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELSE IF (filo(ifile) .eq. 'GOESND' .or.
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; filo(ifile) .eq. 'SATEMP' ) then
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE&nbsp; ( UNIT = iuno, FMT =
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '("For reports with non-radiance data:"/' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '"&nbsp; ACAV -- Total number with respect to accumulation ",'//
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '"or average"/' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '"&nbsp; PRSS -- Surface pressure observation (mb)"/' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '"For reports with radiance data:"/' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '"&nbsp; ELEV -- Satellite elevation (zenith angle - deg.)"/' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '"&nbsp; SOEL -- Solar elevation (zenith angle - deg.)"/' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '"&nbsp; OZON -- Total ozone (Dobson units)"/' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '"&nbsp; TMSK -- Skin temperature (Kelvin)"/' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '"&nbsp; CLAM -- Cloud Amount (BUFR code table 0-20-011)")')
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELSE IF (filo(ifile) .eq. 'QKSWND' ) then
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE&nbsp; ( UNIT = iuno, FMT =
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '("ATRN -- Along track row number"/' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '"CTCN -- Cross track cell number"/' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '"SPRR -- Seawinds probability of rain (%)")')
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELSE IF (filo(ifile) .eq. 'AIRCAR' ) then
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE&nbsp; ( UNIT = iuno, FMT =
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '("PCAT -- Precision of temperature obs. (Kelvin)"/' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '"POAF -- Phase of aircraft flight (BUFR code table ",' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '"0-08-004)"/' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '"TRBX10 -- Turbulence index for period TOB-1 min to ",' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '"TOB"/' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '"TRBX21 -- Turbulence index for period TOB-2 min to ",' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '"TOB-1 min"/' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '"TRBX32 -- Turbulence index for period TOB-3 min to ",' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '"TOB-2 min"/' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '"TRBX43 -- Turbulence index for period TOB-4 min to ",' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '"TOB-3 min")')
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELSE IF (filo(ifile) .eq. 'AIRCFT' ) then
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE&nbsp; ( UNIT = iuno, FMT =
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '("RCT&nbsp; -- Receipt time (hours)"/' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '"PCAT -- Precision of temperature obs. (Kelvin)"/' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '"POAF -- Phase of aircraft flight (BUFR code table ",' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '"0-08-004)"/' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '"DGOT -- Degree of turbulence (BUFR code table ",' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '"0-11-031)")')
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELSE IF (filo(ifile) .eq. 'ADPSFC' ) then
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE&nbsp; ( UNIT = iuno, FMT =
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '("PMO&nbsp; -- Mean sea-level pressure observation (mb)"/' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '"PMQ&nbsp; -- Mean sea-level pressure quality marker"/' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '"ALSE -- Altimeter setting observation (mb)"/' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '"SOB&nbsp; -- Wind speed observation (stored when ",' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '"direction is missing) (m/s)"/' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '"SQM&nbsp; -- Wind speed quality marker (stored when ",' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '"direction is missing)")')
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELSE IF (filo(ifile) .eq. 'SFCSHP' ) then
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE&nbsp; ( UNIT = iuno, FMT =
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '("PMO&nbsp; -- Mean sea-level pressure observation (mb)"/' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '"PMQ&nbsp; -- Mean sea-level pressure quality marker")')
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELSE IF (filo(ifile) .eq. 'SATWND' ) then
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE&nbsp; ( UNIT = iuno, FMT =
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '("RFFL -- NESDIS recursive filter flag")')
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END IF
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE  ( UNIT = iuno, FMT = '(//"PREPBUFR FILE DATE IS: ",
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; I10)') idate
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE&nbsp; ( UNIT = iuno, FMT = '(/)')
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ifirst(ifile)=1
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END IF

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE&nbsp; ( UNIT = iuno,
&nbsp;&nbsp;&nbsp;&nbsp; + FMT = '(/"SID=",A8,", YOB=",F6.2,", XOB=",F6.2,", ELV=",I5,' //
&nbsp;&nbsp;&nbsp;&nbsp; + '", DHR=",F6.3,", RPT=",F8.3,", TCOR=",I1,", TYP=",I3,' //
&nbsp;&nbsp;&nbsp;&nbsp; + '", TSB=",I1,", T29=",I3,", ITP=",I2,", SQN=",I6/,"PROCN=",I2,'//
&nbsp;&nbsp;&nbsp;&nbsp; + '", SAID=",I3)')
&nbsp;&nbsp;&nbsp;&nbsp; + (hdr(ii),ii=1,3),nint(hdr(4)),hdr(5),hdr(6),(nint(hdr(ii)),
&nbsp;&nbsp;&nbsp;&nbsp; + ii=7,14)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF (filo(ifile) .eq. 'ADPUPA' ) then
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE&nbsp; ( UNIT = iuno, FMT = '("SIRC=",I2)') nint(adpupa_hdr)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELSE IF (filo(ifile) .eq. 'GOESND' .or.
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; filo(ifile) .eq. 'SATEMP' ) then
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF (nlev.gt.0)&nbsp; THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE&nbsp; ( UNIT = iuno, FMT = '("ACAV=",I3,", PRSS=",F6.1)')
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nint(goesnd1_hdr(1)),goesnd2_hdr(1)*0.01
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END IF
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF (nchn.gt.0)&nbsp; THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE&nbsp; ( UNIT = iuno, FMT = '("ELEV=",F6.2,", SOEL=",' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'F6.2,", OZON=",I4,", TMSK=",F5.1,", CLAM=",I2)')
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goesnd1_hdr(2),goesnd1_hdr(3),nint(goesnd1_hdr(4)),
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goesnd1_hdr(5),nint(goesnd1_hdr(6))
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END IF
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELSE IF (filo(ifile) .eq. 'QKSWND' ) then
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE&nbsp; ( UNIT = iuno, FMT = '("ATRN=",I3,", CTCN=",I3,' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp; '", SPRR=",I3)') (nint(qkswnd_hdr(ii)),ii=1,3)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELSE IF (filo(ifile) .eq. 'AIRCAR' ) then
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE&nbsp; ( UNIT = iuno, FMT = '("PCAT=",F5.2,", POAF=",I3,' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; '", TRBX10=",I3,", TRBX21=",I3,", TRBX32=",I3,", TRBX43=",I3)')
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; aircar_hdr(1),(nint(aircar_hdr(ii)),ii=2,6)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELSE IF (filo(ifile) .eq. 'AIRCFT' ) then
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE&nbsp; ( UNIT = iuno, FMT = '("RCT=",F7.2,", PCAT=",F5.2,' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; '", POAF=",I3,", DGOT=",I3)') aircft_hdr(1),aircft_hdr(2),
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; (nint(aircft_hdr(ii)),ii=3,4)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELSE IF (filo(ifile) .eq. 'ADPSFC' ) then
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE&nbsp; ( UNIT = iuno, FMT = '("PMO=",F6.1,", PMQ=",I2,' //
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; '", ALSE=",F6.1,", SOB=",F5.1,", SQM=",I2)')
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp; adpsfc_hdr(1),nint(adpsfc_hdr(2)),adpsfc_hdr(3)*0.01,
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp; adpsfc_hdr(4),nint(adpsfc_hdr(5))
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELSE IF (filo(ifile) .eq. 'SFCSHP' ) then
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE&nbsp; ( UNIT = iuno, FMT = '("PMO=",F6.1,", PMQ=",I2)')
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp; sfcshp_hdr(1),nint(sfcshp_hdr(2))
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELSE IF (filo(ifile) .eq. 'SATWND' ) then
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE&nbsp; ( UNIT = iuno, FMT = '("RFFL=",I3)') nint(satwnd_hdr(1))
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END IF

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF (nlev .gt. 0 )&nbsp; THEN

C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Print the level (non-radiance) data for report (if separate
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mass &amp; wind pieces in PREPBUFR file, these have been merged).
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --------------------------------------------------------------

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DO lv = 1, nlev&nbsp; ! loop through the levels
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE&nbsp; ( UNIT = iuno, FMT = '( 94("-") )' )
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE&nbsp; ( UNIT = iuno,
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FMT = '( 10X,"level ", I4, 2X, A9,A8,A10,5A9 )' )
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lv, 'obs&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ', 'qmark&nbsp;&nbsp; ', 'qc_step&nbsp;&nbsp; ', 'rcode&nbsp;&nbsp;&nbsp; ',
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'fcst&nbsp;&nbsp;&nbsp;&nbsp; ', 'anal&nbsp;&nbsp;&nbsp;&nbsp; ', 'oberr&nbsp;&nbsp;&nbsp; ', 'category '
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE&nbsp; ( UNIT = iuno, FMT = '( 94("-") )' )
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DO kk = indxvr1(nint(hdr(8))),indxvr2(nint(hdr(8)))
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ! loop through the variables
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF( kk .eq. 10 )&nbsp; ! convert rain rate from mm/s to mm/hr
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; evns( 1, lv, :,kk) = evns( 1, lv, :,kk)*3600.0_8
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF( kk .eq. 15 ) ! convert cloud-top press. from Pa to mb
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; evns( 1, lv, :,kk) = evns( 1, lv, :,kk)*0.01
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DO jj = 1, MXR8VN&nbsp; ! loop through the events
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF(min(evns(1,lv,jj,kk),evns(2,lv,jj,kk),
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; evns(3,lv,jj,kk),evns(4,lv,jj,kk),
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; evns(5,lv,jj,kk),evns(6,lv,jj,kk),
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; evns(7,lv,jj,kk))
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .lt. R8BFMS) THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF(evns(3,lv,jj,kk) .le. R8BFMS) THEN

C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Copy forecast value, analyzed value, observation error and
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PREPBUFR category from latest event sequence to all earlier
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; valid event sequences
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --------------------------------------------------------------

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; evns(5:8,lv,jj,kk) = evns(5:8,lv,1,kk)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pcode = evns(3,lv,jj,kk)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CALL UFBQCP(11,pcode,QC_STEP)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELSE
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QC_STEP = '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END IF
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE&nbsp; ( UNIT = iuno,
&nbsp;&nbsp;&nbsp;&nbsp; + FMT = '( A18,1X,F8.1,2X,F6.0,4X,A8,2X,F5.0,3(1X,F8.1),2X,F7.0)' )
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; var (kk), ( evns ( ii, lv, jj, kk ), ii = 1, 2 ),
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qc_step,&nbsp; ( evns ( ii, lv, jj, kk ), ii = 4, 8 )
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END IF
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END DO
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END DO
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF ( msgtyp .eq. 'ADPUPA' )&nbsp; THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE&nbsp; ( UNIT = iuno,
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; FMT = '( 10X,"BALLOON DRIFT: D-TIME(HRS)=",F7.3,", LAT(N)=",
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; F6.2,", LON(E)=",F6.2)' ) ( drft ( ii, lv), ii = 1,3)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF(min(toth(1,lv),toth(2,lv)) .lt. R8BFMS)
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE&nbsp; ( UNIT = iuno,
&nbsp;&nbsp;&nbsp;&nbsp; + FMT = '( 10X,"Through PREPRO STEP only: VIRTUAL TEMP (C)=",F8.1,
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ", DEWPOINT TEMP (C)=",F8.1)' ) toth (1,lv), toth (2,lv)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END IF
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END DO
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END IF

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF (nchn .gt. 0 )&nbsp; THEN

C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Print the channel (radiance) data for report
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --------------------------------------------

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE&nbsp; ( UNIT = iuno, FMT = '( 42("-") )' )
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE&nbsp; ( UNIT = iuno,
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FMT = '("BRIGHTNESS TEMP&nbsp; channel&nbsp; observation (K)")')
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE&nbsp; ( UNIT = iuno, FMT = '( 42("-") )' )
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DO lv = 1, nchn&nbsp; ! loop through the channels
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF(min(brts(1,lv),brts(2,lv)) .lt. R8BFMS) THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WRITE&nbsp; ( UNIT = iuno, FMT = '(19X,I3,7X,F6.2)' )
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nint(brts(1,lv)), brts(2,lv)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END IF
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END DO
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END IF

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF&nbsp; ( ierrpb .eq. 0 )&nbsp; GO TO 10

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; print *, '2-All subsets read in and processed'

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; STOP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ! All subsets read in and processed

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END

C$$$&nbsp; SUBPROGRAM DOCUMENTATION BLOCK
C
C SUBPROGRAM:&nbsp;&nbsp;&nbsp; READPB
C&nbsp;&nbsp; PRGMMR: KEYSER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ORG: NP12&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DATE: 2002-01-28
C
C ABSTRACT: THIS SUBROUTINE READS IN SUBSETS FROM THE PREPBUFR
C&nbsp;&nbsp; FILE.&nbsp; SINCE ACTUAL OBSERVATIONS ARE SPLIT INTO MASS AND
C&nbsp;&nbsp; WIND SUBSETS, THIS ROUTINE COMBINES THEM INTO A SINGLE
C&nbsp;&nbsp; REPORT FOR OUTPUT.&nbsp; IT IS STYLED AFTER BUFRLIB ENTRY POINT
C&nbsp;&nbsp; READNS, AND IT ONLY REQUIRES THE PREPBUFR FILE TO BE OPENED
C&nbsp;&nbsp; FOR READING WITH OPENBF.&nbsp; THE COMBINED REPORT IS RETURNED TO
C&nbsp;&nbsp; THE CALLER IN COMMON /PREPBC/.&nbsp; THIS COMMON AREA CONTAINS
C&nbsp;&nbsp; THE NUMBER OF LEVELS (NON-RADIANCES) IN THE REPORT, THE
C&nbsp;&nbsp; NUMBER OF CHANNELS (RADIANCES) IN THE REPORT, A ONE
C&nbsp;&nbsp; DIMENSIONAL ARRAY WITH THE HEADER INFORMATION, A FOUR
C&nbsp;&nbsp; DIMENSIONAL ARRAY CONTAINING ALL EVENTS FROM ALL
C&nbsp;&nbsp; NON-RADIANCE OBSERVATIONAL VARIABLE TYPES, AND A TWO
C&nbsp;&nbsp; DIMENSIONAL ARRAY CONTAINING ALL CHANNELS OF BRIGHTNESS
C&nbsp;&nbsp; TEMPERATURE FOR REPORTS CONTAINING RADIANCE DATA.
C
C PROGRAM HISTORY LOG:
C ????-??-??&nbsp; WOOLLEN/GSC ORIGINAL AUTHOR
C ????-??-??&nbsp; ATOR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; STREAMLINED AND DOCUMENTED
C 2001-10-26&nbsp; KEYSER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FURTHER DOCUMENTATION FOR WEB, UPDATED
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TO REPLACE OBSOLETE MESSAGE TYPE "SATBOG"
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WITH "QKSWND"; ADDED MORE VARAIBLES AND
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MANY OTHER UPDATES
C 2002-01-28&nbsp; KEYSER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NOW THAT "PCAT" (PRECISION OF TEMPERATURE
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OBS.) HAS BEEN ADDED TO PREPBUFR FILE FOR
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "AIRCFT" AND "AIRCAR" MESSAGE TYPES, ADDED
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; THIS TO LISTING
C
C USAGE:&nbsp;&nbsp;&nbsp; CALL READPB&nbsp; (LUNIT, MSGTYP, IDATE, IRET)
C&nbsp;&nbsp; INPUT ARGUMENT LIST:
C&nbsp;&nbsp;&nbsp;&nbsp; LUNIT&nbsp;&nbsp;&nbsp; - UNIT NUMBER OF INPUT PREPBUFR FILE
C
C&nbsp;&nbsp; OUTPUT ARGUMENT LIST:
C&nbsp;&nbsp;&nbsp;&nbsp; MSGTYP&nbsp;&nbsp; - BUFR MESSAGE TYPE (CHARACTER)
C&nbsp;&nbsp;&nbsp;&nbsp; IDATE&nbsp;&nbsp;&nbsp; - BUFR MESSAGE DATE IN FORM YYYYMMDDHH
C&nbsp;&nbsp;&nbsp;&nbsp; IRET&nbsp;&nbsp;&nbsp;&nbsp; - ERROR RETURN CODE (0 - normal return; 1 - the report
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; within COMMON /PREPBC/ contains the last available
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; report from within the prepbufr file; -1 - there are
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; no more reports available from within the PREPBUFR
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; file, all subsets have been processed)
C
C REMARKS:&nbsp;
C&nbsp;
C&nbsp;&nbsp; The header array HDR contains the following list of mnemonics:
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HDR(1)&nbsp; Station identification (SID)
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HDR(2)&nbsp; Latitude&nbsp; (YOB)
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HDR(3)&nbsp; Longitude (XOB)
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HDR(4)&nbsp; Elevation (ELV)
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HDR(5)&nbsp; Observation time minus cycle time (DHR)
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HDR(6)&nbsp; Reported observation time (RPT)
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HDR(7)&nbsp; Indicator whether observation time used to generate
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "DHR" was corrected (TCOR)
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HDR(8)&nbsp; PREPBUFR report type (TYP)
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HDR(9) PREPBUFR report subtype (TSB)
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HDR(10) Input report type (T29)
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HDR(11) Instrument type (ITP)
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HDR(12) Report sequence number (SQN)
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HDR(13) Process number for this MPI run (obtained from
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; script (PROCN)
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HDR(14) Satellite identifier (SAID)
C&nbsp;
C&nbsp;&nbsp; The 4-D array of non-radiance data, EVNS (ii, lv, jj, kk), is
C&nbsp;&nbsp;&nbsp; indexed as follows:
C&nbsp;&nbsp;&nbsp;&nbsp; "ii" indexes the event data types; these consist of:
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1) Observation&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (e.g., POB, ZOB, UOB, VOB, TOB, QOB, PWO)
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2) Quality mark&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (e.g., PQM, ZRM, WQM, TQM, QQM, PWQ)
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3) Program code&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (e.g., PPC, ZPC, WPC, TPC, QPC, PWP)
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4) Reason code&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (e.g., PRC, ZRC, WRC, TRC, QRC, PWR)
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5) Forecast value&nbsp;&nbsp;&nbsp; (e.g., PFC, ZFC, UFC, VFC, TFC, QFC, PWF)
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6) Analyzed value&nbsp;&nbsp;&nbsp; (e.g., PAN, ZAN, UAN, VAN, TAN, QAN, PWA)
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7) Observation error (e.g., POE, ZOE, WOE, TOE, QOE, PWO)
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8) PREPBUFR data level category (CAT)
C&nbsp;&nbsp;&nbsp;&nbsp; "lv" indexes the levels of the report
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1) Lowest level
C&nbsp;&nbsp;&nbsp;&nbsp; "jj" indexes the event stacks
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1) N'th event
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2) (N-1)'th event (if present)
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3) (N-2)'th event (if present)
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ...
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10) (N-9)'th event (if present)
C&nbsp;&nbsp;&nbsp;&nbsp; "kk" indexes the variable types
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1) Pressure
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2) Specific humidity
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 3) Temperature
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4) Height
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5) U-component wind
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6) V-component wind
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7) Wind direction
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8) Wind speed
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 9) Total precipitable water
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10) Rain rate
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 11) 1.0 to 0.9 sigma layer precipitable water
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12) 0.9 to 0.7 sigma layer precipitable water
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 13) 0.7 to 0.3 sigma layer precipitable water
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 14) 0.3 to 0.0 sigma layer precipitable water
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 15) Cloud-top pressure
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16) Cloud-top temperature
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17) Total cloud cover
C&nbsp;
C&nbsp;&nbsp;&nbsp;&nbsp; Note that the structure of this array is identical to one
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; returned from BUFRLIB routine UFBEVN, with an additional (4'th)
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dimension to include the 14 variable types into the same
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; array.
C&nbsp;
C&nbsp;&nbsp; The 2-D array of radiance data, BRTS (ii, lv), is indexed
C&nbsp;&nbsp;&nbsp; as follows:
C&nbsp;&nbsp;&nbsp;&nbsp; "ii" indexes the event data types; these consist of:
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1) Observation&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (CHNM, TMBR)
C&nbsp;&nbsp;&nbsp;&nbsp; "lv" indexes the channels (CHNM gives channel number)
C&nbsp;
C&nbsp;&nbsp;&nbsp;&nbsp; Note that this array is directly returned from BUFRLIB
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; routine UFBINT.
C
C
C ATTRIBUTES:
C&nbsp;&nbsp; LANGUAGE: FORTRAN 90
C&nbsp;&nbsp; MACHINE:&nbsp; IBM SP
C
C$$$
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SUBROUTINE READPB&nbsp; ( lunit, msgtyp, idate, iret )

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REAL*8&nbsp;&nbsp;&nbsp; R8BFMS

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PARAMETER ( R8BFMS = 9.0E08 )! Missing value threshhold for BUFR
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PARAMETER ( NHR8PM = 14 )&nbsp;&nbsp;&nbsp; ! Actual number of BUFR parameters
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !&nbsp; in header
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PARAMETER ( MXR8PM =&nbsp; 8 )&nbsp;&nbsp;&nbsp; ! Maximum number of BUFR parameters
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !&nbsp; in level data (non-radiance) or
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !&nbsp; in channel data (radiance)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PARAMETER ( MXR8LV = 255 )&nbsp;&nbsp; ! Maximum number of BUFR levels/
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; channels
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PARAMETER ( MXR8VN = 10 )&nbsp;&nbsp;&nbsp; ! Max. number of BUFR event sequences
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !&nbsp; (non-radiance reports)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PARAMETER ( MXR8VT = 17)&nbsp;&nbsp;&nbsp;&nbsp; ! Max. number of BUFR variable types
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !&nbsp; (non-radiance reports)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PARAMETER ( MXSTRL = 80 )&nbsp;&nbsp;&nbsp; ! Maximum size of a string

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REAL*8&nbsp;&nbsp;&nbsp; hdr ( NHR8PM ), qkswnd_hdr(3), aircar_hdr(6),
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aircft_hdr(4),&nbsp; adpupa_hdr(1), goesnd1_hdr(6),
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goesnd2_hdr(MXR8LV), adpsfc_hdr(5), sfcshp_hdr(2),
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; satwnd_hdr(1), evns ( MXR8PM, MXR8LV, MXR8VN, MXR8VT ),
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drft ( 3, MXR8LV ), brts ( MXR8PM, MXR8LV ),
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; toth ( 2, MXR8LV )
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REAL*8&nbsp;&nbsp;&nbsp; hdr2 ( NHR8PM ), qkswnd_hdr2(3), aircar_hdr2(6),
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aircft_hdr2(4),&nbsp; adpupa_hdr2(1), goesnd1_hdr2(6),
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goesnd2_hdr2(MXR8LV), adpsfc_hdr2(5), sfcshp_hdr2(2),
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; satwnd_hdr2(1), evns2 ( MXR8PM, MXR8LV, MXR8VN, MXR8VT),
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drft2 ( 3, MXR8LV ), toth2 ( 2, MXR8LV )
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REAL*8&nbsp;&nbsp;&nbsp; hdr_save&nbsp; ( NHR8PM ), adpsfc_hdr_save(5),
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sfcshp_hdr_save(2),
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; evns_save ( MXR8PM, MXR8LV, MXR8VN, MXR8VT ),
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drft_save ( 3, MXR8LV ), toth_save ( 2, MXR8LV )
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REAL*8&nbsp;&nbsp;&nbsp; r8sid, r8sid2, pob1, pob2

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REAL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p ( MXR8LV )

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INTEGER&nbsp; indr ( MXR8LV ), indxvr1 ( 100:299 ), indxvr2 ( 100:299 )

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHARACTER&nbsp;&nbsp;&nbsp; msgtyp*8, msgtyp_process*8
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHARACTER*8&nbsp; csid, csid2, msgtp2
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CHARACTER*(MXSTRL)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; head1, head2, ostr ( MXR8VT )

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LOGICAL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; match, seq_match, single_msgtyp, radiance,
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; not_radiance

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; EQUIVALENCE&nbsp;&nbsp;&nbsp;&nbsp; ( r8sid, csid ), ( r8sid2, csid2 )

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; COMMON&nbsp; / PREPBC /&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdr, evns, drft, toth, brts, qkswnd_hdr,
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp; aircar_hdr, aircft_hdr, adpupa_hdr, goesnd1_hdr, goesnd2_hdr,
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp; adpsfc_hdr, sfcshp_hdr, satwnd_hdr, indxvr1, indxvr2, nlev, nchn

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DATA&nbsp;&nbsp; head1
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; / 'SID YOB XOB ELV DHR RPT TCOR TYP TSB T29 ITP SQN' /
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DATA&nbsp;&nbsp; head2
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; / 'PROCN SAID' /
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DATA&nbsp;&nbsp; ostr
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; / 'POB PQM PPC PRC PFC PAN POE CAT',
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'QOB QQM QPC QRC QFC QAN QOE CAT',
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'TOB TQM TPC TRC TFC TAN TOE CAT',
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'ZOB ZQM ZPC ZRC ZFC ZAN ZOE CAT',
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'UOB WQM WPC WRC UFC UAN WOE CAT',
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'VOB WQM WPC WRC VFC VAN WOE CAT',
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'DDO DFQ DFP DFR NULL NULL NULL CAT',
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'FFO DFQ DFP DFR NULL NULL NULL CAT',
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'PWO PWQ PWP PWR PWF PWA PWE CAT',
&nbsp;&nbsp;&nbsp;&nbsp; + 'REQ6 REQ6_QM REQ6_PC REQ6_RC REQ6_FC REQ6_AN REQ6_OE CAT',
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'PW1O PW1Q PW1P PW1R PW1F PW1A PW1E CAT',
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'PW2O PW2Q PW2P PW2R PW2F PW2A PW2E CAT',
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'PW3O PW3Q PW3P PW3R PW3F PW3A PW3E CAT',
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'PW4O PW4Q PW4P PW4R PW4F PW4A PW4E CAT',
&nbsp;&nbsp;&nbsp;&nbsp; + 'CDTP CDTP_QM CDTP_PC CDTP_RC CDTP_TC CDTP_AN CDTP_OE CAT',
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'GCDTT NULL NULL NULL NULL NULL NULL CAT' ,
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'TOCC&nbsp; NULL NULL NULL NULL NULL NULL CAT' /
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DATA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; match / .true. /, seq_match / .false. /

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SAVE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; match, msgtp2, idate2
C-----------------------------------------------------------------------
</pre>

<pre><a NAME="single_msgtyp"></a>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; single_msgtyp = .false.&nbsp;&nbsp; ! set to true if you want to process
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !&nbsp; reports from only ONE message type
</pre>

<pre><a NAME="msgtyp_process"></a>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msgtyp_process = 'ADPUPA' ! if single_msgtyp=T, then only
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !&nbsp; reports in this msgtyp will be
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !&nbsp; processed

&nbsp;1000 continue

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iret = 0

C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; If the previous call to this subroutine did not yield matching
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mass and wind subsets, then BUFRLIB routine READNS is already
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pointing at an unmatched subset.&nbsp; Otherwise, call READNS to
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; advance the subset pointer to the next subset.
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --------------------------------------------------------------

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF&nbsp; ( match )&nbsp; THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CALL READNS(lunit,msgtyp,idate,jret) ! BUFRLIB routine to
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !&nbsp; read in next subset
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF&nbsp; ( jret .ne. 0 )&nbsp; THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iret = -1 ! there are no more subsets in the PREPBUFR file
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !&nbsp; and all subsets have been processed
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RETURN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END IF
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(single_msgtyp .and. msgtyp.ne.msgtyp_process) go to 1000
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELSE
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msgtyp = msgtp2
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idate = idate2
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END IF

C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Read the report header based on mnemonic string "head" and
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; transfer 1 for 1 into array HDR for the subset that is
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; currently being pointed to.
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -----------------------------------------------------------

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !BUFRLIB routine to read specific info from
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ! report (no event info though)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CALL UFBINT(lunit,hdr,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12,1,jret,head1)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CALL UFBINT(lunit,hdr(13),NHR8PM-12,1,jret,head2)

C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Read header information that is specific to the various
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; message types
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -------------------------------------------------------

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qkswnd_hdr=10E10
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aircar_hdr=10E10
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aircft_hdr=10E10
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adpupa_hdr=10E10
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goesnd1_hdr=10E10
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goesnd2_hdr=10E10
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adpsfc_hdr=10E10
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sfcshp_hdr=10E10
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; satwnd_hdr=10E10

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF( msgtyp .eq. 'QKSWND')&nbsp; THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CALL UFBINT(lunit,qkswnd_hdr,3,1,jret,'CTCN ATRN SPRR ')
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELSE IF( msgtyp .eq. 'AIRCAR')&nbsp; THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CALL UFBINT(lunit,aircar_hdr,6,1,jret,
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; 'PCAT POAF TRBX10 TRBX21 TRBX32 TRBX43 ')
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELSE IF( msgtyp .eq. 'AIRCFT')&nbsp; THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CALL UFBINT(lunit,aircft_hdr,4,1,jret,'RCT PCAT POAF DGOT ')
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELSE IF( msgtyp .eq. 'ADPUPA')&nbsp; THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CALL UFBINT(lunit,adpupa_hdr,1,1,jret,'SIRC ')
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELSE IF( msgtyp .eq. 'GOESND' .or.&nbsp; msgtyp .eq. 'SATEMP' )&nbsp; THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CALL UFBINT(lunit,goesnd1_hdr,6,1,jret,
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'ACAV ELEV SOEL OZON TMSK CLAM')
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF( msgtyp .eq. 'GOESND' ) CALL UFBINT(lunit,goesnd2_hdr,1,
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MXR8LV,jret,'PRSS ')
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELSE IF( msgtyp .eq. 'ADPSFC')&nbsp; THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CALL UFBINT(lunit,adpsfc_hdr,5,1,jret,'PMO PMQ ALSE SOB SQM ')
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELSE IF( msgtyp .eq. 'SFCSHP')&nbsp; THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CALL UFBINT(lunit,sfcshp_hdr,2,1,jret,'PMO PMQ ')
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELSE IF( msgtyp .eq. 'SATWND')&nbsp; THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CALL UFBINT(lunit,satwnd_hdr,1,1,jret,'RFFL ')
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END IF

C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; From PREPBUFR report type, determine if this report contains
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; only non-radiance data, only radiance data, or both
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ------------------------------------------------------------

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; radiance = (&nbsp; nint(hdr(8)) .eq. 102 .or.
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ( nint(hdr(8)) .ge. 160 .and. nint(hdr(8)) .le. 179 ))
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; not_radiance = ( .not.radiance .or.&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ( nint(hdr(8)) .ge. 160 .and. nint(hdr(8)) .le. 163 )
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp; .or. ( nint(hdr(8)) .ge. 170 .and. nint(hdr(8)) .le. 173 ))

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; EVNS = 10E10
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BRTS = 10E10
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nlev = 0
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nchn = 0

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF ( not_radiance )&nbsp; THEN

C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; For reports with non-radiance data, read the report level data
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for the variable types based on the variable-specific mnemonic
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; string "ostr(kk)" and transfer all levels, all events 1 for 1
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; into array EVNS for the subset that is currently being pointed
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to.
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ---------------------------------------------------------------


&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DO kk = indxvr1(nint(hdr(8))),indxvr2(nint(hdr(8)))
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ! loop through the variables
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CALL UFBEVN(lunit,evns(1,1,1,kk),MXR8PM,MXR8LV,MXR8VN,nlev,
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ostr(kk)) ! BUFRLIB routine to read specific info from
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ! report, accounting for all possible events
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END DO

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drft=10E10
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; toth=10E10
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF( msgtyp .eq. 'ADPUPA')&nbsp; THEN

C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Read balloon drift level data for message type ADPUPA
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -----------------------------------------------------

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CALL UFBINT(lunit,drft,3,MXR8LV,nlevd,'HRDR YDR XDR ')
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(nlevd .ne. nlev)&nbsp; CALL ERREXIT(22)

C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Read virtual temperature and dewpoint temperature (through
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "PREPRO" step only) data for message type ADPUPA
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ----------------------------------------------------------

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CALL UFBINT(lunit,toth,2,MXR8LV,nlevt,'TVO TDO ')
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(nlevt .ne. nlev)&nbsp; CALL ERREXIT(33)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END IF

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END IF

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF ( radiance)&nbsp; THEN

C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; For reports with radiance data, read the report channel data
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for the variable types based on the mnemonic string
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "CHNM TMBR" and transfer all channels 1 for 1 into array BRTS
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for the subset that is currently being pointed to.
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --------------------------------------------------------------

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CALL UFBINT(lunit,brts,MXR8PM,MXR8LV,nchn,'CHNM TMBR')

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END IF

&nbsp;2000 CONTINUE

C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Now, advance the subset pointer to the next subset and read
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; its report header.
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -----------------------------------------------------------

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CALL READNS(lunit,msgtp2,idate2,jret)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF&nbsp; ( jret .ne. 0 )&nbsp; THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iret = 1 ! there are no more subsets in the PREPBUFR file
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !&nbsp; but we must still return and process the
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !&nbsp; previous report in common /PREPBC/
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RETURN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END IF
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(single_msgtyp .and. msgtp2.ne.msgtyp_process) go to 2000
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CALL UFBINT(lunit,hdr2,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 12,1,jret,head1)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CALL UFBINT(lunit,hdr2(13),NHR8PM-12,1,jret,head2)

C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Next, check whether this subset and the previous one are
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; matching mass and wind components for a single "true" report.
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --------------------------------------------------------------

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; match = .true.
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seq_match = .false.

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF ( max( hdr (12), hdr2 (12) ) .le. R8BFMS )&nbsp; THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF ( hdr (13)&nbsp; .gt. R8BFMS )&nbsp; hdr (13) = 0.
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF ( hdr2(13)&nbsp; .gt. R8BFMS )&nbsp; hdr2(13) = 0.
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seq&nbsp; = (hdr (13) * 1000000.) + hdr (12) ! combine seq. nunmber
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seq2 = (hdr2(13) * 1000000.) + hdr2(12) !&nbsp; and MPI proc. number
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF&nbsp; ( seq .ne. seq2 )&nbsp; THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; match = .false.
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RETURN&nbsp; ! the two process/sequence numbers do not match,
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !&nbsp; return and process information in common /PREPBC/
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELSE
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; seq_match = .true.&nbsp; ! the two process/sequence numbers match
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END IF
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END IF

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF&nbsp; ( msgtyp .ne. msgtp2 )&nbsp; THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; match = .false.
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RETURN&nbsp;&nbsp; ! the two message types do not match, return and
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !&nbsp; process information in common /PREPBC/
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END IF

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF ( .not. seq_match )&nbsp; THEN

C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The two process/sequence numbers are missing, so as a last
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resort must check whether this subset and the previous one
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; have identical values for SID, YOB, XOB, ELV, and DHR in
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; which case they match.
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -----------------------------------------------------------

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r8sid&nbsp; = hdr (1)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r8sid2 = hdr2(1)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF&nbsp; ( csid .ne. csid2 )&nbsp; THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; match = .false.
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RETURN&nbsp;&nbsp; ! the two report id's do not match, return and
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !&nbsp; process information in common /PREPBC/
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END IF

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DO ii = 5, 2, -1
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF&nbsp; ( hdr (ii) .ne. hdr2 (ii) )&nbsp; THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; match = .false.
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RETURN&nbsp;&nbsp; ! the two headers do not match, return and
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !&nbsp; process information in common /PREPBC/
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END IF
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END DO
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END IF

C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The two headers match, read level data for the second subset.
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (Note: This can only happen for non-radiance reports)
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -------------------------------------------------------------

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DO kk = indxvr1(nint(hdr(8))),indxvr2(nint(hdr(8)))
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ! loop through the variables
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CALL UFBEVN(lunit,evns2 (1,1,1,kk),MXR8PM,MXR8LV,MXR8VN,
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp; nlev2,ostr(kk))
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ENDDO

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drft2=10E10
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; toth2=10E10
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF( msgtp2 .eq. 'ADPUPA')&nbsp; THEN

C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Read balloon drift level data for message type ADPUPA
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for the second subset
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -----------------------------------------------------

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CALL UFBINT(lunit,drft2,3,MXR8LV,nlev2d,'HRDR YDR XDR ')
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(nlev2d .ne. nlev2)&nbsp; CALL ERREXIT(22)

C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Read virtual temperature and dewpoint temperature (through
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "PREPRO" step only) data for message type ADPUPA for the
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; second subset
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ----------------------------------------------------------

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CALL UFBINT(lunit,toth2,2,MXR8LV,nlev2t,'TVO TDO ')
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(nlev2t .ne. nlev2)&nbsp; CALL ERREXIT(33)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END IF

C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Read header information that is specific to the various
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; message types for the second supset
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -------------------------------------------------------

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qkswnd_hdr2=10E10
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aircar_hdr2=10E10
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aircft_hdr2=10E10
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adpupa_hdr2=10E10
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goesnd1_hdr2=10E10
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goesnd2_hdr2=10E10
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adpsfc_hdr2=10E10
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sfcshp_hdr2=10E10
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; satwnd_hdr2=10E10
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF( msgtp2 .eq. 'QKSWND')&nbsp; THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CALL UFBINT(lunit,qkswnd_hdr2,3,1,jret,'CTCN ATRN SPRR ')
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELSE IF( msgtp2 .eq. 'AIRCAR')&nbsp; THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CALL UFBINT(lunit,aircar_hdr2,6,1,jret,
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp; 'PCAT POAF TRBX10 TRBX21 TRBX32 TRBX43 ')
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELSE IF( msgtp2 .eq. 'AIRCFT')&nbsp; THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CALL UFBINT(lunit,aircft_hdr2,4,1,jret,'RCT PCAT POAF DGOT ')
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELSE IF( msgtp2 .eq. 'ADPUPA')&nbsp; THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CALL UFBINT(lunit,adpupa_hdr2,1,1,jret,'SIRC ')
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELSE IF( msgtp2 .eq. 'GOESND' .or.&nbsp; msgtp2 .eq. 'SATEMP' )&nbsp; THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CALL UFBINT(lunit,goesnd1_hdr2,6,1,jret,
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 'ACAV ELEV SOEL OZON TMSK CLAM')
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF( msgtp2 .eq. 'GOESND' ) CALL UFBINT(lunit,goesnd2_hdr2,1,
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MXR8LV,jret,'PRSS ')
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELSE IF( msgtp2 .eq. 'ADPSFC')&nbsp; THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CALL UFBINT(lunit,adpsfc_hdr2,5,1,jret,'PMO PMQ ALSE SOB SQM ')
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELSE IF( msgtp2 .eq. 'SFCSHP')&nbsp; THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CALL UFBINT(lunit,sfcshp_hdr2,2,1,jret,'PMO PMQ ')
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELSE IF( msgtp2 .eq. 'SATWND')&nbsp; THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CALL UFBINT(lunit,satwnd_hdr2,1,1,jret,'RFFL ')
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END IF

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF (nint(hdr(8)) .ge. 280)&nbsp; THEN

C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; If this is a surface report, the wind subset precedes the
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mass subset - switch the subsets around in order to combine
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the surface pressure properly
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ------------------------------------------------------------

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; evns_save = evns2
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; evns2 = evns
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; evns = evns_save
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdr_save = hdr2
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdr2 = hdr
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdr = hdr_save
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adpsfc_hdr_save = adpsfc_hdr2
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adpsfc_hdr2 = adpsfc_hdr
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adpsfc_hdr = adpsfc_hdr_save
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sfcshp_hdr_save = sfcshp_hdr2
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sfcshp_hdr2 = sfcshp_hdr
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sfcshp_hdr = sfcshp_hdr_save
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END IF

C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Combine the message type-specific header data for the two
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; matching subsets into a single array.&nbsp;
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ---------------------------------------------------------

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qkswnd_hdr(:) = min(qkswnd_hdr(:),qkswnd_hdr2(:))
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aircar_hdr(:) = min(aircar_hdr(:),aircar_hdr2(:))
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aircft_hdr(:) = min(aircft_hdr(:),aircft_hdr2(:))
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adpupa_hdr(:) = min(adpupa_hdr(:),adpupa_hdr2(:))
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goesnd1_hdr(:) = min(goesnd1_hdr(:),goesnd1_hdr2(:))
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goesnd2_hdr(:) = min(goesnd2_hdr(:),goesnd2_hdr2(:))
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adpsfc_hdr(:) = min(adpsfc_hdr(:),adpsfc_hdr2(:))
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sfcshp_hdr(:) = min(sfcshp_hdr(:),sfcshp_hdr2(:))
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; satwnd_hdr(:) = min(satwnd_hdr(:),satwnd_hdr2(:))

C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Combine the data for the two matching subsets into a single 4-D
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; array.&nbsp; Do this by merging the EVNS2 array into the EVNS array.
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ----------------------------------------------------------------

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LOOP1: DO lv2 = 1, nlev2&nbsp; ! loop through the levels of subset 2
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DO lv1 = 1, nlev&nbsp; ! loop through the levels of subset 1
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pob1 = evns&nbsp; ( 1, lv1, 1, 1 )
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pob2 = evns2 ( 1, lv2, 1, 1 )
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF&nbsp; ( pob1 .eq. pob2 )&nbsp; THEN

C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; This pressure level from the second subset also exists in the
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; first subset, so overwrite any "missing" piece of data for
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; this pressure level in the first subset with the corresponding
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; piece of data from the second subset (since this results in no
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; net loss of data!).
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ---------------------------------------------------------------

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DO kk = indxvr1(nint(hdr(8))),indxvr2(nint(hdr(8)))
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ! loop through the variables
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DO jj = 1,MXR8VN&nbsp; ! loop through the events
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DO ii = 1,MXR8PM-1 ! loop through BUFR parameters
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ! skip the CAT parameter
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF ( evns (ii,lv1,jj,kk ) .gt. R8BFMS ) THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; evns&nbsp; ( ii, lv1, jj, kk ) =
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; evns2 ( ii, lv2, jj, kk )
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF ( evns2 (ii,lv2,jj,kk).le.R8BFMS) THEN

C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; If any piece of data in the first subset is missing and the
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; corresponding piece of data is NOT missing in the second
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; subset, also overwrite the PREPBUFR category parameter in the
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; first subset with that from the second subset regardless of
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; its value in either subset
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --------------------------------------------------------------

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; evns&nbsp; (&nbsp; 8, lv1, jj, kk ) =
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; evns2 (&nbsp; 8, lv2, jj, kk )
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END IF
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END IF
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END DO
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END DO
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END DO
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CYCLE LOOP1
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELSE IF&nbsp; (&nbsp; ( pob2 .gt. pob1 )&nbsp; .or.
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ( lv1&nbsp; .eq. nlev )&nbsp; )&nbsp; THEN

C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Either all remaining pressure levels within the first subset
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; are less than this pressure level from the second subset
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (since levels within each subset are guaranteed to be in
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; descending order wrt pressure!) *OR* there are more total
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; levels within the second subset than in the first subset.
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; In either case, we should now add this second subset level
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to the end of the EVNS array.
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ------------------------------------------------------------

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nlev = nlev + 1
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; evns&nbsp; ( :, nlev, :, : ) = evns2 ( :, lv2,&nbsp; :, : )
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drft&nbsp; ( :, nlev ) = drft2 ( :, lv2 )
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; toth&nbsp; ( :, nlev ) = toth2 ( :, lv2 )
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CYCLE LOOP 1
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END IF
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END DO
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END DO&nbsp; LOOP1

C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sort combined report according to decreasing pressure.
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ------------------------------------------------------

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; p(:) = evns&nbsp; ( 1, :, 1, 1)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(nlev .gt. 0)&nbsp; call indexf(nlev,p,indr)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; evns_save = evns
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drft_save = drft
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; toth_save = toth
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do i = 1,nlev
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; j = indr(nlev-i+1)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; evns ( :, i, :, :) = evns_save ( :, j, :, :)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drft ( :, i) = drft_save ( :, j)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; toth ( :, i) = toth_save ( :, j)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; end do

C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Return to calling program with a complete report in common
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /PREPBC/.
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ----------------------------------------------------------

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RETURN

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END

C$$$&nbsp; SUBPROGRAM DOCUMENTATION BLOCK
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .&nbsp;&nbsp;&nbsp; .&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .
C SUBPROGRAM:&nbsp;&nbsp;&nbsp; INDEXF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GENERAL SORT ROUTINE FOR REAL ARRAY
C&nbsp;&nbsp; PRGMMR: D. A. KEYSER&nbsp;&nbsp;&nbsp;&nbsp; ORG: NP22&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DATE: 1995-05-30
C
C ABSTRACT: USES EFFICIENT SORT ALGORITHM TO PRODUCE INDEX SORT LIST
C&nbsp;&nbsp; FOR AN REAL ARRAY.&nbsp; DOES NOT REARRANGE THE FILE.
C
C PROGRAM HISTORY LOG:
C 1993-06-05&nbsp; R&nbsp; KISTLER -- FORTRAN VERSION OF C-PROGRAM
C 1995-05-30&nbsp; D. A. KEYSER - TESTS FOR &lt; 2 ELEMENTS IN SORT LIST,
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF SO RETURNS WITHOUT SORTING (BUT FILLS INDX ARRAY)
C
C USAGE:&nbsp;&nbsp;&nbsp; CALL INDEXF(N,ARRIN,INDX)
C&nbsp;&nbsp; INPUT ARGUMENT LIST:
C&nbsp;&nbsp;&nbsp;&nbsp; N&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - SIZE OF ARRAY TO BE SORTED
C&nbsp;&nbsp;&nbsp;&nbsp; ARRIN&nbsp;&nbsp;&nbsp; - REAL ARRAY TO BE SORTED
C
C&nbsp;&nbsp; OUTPUT ARGUMENT LIST:
C&nbsp;&nbsp;&nbsp;&nbsp; INDX&nbsp;&nbsp;&nbsp;&nbsp; - ARRAY OF POINTERS GIVING SORT ORDER OF ARRIN IN
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - ASCENDING ORDER {E.G., ARRIN(INDX(I)) IS SORTED IN
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - ASCENDING ORDER FOR ORIGINAL I = 1, ... ,N}
C
C REMARKS: NONE.
C
C ATTRIBUTES:
C&nbsp;&nbsp; LANGUAGE: FORTRAN 90
C&nbsp;&nbsp; MACHINE:&nbsp; IBM-SP
C
C$$$
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SUBROUTINE INDEXF(N,ARRIN,INDX)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INTEGER&nbsp; INDX(N)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REAL&nbsp; ARRIN(N)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DO J = 1,N
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INDX(J) = J
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ENDDO
C MUST BE > 1 ELEMENT IN SORT LIST, ELSE RETURN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF(N.LE.1)&nbsp; RETURN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; L = N/2 + 1
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IR = N
&nbsp;&nbsp; 33 CONTINUE
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF(L.GT.1)&nbsp; THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; L = L - 1
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INDXT = INDX(L)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AA = ARRIN(INDXT)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELSE
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INDXT = INDX(IR)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AA = ARRIN(INDXT)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INDX(IR) = INDX(1)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IR = IR - 1
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF(IR.EQ.1)&nbsp; THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INDX(1) = INDXT
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RETURN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END IF
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END IF
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I = L
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; J = L * 2
&nbsp;&nbsp; 30 CONTINUE
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF(J.LE.IR)&nbsp; THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF(J.LT.IR)&nbsp; THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF(ARRIN(INDX(J)).LT.ARRIN(INDX(J+1)))&nbsp; J = J + 1
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END IF
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF(AA.LT.ARRIN(INDX(J)))&nbsp; THEN
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INDX(I) = INDX(J)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I = J
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; J = J + I
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELSE
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; J = IR + 1
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END IF
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END IF
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; IF(J.LE.IR)&nbsp; GO TO 30
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INDX(I) = INDXT
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GO TO 33
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BLOCK DATA

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PARAMETER ( NHR8PM = 14 )&nbsp;&nbsp;&nbsp; ! Actual number of BUFR parameters
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !&nbsp; in header
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PARAMETER ( MXR8PM =&nbsp; 8 )&nbsp;&nbsp;&nbsp; ! Maximum number of BUFR parameters
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !&nbsp; in level data (non-radiance) or
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !&nbsp; in channel data (radiance)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PARAMETER ( MXR8LV = 255 )&nbsp;&nbsp; ! Maximum number of BUFR levels/
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; channels
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PARAMETER ( MXR8VN = 10 )&nbsp;&nbsp;&nbsp; ! Max. number of BUFR event sequences
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !&nbsp; (non-radiance reports)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PARAMETER ( MXR8VT = 17)&nbsp;&nbsp;&nbsp;&nbsp; ! Max. number of BUFR variable types
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !&nbsp; (non-radiance reports)

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; REAL*8&nbsp;&nbsp;&nbsp; hdr ( NHR8PM ), qkswnd_hdr(3), aircar_hdr(6),
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aircft_hdr(4),&nbsp; adpupa_hdr(1), goesnd1_hdr(6),
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goesnd2_hdr(MXR8LV), adpsfc_hdr(5), sfcshp_hdr(2),
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; satwnd_hdr(1), evns ( MXR8PM, MXR8LV, MXR8VN, MXR8VT ),
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drft ( 3, MXR8LV ), brts ( MXR8PM, MXR8LV ),
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; toth ( 2, MXR8LV )

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INTEGER&nbsp;&nbsp; indxvr1 ( 100:299 ), indxvr2 ( 100:299 )

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; COMMON&nbsp; / PREPBC /&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hdr, evns, drft, toth, brts, qkswnd_hdr,
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp; aircar_hdr, aircft_hdr, adpupa_hdr, goesnd1_hdr, goesnd2_hdr,
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp; adpsfc_hdr, sfcshp_hdr, satwnd_hdr, indxvr1, indxvr2, nlev, nchn

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DATA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nlev /0/, nchn /0/

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DATA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; indxvr1
&nbsp;&nbsp;&nbsp;&nbsp; + /&nbsp;&nbsp; 20*1,&nbsp;&nbsp;&nbsp; 30*1,&nbsp;&nbsp; 10,&nbsp; 15,&nbsp;&nbsp; 9,&nbsp;&nbsp;&nbsp; 3*1,&nbsp;&nbsp;&nbsp; 4*11,&nbsp;&nbsp;&nbsp; 40*1 ,
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 100-119&nbsp; 120-149&nbsp; 150&nbsp; 151&nbsp; 152&nbsp; 153-155&nbsp; 156-159&nbsp; 160-199
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp; 20*1,&nbsp;&nbsp;&nbsp; 40*1,&nbsp;&nbsp;&nbsp; 25*1,&nbsp;&nbsp;&nbsp; 1,&nbsp;&nbsp; 1,&nbsp;&nbsp; 13*1&nbsp;&nbsp;&nbsp; /
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 200-219&nbsp; 220-259&nbsp; 260-284&nbsp; 285&nbsp; 286&nbsp; 287-299

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DATA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; indxvr2
&nbsp;&nbsp;&nbsp;&nbsp; + /&nbsp;&nbsp; 20*4,&nbsp;&nbsp;&nbsp; 30*8,&nbsp;&nbsp; 10,&nbsp; 17,&nbsp;&nbsp; 9,&nbsp;&nbsp;&nbsp; 3*6,&nbsp;&nbsp;&nbsp; 4*14,&nbsp;&nbsp;&nbsp; 40*6 ,
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 100-119&nbsp; 120-149&nbsp; 150&nbsp; 151&nbsp; 152&nbsp; 153-155&nbsp; 156-159&nbsp; 160-299
&nbsp;&nbsp;&nbsp;&nbsp; +&nbsp;&nbsp;&nbsp;&nbsp; 20*6,&nbsp;&nbsp;&nbsp; 40*8,&nbsp;&nbsp;&nbsp; 25*6,&nbsp;&nbsp;&nbsp; 8,&nbsp;&nbsp; 8,&nbsp;&nbsp; 13*6&nbsp;&nbsp;&nbsp; /
C&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 200-219&nbsp; 220-259&nbsp; 260-284&nbsp; 285&nbsp; 286&nbsp; 287-299

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END



</pre>

</body>
</html>
