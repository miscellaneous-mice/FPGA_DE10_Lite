#include <stdio.h>
#include <stdint.h>
#include <unistd.h>
#include "system.h"
#include "io.h"
#include "altera_msgdma.h"
#include "altera_msgdma_descriptor_regs.h"

// Nios II Cache Bypass Macro
#define UNCACHED(addr) ((void*)((uint32_t)(addr) | 0x80000000))

// DMA Buffers in SDRAM (32-byte alignment is best practice for mSGDMA)
static volatile uint32_t key_buf __attribute__ ((aligned (32))) = 0;
static volatile uint32_t sw_buf  __attribute__ ((aligned (32))) = 0;

int main() {
    alt_msgdma_dev *dma = alt_msgdma_open(DMA_IO_CSR_NAME);
    alt_msgdma_standard_descriptor desc;

    if (!dma) {
        printf("ERROR: Could not open DMA_IO. Check your Qsys names.\n");
        return -1;
    }

    printf("--- DMA Automation: Switch-to-HEX System ---\n");
    printf("Press KEY0 to capture switches and update the HEX display.\n");

    while(1) {
        // ------------------------------------------------------------------
        // STEP 1: DMA capturing KEY0 state into SDRAM
        // ------------------------------------------------------------------
        alt_msgdma_construct_standard_mm_to_mm_descriptor(
            dma, &desc,
            (uint32_t *)IO_MODULES_AVALON_KEY_PIO_BASE, // Source
            (uint32_t *)&key_buf,                       // Destination
            4, 0
        );
        alt_msgdma_standard_descriptor_sync_transfer(dma, &desc);

        // Read through cache bypass
        uint32_t k = IORD_32DIRECT(UNCACHED(&key_buf), 0);

        // Detect KEY0 press (Logic 1 from your inverted debouncer)
        if (k & 0x01) {
            printf("Trigger Detected! Processing...\n");

            // --------------------------------------------------------------
            // STEP 2: DMA capturing SWITCHES into SDRAM
            // --------------------------------------------------------------
            alt_msgdma_construct_standard_mm_to_mm_descriptor(
                dma, &desc,
                (uint32_t *)IO_MODULES_AVALON_SW_PIO_BASE, // Source
                (uint32_t *)&sw_buf,                       // Destination
                4, 0
            );
            alt_msgdma_standard_descriptor_sync_transfer(dma, &desc);

            // --------------------------------------------------------------
            // STEP 3: DMA moving value from SDRAM to HEX DISPLAY
            // --------------------------------------------------------------
            // This bypasses the CPU entirely for the data movement.
            alt_msgdma_construct_standard_mm_to_mm_descriptor(
                dma, &desc,
                (uint32_t *)&sw_buf,                        // Source (SDRAM)
                (uint32_t *)IO_MODULES_AVALON_HEX_PIO_BASE, // Destination (HEX)
                4, 0
            );
            alt_msgdma_standard_descriptor_sync_transfer(dma, &desc);

            // Diagnostics: Show what was captured
            uint32_t val = IORD_32DIRECT(UNCACHED(&sw_buf), 0);
            printf("Captured: 0x%03X -> Dispatched to HEX Display via DMA.\n", (unsigned int)(val & 0x3FF));

            // Debounce delay
            usleep(300000);
        }

        usleep(10000); // 10ms loop polling
    }
    return 0;
}
