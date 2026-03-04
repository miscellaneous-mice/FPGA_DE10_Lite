#include <stdio.h>
#include <unistd.h>
#include "system.h"
#include "io.h"

// Register Byte Offsets (matching your hardware logic)
#define REG_CTRL   0x0   // Control
#define REG_COUNT  0x4   // Current Value
#define REG_SPEED  0x8   // Speed Limit
#define REG_MAX    0xC   // Max Count

int main() {
    printf("--- Final SoC System Initializing ---\n");

    int hw_count = 0;
    int buttons = 0;
    int led_state = 0;
    int loop_timer = 0;

    // 1. Initial Setup of the Counter Hardware
    // Set Speed to 2,500,000 (Faster count for testing - 20Hz at 50MHz clk)
    IOWR_32DIRECT(IO_PERIPHERALS_COUNTER_BASE, REG_SPEED, 2500000);

    // Set Max Limit to 999,999
    IOWR_32DIRECT(IO_PERIPHERALS_COUNTER_BASE, REG_MAX, 999999);

    // START the counter (Bit 0 = 1)
    IOWR_32DIRECT(IO_PERIPHERALS_COUNTER_BASE, REG_CTRL, 0x1);

    printf("Hardware Counter Started...\n");

    while (1) {
        // --- 2. Button Handling (KEY0) ---
        // The PIO is 2 bits wide. KEY0 is usually bit 0.
        buttons = IORD_32DIRECT(IO_PERIPHERALS_BUTTON_PIO_BASE, 0);

        if ((buttons & 0x01) == 0) { // KEY0 pressed (Active Low)
            printf("KEY0 Pressed: Resetting Counter\n");

            // Pulse the hardware Soft Reset (Bit 1 = Reset, Bit 0 = Run)
            IOWR_32DIRECT(IO_PERIPHERALS_COUNTER_BASE, REG_CTRL, 0x3);
            usleep(100); // Small pulse width
            IOWR_32DIRECT(IO_PERIPHERALS_COUNTER_BASE, REG_CTRL, 0x1);

            usleep(200000); // Debounce delay to prevent multiple resets
        }

        // --- 3. Read Hardware State ---
        hw_count = IORD_32DIRECT(IO_PERIPHERALS_COUNTER_BASE, REG_COUNT);

        // --- 4. Update Display ---
        // Push the count value into the Hex Decoder hardware
        IOWR_32DIRECT(IO_PERIPHERALS_HEX_DISPLAY_BASE, 0, hw_count);

        // --- 5. Background Heartbeat (LED and Print) ---
        loop_timer++;
        if (loop_timer >= 500) { // Roughly every 500ms (1ms * 500)
            led_state = !led_state;
            IOWR_32DIRECT(IO_PERIPHERALS_LED_PIO_BASE, 0, led_state);

            // Debugging info to the PC console via JTAG UART
            printf("Status | Count: %d | Buttons: %d\n", hw_count, buttons);
            loop_timer = 0;
        }

        usleep(1000); // 1ms sleep to keep the loop timing predictable
    }

    return 0;
}
