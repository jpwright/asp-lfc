/*
  xmega-serial-cmd.c

  This is a simple utility that allows testing a number of functions of the Xmega
  including the ADC, DAC, GPIOs, Clock selection and Sleep function

  To use you need an EVAL-USB board (or equiv) with PORTF configured for USART at 9600 baud

  Connect to PC with appropriate COM port at 9600baud, 8-N-1 no flow control

  You will get a commandline terminal to set and configure a number of functions

  www.bostonandroid.com/examples/xmega-serial-cmd.c
*/
#define F_CPU 32000000UL

#include <stdio.h>
#include <stddef.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <avr\io.h>

#include <util\delay.h>
#include <avr\sleep.h>
#include <avr\pgmspace.h>


#include <asf.h>

#include "app_config.h"
#include "USART.h"
#include "USART_string.h"
#include "SDRAM.h"

#include "ff.h"
#include "diskio.h"


#define Delay1ms(x)				_delay_ms(x)

#define VERSION "0.0.3"


uint8_t ReadCalibrationByte( uint8_t index );

void Config32MHzClock(void);
void Config32KHzClock(void);
void Config2MHzClock(void);

int IsAlpha(char val);
void ParseCommand(char *string);
int GetParams(char *string, unsigned int *Params);

void DoBlink(unsigned int freq, unsigned int count);
void DoDAC(unsigned int ch, unsigned int value, unsigned int ref);
void DoADC(unsigned int pos, unsigned int neg, unsigned int sign, unsigned int ref);
void DoADCInternal(unsigned int pos, unsigned int sign, unsigned int ref);
void DoADCGain(unsigned int pos, unsigned int neg, unsigned int gain, unsigned int ref);
void DoADCCalibration(void);
void DoInput(char port, unsigned int pin);
void DoOutput(char port, unsigned int pin, unsigned int val);
void DoSleep(unsigned int mode);
void DoOscillator(unsigned int osc);
void DoUsartConfig(char port, unsigned int num, unsigned int bsel, unsigned int bscale);
void DoUsartTx(char port, unsigned int num, char *string);
void DoSpiConfig(char port, unsigned int div);
void DoSpiTx(char port, char *string);

void TFT_init(void);
void start_interrupts(void);
void stop_interrupts(void);
void Delay100ms(uint8_t x);

void ADconvert(void);
void MUXincrement(void);

int MUXpin = 0;
int frame = 0;

char globalbuffer[10];

/**
 * \brief EBI chip select configuration
 *
 * This struct holds the configuration for the chip select used to set up the
 * SDRAM. The example code will use the EBI helper function to setup the
 * contents before writing the configuration using ebi_cs_write_config().
 */
static struct ebi_cs_config     cs_config;

/**
 * \brief EBI SDRAM configuration
 *
 * This struct holds the configuration for the SDRAM.  The example code will
 * use the EBI helper function to setup the contents before writing the
 * configuration using ebi_sdram_write_config().
 */
static struct ebi_sdram_config  sdram_config;

DWORD get_fattime (void)
{
	return (DWORD)0;
}

int main(void)
{
	int data;
	int index=0;
	char buffer[100];
	Config32MHzClock();

	CLK.PSCTRL = 0x00; // no division on peripheral clock

	UsartInit();
	
	UsartWriteString("\r\n\r\nBOOT: Starting...\r\n");

	//Analog Mux
	PORTF.DIR = 0b11111111; //Output

	PORTF.OUTCLR = PIN6_bm;
	PORTF.OUTCLR = PIN4_bm | PIN7_bm;
	PORTF.OUTSET = PIN5_bm;

	PORTF.OUTCLR = PIN0_bm | PIN1_bm | PIN2_bm | PIN3_bm;
	//PORTF.OUTSET = PIN1_bm;

	PORTF.OUTCLR = PIN6_bm;
	PORTF.OUTSET = PIN4_bm;
	PORTF.OUTCLR = PIN5_bm;
	PORTF.OUTSET = PIN7_bm; //WR

	UsartWriteString("BOOT: Analog Mux configured...\r\n");

	//ADC
	PORTQ.DIR = 0b1111; //Output
	PORTQ.OUTCLR = PIN1_bm | PIN3_bm; //PWRDWN pins

	PORTQ.OUTSET = PIN0_bm | PIN2_bm; //ENCODE pins

	//Reading Values
	PORTD.DIR = 0b00000000; //Input
	PORTE.DIR = 0b00000000; //Input

	UsartWriteString("BOOT: ADC configured...\r\n");

	//TFT LCD
	TFT_init();

	Delay100ms(10);
	Delay100ms(10);
	Delay100ms(10);
	Delay100ms(10);
	Delay100ms(10);
	
	TSLCDFillRect(0,TS_SIZE_X-1,0,TS_SIZE_Y-1,TS_COL_BLUE,TS_MODE_NORMAL);
	/*
	TSLCDFillRect(0,TS_SIZE_X-1,0,70,TS_COL_WHITE,TS_MODE_NORMAL);
	TSLCDSetFontColor(TS_COL_BLUE);
	TSLCDPrintStr(2,6,"Testing ELT240320TP with AVR",TS_MODE_NORMAL);
	TSLCDFillRect(20,80,90,130,TS_COL_BLACK,TS_MODE_NORMAL);
	TSLCDFillRect(30,90,100,140,TS_COL_YELLOW,TS_MODE_NORMAL);
	TSLCDFillRect(20,80,160,200,TS_COL_BLACK,TS_MODE_NORMAL);
	TSLCDFillRect(30,90,170,210,TS_COL_RED,TS_MODE_NORMAL);
	TSLCDFillRect(195,205,71,TS_SIZE_Y-1,TS_COL_WHITE,TS_MODE_NORMAL);
	TSLCDFillCirc(200,155,60,TS_COL_WHITE,TS_MODE_NORMAL);
	TSLCDFillCirc(200,155,50,TS_COL_BLUE,TS_MODE_NORMAL);
	TSLCDFillCirc(200,155,40,TS_COL_BLACK,TS_MODE_NORMAL);
	TSLCDFillCirc(200,155,30,TS_COL_RED,TS_MODE_NORMAL);
	*/
	
	UsartWriteString("BOOT: TFT LCD configured...\r\n");

	//Timing Lines

	//INT0: breakoutbar6 / A0 / frame
	//INT1: slicebin0 / A1 / pixel
	PORTA.INTCTRL = (PORTA.INTCTRL & ~PORT_INT0LVL_gm ) | PORT_INT0LVL_LO_gc; 
	PORTA.INTCTRL = (PORTA.INTCTRL & ~PORT_INT1LVL_gm ) | PORT_INT1LVL_LO_gc;

	//Detect rising edge only
	PORTA.PIN0CTRL |= 0x01;
	PORTA.PIN0CTRL &= ~0x06;
	PORTA.PIN1CTRL |= 0x01;
	PORTA.PIN1CTRL &= ~0x06;

    PORTA.INT0MASK = PIN0_bm;
	PORTA.INT1MASK = PIN1_bm;
	
	UsartWriteString("BOOT: Interrupts configured...\r\n");
	
	//EBI/SDRAM
	ebi_setup_port(12, 0, 0, EBI_PORT_3PORT | EBI_PORT_SDRAM);
	/*
	 * Configure the EBI chip select for an 8 MB SDRAM located at
	 * \ref BOARD_EBI_SDRAM_BASE.
	 */
	ebi_cs_set_mode(&cs_config, EBI_CS_MODE_SDRAM_gc);
	ebi_cs_set_address_size(&cs_config, EBI_CS_ASPACE_8MB_gc);
	ebi_cs_set_base_address(&cs_config, BOARD_EBI_SDRAM_BASE);

	/* Configure the EBI chip select to be in SDRAM mode. */
	ebi_sdram_set_mode(&cs_config, EBI_CS_SDMODE_NORMAL_gc);

	/* Setup the number of SDRAM rows and columns. */
	ebi_sdram_set_row_bits(&sdram_config, 12);
	ebi_sdram_set_col_bits(&sdram_config, 10);

	/* Further, setup the SDRAM timing. */
	ebi_sdram_set_cas_latency(&sdram_config, 3);
	ebi_sdram_set_mode_delay(&sdram_config, EBI_MRDLY_2CLK_gc);
	ebi_sdram_set_row_cycle_delay(&sdram_config, EBI_ROWCYCDLY_7CLK_gc);
	ebi_sdram_set_row_to_precharge_delay(&sdram_config, EBI_RPDLY_7CLK_gc);
	ebi_sdram_set_write_recovery_delay(&sdram_config, EBI_WRDLY_1CLK_gc);
	ebi_sdram_set_self_refresh_to_active_delay(&sdram_config,
			EBI_ESRDLY_7CLK_gc);
	ebi_sdram_set_row_to_col_delay(&sdram_config, EBI_ROWCOLDLY_7CLK_gc);
	ebi_sdram_set_refresh_period(&sdram_config, BOARD_EBI_SDRAM_REFRESH);
	ebi_sdram_set_initialization_delay(&sdram_config,
			BOARD_EBI_SDRAM_INITDLY);

	/* Write SDRAM configuration into the EBI registers. */
	ebi_sdram_write_config(&sdram_config);
	/* Write the chip select configuration into the EBI registers. */
	ebi_cs_write_config(EBI_SDRAM_CS, &cs_config);

	ebi_enable_cs(EBI_SDRAM_CS, &cs_config);
	
	UsartWriteString("BOOT: SDRAM configured...\r\n");
	
	do {
		// Wait for SDRAM to initialize.
	} while (!ebi_sdram_is_ready());
	
	UsartWriteString("BOOT: SDRAM ready...\r\n");
	
	status_code_t retval = ebi_test_data_bus((hugemem_ptr_t)BOARD_EBI_SDRAM_BASE);
	if (retval == STATUS_OK) {
		UsartWriteString("BOOT: SDRAM data bus test completed...\r\n");
	} else {
		UsartWriteString("BOOT: WARNING: SDRAM data bus test failed...\r\n");
	}
	
	retval = ebi_test_addr_bus((hugemem_ptr_t)BOARD_EBI_SDRAM_BASE,BOARD_EBI_SDRAM_SIZE);
	if (retval == STATUS_OK) {
		UsartWriteString("BOOT: SDRAM address bus test completed...\r\n");
	} else {
		UsartWriteString("BOOT: WARNING: SDRAM address bus test failed...\r\n");
	}

	//_delay_ms(1);
	
	//SD Card testing
	UsartWriteString("BOOT: SD Card testing...\r\n");
	//_delay_ms(1);
	
	FRESULT f_err_code;
	static FATFS FATFS_Obj;

	UsartWriteString("BOOT: SD Card: initializing disk...\r\n");
	disk_initialize(0);

	UsartWriteString("BOOT: SD Card: mounting disk...\r\n");
	f_err_code = f_mount(0, &FATFS_Obj);

	if (f_err_code == FR_OK) {
	
		FIL fil_obj;
		int test_number = 5;

		UsartWriteString("BOOT: SD Card: opening file...\r\n");
		f_open(&fil_obj, "asplfc.txt", FA_WRITE);
		UsartWriteString("BOOT: SD Card: writing file...\r\n");
		int out = f_printf(&fil_obj, "moo %d", test_number);
		UsartWriteString("BOOT: SD Card: closing file...\r\n");
		f_close(&fil_obj);

	} else {
		UsartWriteLine("BOOT: WARNING: No SD card found...");
	}

	//PORTQ.OUTCLR = PIN2_bm | PIN4_bm;

	UsartWriteString("\n\rASP LFC firmware -- v0.1\r\n");
	UsartWriteString("> ");
	while(1)
	{
		data=UsartReadChar(); // read char
		// check for carriage return and try to match/execute command
		if((data == '\r')||(index==sizeof(buffer)))
		{
			//PORTF.OUT ^= (1<<0);      // switch LED
			buffer[index]=0;          // null terminate
			index=0;                  // reset buffer index
			UsartWriteString("\n\r"); // echo newline
			ParseCommand(buffer);     // attempt to parse command
			  UsartWriteString("> ");
		}
		else if(data==8)              // backspace character
		{
			if(index>0)
				index--;                  // backup one character
			UsartWriteChar(data);
		}
		else
		{
			buffer[index++]=data;
			UsartWriteChar(data);
		};

		//	UsartWriteChar(data); // write char
		//	_delay_ms(100);
		//	PORTF.OUT ^= (1<<0); // toggle LED

	};
};

ISR(PORTA_INT0_vect) 
{ 
	//UsartWriteString("BB6 interrupt\n\r");
	if (frame < 3) { 
		frame++;
	} else {
		stop_interrupts();
	}
	IntToString(frame,&globalbuffer[0]);
	UsartWriteLine(globalbuffer);
}

ISR(PORTA_INT1_vect) 
{ 
	if (frame) {
		//UsartWriteString("SB0 interrupt\n\r");
		MUXincrement();
		ADconvert();
		//IntToString(PORTD.IN,&globalbuffer[0]);
		//UsartWriteLine(globalbuffer);
		//IntToString(PORTE.IN,&globalbuffer[0]);
		//UsartWriteLine(globalbuffer);
	}
}

void start_interrupts(void)
{
	PMIC.CTRL |= PMIC_LOLVLEN_bm | PMIC_MEDLVLEN_bm | PMIC_HILVLEN_bm;
	sei();
}

void stop_interrupts(void)
{
	PMIC.CTRL &= ~(PMIC_LOLVLEN_bm | PMIC_MEDLVLEN_bm | PMIC_HILVLEN_bm);
	cli();
}

void TFT_init(void)
{
	Orb(LCD_RST_DPRT,LCD_RST_PIN);
	Orb(LCD_RS_DPRT,LCD_RS_PIN);
	Orb(LCD_CS_DPRT,LCD_CS_PIN);
	Orb(LCD_RD_DPRT,LCD_RD_PIN);
	Orb(LCD_WR_DPRT,LCD_WR_PIN);

	UsartWriteString("BOOT: Resetting LCD\n\r");

	TSLCDRst();

	UsartWriteString("BOOT: Initializing LCD\n\r");

	TSLCDInit();

}

void Delay100ms(uint8_t x)
{
	uint8_t i;
	for (i=0;i<x;i++)
	{
		Delay1ms(100);
	}
}

void ADconvert(void)
{
	PORTQ.OUTCLR = PIN0_bm | PIN2_bm; //ENCODE pins
	//_delay_ms(1);
	PORTQ.OUTSET = PIN0_bm | PIN2_bm;
	//_delay_ms(1);
	//char value = PORTD.IN;
}

void MUXincrement(void)
{

	PORTF.OUT = 0b10000000 + MUXpin;
	PORTF.OUT = 0b00000000 + MUXpin;
	MUXpin++;
	if (MUXpin == 16) MUXpin = 0;
	PORTF.OUT = 0b00000000 + MUXpin;
	PORTF.OUT = 0b10000000 + MUXpin;
	PORTF.OUT = 0b10110000 + MUXpin;

}


#define MAX_COMMAND_PARAMS 10
void ParseCommand(char *string)
{
  char Command;
  char Command2 = 0;
  unsigned int Params[MAX_COMMAND_PARAMS];
  unsigned int NumParams=0;

/*  UsartWriteString("Command Received: ");
  UsartWriteString(string);
  UsartWriteString("\n\r");
*/
  // assume commands are single character followed by numerical parameters sep by spaces
  // e.g. "s 1 5", "b 7", "b 100 120 001 212 123"
  Command = string[0];
  if(IsAlpha(string[1])) // multi-char command (e.g. pa, oa, ia, etc)
	  Command2 = string[1];

  if(Command != 0)
  {
    NumParams=GetParams(string,Params); // read any optional parameters after command

/*
    UsartWriteString("CommandID: ");
    UsartWriteChar(Command);
    if(Command2 != 0)
      UsartWriteChar(Command2);
    UsartWriteString(" #Params: ");
    UsartWriteChar(48+NumParams);
    UsartWriteString("\n\r");
*/
  }
  else
  {
  UsartWriteString("No Command\n\r");
  };

  unsigned short lcdDataIn;
  static char buffer[10];

  switch(Command)
  {


    case 'a': // ADC do immediate conversion
	    PORTQ.OUTCLR = PIN0_bm | PIN2_bm; //ENCODE pins
		_delay_ms(1);
		PORTQ.OUTSET = PIN0_bm | PIN2_bm;
		_delay_ms(1);
		char value = PORTD.IN;
		
		
		
		IntToString(value,&buffer[0]);
		UsartWriteLine(buffer);
	  break;

	case 'b': // read imager flag
		PORTA.DIR &= ~0x01;
		char bb6 = PORTA.IN & 0x01;
		
		IntToString(bb6,&buffer[0]);
		UsartWriteLine(buffer);
	  break;

	case 'y': // Start Image
		frame = 0;
		start_interrupts();
	break;

	case 'z': // Stop Image
		stop_interrupts();
	break;

    case 'l':
		lcdDataIn = TSLCDInDat();
		IntToString(lcdDataIn,&buffer[0]);
		UsartWriteLine(buffer);
      break;

	case 'x':
		IntToString(4,&buffer[0]);
		UsartWriteLine(buffer);
      break;

    case 'T': // Usart TX test
	  DoUsartTx(Command2,Params[0],"0123456789");
	  break;

    case 'S': // Config SPI port
	  DoSpiConfig(Command2,Params[0]);
	  break;

    case 'X': // SPI TX test
	  DoSpiTx(Command2,"0123456789");
	  break;

    case 's': // Sleep CPU
	  DoSleep(Params[0]); // this will not return 
	  break;

    case 'O': // Set oscillator source
	  DoOscillator(Params[0]); // this will not return 
	  break;

    case 'h': // Usage
	  break;

  };	  


return;
};


void DoSleep(unsigned int mode)
{
  switch(mode)
  {
    case 0:
	  set_sleep_mode(SLEEP_MODE_IDLE);
	  break;
    case 2:
	  set_sleep_mode(SLEEP_MODE_PWR_DOWN);
	  break;
    case 3:
	  set_sleep_mode(SLEEP_MODE_PWR_SAVE);
	  break;
    case 6:
	  set_sleep_mode(SLEEP_MODE_STANDBY);
	  break;
    case 7:
	  set_sleep_mode(SLEEP_MODE_EXT_STANDBY);
	  break;
    default:
	  Error("Unused sleep mode");
	  return;
  };


  sleep_enable();
  sleep_cpu();

};

void DoOscillator(unsigned int osc)
{
  switch(osc)
  {
    case 0:
	  Config2MHzClock();
	  break;
    case 1:
	  Config32MHzClock();
	  break;
    case 2:
	  Config32KHzClock();
	  break;
    default:
	  Error("Unsupported Selectrion");
	  return;
  };
};


void DoUsartTx(char port, unsigned int num, char *string)
{
  USART_t *Port;

  if(num==0)
  {
    switch(port)
    {
      case 'c':
	    Port = (USART_t*)_SFR_IO_ADDR(USARTC0);
		PORTC.DIR |= (1<<3);
	    break;
      case 'd':
	    Port = (USART_t*)_SFR_IO_ADDR(USARTD0);
		PORTD.DIR |= (1<<3);
	    break;
      case 'e':
	    Port = (USART_t*)_SFR_IO_ADDR(USARTE0);
		PORTE.DIR |= (1<<3);
	    break;
      case 'f':
	    Port = (USART_t*)_SFR_IO_ADDR(USARTF0);
		PORTF.DIR |= (1<<3);
	    break;
      default:
	    Error("Illegal port");
	    return; // if no valid port, return
    };
  }
  else if(num==1)
  {
    switch(port)
    {
      case 'c':
	    Port = (USART_t*)_SFR_IO_ADDR(USARTC1);
		PORTC.DIR |= (1<<7);
	    break;
      case 'd':
	    Port = (USART_t*)_SFR_IO_ADDR(USARTD1);
		PORTD.DIR |= (1<<7);
	    break;
      case 'e':
	    Port = (USART_t*)_SFR_IO_ADDR(USARTE1);
		PORTE.DIR |= (1<<7);
	    break;
      case 'f':
	    Port = (USART_t*)_SFR_IO_ADDR(USARTF1);
		PORTF.DIR |= (1<<7);
	    break;
      default:
	    Error("Illegal port");
	    return; // if no valid port, return
    };
  }
  else
  {
    Error("Illegal port num");
    return;
  };

    while(*string != 0)
	{
		Port->DATA = *string++;
        	if(!(Port->STATUS&USART_DREIF_bm))
		while(!(Port->STATUS & USART_TXCIF_bm)); // wait for TX complete
  		Port->STATUS |= USART_TXCIF_bm;  // clear TX interrupt flag
	};

};


void DoSpiConfig(char port, unsigned int div)
{
  SPI_t *Port;

    switch(port)
    {
      case 'c':
	    Port = (SPI_t*)_SFR_IO_ADDR(SPIC);
		PORTC.DIR |= (1<<4) | (1<<5) | (1<<7);
	    break;
      case 'd':
	    Port = (SPI_t*)_SFR_IO_ADDR(SPID);
		PORTD.DIR |= (1<<4) | (1<<5)| (1<<7);
	    break;
      case 'e':
	    Port = (SPI_t*)_SFR_IO_ADDR(SPIE);
		PORTE.DIR |= (1<<4) | (1<<5)| (1<<7);
	    break;
      default:
	    Error("Illegal port");
	    return; // if no valid port, return
    };

	Port->CTRL = 0x50 | (div & 0x3);
};


void DoSpiTx(char port, char *string)
{
  SPI_t *Port;

    switch(port)
    {
      case 'c':
	    Port = (SPI_t*)_SFR_IO_ADDR(SPIC);
	    break;
      case 'd':
	    Port = (SPI_t*)_SFR_IO_ADDR(SPID);
	    break;
      case 'e':
	    Port = (SPI_t*)_SFR_IO_ADDR(SPIE);
	    break;
      default:
	    Error("Illegal port");
	    return; // if no valid port, return
    };

    while(*string != 0)
	{
		Port->DATA = *string++;
        	if(!(Port->STATUS&(1<<7)))
		while(!(Port->STATUS & (1<<7))); // wait for TX complete
  		Port->STATUS |= (1<<7);  // clear TX interrupt flag
	};
};


int GetParams(char *string, unsigned int *Params)
{
char buffer[10]; // max parameter length is 10 characters
int NumParams=0;
int index_in=0;
int index_buf=0;
int NumFound=0;

NumParams=0; // clear every time called

while(string[index_in] != 0)
{
	if((string[index_in] >= 48)&&(string[index_in] <= 57))
	{
	   buffer[index_buf++]=string[index_in++];
	   NumFound=1;
	}
    else if(NumFound && string[index_in] == 32)   // space
	{  
	   buffer[index_buf]=0; // terminate with 0
	   Params[NumParams]=StringToInt(buffer);
	   NumParams++; // increment num params parsed
       for(index_buf=0;index_buf<10;index_buf++) buffer[index_buf]=0;   // null buffer
	   index_buf=0; // reset buffer index to beginning
	   index_in++;
	}
	else // illegal character, ignore
	{
	   index_in++;
    };

};

// if bytes left, parse them as last parameter (non-space terminated)
if(index_buf > 0)
{
  	   Params[NumParams]=StringToInt(buffer);
	   NumParams++; // increment num params parsed
};


return NumParams;
};


int IsAlpha(char val)
{
  if(((val > 64)&&(val < 91)) || ((val > 60)&&(val < 123))) return 1;
  else return 0;
};





void Config32MHzClock(void)
{
  CCP = CCP_IOREG_gc; //Security Signature to modify clock 
  // initialize clock source to be 32MHz internal oscillator (no PLL)
  OSC.CTRL = OSC_RC32MEN_bm; // enable internal 32MHz oscillator
  while(!(OSC.STATUS & OSC_RC32MRDY_bm)); // wait for oscillator ready
  CCP = CCP_IOREG_gc; //Security Signature to modify clock 
  CLK.CTRL = CLK_SCLKSEL_RC32M_gc; //select sysclock 32MHz osc
// update baud rate control to match new clk
  USARTF0.BAUDCTRLA = 207; // 9600b  (BSCALE=207,BSEL=0)
};

void Config2MHzClock(void)
{
  CCP = CCP_IOREG_gc; //Security Signature to modify clock 
  // initialize clock source to be 32MHz internal oscillator (no PLL)
  OSC.CTRL = OSC_RC2MEN_bm; // enable internal 32MHz oscillator
  while(!(OSC.STATUS & OSC_RC2MRDY_bm)); // wait for oscillator ready
  CCP = CCP_IOREG_gc; //Security Signature to modify clock 
  CLK.CTRL = CLK_SCLKSEL_RC2M_gc; //select sysclock 32MHz osc
// update baud rate control to match new clk
    USARTF0.BAUDCTRLA = 12; // 9600b  (BSCALE=13,BSEL=0)
};

void Config32KHzClock(void)
{
  CCP = CCP_IOREG_gc; //Security Signature to modify clock 
  // initialize clock source to be 32MHz internal oscillator (no PLL)
  OSC.CTRL = OSC_RC32KEN_bm; // enable internal 32MHz oscillator
  while(!(OSC.STATUS & OSC_RC32KRDY_bm)); // wait for oscillator ready
  CCP = CCP_IOREG_gc; //Security Signature to modify clock 
  CLK.CTRL = CLK_SCLKSEL_RC32K_gc; //select sysclock 32MHz osc
// serial port doesn't work at this clk speed so demo program will stop
};

uint8_t ReadCalibrationByte( uint8_t index ) 
{ 
uint8_t result; 

/* Load the NVM Command register to read the calibration row. */ 
NVM_CMD = NVM_CMD_READ_CALIB_ROW_gc; 
result = pgm_read_byte(index); 

/* Clean up NVM Command register. */ 
NVM_CMD = NVM_CMD_NO_OPERATION_gc; 

return( result ); 
} 
