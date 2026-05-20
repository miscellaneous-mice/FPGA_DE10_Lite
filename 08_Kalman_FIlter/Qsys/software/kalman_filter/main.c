#include <stdio.h>
#include "system.h"
#include "io.h"
#include <unistd.h> // for usleep

// Define the Q-format from your Verilog (Q18)
#define Q_SHIFT 18
#define FLOAT_TO_FIXED(x) ((signed int)((x) * (1 << Q_SHIFT)))
#define FIXED_TO_FLOAT(x) ((float)(x) / (float)(1 << Q_SHIFT))

// Register Offsets (Address * 4 because IORD/IOWR uses byte addressing)
#define REG_VALPHA    (0  * 4)
#define REG_VBETA     (1  * 4)
#define REG_IALPHAM   (2  * 4)
#define REG_IBETAM    (3  * 4)
#define REG_CTHETA_T  (4  * 4)
#define REG_STHETA_T  (5  * 4)
#define REG_NBSAMPLES (6  * 4)

#define REG_OMEGA     (7  * 4)
#define REG_THETA     (8  * 4)
#define REG_IALPHAK   (9  * 4)
#define REG_IBETAK    (10 * 4)
#define REG_K00       (11 * 4)
#define REG_K01       (12 * 4)

int main() {
    printf("Starting Kalman Filter Test...\n");

    // 1. Prepare some test data (example values)
    float v_alpha_input = 0.5;
    float v_beta_input  = -0.2;
    float i_alpha_meas  = 1.2;
    float i_beta_meas   = 0.8;
    int samples         = 100;

    while (1) {
        // 2. Write Inputs to the Kalman IP
        // We convert float -> signed int (Q18)
        IOWR_32DIRECT(KALMAN_BASE, REG_VALPHA,    FLOAT_TO_FIXED(v_alpha_input));
        IOWR_32DIRECT(KALMAN_BASE, REG_VBETA,     FLOAT_TO_FIXED(v_beta_input));
        IOWR_32DIRECT(KALMAN_BASE, REG_IALPHAM,   FLOAT_TO_FIXED(i_alpha_meas));
        IOWR_32DIRECT(KALMAN_BASE, REG_IBETAM,    FLOAT_TO_FIXED(i_beta_meas));
        IOWR_32DIRECT(KALMAN_BASE, REG_NBSAMPLES, samples);

        // Optional: Small delay to let the Hardware State Machine finish its cycles
        // though Nios IO is usually slow enough that this isn't strictly necessary.
        usleep(100);

        // 3. Read Outputs from the Kalman IP
        signed int raw_omega = IORD_32DIRECT(KALMAN_BASE, REG_OMEGA);
        signed int raw_theta = IORD_32DIRECT(KALMAN_BASE, REG_THETA);
        signed int raw_k00   = IORD_32DIRECT(KALMAN_BASE, REG_K00);

        // 4. Convert back to float for display
        float omega_out = FIXED_TO_FLOAT(raw_omega);
        float theta_out = FIXED_TO_FLOAT(raw_theta);
        float k00_out   = FIXED_TO_FLOAT(raw_k00);

        // 5. Print Results
        printf("--- Kalman Update ---\n");
        printf("Input V_alpha: %f\n", v_alpha_input);
        printf("Output Omega:  %f rad/s\n", omega_out);
        printf("Output Theta:  %f rad\n", theta_out);
        printf("Gain K00:      %f\n", k00_out);

        // Modify values slightly for next loop iteration
        v_alpha_input += 0.01;
        if (v_alpha_input > 1.0) v_alpha_input = 0.5;

        usleep(1000000); // Wait 1 second
    }

    return 0;
}
