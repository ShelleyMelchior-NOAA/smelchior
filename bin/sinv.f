C-----------------------------------------------------------------------
C-----------------------------------------------------------------------
      PROGRAM SINV
 
      PARAMETER (MAXA=16000000)
      PARAMETER (MAXS=1000)
 
      CHARACTER(255) FILE   
      CHARACTER(8)  SUBSET
      CHARACTER(16) ci,cj
      DIMENSION     isat(0:maxs,0:maxs)  
      real(8)       arr(2,maxa),said(maxa),siid(maxa)
 
      DATA BMISS  /10E10/
      DATA LUNBF  /20/
 
C-----------------------------------------------------------------------
C-----------------------------------------------------------------------
 
      isat=0  
      said=0
      ssid=0

      read(5,'(a)') file
      !print*; print*,file; print*
      open(lunbf,file=file,form='unformatted')
 
      CALL OPENBF(LUNBF,'IN',LUNBF)

      call ufbtab(lunbf,said,1,maxa,nret,'SAID')
      !print*,nret
      !call ufbtab(lunbf,siid,1,maxa,nret,'SIID')
      !print*,nret

      do n=1,nret
      i = said(n)
      j = siid(n)  
      if(i>maxs.or.i<0) i=0                 
      if(j>maxs.or.j<0) j=0                 
      isat(i,j) = isat(i,j)+1
      enddo

      !print1,'satellite     ','instrument    ','   count'
      !print'(40("-"))'
      print*
1     format(a14,2x,a14,2x,a8)
      do i=0,1000
      do j=0,1000
      if(isat(i,j).gt.0) then 
         call satcode(i,ci,j,cj)
         if(ci==' ') write(ci,'(i4.4)')i
         if(cj==' ') write(cj,'(i4.4)')j
         print'(2(i4.4,2x,a16,2x),i8)',i,ci,j,cj,isat(i,j)
      endif
      enddo
      enddo; print*

      stop
      end
c-----------------------------------------------------------------------
c  looks up BUFR code table values for SAID (said) and SIID (instrument)
c-----------------------------------------------------------------------
      subroutine satcode(icode,csad,jcode,csid)

      character(16) csad,csid
      character(16) saic(1000)
      integer said
      logical first /.true./

      csad=' '; csid=' '

      if(first)then
         open(8)
1        read(8,*,end=2) said,saic(said)
         !!print*,said,saic(said)
         goto 1
2        first=.false.
      endif

c  figure out what satellite this really is

      csad=saic(icode)

      if(jcode.eq.363) csid = 'sbuv/1 '
      if(jcode.eq.420) csid = 'airs   '
      if(jcode.eq.431) csid = 'toms   '
      if(jcode.eq.570) csid = 'amsu-a '
      if(jcode.eq.574) csid = 'amsu-b '
      if(jcode.eq.580) csid = 'atovs  '
      if(jcode.eq.580) csid = 'atovs  '
      if(jcode.eq.590) csid = 'avhrr/2'
      if(jcode.eq.591) csid = 'avhrr/3'
      if(jcode.eq.592) csid = 'avhrr/2'
      if(jcode.eq.605) csid = 'hirs/2 '
      if(jcode.eq.606) csid = 'hirs/3 '
      if(jcode.eq.607) csid = 'hirs/4 '
      if(jcode.eq.615) csid = 'imager '
      if(jcode.eq.622) csid = 'mss    '
      if(jcode.eq.623) csid = 'msu    '
      if(jcode.eq.624) csid = 'sbuv/2 '
      if(jcode.eq.625) csid = 'sbuv/3 '
      if(jcode.eq.626) csid = 'sounder'
      if(jcode.eq.627) csid = 'ssu    '
      if(jcode.eq.629) csid = 'rtovs  '
      if(jcode.eq.630) csid = 'vas    '

      return
      end
