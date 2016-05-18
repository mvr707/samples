#include <iostream>
using namespace std;

double my_variable = 3.5;

int hello(int i)
{
	cout << "Hello World from C++ " << i << endl;
	i++;
	return i;
}

class Rectangle {
	double width, height;

	public:
		void set_values(double,double);
		double area();
};


void Rectangle::set_values (double x, double y) {

	width = x;
	height = y;

}

double Rectangle::area() {

	return width * height;
}

