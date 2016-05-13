
n1:
	@echo "Using native library ..."
	perl6 n1.p6

n2:
	@echo "Using custom helloworld C library ..."
	gcc -shared -o libn2.so -fPIC n2.c
	perl6 n2.p6

n3:
	@echo "Using custom library with variables and functions ..."
	gcc -shared -o libn3.so -fPIC n3.c
	perl6 n3.p6

n4:
	@echo "Using custom C++ library ..."
	g++ -shared -o libn4.so -fPIC n4.cpp
	perl6 n4.p6
