#compile the LC_3X precompiler
cd compile_LC_3X

rm a.out
g++ pre_compiler.cpp



if [ "$#" -eq 0 ]; then
	echo "Need to provide a source path to *.asm"

fi

if [ "$#" -eq 1 ]; then
	
	#remove the previously existing file
	rm temp.asm
 
	#run the program on the assebly located at the path provied 
	./a.out ../$1
	cd ..

	#call the given pre_compiler
	#sh load_memory.sh compile_LC_3X/temp.asm

fi



#need to add case with two parameters

if [ "$#" -eq 3 ]; then
	echo "Cannot pass more than two parameters"

fi