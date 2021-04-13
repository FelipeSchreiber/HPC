module MultiplicarMatrizes
implicit none
contains

subroutine init_random_seed()
    use iso_fortran_env, only: int64
    implicit none
    integer, allocatable :: seed(:)
    integer :: i, n, un, istat, dt(8), pid
    integer(int64) :: t
  
    call random_seed(size = n)
    allocate(seed(n))
    ! First try if the OS provides a random number generator
    open(newunit=un, file="/dev/urandom", access="stream", &
         form="unformatted", action="read", status="old", iostat=istat)
    if (istat == 0) then
       read(un) seed
       close(un)
    else
       ! Fallback to XOR:ing the current time and pid. The PID is
       ! useful in case one launches multiple instances of the same
       ! program in parallel.
       call system_clock(t)
       if (t == 0) then
          call date_and_time(values=dt)
          t = (dt(1) - 1970) * 365_int64 * 24 * 60 * 60 * 1000 &
               + dt(2) * 31_int64 * 24 * 60 * 60 * 1000 &
               + dt(3) * 24_int64 * 60 * 60 * 1000 &
               + dt(5) * 60 * 60 * 1000 &
               + dt(6) * 60 * 1000 + dt(7) * 1000 &
               + dt(8)
       end if
       pid = getpid()
       t = ieor(t, int(pid, kind(t)))
       do i = 1, n
          seed(i) = lcg(t)
       end do
    end if
    call random_seed(put=seed)
  contains
    ! This simple PRNG might not be good enough for real work, but is
    ! sufficient for seeding a better PRNG.
    function lcg(s)
      integer :: lcg
      integer(int64) :: s
      if (s == 0) then
         s = 104729
      else
         s = mod(s, 4294967296_int64)
      end if
      s = mod(s * 279470273_int64, 4294967291_int64)
      lcg = int(mod(s, int(huge(0), int64)), kind(0))
    end function lcg
  end subroutine init_random_seed

subroutine criarMatrizAleatoria(darray, n)  
   integer, intent (in) :: n   
   real(8), dimension (:,:), intent (inout) :: darray  
   ! allocate memory        
   CALL init_random_seed()
   CALL RANDOM_NUMBER(darray)
end subroutine criarMatrizAleatoria
subroutine MultiplicarMatrizVetor(A,vec,n,mode,resultado)
   integer, intent (in) :: n, mode
   integer :: i,j
   real(8), dimension (:,:), intent (inout) :: A   
   real(8), dimension (:), intent (inout) :: resultado
   real(8), dimension (:), intent (in) :: vec
   if (mode == 1) then 
      do i = 1, n           
         do j = 1, n               
            resultado(i) = resultado(i) + A(i,j)*vec(j)           
         end do      
      end do
   else
      do j = 1, n           
         do i = 1, n               
            resultado(i) = resultado(i) + A(i,j)*vec(j)           
         end do      
      end do
   endif
 end subroutine
subroutine appendData(filename, mode, n, tempo_exec)
   character(len=*), intent(in) :: filename
   integer, intent(in) :: mode,n
   real, intent(in) :: tempo_exec
   character(len=*), parameter :: FMT = "(I1,I16.4,F32.2)"
   logical :: exist
   inquire(file=filename, exist=exist)
   if (exist) then
     open(12, file=filename, status="old", position="append", action="write")
   else
     open(12, file=filename, status="new", action="write")
   end if
   write(12, FMT) mode, n, tempo_exec 
   close(12)
end subroutine
end module MultiplicarMatrizes