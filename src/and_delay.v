/*
 * Copyright (c) 2024 Phillip Marlowe
 * SPDX-License-Identifier: Apache-2.0
 */

// Define cell 
`define AND_CELL          sky130_fd_sc_hd__and2_1 

// Define techmap for cell type (yosys)
(* techmap_celltype = "$and" *)
module dand #(parameter n=32) ( 
	input [0:0] 	sel_i,
    output [0:0]	out_o,
	output [n-1:0]  ffout_o
);
	
	wire [n-1:0] tout_w;
	
	assign ffout_o = tout_w;
	
	`AND_CELL DAND ( .X(tout_w[0]), .A(1'b1), .B(sel_i));
	
	generate 
		genvar i;
		for(i=1; i<n; i=i+1) begin : dand_genblk
			`AND_CELL DAND ( .X(tout_w[i]), .A(1'b1), .B(tout_w[i-1]));
        end
   	endgenerate

endmodule