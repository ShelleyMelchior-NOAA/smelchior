! This program can be used to pull the NCEP BUFR table out of a BUFR file 
! constructed with the NCEP BUFRLIB (aka "Woollen BUFR files" or "NCEP BUFR"
! files).
!
! 2007-06-21 S. Bender - Original program
! 2016-07-22 S. Melchior - Updated compile instructions for WCOSS-IBM
! 2019-03-08 S. Melchior - Updated compile instructions for WCOSS-Dell
!
! Compile instructions for Dell-ph3: 
!    ifort tablextractor.f90 -o tablextractor.x
!    /gpfs/dell1/nco/ops/nwprod/lib/bufr/v11.2.0/ips/18.0.1/libbufr_v11.2.0_4_64.a
!
! Compile instructions for IBM ph2:
!    ifort tablextractor.f90 -o tablextractor.x
!    /nwprod2/lib/bufr/v11.2.0/libbufr_v11.2.0_4_64.a
! -----------------------------------------------------------------------------
program tablextractor

implicit none

integer inlun, tablun

! start program
! -------------
inlun = 11
tablun = 51

call openbf(inlun,'IN',inlun)

call dxdump(inlun,tablun)

call closbf(inlun)

end
