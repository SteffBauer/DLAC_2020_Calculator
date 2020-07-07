#include "methods.h"

#include <sstream>
#include <string.h>
#include <algorithm>



std::string doubleToString(double dbl) {
	std::ostringstream strs;
	strs << dbl;
	std::string number = strs.str();
    
    return number;
}

double stringToDouble(std::string s){
    std::replace(s.begin(), s.end(), ',', '.');

    double dbl;
    sscanf(s.c_str(),"%lf", &dbl);

    return dbl;
}

double handleNumber(double dbl, int remaining) {

    std::string number = doubleToString(dbl);
    
    std::string returnValue = "";
    bool sep=false;

    int num, counter = 0;
    

    for(int i = 0; i < strlen(number.c_str()); i++) {
        if(number[i] == '.' || number[i] == '-') {
            returnValue += number[i];
            continue;
        }
        num = std::stoi(number.substr(i,1));
        if(num%2 == remaining){
            returnValue += number[i];
            counter++;
        }
    }
    
    if(counter == 0)
        returnValue = '0';

    return std::stof(returnValue);
}


double even(double number){
    return handleNumber(number, 0);
}

double odd(double number){
    return handleNumber(number, 1);
}


/*
int main (int argc, char** args){
    double test =12367.1237f;
    double f =odd(test);
    printf("%f\n",f);
}
*/