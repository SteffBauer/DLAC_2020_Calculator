# DLAC_2020_SyntaxAnalyzer
## Introduction
This is the Repository for the syntactical analyzer of a simple calculator.
Beside the methods for adding and multiplying integers, the modifications below were made.
## Modifications
- Calculating with negative numbers
- Support for decimal numbers (comma/point separated)
- Division and Multiplication ("/" and "*")
- Filter even numbers: Even(1648) -> 648
- Filiter odd numbers: Odd(1648) -> 1
## The EBNF grammar
```
expr = term1, {("+" | "-"), term2};
term1 = factor1, {termextension};
term2 = factor2, {termextension};
factor1 = factor2 | negative;
factor2 = "(", expr, ")" | function | positive;
termextension = ("*" | "/"), factor2;

function = even | odd;
even = "even(", expr, ")";
odd = "odd(", expr, ")";

negative = "-", positive;
positive = number | float;
float = number, separator, digit, {digit};

number = zero | nonzero, {digit};

zero = "0";
nonzero = "1"|"2"|"3"|"4"|"5"|"6"|"7"|"8"|"9";
digit = "1"|"2"|"3"|"4"|"5"|"6"|"7"|"8"|"9"|"0";
separator = "," | ".";
syntax = expr;
```
## Compiling and tests
### Compiling
To compile the final calc file, use following command:
```
make calc
```
To clean the compiled files and rebuild all, use following command:
```
make all
```
### Make use of the calculator
```
./calc
```
or
```
./calc testfilePositive
```
starts the syntactical analyzer and computes the output from the given input.
You can exit the calculator with 'e' or 'E' followed by pressing Enter.
