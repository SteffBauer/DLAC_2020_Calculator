#option: make clean
#option: make all

#./calc ./testing.txt; errorcode: return $?
#./calc; echo errorcode: $?

CC := gcc
CFLAG :=  -Wall -g


LEX_SOURCE := syntax
YACC_SOURCE := syntactical
OUTPUT := calc

all: clean calc

clean:
	rm -f calc lex.yy.c y.tab.c y.tab.h

calc: $(YACC_SOURCE).y $(LEX_SOURCE).l
	yacc -d $(YACC_SOURCE).y
	flex   $(LEX_SOURCE).l
	$(CC) $(CFLAG) -o $(OUTPUT) lex.yy.c y.tab.c
