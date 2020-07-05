#include "methods.h"
#include <stdio.h>
#include <math.h>


double even(double number){
    double even=0;

    int n=number;
    int n_counter=1;


        printf("%f\n",number);
    double dec=number-n;
    double dec_counter=10;


    // Vorkommastellen
    while (n > 0)  
    { 
        int rem = n%10; 
        if (rem % 2 == 0){
            even=even +rem*n_counter; 
            n_counter=n_counter*10;
        }
        n = n / 10; 
    }

    //printf("%f\n",even);

    // Nachkommastellen
    while (dec > 0)  
    { 
        int rem = dec*10; 
        //printf("%d\n",rem);
        if (rem % 2 == 0){
            even=even +rem/dec_counter; 
            dec_counter=dec_counter*10;
            //printf("%f\n",even);
            //printf("%d\n",rem);
        }
        dec=dec*10-rem;
        //printf("%f\n",dec);
    }
    
    
    return even;
}

double odd(double number){
    double even=0;

    int n=number;
    int n_counter=1;


    //printf("%f\n",number);
    double dec=number-n;
    double dec_counter=10;


    // Vorkommastellen
    while (n > 0)  
    { 
        int rem = n%10; 
        if (rem % 2 == 1){
            even=even +rem*n_counter; 
            n_counter=n_counter*10;
        }
        n = n / 10; 
    }

    //printf("%f\n",even);

    // Nachkommastellen
    while (dec > 0)  
    { 
        int rem = dec*10; 
        //printf("%d\n",rem);
        if (rem % 2 == 1){
            even=even +rem/dec_counter; 
            dec_counter=dec_counter*10;
            //printf("%f\n",even);
            //printf("%d\n",rem);
        }
        dec=dec*10-rem;
        //printf("%f\n",dec);
    }
    
    
    return even;
}

/*
int main (int argc, char* args){
    double f = 12345.65987654321;
    printf("%f\n",f);
    f=odd(f);
    printf("%f\n",f);
}
*/