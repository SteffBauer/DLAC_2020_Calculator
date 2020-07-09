#include "methods.h"

#include <sstream>
#include <iostream>
#include <string.h>
#include <algorithm>



double stringToDouble(std::string s){
    // Replacing comma separated values with a dot separated notation
    std::replace(s.begin(), s.end(), ',', '.');

    // The actual conversion
    double dbl;
    sscanf(s.c_str(),"%lf", &dbl);

    return dbl;
}

std::string doubleToString(double dbl) {
	// Writing a double value in a string variable
	std::ostringstream strs;
	strs << dbl;
	std::string number = strs.str();
    
    return number;
}

double handleNumber(double dbl, int remaining) {
    // Convert the double to a string, to iterate over the single positions
    // Calculating with *10 and /10 failed, because of problems with binary storing - decimal interpretation
    std::string number = doubleToString(dbl);
    
    std::string returnValue = "";
    bool sep=false;
    int num, counter = 0;
    
    // Iterate over each position of the double value, stored as string
    for(int i = 0; i < strlen(number.c_str()); i++) {
        // Handle special cases like 
        if(number[i] == '.' || number[i] == '-') {
            returnValue += number[i];
            continue;
        }

        // Convert the char at the current position to an integer value
        num = std::stoi(number.substr(i,1));
        // Add the current integer value to the returnValue, if modulo two matches the return value
        if(num%2 == remaining){
            returnValue += number[i];
            counter++;
        }
    }
    
    // In the case, that there was no matching integer in the number, the returnValue is zero
    if(counter == 0)
        return 0;

    // Convert the string, containing the return value back to a double value and return it
    return std::stof(returnValue);
}

double even(double number){
    // The encapsulated function is called with 0 as value for the remaining part
    return handleNumber(number, 0);
}

double odd(double number){
    // The encapsulated function is called with 1 as value for the remaining part
    return handleNumber(number, 1);
}