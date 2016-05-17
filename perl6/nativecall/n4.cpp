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
	int width, height;

	public:
		void set_values (int,int);
		int area();
};


void Rectangle::set_values (int x, int y) {

	width = x;
	height = y;

}

int Rectangle::area() {

	return width * height;
}

