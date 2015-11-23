#include <iostream>
#include <fstream>
#include <string> 
#include <sstream>
#include <algorithm> 
#include <bitset>

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
	const static int div_sel = 0x0000;
	const static int mult_sel = 0x0008;
	const static int sub_sel = 0x0010;
	const static int xor_sel = 0x0018;
	const static int or_sel = 0x0020;
	const static int dr_shift = 9; 
	const static int sr1_shift = 6;
	const static int sr2_shift = 0;
	const static int sel_shift = 3;
};

int main(int argc, char * argv[])
{
	ifstream infile;
	ofstream outfile ("temp.asm");
	
    string test = argv[1];
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
		temp = true;
	else
		temp = false;
    return temp;
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
	getline( infile, dr, ',' ); //get instruction 
	std::string::iterator end_pos = std::remove(dr.begin(), dr.end(), ' '); // remove white space
	dr.erase(end_pos, dr.end());

	getline( infile, sr1, ',' );
	end_pos = std::remove(sr1.begin(), sr1.end(), ' '); // remove white space
	sr1.erase(end_pos, sr1.end());

	infile >> sr2; // get sr2 assumes space between next thing or comment!!!


	//error checking
	if( ((int)dr.size() != 2 ) || ((int)sr1.size() != 2 ) || ((int)sr2.size() != 2 ))
	{
		curr = "Error with parameters in LC-3X instruction";
		return false;
	}

	if( (dr[0] != 'R') || (sr1[0] != 'R') || (sr2[0] != 'R') )
	{
		curr = "Error with parameters in LC-3X instruction";
		return false;
	}
	dr_val = dr[1] - '0';
	sr1_val = sr1[1] - '0';
	sr2_val = sr2[1] - '0';

	if( (dr_val < 0) || (sr1_val < 0) || (sr2_val < 0) )
	{
		curr = "Error with parameters in LC-3X instruction";
		return false;
	}

	if( (dr_val > 7) || (sr1_val > 7) || (sr2_val > 7) )
	{
		curr = "Error with parameters in LC-3X instruction";
		return false;
	}

	//if here then input is valid and substiture the current string
	//first build instruction

	//add opcode
	instruction |= opcode;

	//add sel bits
	if(curr == "DIV")
	{
		instruction |= div_sel;
	}
	else if(curr == "MULT")
	{
		instruction |= mult_sel;
	}
	else if(curr == "SUB")
	{
		instruction |= sub_sel;
	}
	else if(curr == "XOR")
	{
		instruction |= xor_sel;
	}
	else if(curr == "OR")
	{
		instruction |= or_sel;
	}

	//add dr
	instruction |= (dr_val << dr_shift);

	//add sr1
	instruction |= (sr1_val << sr1_shift);

	//add sr2
	instruction |= (sr2_val << sr2_shift);

	stringstream ss;
	ss << hex << instruction;
	// add comment with the bit representation of the instruction
	ss << "    ;";
	ss << std::bitset<16>(instruction);
	
	curr = "DATA2 4x";
	curr += ss.str();
	
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





















