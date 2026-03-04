#include "sys/alt_stdio.h"
#include "system.h"
#include "altera_avalon_pio_regs.h"
#include <unistd.h>

int main()
{ 
  alt_putstr("System Ready. Loop running...\n");

  int led_state = 0;
  int button_val;
  int prev_button_val = 1;

  // Timer variable to track when to blink
  int blink_timer = 0;

  // Define how many loop iterations equal one blink toggle
  // If we delay 1ms per loop, 500 loops = 0.5 seconds
  const int BLINK_THRESHOLD = 500;

  while (1)
  {
      // ============================================
      // 1. FAST TASK: Poll the Button (Runs every 1ms)
      // ============================================

      button_val = IORD_ALTERA_AVALON_PIO_DATA(BUTTON_PIO_BASE);
      button_val = button_val & 0x1;

      // Detect Falling Edge (Press)
      if (prev_button_val == 1 && button_val == 0)
      {
          alt_putstr("Button KEY[0] Pressed!\n");

          // Optional: Force LED change immediately on press if you want
          // led_state = 1;
          // IOWR_ALTERA_AVALON_PIO_DATA(LED_PIO_BASE, led_state);
      }
      prev_button_val = button_val;

      // ============================================
      // 2. SLOW TASK: Blink LED (Runs every 500ms)
      // ============================================

      blink_timer++; // Increment timer

      if (blink_timer >= BLINK_THRESHOLD)
      {
          // Time to toggle!
          led_state = !led_state;
          IOWR_ALTERA_AVALON_PIO_DATA(LED_PIO_BASE, led_state);

          // Reset timer
          blink_timer = 0;
      }

      // ============================================
      // 3. Small Delay
      // ============================================
      // Wait only 1ms (1000 microseconds).
      // This prevents the CPU from working too hard but keeps it responsive.
      usleep(1000);
  }

  return 0;
}
