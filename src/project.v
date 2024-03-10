/*
 * Copyright (c) 2024 Phillip Marlowe
 * SPDX-License-Identifier: Apache-2.0
 */


module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
  //assign uo_out  = ui_in + uio_in;  // Example: ou_out is the sum of ui_in and uio_in
  assign uio_oe = 8'hFF;
  assign uio_out = 8'h00;
    
  dand 
  #(7)
  dand_inst(
    .sel_i(ui_in[0]),
	.out_o(uo_out[0]),
	.ffout_o(uo_out[7:1])
  );
  
  //assign uo_out[0] = ui_in[0] & ui_in[1];
  //assign uo_out[7:1] = 7'b0;
  
endmodule
