program main_matmul
use MultiplicarMatrizes
real(8), dimension (:,:), allocatable :: A
real(8), dimension (:), allocatable :: vec, resultado
character(len=32) :: n,mode
integer :: int_n, int_mode
real :: start, finish
character(len=*), parameter :: filename = "resultados_F.csv"
CALL get_command_argument(1,n)
read(n,*)int_n
CALL get_command_argument(2,mode)
read(mode,*)int_mode
print *,int_n
print *,int_mode
allocate ( A(int_n,int_n) )
allocate ( vec(int_n) )
allocate ( resultado(int_n) )
call criarMatrizAleatoria(A,int_n)
CALL RANDOM_NUMBER(vec)
! do i=1, size(A,1)
!     print '(*(g9.4),1x)', A(i,:)
! end do
do i = 1, 10
    call cpu_time(start)
    call MultiplicarMatrizVetor(A,vec,int_n,int_mode,resultado)
    call cpu_time(finish)
    call appendData(filename,int_mode,int_n,(finish-start))
end do
deallocate(A)
deallocate(vec)
deallocate(resultado)
end program main_matmul