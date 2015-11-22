#include <iostream>
#include <fstream>
#include <string> 

using namespace std; 
/*
Form of the LC_3X added instructions

*/

int main(int argc, char * argv[])
{
	ifstream infile;
	ofstream outfile ("temp.asm");
	

	// open the file provided by the user
	infile.open( argv[1] ) ; 

	string s; 
	while(!infile.eof())
	{
		infile >> s;
		cout << s << endl;
		outfile << s << endl;
	}

	infile.close();
	outfile.close();
 
	return 0;
}