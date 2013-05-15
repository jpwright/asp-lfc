#define F_CPU 32000000UL

#include <avr\io.h>
#include <util\delay.h>

void UsartInit(void)
{
	//PORTCFG.CLKEVOUT = PORTCFG_CLKOUT_PE7_gc;
	//PORTE.DIR = (1<<7); // clkout

	// configure PORTC, USARTC0 (PORTC:3=Tx, PORTC:2=Rx) as asynch serial port

	PORTC.DIR |= (1<<3) | (1<<0); // set PORTF:3 transmit pin as output
	PORTC.OUT |= (1<<3);          // set PORTF:3 hi
	USARTC0.BAUDCTRLA = 207; // 9600b  (BSCALE=207,BSEL=0)
	//  USARTF0.BAUDCTRLA = 103; // 19200b  (BSCALE=103,BSEL=0)
	//  USARTF0.BAUDCTRLA = 34;  // 57600b  (BSCALE=34,BSEL=0)
	//  USARTF0.BAUDCTRLA = 33; USARTF0.BAUDCTRLB = (-1<<4); // 115.2kb (BSCALE=33,BSEL=-1)
	//  USARTF0.BAUDCTRLA = 31; USARTF0.BAUDCTRLB = (-2<<4); // 230.4kb (BSCALE=31,BSEL=-2)
	//  USARTF0.BAUDCTRLA = 27; USARTF0.BAUDCTRLB = (-3<<4); // 460.8kb (BSCALE=27,BSEL=-3)
	//  USARTF0.BAUDCTRLA = 19; USARTF0.BAUDCTRLB = (-4<<4); // 921.6kb (BSCALE=19,BSEL=-4)
	//  USARTF0.BAUDCTRLA = 1; USARTF0.BAUDCTRLB = (1<<4); // 500kb (BSCALE=19,BSEL=-4)
	//  USARTF0.BAUDCTRLA = 1;   // 1Mb (BSCALE=1,BSEL=0)

	USARTC0.CTRLB = USART_TXEN_bm | USART_RXEN_bm; // enable tx and rx on USART
	//USARTC0.CTRLC = 0b00111011; //8-bits, 2 stop bits, odd parity
}

void UsartWriteChar(unsigned char data)
{
    USARTC0.DATA = data; // transmit ascii 3 over and over
	if(!(USARTC0.STATUS&USART_DREIF_bm))
		while(!(USARTC0.STATUS & USART_TXCIF_bm)); // wait for TX complete
  	USARTC0.STATUS |= USART_TXCIF_bm;  // clear TX interrupt flag
};

unsigned char UsartReadChar(void)
{
	while(!(USARTC0.STATUS&USART_RXCIF_bm));  // wait for RX complete

  	return USARTC0.DATA;
};

// write out a simple '\0' terminated string
void UsartWriteString(char *string)
{

    while(*string != 0)
	  UsartWriteChar(*string++);
};

// write out a simple '\0' terminated string and print "\n\r" at end
void UsartWriteLine(char *string)
{
   UsartWriteString(string);
   UsartWriteString("\n\r");

};

void Error(char *string)
{
   UsartWriteString("Err: ");
   UsartWriteLine(string);
};
