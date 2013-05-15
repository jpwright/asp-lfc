#ifndef _HW_ATXMEGA128A1_H_
#define _HW_ATXMEGA128A1_H_

#define LCD_RST_DPRT	PORTB.DIR
#define LCD_RST_PRTS	PORTB
#define LCD_RST_PRTC	PORTB
#define LCD_RST_PIN		6

#define LCD_RS_DPRT		PORTB.DIR
#define LCD_RS_PRTS		PORTB
#define LCD_RS_PRTC		PORTB
#define LCD_RS_PIN		3

#define LCD_CS_DPRT		PORTB.DIR
#define LCD_CS_PRTS		PORTB
#define LCD_CS_PRTC		PORTB
#define LCD_CS_PIN		2

#define LCD_RD_DPRT		PORTB.DIR
#define LCD_RD_PRTS		PORTB
#define LCD_RD_PRTC		PORTB
#define LCD_RD_PIN		5

#define LCD_WR_DPRT		PORTB.DIR
#define LCD_WR_PRTS		PORTB
#define LCD_WR_PRTC		PORTB
#define LCD_WR_PIN		4

#define LCD_DB10_DPRT   PORTA.DIR
#define LCD_DB10_PORT   PORTA
#define LCD_DB10_PINP   PORTA.IN
#define LCD_DB10_PIN    2
#define LCD_DB10_PINM   PIN2_bm

#define LCD_DB11_DPRT   PORTA.DIR
#define LCD_DB11_PORT   PORTA
#define LCD_DB11_PINP   PORTA.IN
#define LCD_DB11_PIN    3
#define LCD_DB11_PINM   PIN3_bm

#define LCD_DB12_DPRT   PORTA.DIR
#define LCD_DB12_PORT   PORTA
#define LCD_DB12_PINP   PORTA.IN
#define LCD_DB12_PIN    4
#define LCD_DB12_PINM   PIN4_bm

#define LCD_DB13_DPRT   PORTA.DIR
#define LCD_DB13_PORT   PORTA
#define LCD_DB13_PINP   PORTA.IN
#define LCD_DB13_PIN    5
#define LCD_DB13_PINM   PIN5_bm

#define LCD_DB14_DPRT   PORTA.DIR
#define LCD_DB14_PORT   PORTA
#define LCD_DB14_PINP   PORTA.IN
#define LCD_DB14_PIN    6
#define LCD_DB14_PINM   PIN6_bm

#define LCD_DB15_DPRT   PORTA.DIR
#define LCD_DB15_PORT   PORTA
#define LCD_DB15_PINP   PORTA.IN
#define LCD_DB15_PIN    7
#define LCD_DB15_PINM   PIN7_bm

#define LCD_DB16_DPRT   PORTB.DIR
#define LCD_DB16_PORT   PORTB
#define LCD_DB16_PINP   PORTB.IN
#define LCD_DB16_PIN    0
#define LCD_DB16_PINM   PIN0_bm

#define LCD_DB17_DPRT   PORTB.DIR
#define LCD_DB17_PORT   PORTB
#define LCD_DB17_PINP   PORTB.IN
#define LCD_DB17_PIN    1
#define LCD_DB17_PINM   PIN1_bm

#define TS_CS_DPRT		DDRB
#define TS_CS_PRTS		PORTB
#define TS_CS_PRTC		PORTB
#define TS_CS_PIN		PB0

#define TS_PEN_DPRT		DDRB
#define TS_PEN_PRTS		PORTB
#define TS_PEN_PRTC		PORTB
#define TS_PEN_PIN		PB1

#endif
