/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`define default_netname none

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
  assign uio_out = 0;
  assign uio_oe  = 0;
  
  // ui_in[0]  used for Carry in signal
  // ui_out[0] used for output sum signal
  // ui_out[1] used for Carry out signal
  
  full_adder
  #()
  fa_i(
	.a(1'b1),
	.b(1'b1),
	.cin(ui_in[0]),
	.sum(ui_out[0]),
	.cout(ui_out[1])
  );
  
endmodule

// Full adder def
module full_adder(
    input a, 
    input b, 
    input cin, 
    output sum, 
    output cout
);
    wire sum_half, carry_half1, carry_half2;
    
    // First half adder for inputs a and b
    half_adder ha_i1(
        .a(a), 
        .b(b), 
        .sum(sum_half), 
        .carry(carry_half1)
    );
    
    // Second half adder for sum of first half adder and cin
    half_adder ha_i2(
        .a(sum_half), 
        .b(cin), 
        .sum(sum), 
        .carry(carry_half2)
    );
    
    // OR gate to determine final carry out
    assign cout = carry_half1 | carry_half2;
endmodule


// Half adder def
module half_adder(
    input a, 
    input b, 
    output sum, 
    output carry
);
    // Sum is XOR of the two inputs
    assign sum = a ^ b;
    // Carry is AND of the two inputs
    assign carry = a & b;
endmodule
