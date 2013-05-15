#include <stdint.h>
#include <hugemem.h>
#include <status_codes.h>

//! SDRAM initialization delay in number of CLKper2 cycles (100 us)
#define BOARD_EBI_SDRAM_INITDLY         \
(100 * 2 * sysclk_get_per2_hz() / 1000000)

//! SDRAM refresh interval in number of CLKper2 cycles (16 us)
#define BOARD_EBI_SDRAM_REFRESH         \
(16 * 2 * sysclk_get_per2_hz() / 1000000)

status_code_t ebi_test_data_bus(hugemem_ptr_t base);
status_code_t ebi_test_addr_bus(hugemem_ptr_t base, uint32_t size);
status_code_t ebi_test_data_integrity(hugemem_ptr_t base, uint32_t size);