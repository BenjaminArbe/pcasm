X:=
D:=driver
L:=				# ex. L=-lstdc++
SRC:=$(patsubst %, %.s, $(X))
OBJ:=$(patsubst %, %.o, $(X))
BIN:=$(word 1, $(X))
DRIVER:=$(addsuffix .cpp, $(D))

AS:= as -c -32
AR:= ar
CC:= cc -m32 
LIB:= libio.a
LFLAGS:= -L. -lio $(L)
LIBOBJ:= asm_io.o
FIND:= find
RM:= rm -rf


all:	$(DRIVER) $(OBJ) macros.inc libio
	$(CC) $(OBJ) $(DRIVER) $(LFLAGS) -o $(BIN)

.s.o:
	$(AS) $< -o $@

libio:	$(LIBOBJ)
	$(AR) cr $(LIB) $<
	$(RM) $(LIBOBJ)

clean:
	$(FIND) . -type f -executable -delete
	$(RM) *.o 

clean_all:	clean
	$(RM) libio.a
	
