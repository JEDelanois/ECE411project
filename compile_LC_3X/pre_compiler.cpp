#include <iostream>
#include <fstream>
#include <string> 

using namespace std; 
/*
Form of the LC_3X added instructions
	|opcode     |dr     |sr1  |sel  |sr2
	|15 14 13 12|11 10 9|8 7 6|5 4 3|2 1 0 

DIV	|1  0  0  0 |       |     |0 0 0|       
MULT	|1  0  0  0 |       |     |0 0 1|       
SUB	|1  0  0  0 |       |     |0 1 0|       
XOR	|1  0  0  0 |       |     |0 1 1|    
OR	|1  0  0  0 |       |     |1 0 0|


        
*/

class LC_3X
{
public:
	static bool isKeyWord(string s);
	static bool isNewInstruction(string s);
	static bool replaceInstruction(string & curr, ifstream & infile);

private:
	const static unsigned int opcode = 0x8000;
	const static int dr_shift = 9; 
	const static int sr1_shift = 6;
	const static int sr2_shift = 0;
	const static int sel_shift = 3;
};

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
		if( LC_3X::isKeyWord(s) ){
			s.insert(0, "\n");
		}
		else if(  LC_3X::isNewInstruction(s) ){ 
			if(LC_3X::replaceInstruction(s, infile) == false)
			{
				cout << "Error" <<endl;
				return 0;
			}
			s.insert(0, "\n");
		}

		s += " ";
		cout << s;
		outfile << s;
		s = ""; // need to reset incase whitespace at end
	}

	cout << endl;
	outfile << endl;

	infile.close();
	outfile.close();
 
	return 0;
}






//returns if this is an lc3 key word
bool LC_3X::isKeyWord(string s)
{
	bool temp;
		// label
	if( (s[(int)s.length() - 1] == ':') || (s == "ADD" ) || (s =="AND" ) || (s == "BR" ) || (s =="JMP" ) || (s == "JSR" ) || (s =="JSRR" ) || (s == "LDB" ) || (s =="LDI" ) || (s == "LDR" ) || (s =="LEA" ) || (s == "NOT" ) || (s =="RET" ) || (s =="SHF" ) || (s == "STB" ) || (s =="STI" ) || (s == "STR" ) || (s =="TRAP" ) || (s =="DATA2" ) || (s =="NOP" ) || (s =="nop" ) )
		temp = true;
	else 
		temp = false;
	

	return temp;
}


bool LC_3X::isNewInstruction(string s)
{	
	bool temp;
	if( (s == "DIV") || (s == "MULT") || (s == "SUB") || (s == "XOR") || (s == "OR") )
		temp == true;
	else
		temp == false;
}


/*
it is assumed that the string curr starts out with the new instruction's tag
and that the infile is pointing the the string immediatly after that (ie at DR)
*/
bool LC_3X::replaceInstruction(string & curr, ifstream & infile)
{	
	int instruction = 0;
	int dr_val, sr1_val, sr2_val;
	string dr, sr1, sr2;
	
	//get the parameters
	getline( infile, dr, ',' );
	getline( infile, sr1, ',' );
	infile >> sr2;

	cout << dr << " " << sr1 << " " << sr2 << endl;


	return true;
}




/*
hex

0	0000
1	0001
2	0010
3	0011
4	0100
5	0101
6	0110
7	0111
8	1000
9	1001
A	1010
B	1011
C	1100
D	1101
E	1110
F	1111


*/





















