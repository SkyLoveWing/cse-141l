`timescale 1ns / 1ps

// A simple register file wrapper

// University of California San Diego
// CSE141L Spring 2010
// Written by Matt DeVuyst
// April 7, 2010
// Modified by Vikram Bhatt
// April 1, 2011 (not trying to fool you, really!)
// Modified by Nikolaos Strikos
// April 8, 2012

module register_file_wrap
  (
   // Inputs
   clk,                       // Clock to control when write happen.
   wen_i,                     // Enable writing to a register.
   ra0_i,                     // The number of a register to read from.
   ra1_i,                     // The number of a register to read from.
   wa_i,                      // The number of a register to write to.
   wd_i,                      // Data to write to a given register.

   // Outputs
   rd0_o,                     // Data read from a given register.
   rd1_o                      // Data read from a given register.
   );

   parameter NUM_REGS = 32;      // Number of registers.
   parameter NUM_REGS_LOG = 3;  // Log_base_2 (number_of_registers).
   parameter DATA_WIDTH = 64;   // The width of each register.

   // Inputs
   input                    clk;
   input                    wen_i;
   input [NUM_REGS_LOG-1:0] ra0_i;
   input [NUM_REGS_LOG-1:0] ra1_i;
   input [NUM_REGS_LOG-1:0] wa_i;
   input [DATA_WIDTH-1:0]   wd_i;

   // Outputs
   output [DATA_WIDTH-1:0]  rd0_o;
   output [DATA_WIDTH-1:0]  rd1_o;

   // Internal logic
   logic                    wen_r;
   logic [NUM_REGS_LOG-1:0] ra0_r;
   logic [NUM_REGS_LOG-1:0] ra1_r;
   logic [NUM_REGS_LOG-1:0] wa_r;
   logic [DATA_WIDTH-1:0]   wd_r;
   logic [DATA_WIDTH-1:0]   rd0_r;
   logic [DATA_WIDTH-1:0]   rd1_r;
   logic [DATA_WIDTH-1:0]   rd0_w;
   logic [DATA_WIDTH-1:0]   rd1_w;

   assign rd0_o = rd0_r;
   assign rd1_o = rd1_r;

   register rf
     (
      // Inputs
      .clk   	(clk),
      .wen_i 	(wen_r),
      .ra0_i	(ra0_r),
      .ra1_i 	(ra1_r),
      .wa_i  	(wa_r),
      .wd_i  	(wd_r),
      // Outputs
      .rd0_o 	(rd0_w),
      .rd1_o 	(rd1_w)
      );

   always @(posedge clk)
     begin
        wen_r  <= wen_i;
        ra0_r  <= ra0_i;
        ra1_r  <= ra1_i;
        wa_r   <= wa_i;
        wd_r   <= wd_i;
        rd0_r  <= rd0_w;
        rd1_r  <= rd1_w;
     end

endmodule // register_file_wrap



