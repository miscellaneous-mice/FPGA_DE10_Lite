//Legal Notice: (C)2026 Altera Corporation. All rights reserved.  Your
//use of Altera Corporation's design tools, logic functions and other
//software and tools, and its AMPP partner logic functions, and any
//output files any of the foregoing (including device programming or
//simulation files), and any associated documentation or information are
//expressly subject to the terms and conditions of the Altera Program
//License Subscription Agreement or other applicable license agreement,
//including, without limitation, that your use is for the sole purpose
//of programming logic devices manufactured by Altera and sold by Altera
//or its authorized distributors.  Please refer to the applicable
//agreement for further details.

// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module avalon_design_DSP_NIOS_FIFO_IN_dual_clock_fifo (
                                                        // inputs:
                                                         aclr,
                                                         data,
                                                         rdclk,
                                                         rdreq,
                                                         wrclk,
                                                         wrreq,

                                                        // outputs:
                                                         q,
                                                         rdempty,
                                                         wrempty,
                                                         wrfull,
                                                         wrusedw
                                                      )
  /* synthesis ALTERA_ATTRIBUTE = "SUPPRESS_DA_RULE_INTERNAL=R101" */ ;

  output  [ 24: 0] q;
  output           rdempty;
  output           wrempty;
  output           wrfull;
  output  [  6: 0] wrusedw;
  input            aclr;
  input   [ 24: 0] data;
  input            rdclk;
  input            rdreq;
  input            wrclk;
  input            wrreq;


wire             int_wrfull;
wire    [ 24: 0] q;
wire             rdempty;
wire             wrempty;
wire             wrfull;
wire    [  6: 0] wrusedw;
  assign wrfull = (wrusedw >= 128-3) | int_wrfull;
  dcfifo dual_clock_fifo
    (
      .aclr (aclr),
      .data (data),
      .q (q),
      .rdclk (rdclk),
      .rdempty (rdempty),
      .rdreq (rdreq),
      .wrclk (wrclk),
      .wrempty (wrempty),
      .wrfull (int_wrfull),
      .wrreq (wrreq),
      .wrusedw (wrusedw)
    );

  defparam dual_clock_fifo.add_ram_output_register = "OFF",
           dual_clock_fifo.clocks_are_synchronized = "FALSE",
           dual_clock_fifo.intended_device_family = "MAX10",
           dual_clock_fifo.lpm_hint = "DISABLE_DCFIFO_EMBEDDED_TIMING_CONSTRAINT",
           dual_clock_fifo.lpm_numwords = 128,
           dual_clock_fifo.lpm_showahead = "OFF",
           dual_clock_fifo.lpm_type = "dcfifo",
           dual_clock_fifo.lpm_width = 25,
           dual_clock_fifo.lpm_widthu = 7,
           dual_clock_fifo.overflow_checking = "ON",
           dual_clock_fifo.rdsync_delaypipe = 4,
           dual_clock_fifo.read_aclr_synch = "ON",
           dual_clock_fifo.underflow_checking = "ON",
           dual_clock_fifo.use_eab = "ON",
           dual_clock_fifo.write_aclr_synch = "ON",
           dual_clock_fifo.wrsync_delaypipe = 4;


endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module avalon_design_DSP_NIOS_FIFO_IN_dcfifo_with_controls (
                                                             // inputs:
                                                              data,
                                                              rdclk,
                                                              rdreq,
                                                              rdreset_n,
                                                              wrclk,
                                                              wrclk_control_slave_address,
                                                              wrclk_control_slave_read,
                                                              wrclk_control_slave_write,
                                                              wrclk_control_slave_writedata,
                                                              wrreq,
                                                              wrreset_n,

                                                             // outputs:
                                                              q,
                                                              rdempty,
                                                              wrclk_control_slave_readdata,
                                                              wrfull
                                                           )
;

  output  [ 24: 0] q;
  output           rdempty;
  output  [ 31: 0] wrclk_control_slave_readdata;
  output           wrfull;
  input   [ 24: 0] data;
  input            rdclk;
  input            rdreq;
  input            rdreset_n;
  input            wrclk;
  input   [  2: 0] wrclk_control_slave_address;
  input            wrclk_control_slave_read;
  input            wrclk_control_slave_write;
  input   [ 31: 0] wrclk_control_slave_writedata;
  input            wrreq;
  input            wrreset_n;


wire    [ 24: 0] q;
wire             rdempty;
wire             rdreq_sync;
reg              wrclk_control_slave_almostempty_n_reg;
wire             wrclk_control_slave_almostempty_pulse;
wire             wrclk_control_slave_almostempty_signal;
reg     [  7: 0] wrclk_control_slave_almostempty_threshold_register;
reg              wrclk_control_slave_almostfull_n_reg;
wire             wrclk_control_slave_almostfull_pulse;
wire             wrclk_control_slave_almostfull_signal;
reg     [  7: 0] wrclk_control_slave_almostfull_threshold_register;
reg              wrclk_control_slave_empty_n_reg;
wire             wrclk_control_slave_empty_pulse;
wire             wrclk_control_slave_empty_signal;
reg              wrclk_control_slave_event_almostempty_q;
wire             wrclk_control_slave_event_almostempty_signal;
reg              wrclk_control_slave_event_almostfull_q;
wire             wrclk_control_slave_event_almostfull_signal;
reg              wrclk_control_slave_event_empty_q;
wire             wrclk_control_slave_event_empty_signal;
reg              wrclk_control_slave_event_full_q;
wire             wrclk_control_slave_event_full_signal;
reg              wrclk_control_slave_event_overflow_q;
wire             wrclk_control_slave_event_overflow_signal;
wire    [  5: 0] wrclk_control_slave_event_register;
reg              wrclk_control_slave_event_underflow_q;
wire             wrclk_control_slave_event_underflow_signal;
reg              wrclk_control_slave_full_n_reg;
wire             wrclk_control_slave_full_pulse;
wire             wrclk_control_slave_full_signal;
reg     [  5: 0] wrclk_control_slave_ienable_register;
wire    [  7: 0] wrclk_control_slave_level_register;
wire    [ 31: 0] wrclk_control_slave_read_mux;
reg     [ 31: 0] wrclk_control_slave_readdata;
reg              wrclk_control_slave_status_almostempty_q;
wire             wrclk_control_slave_status_almostempty_signal;
reg              wrclk_control_slave_status_almostfull_q;
wire             wrclk_control_slave_status_almostfull_signal;
reg              wrclk_control_slave_status_empty_q;
wire             wrclk_control_slave_status_empty_signal;
reg              wrclk_control_slave_status_full_q;
wire             wrclk_control_slave_status_full_signal;
reg              wrclk_control_slave_status_overflow_q;
wire             wrclk_control_slave_status_overflow_signal;
wire    [  5: 0] wrclk_control_slave_status_register;
reg              wrclk_control_slave_status_underflow_q;
wire             wrclk_control_slave_status_underflow_signal;
wire    [  7: 0] wrclk_control_slave_threshold_writedata;
wire             wrempty;
wire             wrfull;
wire    [  7: 0] wrlevel;
wire             wroverflow;
wire             wrreq_valid;
wire             wrunderflow;
wire    [  6: 0] wrusedw;
  //the_dcfifo, which is an e_instance
  avalon_design_DSP_NIOS_FIFO_IN_dual_clock_fifo the_dcfifo
    (
      .aclr    (~(rdreset_n && wrreset_n)),
      .data    (data),
      .q       (q),
      .rdclk   (rdclk),
      .rdempty (rdempty),
      .rdreq   (rdreq),
      .wrclk   (wrclk),
      .wrempty (wrempty),
      .wrfull  (wrfull),
      .wrreq   (wrreq_valid),
      .wrusedw (wrusedw)
    );

  altera_std_synchronizer rdreq_sync_i
    (
      .clk (wrclk),
      .din (rdreq),
      .dout (rdreq_sync),
      .reset_n (wrreset_n)
    );

  defparam rdreq_sync_i.depth = 4;

  assign wrlevel = {1'b0,
    wrusedw};

  assign wrreq_valid = wrreq & ~wrfull;
  assign wroverflow = wrreq & wrfull;
  assign wrunderflow = rdreq_sync & wrempty;
  assign wrclk_control_slave_threshold_writedata = (wrclk_control_slave_writedata < 1) ? 1 :
    (wrclk_control_slave_writedata > 124) ? 124 :
    wrclk_control_slave_writedata[7 : 0];

  assign wrclk_control_slave_event_almostfull_signal = wrclk_control_slave_almostfull_pulse;
  assign wrclk_control_slave_event_almostempty_signal = wrclk_control_slave_almostempty_pulse;
  assign wrclk_control_slave_status_almostfull_signal = wrclk_control_slave_almostfull_signal;
  assign wrclk_control_slave_status_almostempty_signal = wrclk_control_slave_almostempty_signal;
  assign wrclk_control_slave_event_full_signal = wrclk_control_slave_full_pulse;
  assign wrclk_control_slave_event_empty_signal = wrclk_control_slave_empty_pulse;
  assign wrclk_control_slave_status_full_signal = wrclk_control_slave_full_signal;
  assign wrclk_control_slave_status_empty_signal = wrclk_control_slave_empty_signal;
  assign wrclk_control_slave_event_overflow_signal = wroverflow;
  assign wrclk_control_slave_event_underflow_signal = wrunderflow;
  assign wrclk_control_slave_status_overflow_signal = wroverflow;
  assign wrclk_control_slave_status_underflow_signal = wrunderflow;
  assign wrclk_control_slave_empty_signal = wrempty;
  assign wrclk_control_slave_empty_pulse = wrclk_control_slave_empty_signal & wrclk_control_slave_empty_n_reg;
  always @(posedge wrclk or negedge wrreset_n)
    begin
      if (wrreset_n == 0)
          wrclk_control_slave_empty_n_reg <= 0;
      else 
        wrclk_control_slave_empty_n_reg <= !wrclk_control_slave_empty_signal;
    end


  assign wrclk_control_slave_full_signal = wrfull;
  assign wrclk_control_slave_full_pulse = wrclk_control_slave_full_signal & wrclk_control_slave_full_n_reg;
  always @(posedge wrclk or negedge wrreset_n)
    begin
      if (wrreset_n == 0)
          wrclk_control_slave_full_n_reg <= 0;
      else 
        wrclk_control_slave_full_n_reg <= !wrclk_control_slave_full_signal;
    end


  assign wrclk_control_slave_almostempty_signal = wrlevel <= wrclk_control_slave_almostempty_threshold_register;
  assign wrclk_control_slave_almostempty_pulse = wrclk_control_slave_almostempty_signal & wrclk_control_slave_almostempty_n_reg;
  always @(posedge wrclk or negedge wrreset_n)
    begin
      if (wrreset_n == 0)
          wrclk_control_slave_almostempty_n_reg <= 0;
      else 
        wrclk_control_slave_almostempty_n_reg <= !wrclk_control_slave_almostempty_signal;
    end


  assign wrclk_control_slave_almostfull_signal = wrlevel >= wrclk_control_slave_almostfull_threshold_register;
  assign wrclk_control_slave_almostfull_pulse = wrclk_control_slave_almostfull_signal & wrclk_control_slave_almostfull_n_reg;
  always @(posedge wrclk or negedge wrreset_n)
    begin
      if (wrreset_n == 0)
          wrclk_control_slave_almostfull_n_reg <= 0;
      else 
        wrclk_control_slave_almostfull_n_reg <= !wrclk_control_slave_almostfull_signal;
    end


  always @(posedge wrclk or negedge wrreset_n)
    begin
      if (wrreset_n == 0)
          wrclk_control_slave_almostempty_threshold_register <= 1;
      else if ((wrclk_control_slave_address == 5) & wrclk_control_slave_write)
          wrclk_control_slave_almostempty_threshold_register <= wrclk_control_slave_threshold_writedata;
    end


  always @(posedge wrclk or negedge wrreset_n)
    begin
      if (wrreset_n == 0)
          wrclk_control_slave_almostfull_threshold_register <= 124;
      else if ((wrclk_control_slave_address == 4) & wrclk_control_slave_write)
          wrclk_control_slave_almostfull_threshold_register <= wrclk_control_slave_threshold_writedata;
    end


  always @(posedge wrclk or negedge wrreset_n)
    begin
      if (wrreset_n == 0)
          wrclk_control_slave_ienable_register <= 0;
      else if ((wrclk_control_slave_address == 3) & wrclk_control_slave_write)
          wrclk_control_slave_ienable_register <= wrclk_control_slave_writedata[5 : 0];
    end


  assign wrclk_control_slave_level_register = wrlevel;
  always @(posedge wrclk or negedge wrreset_n)
    begin
      if (wrreset_n == 0)
          wrclk_control_slave_event_underflow_q <= 0;
      else if (wrclk_control_slave_write & 
                               (wrclk_control_slave_address == 2) &
                               wrclk_control_slave_writedata[5])
          wrclk_control_slave_event_underflow_q <= 0;
      else if (wrclk_control_slave_event_underflow_signal)
          wrclk_control_slave_event_underflow_q <= -1;
    end


  always @(posedge wrclk or negedge wrreset_n)
    begin
      if (wrreset_n == 0)
          wrclk_control_slave_event_overflow_q <= 0;
      else if (wrclk_control_slave_write & 
                               (wrclk_control_slave_address == 2) &
                               wrclk_control_slave_writedata[4])
          wrclk_control_slave_event_overflow_q <= 0;
      else if (wrclk_control_slave_event_overflow_signal)
          wrclk_control_slave_event_overflow_q <= -1;
    end


  always @(posedge wrclk or negedge wrreset_n)
    begin
      if (wrreset_n == 0)
          wrclk_control_slave_event_almostempty_q <= 0;
      else if (wrclk_control_slave_write & 
                               (wrclk_control_slave_address == 2) &
                               wrclk_control_slave_writedata[3])
          wrclk_control_slave_event_almostempty_q <= 0;
      else if (wrclk_control_slave_event_almostempty_signal)
          wrclk_control_slave_event_almostempty_q <= -1;
    end


  always @(posedge wrclk or negedge wrreset_n)
    begin
      if (wrreset_n == 0)
          wrclk_control_slave_event_almostfull_q <= 0;
      else if (wrclk_control_slave_write & 
                               (wrclk_control_slave_address == 2) &
                               wrclk_control_slave_writedata[2])
          wrclk_control_slave_event_almostfull_q <= 0;
      else if (wrclk_control_slave_event_almostfull_signal)
          wrclk_control_slave_event_almostfull_q <= -1;
    end


  always @(posedge wrclk or negedge wrreset_n)
    begin
      if (wrreset_n == 0)
          wrclk_control_slave_event_empty_q <= 0;
      else if (wrclk_control_slave_write & 
                               (wrclk_control_slave_address == 2) &
                               wrclk_control_slave_writedata[1])
          wrclk_control_slave_event_empty_q <= 0;
      else if (wrclk_control_slave_event_empty_signal)
          wrclk_control_slave_event_empty_q <= -1;
    end


  always @(posedge wrclk or negedge wrreset_n)
    begin
      if (wrreset_n == 0)
          wrclk_control_slave_event_full_q <= 0;
      else if (wrclk_control_slave_write & 
                               (wrclk_control_slave_address == 2) &
                               wrclk_control_slave_writedata[0])
          wrclk_control_slave_event_full_q <= 0;
      else if (wrclk_control_slave_event_full_signal)
          wrclk_control_slave_event_full_q <= -1;
    end


  assign wrclk_control_slave_event_register = {wrclk_control_slave_event_underflow_q,
    wrclk_control_slave_event_overflow_q,
    wrclk_control_slave_event_almostempty_q,
    wrclk_control_slave_event_almostfull_q,
    wrclk_control_slave_event_empty_q,
    wrclk_control_slave_event_full_q};

  always @(posedge wrclk or negedge wrreset_n)
    begin
      if (wrreset_n == 0)
          wrclk_control_slave_status_underflow_q <= 0;
      else 
        wrclk_control_slave_status_underflow_q <= wrclk_control_slave_status_underflow_signal;
    end


  always @(posedge wrclk or negedge wrreset_n)
    begin
      if (wrreset_n == 0)
          wrclk_control_slave_status_overflow_q <= 0;
      else 
        wrclk_control_slave_status_overflow_q <= wrclk_control_slave_status_overflow_signal;
    end


  always @(posedge wrclk or negedge wrreset_n)
    begin
      if (wrreset_n == 0)
          wrclk_control_slave_status_almostempty_q <= 0;
      else 
        wrclk_control_slave_status_almostempty_q <= wrclk_control_slave_status_almostempty_signal;
    end


  always @(posedge wrclk or negedge wrreset_n)
    begin
      if (wrreset_n == 0)
          wrclk_control_slave_status_almostfull_q <= 0;
      else 
        wrclk_control_slave_status_almostfull_q <= wrclk_control_slave_status_almostfull_signal;
    end


  always @(posedge wrclk or negedge wrreset_n)
    begin
      if (wrreset_n == 0)
          wrclk_control_slave_status_empty_q <= 0;
      else 
        wrclk_control_slave_status_empty_q <= wrclk_control_slave_status_empty_signal;
    end


  always @(posedge wrclk or negedge wrreset_n)
    begin
      if (wrreset_n == 0)
          wrclk_control_slave_status_full_q <= 0;
      else 
        wrclk_control_slave_status_full_q <= wrclk_control_slave_status_full_signal;
    end


  assign wrclk_control_slave_status_register = {wrclk_control_slave_status_underflow_q,
    wrclk_control_slave_status_overflow_q,
    wrclk_control_slave_status_almostempty_q,
    wrclk_control_slave_status_almostfull_q,
    wrclk_control_slave_status_empty_q,
    wrclk_control_slave_status_full_q};

  assign wrclk_control_slave_read_mux = ({32 {(wrclk_control_slave_address == 0)}} & wrclk_control_slave_level_register) |
    ({32 {(wrclk_control_slave_address == 1)}} & wrclk_control_slave_status_register) |
    ({32 {(wrclk_control_slave_address == 2)}} & wrclk_control_slave_event_register) |
    ({32 {(wrclk_control_slave_address == 3)}} & wrclk_control_slave_ienable_register) |
    ({32 {(wrclk_control_slave_address == 4)}} & wrclk_control_slave_almostfull_threshold_register) |
    ({32 {(wrclk_control_slave_address == 5)}} & wrclk_control_slave_almostempty_threshold_register) |
    ({32 {(~((wrclk_control_slave_address == 0))) && (~((wrclk_control_slave_address == 1))) && (~((wrclk_control_slave_address == 2))) && (~((wrclk_control_slave_address == 3))) && (~((wrclk_control_slave_address == 4))) && (~((wrclk_control_slave_address == 5)))}} & wrclk_control_slave_level_register);

  always @(posedge wrclk or negedge wrreset_n)
    begin
      if (wrreset_n == 0)
          wrclk_control_slave_readdata <= 0;
      else if (wrclk_control_slave_read)
          wrclk_control_slave_readdata <= wrclk_control_slave_read_mux;
    end



endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module avalon_design_DSP_NIOS_FIFO_IN_map_avalonmm_to_avalonst (
                                                                 // inputs:
                                                                  avalonmm_data,

                                                                 // outputs:
                                                                  avalonst_data
                                                               )
;

  output  [ 24: 0] avalonst_data;
  input   [ 31: 0] avalonmm_data;


wire    [ 24: 0] avalonst_data;
  assign avalonst_data[24 : 0] = avalonmm_data[24 : 0];

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module avalon_design_DSP_NIOS_FIFO_IN_dual_clock_fifo_for_other_info (
                                                                       // inputs:
                                                                        aclr,
                                                                        data,
                                                                        rdclk,
                                                                        rdreq,
                                                                        wrclk,
                                                                        wrreq,

                                                                       // outputs:
                                                                        q,
                                                                        rdempty,
                                                                        wrfull
                                                                     )
  /* synthesis ALTERA_ATTRIBUTE = "SUPPRESS_DA_RULE_INTERNAL=R101" */ ;

  output  [  1: 0] q;
  output           rdempty;
  output           wrfull;
  input            aclr;
  input   [  1: 0] data;
  input            rdclk;
  input            rdreq;
  input            wrclk;
  input            wrreq;


wire             int_wrfull;
wire    [  1: 0] q;
wire             rdempty;
wire             wrfull;
wire    [  6: 0] wrusedw;
  assign wrfull = (wrusedw >= 128-3) | int_wrfull;
  dcfifo dual_clock_fifo
    (
      .aclr (aclr),
      .data (data),
      .q (q),
      .rdclk (rdclk),
      .rdempty (rdempty),
      .rdreq (rdreq),
      .wrclk (wrclk),
      .wrfull (int_wrfull),
      .wrreq (wrreq),
      .wrusedw (wrusedw)
    );

  defparam dual_clock_fifo.add_ram_output_register = "OFF",
           dual_clock_fifo.clocks_are_synchronized = "FALSE",
           dual_clock_fifo.intended_device_family = "MAX10",
           dual_clock_fifo.lpm_hint = "DISABLE_DCFIFO_EMBEDDED_TIMING_CONSTRAINT",
           dual_clock_fifo.lpm_numwords = 128,
           dual_clock_fifo.lpm_showahead = "OFF",
           dual_clock_fifo.lpm_type = "dcfifo",
           dual_clock_fifo.lpm_width = 2,
           dual_clock_fifo.lpm_widthu = 7,
           dual_clock_fifo.overflow_checking = "ON",
           dual_clock_fifo.rdsync_delaypipe = 4,
           dual_clock_fifo.read_aclr_synch = "ON",
           dual_clock_fifo.underflow_checking = "ON",
           dual_clock_fifo.use_eab = "ON",
           dual_clock_fifo.write_aclr_synch = "ON",
           dual_clock_fifo.wrsync_delaypipe = 4;


endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module avalon_design_DSP_NIOS_FIFO_IN_map_avalonmm_to_avalonst_other_info (
                                                                            // inputs:
                                                                             auto_clr,
                                                                             avalonmm_other_info,
                                                                             clock,
                                                                             enable,
                                                                             reset_n,

                                                                            // outputs:
                                                                             avalonst_other_info
                                                                          )
;

  output  [  1: 0] avalonst_other_info;
  input            auto_clr;
  input   [ 31: 0] avalonmm_other_info;
  input            clock;
  input            enable;
  input            reset_n;


wire    [  1: 0] avalonst_other_info;
wire             eop;
reg              eop_q;
wire             sop;
reg              sop_q;
  assign sop = avalonmm_other_info[0];
  assign eop = avalonmm_other_info[1];
  assign avalonst_other_info = {eop_q,
    sop_q};

  always @(posedge clock or negedge reset_n)
    begin
      if (reset_n == 0)
          sop_q <= 0;
      else if (enable | auto_clr)
          if (auto_clr)
              sop_q <= 0;
          else 
            sop_q <= sop;
    end


  always @(posedge clock or negedge reset_n)
    begin
      if (reset_n == 0)
          eop_q <= 0;
      else if (enable | auto_clr)
          if (auto_clr)
              eop_q <= 0;
          else 
            eop_q <= eop;
    end



endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module avalon_design_DSP_NIOS_FIFO_IN_map_fifo_other_info_to_avalonst (
                                                                        // inputs:
                                                                         data_in,

                                                                        // outputs:
                                                                         avalonst_source_endofpacket,
                                                                         avalonst_source_startofpacket
                                                                      )
;

  output           avalonst_source_endofpacket;
  output           avalonst_source_startofpacket;
  input   [  1: 0] data_in;


wire             avalonst_source_endofpacket;
wire             avalonst_source_startofpacket;
  assign {avalonst_source_endofpacket,
avalonst_source_startofpacket} = data_in;

endmodule


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module avalon_design_DSP_NIOS_FIFO_IN (
                                        // inputs:
                                         avalonmm_write_slave_address,
                                         avalonmm_write_slave_write,
                                         avalonmm_write_slave_writedata,
                                         avalonst_source_ready,
                                         rdclock,
                                         rdreset_n,
                                         wrclk_control_slave_address,
                                         wrclk_control_slave_read,
                                         wrclk_control_slave_write,
                                         wrclk_control_slave_writedata,
                                         wrclock,
                                         wrreset_n,

                                        // outputs:
                                         avalonmm_write_slave_waitrequest,
                                         avalonst_source_data,
                                         avalonst_source_endofpacket,
                                         avalonst_source_startofpacket,
                                         avalonst_source_valid,
                                         wrclk_control_slave_readdata
                                      )
;

  output           avalonmm_write_slave_waitrequest;
  output  [ 24: 0] avalonst_source_data;
  output           avalonst_source_endofpacket;
  output           avalonst_source_startofpacket;
  output           avalonst_source_valid;
  output  [ 31: 0] wrclk_control_slave_readdata;
  input            avalonmm_write_slave_address;
  input            avalonmm_write_slave_write;
  input   [ 31: 0] avalonmm_write_slave_writedata;
  input            avalonst_source_ready;
  input            rdclock;
  input            rdreset_n;
  input   [  2: 0] wrclk_control_slave_address;
  input            wrclk_control_slave_read;
  input            wrclk_control_slave_write;
  input   [ 31: 0] wrclk_control_slave_writedata;
  input            wrclock;
  input            wrreset_n;


wire    [ 31: 0] avalonmm_map_data_in;
wire             avalonmm_write_slave_waitrequest;
wire    [ 24: 0] avalonst_map_data_out;
wire    [  1: 0] avalonst_other_info;
wire    [ 24: 0] avalonst_source_data;
wire             avalonst_source_endofpacket;
wire             avalonst_source_startofpacket;
reg              avalonst_source_valid;
wire    [ 24: 0] data;
wire    [ 24: 0] q;
wire    [  1: 0] q_i;
wire             rdclk;
wire             rdempty;
wire             rdempty_i;
wire             rdreq;
wire             wrclk;
wire    [ 31: 0] wrclk_control_slave_readdata;
wire             wrfull;
wire             wrfull_i;
wire             wrreq;
wire             wrreq_driver;
  //the_dcfifo_with_controls, which is an e_instance
  avalon_design_DSP_NIOS_FIFO_IN_dcfifo_with_controls the_dcfifo_with_controls
    (
      .data                          (data),
      .q                             (q),
      .rdclk                         (rdclk),
      .rdempty                       (rdempty),
      .rdreq                         (rdreq),
      .rdreset_n                     (rdreset_n),
      .wrclk                         (wrclk),
      .wrclk_control_slave_address   (wrclk_control_slave_address),
      .wrclk_control_slave_read      (wrclk_control_slave_read),
      .wrclk_control_slave_readdata  (wrclk_control_slave_readdata),
      .wrclk_control_slave_write     (wrclk_control_slave_write),
      .wrclk_control_slave_writedata (wrclk_control_slave_writedata),
      .wrfull                        (wrfull),
      .wrreq                         (wrreq),
      .wrreset_n                     (wrreset_n)
    );

  //in, which is an e_avalon_slave
  assign avalonmm_write_slave_waitrequest = wrfull || wrfull_i;
  //the_map_avalonmm_to_avalonst, which is an e_instance
  avalon_design_DSP_NIOS_FIFO_IN_map_avalonmm_to_avalonst the_map_avalonmm_to_avalonst
    (
      .avalonmm_data (avalonmm_map_data_in),
      .avalonst_data (avalonst_map_data_out)
    );

  assign wrreq_driver = (avalonmm_write_slave_address == 0) & avalonmm_write_slave_write;
  assign avalonmm_map_data_in = avalonmm_write_slave_writedata;
  assign wrreq = wrreq_driver;
  assign data = avalonst_map_data_out;
  assign wrclk = wrclock;
  assign rdclk = rdclock;
  //the_dcfifo_other_info, which is an e_instance
  avalon_design_DSP_NIOS_FIFO_IN_dual_clock_fifo_for_other_info the_dcfifo_other_info
    (
      .aclr    (~(wrreset_n && rdreset_n)),
      .data    (avalonst_other_info),
      .q       (q_i),
      .rdclk   (rdclk),
      .rdempty (rdempty_i),
      .rdreq   (rdreq),
      .wrclk   (wrclk),
      .wrfull  (wrfull_i),
      .wrreq   (wrreq_driver & ~wrfull_i)
    );

  //the_map_avalonmm_to_avalonst_other_info, which is an e_instance
  avalon_design_DSP_NIOS_FIFO_IN_map_avalonmm_to_avalonst_other_info the_map_avalonmm_to_avalonst_other_info
    (
      .auto_clr            (wrreq_driver & ~wrfull_i),
      .avalonmm_other_info (avalonmm_write_slave_writedata),
      .avalonst_other_info (avalonst_other_info),
      .clock               (wrclk),
      .enable              ((avalonmm_write_slave_address == 1) & avalonmm_write_slave_write),
      .reset_n             (wrreset_n)
    );

  //the_map_fifo_other_info_to_avalonst, which is an e_instance
  avalon_design_DSP_NIOS_FIFO_IN_map_fifo_other_info_to_avalonst the_map_fifo_other_info_to_avalonst
    (
      .avalonst_source_endofpacket   (avalonst_source_endofpacket),
      .avalonst_source_startofpacket (avalonst_source_startofpacket),
      .data_in                       (q_i)
    );

  assign avalonst_source_data = q;
  assign rdreq = ~rdempty & ~rdempty_i & avalonst_source_ready;
  always @(posedge rdclk or negedge rdreset_n)
    begin
      if (rdreset_n == 0)
          avalonst_source_valid <= 0;
      else 
        avalonst_source_valid <= ~rdempty & ~rdempty_i & avalonst_source_ready;
    end


  //out, which is an e_atlantic_master
  //in_csr, which is an e_avalon_slave

endmodule

