      program readmp
      character*8 subset, cstr
      character*1 go     ,copt
      integer*4 nr_4

      mcnt=1

      narg=iargc()
      i=1 ; call getarg(i,cstr)
      if (cstr(1:1).eq.'-') then
        copt=cstr(2:2)
        if (copt .eq. 'n') then
          i=i+1 ; call getarg(i,cstr)
          read(cstr,*) mcnt
        endif ! copt = n
      endif ! cstr = -
      if (mcnt.eq.0) mcnt=1

      if (mcnt.ne.1) write(*,*) "readmp: mcnt=",mcnt
c     write(*,*) 'mcnt=',mcnt
c     stop

      call openbf(20,'IN',20)
      nr_4=0
      do while(ireadmg(20,subset,idate).eq.0)
      do while(ireadsb(20).eq.0)

      nr_4=nr_4+1
      if (mod(nr_4,mcnt).eq.0) call ufdump(20,6)

      enddo
      enddo

      stop
      end
