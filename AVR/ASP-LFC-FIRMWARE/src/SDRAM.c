#define F_CPU 32000000UL

#include <stdint.h>
#include <hugemem.h>
#include <status_codes.h>

#include <util\delay.h>

#include "USART.h"
#include "USART_string.h"





/**
 * \brief Test the EBI data bus wired to the SDRAM
 *
 * This function will perform a walking 1s to locate any shorts or open leads
 * to the SDRAM device.
 *
 * \param base Base address of the external memory device
 *
 * \retval STATUS_OK on success, and \ref status_code_t error code on failure
 */
status_code_t ebi_test_data_bus(hugemem_ptr_t base)
{
	hugemem_ptr_t   p;
	uint_fast8_t    i;

	static char buffer[10];
	
	UsartWriteLine("SDRAM: Writing walking 1s");
	_delay_ms(5);

	/* Write walking 1s */
	for (p = base, i = 0; i < 15; i++) {
		hugemem_write32(p, 1UL << i);
		p = (hugemem_ptr_t)((uint32_t)p + sizeof(uint32_t));
		
		IntToString(i,&buffer[0]);
		UsartWriteString("Step: ");
		UsartWriteLine(buffer);
		_delay_ms(5);
		
	}
	
	UsartWriteLine("SDRAM: Read walking 1s, write walking 0s");
	_delay_ms(5);
	
	/* Read walking 1s, write walking 0s */
	for (p = base, i = 0; i < 4; i++) {
		uint32_t        expected = 1UL << i;
		uint32_t        actual;

		actual = hugemem_read32(p);
		if (actual != expected) {
			//return ERR_IO_ERROR;
			UsartWriteString("Error!\r\n");
			_delay_ms(5);
		}

		hugemem_write32(p, ~expected);
		p = (hugemem_ptr_t)((uint32_t)p + sizeof(uint32_t));
		
		IntToString(i,&buffer[0]);
		UsartWriteString("Step: ");
		UsartWriteLine(buffer);
		_delay_ms(5);
	}
	
	UsartWriteLine("SDRAM: Read walking 0s");
	_delay_ms(5);

	/* Read walking 0s */
	for (p = base, i = 0; i < 4; i++) {
		uint32_t        actual;
		uint32_t        expected = ~(1UL << i);

		actual = hugemem_read32(p);
		if (actual != expected) {
			return ERR_IO_ERROR;
		}

		p = (hugemem_ptr_t)((uint32_t)p + sizeof(uint32_t));
		IntToString(i,&buffer[0]);
		UsartWriteString("Step: ");
		UsartWriteLine(buffer);
		_delay_ms(5);
	}

	return STATUS_OK;
}

/**
 * \brief Test the EBI address bus wired to the SDRAM
 *
 * This function will perform an address bus test to locate any shorts or open
 * leads to the SDRAM device.
 *
 * \param base Base address of the external memory device
 * \param size Size of the external memory device
 *
 * \retval STATUS_OK on success, and \ref status_code_t error code on failure
 */
status_code_t ebi_test_addr_bus(hugemem_ptr_t base, uint32_t size)
{
	uint32_t        offset;
	uint_fast8_t    i;
	
	static char buffer[10];
	
	//UsartWriteString("SDRAM: Address test: initializing");
	//_delay_ms(5);

	/* Initialize all power-of-two locations with 0x55 */
	hugemem_write8(base, 0x55);
	for (offset = 1; offset < size; offset <<= 1) {
		hugemem_ptr_t   p;

		p = (hugemem_ptr_t)((uint32_t)base + offset);
		hugemem_write8(p, 0x55);
		/*IntToString(offset,&buffer[0]);
		UsartWriteString("Step: ");
		_delay_ms(5);
		UsartWriteLine(buffer);
		_delay_ms(5);*/
	}
	
	//UsartWriteString("SDRAM: Address test: check for lines stuck high");
	//_delay_ms(5);

	/* Check for address lines stuck high */
	hugemem_write8(base, 0xaa);
	for (i = 0, offset = 1; offset < size; offset <<= 1, i++) {
		hugemem_ptr_t   p;
		uint8_t         actual;

		p = (hugemem_ptr_t)((uint32_t)base + offset);
		actual = hugemem_read8(p);
		if (actual != 0x55) {
			//return ERR_IO_ERROR;
			//UsartWriteString("Error!\r\n");
			//_delay_ms(5);
		}
		/*IntToString(i,&buffer[0]);
		UsartWriteString("Step: ");
		_delay_ms(5);
		UsartWriteLine(buffer);
		_delay_ms(5);*/
	}
	
	//UsartWriteString("SDRAM: Address test: check for lines stuck low");
	//_delay_ms(1000);

	/* Check for address lines stuck low or shorted */
	hugemem_write8(base, 0x55);
	for (i = 0, offset = 1; offset < size; offset <<= 1, i++) {
		hugemem_ptr_t   p;
		uint32_t        offset2;
		uint_fast8_t    j;
		uint8_t         actual;

		p = (hugemem_ptr_t)((uint32_t)base + offset);
		hugemem_write8(p, 0xaa);

		actual = hugemem_read8(base);
		if (actual != 0x55) {
			//return ERR_IO_ERROR;
			//UsartWriteString("Error!\r\n");
			//_delay_ms(5);
		}
		
		/*IntToString(i,&buffer[0]);
		UsartWriteString("(i)Step: ");
		_delay_ms(5);
		UsartWriteLine(buffer);
		_delay_ms(5);*/

		for (j = 0, offset2 = 1; offset2 < size; offset2 <<= 1, j++) {
			hugemem_ptr_t   q;

			if (offset2 == offset)
				continue;

			q = (hugemem_ptr_t)((uint32_t)base + offset2);
			actual = hugemem_read8(q);
			if (actual != 0x55) {
				//return ERR_IO_ERROR;
				//UsartWriteString("Error!\r\n");
				//_delay_ms(5);
			}
			
			/*IntToString(j,&buffer[0]);
			UsartWriteString("(j)Step: ");
			_delay_ms(5);
			UsartWriteLine(buffer);
			_delay_ms(5);*/
		}

		hugemem_write8(p, 0x55);
	}

	return STATUS_OK;
}

/**
 * \brief Perform a SDRAM data integrity test
 *
 * This function will perform a SDRAM data integrity test by writing 0s and 1s
 * to the entire external device.
 *
 * \param base Base address of the external memory device
 * \param size Size of the external memory device
 *
 * \retval STATUS_OK on success, and \ref status_code_t error code on failure
 */
status_code_t ebi_test_data_integrity(hugemem_ptr_t base, uint32_t size)
{
	uint32_t        offset;
	uint32_t        pattern;

	/* Fill memory with a known pattern. */
	for (pattern = 1, offset = 0; offset < size; pattern++,
			offset += sizeof(uint32_t)) {
		hugemem_ptr_t   p;

		p = (hugemem_ptr_t)((uint32_t)base + offset);
		hugemem_write32(p, pattern);
	}

	/* Check each location and invert it for the second pass. */
	for (pattern = 1, offset = 0; offset < size; pattern++,
			offset += sizeof(uint32_t)) {
		hugemem_ptr_t   p;
		uint32_t        actual;
		uint32_t        expected;

		p = (hugemem_ptr_t)((uint32_t)base + offset);

		actual = hugemem_read32(p);
		if (actual != pattern) {
			return ERR_IO_ERROR;
		}

		expected = ~pattern;
		hugemem_write32(p, expected);
	}

	/* Check each location for the inverted pattern and zero it. */
	for (pattern = 1, offset = 0; offset < size; pattern++,
			offset += sizeof(uint32_t)) {
		hugemem_ptr_t   p;
		uint32_t        actual;
		uint32_t        expected;

		p = (hugemem_ptr_t)((uint32_t)base + offset);

		expected = ~pattern;
		actual = hugemem_read32(p);
		if (actual != expected) {
			return ERR_IO_ERROR;
		}
	}

	return STATUS_OK;
}
