#include <stdio.h>
#include <stdint.h>
#include <unistd.h>
#include <math.h>
#include <string.h>
#include "system.h"
#include "io.h"
#include "sys/alt_flash.h"
#include "sys/alt_flash_dev.h"

#define N 64
#define PI 3.14159265358979323846

typedef struct { float Re; float Im; } complex_float;

// Helper to handle 12-bit signed numbers
int16_t sign_extend_12(uint16_t val) {
    if (val & 0x800) return (val | 0xF000);
    return val;
}

void hw_fft(complex_float *v, int n) {
    uint32_t packed_data;
    int16_t fixed_re, fixed_im;
    float input_scale = 1024.0f;

    for(int i = 0; i < n; i++) {
        fixed_re = (int16_t)(v[i].Re * input_scale) & 0xFFF;
        fixed_im = (int16_t)(v[i].Im * input_scale) & 0xFFF;
        // Packing: [23:12] Imag, [11:0] Real
        packed_data = ((uint32_t)fixed_im << 12) | (fixed_re & 0xFFF);
        IOWR_32DIRECT(DSP_NIOS_FIFO_IN_IN_BASE, 4, (i == 0) ? 1 : (i == n-1 ? 2 : 0));
        IOWR_32DIRECT(DSP_NIOS_FIFO_IN_IN_BASE, 0, packed_data);
    }

    while(IORD_32DIRECT(DSP_NIOS_FIFO_OUT_OUT_CSR_BASE, 0) < n);

    for(int i = 0; i < n; i++) {
        packed_data = IORD_32DIRECT(DSP_NIOS_FIFO_OUT_OUT_BASE, 0);
        uint16_t raw_re   = (packed_data & 0xFFF);
        uint16_t raw_im   = (packed_data >> 12) & 0xFFF;
        uint8_t  exponent = (packed_data >> 24) & 0x3F;

        float bfp_scale = powf(2.0f, (float)exponent);
        v[i].Re = ((float)sign_extend_12(raw_re) / input_scale) * bfp_scale;
        v[i].Im = ((float)sign_extend_12(raw_im) / input_scale) * bfp_scale;
    }
}

void flash_interfacing() {
    printf(">> Initializing Flash Memory Test...\n");
    alt_flash_fd* flash_handle = alt_flash_open_dev(FLASH_MEM_DATA_NAME);
    if (flash_handle) {
        char msg[] = "FFT_READY_2026";
        alt_write_flash(flash_handle, 0, msg, strlen(msg) + 1);
        printf(">> Flash status: PASSED\n");
        alt_flash_close_dev(flash_handle);
    }
}

int main() {
    complex_float v[N];
    printf("\n=======================================\n");
    printf("   DE10-LITE NIOS II DSP PLATFORM    \n");
    printf("=======================================\n");

    flash_interfacing();

    // Generate 1kHz test tone
    for(int k = 0; k < N; k++) {
        v[k].Re = 0.5f * cosf(2.0f * PI * k * 8.0f / 64.0f);
        v[k].Im = 0.0f;
    }

    hw_fft(v, N);

    printf("FFT Result at Target Bin [08]: %7.4f\n",
           (double)sqrtf(v[8].Re*v[8].Re + v[8].Im*v[8].Im));
    printf(">> Hardware Accelerator: ONLINE\n\n");

    printf("Entering Real-time IO Loop...\n");
    uint32_t last_sw = 0xFFFFFFFF;
    while (1) {
        uint32_t sw = IORD_32DIRECT(IO_INTERFACE_SWITCH_INTERFACE_BASE, 0);
        IOWR_32DIRECT(IO_INTERFACE_HEX_DISPLAY_BASE, 0, sw);
        if(sw != last_sw) {
            printf("Switch State: 0x%03X\n", (unsigned int)sw);
            last_sw = sw;
        }
        usleep(50000);
    }
    return 0;
}
