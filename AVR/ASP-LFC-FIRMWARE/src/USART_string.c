#define F_CPU 32000000UL

#include <stdio.h>

unsigned int StringToInt(char *string)
{
int index=0;
int value=0;

  // assume string is of the form "NNNNN", unsigned integer, no leading blank space
  while((string[index] >= 48)&&(string[index] <= 57))
  {
     value *= 10;
	 value += string[index]-48;
	 index++;
  };

  return value; // test code, just return 0 every time -RPM
};


void IntToString(int value, char *string)
{
int index=0;

if(value < 0)
{
  string[index++]='-';
  value = value * -1; // remove sign
};

if(value > 9999)
  string[index++]= (value / 10000) + 48;
else
  string[index++]= 48;
value %= 10000;

if(value > 999)
  string[index++]= (value / 1000) + 48;
else
  string[index++]= 48;
value %= 1000;

if(value > 99)
  string[index++]= (value / 100) + 48;
else
  string[index++]= 48;
value %= 100;

if(value > 9)
  string[index++]= (value / 10) + 48;
else
  string[index++]= 48;

value %= 10;

string[index++]=value + 48;

string[index++]=0; // null terminate

};

void IntToHexString(int value, char *string)
{
	//Problem: ÿÿÿ (0xFF appears)
	int len = sprintf(string, "%04x", (unsigned long)value & 0xFFFFFFUL);
	string[len] = ' ';
};
