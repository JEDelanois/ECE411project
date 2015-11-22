#compile the LC_3X precompiler
cd compile_LC_3X
g++ pre_compiler.cpp
#run the program on the assebly located at the path provied 
./a.out ../$1
cd ..

#call the given pre_compiler
sh load_memory.sh compile_LC_3X/temp.asm