//#include <stdio.h>
//#include <stdint.h>
//#include <unistd.h>
//#include "system.h"
//#include "io.h"
//#include "altera_msgdma.h"
//
//#define GPIO_DIR_LOW_OFFSET 8
//#define DMA_TEST_ADDRESS (SDRAM_BASE + 0x02000000)
//
//int main()
//{
//    printf("=== DMA Hardware Diagnostic Test (Byte-Swapped) ===\n");
//
//    IOWR_32DIRECT(GPIO_AVALON_GPIO_INTERFACE_0_BASE, GPIO_DIR_LOW_OFFSET, 0x00000000);
//
//    alt_msgdma_dev *dma_dev = alt_msgdma_open(GPIO_DMA_CSR_NAME);
//    if (!dma_dev) {
//        printf("ERROR: mSGDMA not found!\n");
//        return -1;
//    }
//
//    alt_msgdma_standard_descriptor desc;
//
//    while(1)
//    {
//        IOWR_32DIRECT(DMA_TEST_ADDRESS, 0, 0xDEADBEEF);
//        IOWR_32DIRECT(DMA_TEST_ADDRESS, 4, 0xBAADF00D);
//
//        alt_msgdma_construct_standard_st_to_mm_descriptor(
//            dma_dev,
//            &desc,
//            (uint32_t*)DMA_TEST_ADDRESS,
//            8,
//            0
//        );
//
//        alt_msgdma_standard_descriptor_sync_transfer(dma_dev, &desc);
//
//        // Read the raw, backwards data from the DMA
//        uint32_t read_low  = IORD_32DIRECT(DMA_TEST_ADDRESS, 0);
//        uint32_t read_high = IORD_32DIRECT(DMA_TEST_ADDRESS, 4);
//
//        // Combine into a 64-bit variable
//        uint64_t raw_sample = ((uint64_t)read_high << 32) | read_low;
//
//        // --- THE MAGIC FIX ---
//        // Reverse the bytes back to normal!
//        uint64_t corrected_sample = __builtin_bswap64(raw_sample);
//
//        // Print the corrected Hex value (You should see 0x0000000F_FFFFFFFE)
//        printf("Corrected Data: 0x%08X_%08X\n",
//              (unsigned int)(corrected_sample >> 32),
//              (unsigned int)(corrected_sample & 0xFFFFFFFF));
//
//        // Extract Pins from the CORRECTED sample
//        uint8_t led  = (corrected_sample & (1ULL << 0)) ? 1 : 0;
//        uint8_t nss  = (corrected_sample & (1ULL << 1)) ? 1 : 0;
//        uint8_t mosi = (corrected_sample & (1ULL << 2)) ? 1 : 0;
//        uint8_t sck  = (corrected_sample & (1ULL << 3)) ? 1 : 0;
//        uint8_t miso = (corrected_sample & (1ULL << 4)) ? 1 : 0;
//
//        printf("Parsed Pins -> NSS: %d | SCK: %d | MOSI: %d | MISO: %d | LED: %d\n\n",
//                nss, sck, mosi, miso, led);
//
//        usleep(500000);
//    }
//
//    return 0;
//}
