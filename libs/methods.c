#include "methods.h"
#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>
#include <algorithm>

#define DECPLACES 3

int _factorDecPlaces = 10 * DECPLACES;


double toDouble(std::string s){
    std::replace(s.begin(), s.end(), ',', '.');
    return std::atof(s.c_str());
}



double handleNumber(double number, int remaining) {
    number = roundf(number*_factorDecPlaces)/_factorDecPlaces;
    //printf("%.3f\n",number);

    double returnValue=0;

    int n=number;
    int n_counter=1;


    //printf("%f\n",number);
    double dec=number-n;
    double dec_counter=10;


    // Vorkommastellen
    while (n > 0)  
    { 
        int rem = n%10; 
        if (rem % 2 == remaining){
            returnValue=returnValue +rem*n_counter; 
            n_counter=n_counter*10;
        }
        n = n / 10; 
    }

    //printf("%f\n",returnValue);

    // Nachkommastellen
    int counter = 0;
    while (dec > 0&& counter++<DECPLACES) 
    { 
        int rem = dec*10; 
        //printf("%d\n",rem);
        if (rem % 2 == remaining){
            returnValue=returnValue +rem/dec_counter; 
            dec_counter=dec_counter*10;
            //printf("%f\n",returnValue);
            //printf("%d\n",rem);
        }
        dec=dec*10-rem;
        //printf("%f\n",dec);
    }
    
    
    return returnValue;

}


double even(double number){
    return handleNumber(number, 0);
}

double odd(double number){
    return handleNumber(number, 1);
}


/*
int main (int argc, char** args){
    double f = 0.816541;

    printf("%.3f\n",f);
    f=odd(f);
    printf("%.3f\n",f);
}
*/