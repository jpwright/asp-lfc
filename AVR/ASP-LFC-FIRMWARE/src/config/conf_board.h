/**
 * \file
 *
 * \brief User board configuration template
 *
 */

#ifndef CONF_BOARD_H
#define CONF_BOARD_H

//! Base address of SDRAM on board
#define BOARD_EBI_SDRAM_BASE    0x800000UL

//! Size of SDRAM on board, given in bytes.
//#define BOARD_EBI_SDRAM_SIZE    0x100000UL
#define BOARD_EBI_SDRAM_SIZE    0x800000UL

#define BOARD_EBI_SDRAM_REFRESH (16 * 2 * sysclk_get_per2_hz() / 1000000)
#define BOARD_EBI_SDRAM_INITDLY (100 * 2 * sysclk_get_per2_hz() / 1000000)

#endif // CONF_BOARD_H
