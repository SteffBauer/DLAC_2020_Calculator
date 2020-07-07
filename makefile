CC := c++
FILENAME := calc
LEXFILE := calc.l
SYNFILE := calc.y

all: clean calc

clean: 
	rm -f ${FILENAME} lex.yy.c ${FILENAME}.tab.c ${FILENAME}.tab.h

calc: $(FILENAME).l $(FILENAME).y
	bison -d $(FILENAME).y
	flex $(FILENAME).l
	$(CC) -o $(FILENAME) lex.yy.c $(FILENAME).tab.c ./libs/methods.cpp -lfl