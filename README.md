## PCASM - Dr Paul Carter Assembly examples from his book using GNU AS in IA-32

Notes:
1. The generated executable by make is always named after the .s filename. ex.  make X=01first will produce ./01first
2. The first 9 examples, uses a common driver.cpp file that is the default used by the Makefile to build the executable.
3. Starting in example 9, some examples uses multi-module source files, in that case the executable is named after the first .s
   specified. ex.  make X="09main4 09sub4" will produce ./09main4 
4. Starting in example 10, we used other drivers than driver.cpp. For that we use option D as in:
   make X=10sub5 D=10main5, as said before the executable will be ./10sub5
