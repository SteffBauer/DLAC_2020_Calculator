#include <string>

/**
 * This function takes only the even numbers from the original value.
 * If there is no even number in the original value, the function returns zero.
 * E.g.:
 *      1234.4321   ->  24.42
 *      135.135     ->  0
 *      245         ->  24
 */
double even(double number);

/**
 * This function takes only the odd numbers from the original value.
 * If there is no odd number in the original value, the function returns zero.
 * E.g.:
 *      1234.4321   ->  13.31
 *      246.246     ->  0
 *      345         ->  35
 */
double odd(double number);

/**
 * This function is converting a string value to a double.
 * It does not matter whether a dot or a comma is used as decimal separator.
 */
double stringToDouble(std::string s);