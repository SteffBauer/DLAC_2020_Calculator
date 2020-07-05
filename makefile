FILENAME=calc

clean: 
	rm -f calc lex.yy.c y.tab.c y.tab.h

flex: calc.l
	flex calc.l
	gcc lex.yy.c -o calc

bison: calc.l
	bison -d calc.y
	flex calc.l
	gcc lex.yy.c calc.tab.c -o calc

ubuntu: calc.l
	bison -d calc.y
	flex calc.l
	c++ -o calc lex.yy.c calc.tab.c ./libs/methods.c -lfl