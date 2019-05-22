all : square

libsquare.so : square.cu
	nvcc --ptxas-options=-v --compiler-options '-fPIC' -o libsquare.so --shared square.cu

square : libsquare.so main.cc
	g++ -o square main.cc -L. -lsquare

run : square
	LD_LIBRARY_PATH=.:$LD_LIBRARY_PATH ./square

clean :
	rm *.so square *.o *~

