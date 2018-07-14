module mimic_circuit_adder_testing(inx, iny, sum);
  input [127:0]inx;
  input [127:0]iny;
  output [7:0]sum;

  wire [35:0]int_sum;
	wire [8:0]int_sum_2;
	
	wire [4:0]int_s1;
	wire [4:0]int_s0;

  genvar i;
  generate
  for (i=0; i<5; i=i+1) begin: xnorpop24
    xnorpop24_fatree xnorpop20 (
      .x(inx[i*24+:24]),
      .y(iny[i*24+:24]),
      .s0({int_s1[i], int_s0[i]}),
      .cout(int_sum[i*6+:6])
    );
  end
  endgenerate
  
  xnorpop8_fatree xnorpop8 (.x(inx[127:120]), .y(iny[127:120]), .int_s0(int_s0), .int_s1(int_s1), .s0(sum[0]), .s1(sum[1]), .cout(int_sum[35:30]));  
	add36_fatree add36 (.int_sum(int_sum), .s3(sum[3]), .s2(sum[2]), .cout(int_sum_2));
	addall_fatree addall (.int_sum(int_sum_2), .s7(sum[7]), .s6(sum[6]), .s5(sum[5]), .s4(sum[4]));
endmodule

module mimic_circuit_adder(inx, iny, sum);
  input [127:0]inx;
  input [127:0]iny;
  output [7:0]sum;

  wire [35:0]int_sum;
	wire [8:0]int_sum_2;
	
	wire [4:0]int_s1;
	wire [4:0]int_s0;

  genvar i;
  generate
  for (i=0; i<5; i=i+1) begin: xnorpop24
    xnorpop24 xnorpop20 (
      .x(inx[i*24+:24]),
      .y(iny[i*24+:24]),
      .s0({int_s1[i], int_s0[i]}),
      .cout(int_sum[i*6+:6])
    );
  end
  endgenerate
  
  xnorpop8 xnorpop8 (.x(inx[127:120]), .y(iny[127:120]), .int_s0(int_s0), .int_s1(int_s1), .s0(sum[0]), .s1(sum[1]), .cout(int_sum[35:30]));  
	add36 add36 (.int_sum(int_sum), .s3(sum[3]), .s2(sum[2]), .cout(int_sum_2));
	addall addall (.int_sum(int_sum_2), .s7(sum[7]), .s6(sum[6]), .s5(sum[5]), .s4(sum[4]));
endmodule

/*///////////////////////////////////////////////////////////////////////////
  36 bit adder
*////////////////////////////////////////////////////////////////////////////
module add36_fatree(int_sum, s3, s2, cout);

	input [35:0]int_sum;
	output s3, s2;
	output [8:0]cout;

	wire [8:0]int_co0;
	wire [8:0]int_co1;
	
	fatree_2bit fatree0_0 (.x1(int_sum[0]), .x2(int_sum[1]), .y1(int_sum[18]), .y2(int_sum[19]),
			.t(1'b1), .s0(cout[0]), .ci0(1'b0), .ci1(1'b0), .co0(int_co0[0]), .co1(int_co1[0]));
			
	fatree_2bit fatree0_1 (.x1(int_sum[2]), .x2(int_sum[3]), .y1(int_sum[20]), .y2(int_sum[21]),
			.t(1'b1), .s0(cout[1]), .ci0(int_co0[0]), .ci1(int_co1[0]), .co0(int_co0[1]), .co1(int_co1[1]));
			
	fatree_2bit fatree0_2 (.x1(int_sum[4]), .x2(int_sum[5]), .y1(int_sum[22]), .y2(int_sum[23]),
			.t(1'b1), .s0(cout[2]), .ci0(int_co0[1]), .ci1(int_co1[1]), .co0(int_co0[2]), .co1(int_co1[2]));	
			
	fatree_2bit fatree0_3 (.x1(int_sum[6]), .x2(int_sum[7]), .y1(int_sum[24]), .y2(int_sum[25]),
			.t(1'b1), .s0(cout[3]), .ci0(int_co0[2]), .ci1(int_co1[2]), .co0(int_co0[3]), .co1(int_co1[3]));
			
	fatree_2bit fatree0_4 (.x1(int_sum[8]), .x2(int_sum[9]), .y1(int_sum[26]), .y2(int_sum[27]),
			.t(1'b1), .s0(cout[4]), .ci0(int_co0[3]), .ci1(int_co1[3]), .co0(int_co0[4]), .co1(int_co1[4]));
			
	fatree_2bit fatree0_5 (.x1(int_sum[10]), .x2(int_sum[11]), .y1(int_sum[28]), .y2(int_sum[29]),
			.t(1'b1), .s0(cout[5]), .ci0(int_co0[4]), .ci1(int_co1[4]), .co0(int_co0[5]), .co1(int_co1[5]));	
			
	fatree_2bit fatree0_6 (.x1(int_sum[12]), .x2(int_sum[13]), .y1(int_sum[30]), .y2(int_sum[31]),
			.t(1'b1), .s0(cout[6]), .ci0(int_co0[5]), .ci1(int_co1[5]), .co0(int_co0[6]), .co1(int_co1[6]));	
			
	fatree_2bit fatree0_7 (.x1(int_sum[14]), .x2(int_sum[15]), .y1(int_sum[32]), .y2(int_sum[33]),
			.t(1'b1), .s0(cout[7]), .ci0(int_co0[6]), .ci1(int_co1[6]), .co0(int_co0[7]), .co1(int_co1[7]));
			
	fatree_2bit fatree0_8 (.x1(int_sum[16]), .x2(int_sum[17]), .y1(int_sum[34]), .y2(int_sum[35]),
			.t(1'b1), .s0(cout[8]), .ci0(int_co0[7]), .ci1(int_co1[7]), .co0(int_co0[8]), .co1(int_co1[8]));

	assign s2 = int_co0[8];
	assign s3 = int_co1[8];
			
endmodule

module add36 (int_sum, s3, s2, cout);

	input [35:0]int_sum;
	output s3, s2;
	output [8:0]cout;

  wire [17:0]int_sum_0; 

  assign {s2, int_sum_0} = int_sum[17:0] + int_sum[35:18];
  
  assign s3 = s2;
  assign cout = {int_sum_0[16], int_sum_0[14], int_sum_0[12], int_sum_0[10], int_sum_0[8], int_sum_0[6], int_sum_0[4], int_sum_0[2], int_sum_0[0]};  

endmodule

module addall_fatree(int_sum, s7, s6, s5, s4);

	input [8:0]int_sum;
	output s7, s6, s5, s4;

	wire [1:0]int_co0;
	wire [1:0]int_co1;
	wire [1:0]int_cout;
	
	fatree_2bit fatree0_0 (.x1(int_sum[0]), .x2(int_sum[1]), .y1(int_sum[4]), .y2(int_sum[5]),
			.t(1'b1), .s0(int_cout[0]), .ci0(int_sum[8]), .ci1(1'b0), .co0(int_co0[0]), .co1(int_co1[0]));
			
	fatree_2bit fatree0_1 (.x1(int_sum[2]), .x2(int_sum[3]), .y1(int_sum[6]), .y2(int_sum[7]),
			.t(1'b1), .s0(int_cout[1]), .ci0(int_co0[0]), .ci1(int_co1[0]), .co0(s4), .co1(s5));
			
	fatree_2bit fatree1_0 (.x1(int_cout[0]), .x2(1'b0), .y1(int_cout[1]), .y2(1'b0),
			.t(1'b0), .s0(s7), .ci0(1'b0), .co0(s6));	
			
endmodule

module addall(int_sum, s7, s6, s5, s4);

	input [8:0]int_sum;
	output s7, s6, s5, s4;

  wire [3:0]int_sum_0;
  assign {s4, int_sum_0} = int_sum[3:0] + int_sum[7:4] + int_sum[8];
  assign s5 = s4;

  wire [1:0]int_sum_1;
  assign int_sum_1 = {int_sum_0[2], int_sum_0[0]};

  wire [1:0]int_sum_2;
  assign {s6 ,int_sum_2} = int_sum_1[0] + int_sum_1[1];

  assign s7 = int_sum_2[0];

endmodule

/*///////////////////////////////////////////////////////////////////////////
  8 XNOR-pop mimic function for a LAB
*////////////////////////////////////////////////////////////////////////////
module xnorpop8_fatree(x, y, int_s1, int_s0, s1, s0, cout);
	input [7:0]x;
	input [7:0]y;
	input [4:0]int_s0;
	input [4:0]int_s1;
	output s1;
	output s0;
	output [5:0]cout;

	wire [7:0]xnor_out;
	wire [12:0]sum_in_0;
	wire [2:0]sum_out_0;
	
	// XNOR and first two levels of adder
	assign xnor_out = x ~^ y;
	assign sum_in_0 = {int_s0, xnor_out[7:0]};
	
	// Calculation of final s0
	wire [2:0]int_co0_0;
  wire [2:0]int_co1_0; 
	
	fatree_2bit fatree0_0 (.x1(sum_in_0[0]), .x2(sum_in_0[1]), .y1(sum_in_0[6]), .y2(sum_in_0[7]),
			.t(1'b1), .s0(sum_out_0[0]), .ci0(sum_in_0[12]), .ci1(1'b0), .co0(int_co0_0[0]), .co1(int_co1_0[0]));
  
	fatree_2bit fatree0_1 (.x1(sum_in_0[2]), .x2(sum_in_0[3]), .y1(sum_in_0[8]), .y2(sum_in_0[9]),
			.t(1'b1), .s0(sum_out_0[1]), .ci0(int_co0_0[0]), .ci1(int_co1_0[0]), .co0(int_co0_0[1]), .co1(int_co1_0[1]));
			
	fatree_2bit fatree0_2 (.x1(sum_in_0[4]), .x2(sum_in_0[5]), .y1(sum_in_0[10]), .y2(sum_in_0[11]),
			.t(1'b1), .s0(sum_out_0[2]), .ci0(int_co0_0[1]), .ci1(int_co1_0[1]), .co0(int_co0_0[2]), .co1(int_co1_0[2]));
	
	assign s0 = int_co0_0[2];
	
	// Calculation of final s1
	wire [5:0]sum_in_s1;
	wire [2:0]sum_out_s1;
	wire [1:0]int_co0_s1;
	wire [1:0]int_co1_s1;

	assign sum_in_s1 = {int_s1, int_co1_0[2]};
		
	fatree_2bit fatree1_0 (.x1(sum_in_s1[0]), .x2(sum_in_s1[1]), .y1(sum_in_s1[3]), .y2(sum_in_s1[4]),
			.t(1'b0), .s0(sum_out_s1[0]), .s1(sum_out_s1[1]), .ci0(1'b0), .co0(int_co0_s1[0]));
			
	fatree_2bit fatree1_1 (.x1(sum_in_s1[2]), .x2(1'b0), .y1(sum_in_s1[5]), .y2(1'b0),
			.t(1'b0), .s0(sum_out_s1[2]), .ci0(int_co0_s1[0]), .co0(int_co0_s1[1]));
			
	assign s1 = int_co0_s1[1];		
			
	assign cout = {sum_out_s1, sum_out_0};
			
endmodule

module xnorpop8(x, y, int_s1, int_s0, s1, s0, cout);
	input [7:0]x;
	input [7:0]y;
	input [4:0]int_s0;
	input [4:0]int_s1;
	output s1;
	output s0;
	output [5:0]cout;

	wire [7:0]xnor_out;
	wire [12:0]sum_in_0;
	wire [5:0]sum_out_0;
	
	// XNOR and first two levels of adder
	assign xnor_out = x ~^ y;
	assign sum_in_0 = {int_s0, xnor_out[7:0]};
	
	// Calculation of final s0
	assign {s0, sum_out_0[5:0]} = sum_in_0[11:6] + sum_in_0[5:0] + sum_in_0[12];

	// Calculation of final s1
  wire [5:0]sum_in_s1;
  wire [3:0]sum_out_s1;

  assign sum_in_s1 = {int_s1, s0};
	assign {s1, sum_out_s1} = {1'b0,sum_in_s1[2:0]} + {1'b0,sum_in_s1[5:3]};

  assign cout = {sum_out_s1[2:0], sum_out_0[4], sum_out_0[2],sum_out_0[0]};
	
endmodule


/*///////////////////////////////////////////////////////////////////////////
  24 XNOR-pop mimic function for a LAB
*////////////////////////////////////////////////////////////////////////////
module xnorpop24_fatree(x, y, s0, cout);
  input [23:0]x;
  input [23:0]y;
  output [1:0]s0;
  output [5:0]cout;

  wire [23:0]xnor_out;
  wire [5:0]sum_out;

  // XNOR and first adder tree level
  // Should fit into 5 ALMs
  assign xnor_out = x ~^ y;
 
  wire [5:0]int_co0;
  wire [5:0]int_co1; 
	
  fatree_2bit fatree0_0 (.x1(xnor_out[0]), .x2(xnor_out[1]), .y1(xnor_out[12]), .y2(xnor_out[13]),
       .t(1'b1), .s0(sum_out[0]), .ci0(1'b0), .ci1(1'b0), .co0(int_co0[0]), .co1(int_co1[0]));
  
	fatree_2bit fatree0_1 (.x1(xnor_out[2]), .x2(xnor_out[3]), .y1(xnor_out[14]), .y2(xnor_out[15]),
       .t(1'b1), .s0(sum_out[1]), .ci0(int_co0[0]), .ci1(int_co1[0]), .co0(int_co0[1]), .co1(int_co1[1]));
  
	fatree_2bit fatree0_2 (.x1(xnor_out[4]), .x2(xnor_out[5]), .y1(xnor_out[16]), .y2(xnor_out[17]),
       .t(1'b1), .s0(sum_out[2]), .ci0(int_co0[1]), .ci1(int_co1[1]), .co0(int_co0[2]), .co1(int_co1[2]));
  
	fatree_2bit fatree0_3 (.x1(xnor_out[6]), .x2(xnor_out[7]), .y1(xnor_out[18]), .y2(xnor_out[19]),
       .t(1'b1), .s0(sum_out[3]), .ci0(int_co0[2]), .ci1(int_co1[2]), .co0(int_co0[3]), .co1(int_co1[3]));
  
	fatree_2bit fatree0_4 (.x1(xnor_out[8]), .x2(xnor_out[9]), .y1(xnor_out[20]), .y2(xnor_out[21]),
       .t(1'b1), .s0(sum_out[4]), .ci0(int_co0[3]), .ci1(int_co1[3]), .co0(int_co0[4]), .co1(int_co1[4]));
  
	fatree_2bit fatree0_5 (.x1(xnor_out[10]), .x2(xnor_out[11]), .y1(xnor_out[22]), .y2(xnor_out[23]),
       .t(1'b1), .s0(sum_out[5]), .ci0(int_co0[4]), .ci1(int_co1[4]), .co0(int_co0[5]), .co1(int_co1[5]));	
	
	
	assign s0 = {int_co1[5], int_co0[5]};
	assign cout = sum_out;
  

endmodule

module xnorpop24(x, y, s0, cout);
  input [23:0]x;
  input [23:0]y;
  output [1:0]s0;
  output [5:0]cout;

  wire [23:0]xnor_out;
  wire [11:0]sum_out;

  wire [2:0]sum_out_2; 

  // XNOR and first adder tree level
  // Should fit into 5 ALMs
  assign xnor_out = x ~^ y;
 
  assign {s0[0], sum_out} = xnor_out[23:12] + xnor_out[11:0]; 
	assign s0[1] = s0[0];
  assign cout = {sum_out[10], sum_out[8], sum_out[6], sum_out[4], sum_out[2], sum_out[0]};

endmodule



/*///////////////////////////////////////////////////////////////////////////
  Support modules
*////////////////////////////////////////////////////////////////////////////

module fatree_2bit_mock (x1, x2, y1, y2, ci0, ci1, s0, s1, t, co0, co1);
  input x1, x2, y1, y2, ci0, ci1, t;
  output s0, s1, co0, co1;

  wire [2:0]int_s;
  wire int_c;

	// First level adder
  fa_mock fa_m0 (.x(x1), .y(y1), .ci(ci0), .s(int_s[0]), .co(int_c));
  fa_mock fa_m1 (.x(x2), .y(y2), .ci(int_c), .s(int_s[1]), .co(co0));
	
	// Second level adder
  //fa fa2 (.x(int_s[0]), .y(int_s[1]), .ci(ci1), .s(int_s[2]), .co(co1));

  assign co1 = co0; // FAKING extra output

	assign s0 = int_s[0];
	assign s1 = int_s[1];
	
endmodule

// When we do flip the full adder, co0 and co1 become the sum out
module fatree_2bit (x1, x2, y1, y2, ci0, ci1, s0, s1, t, co0, co1);
  input x1, x2, y1, y2, ci0, ci1, t;
  output s0, s1, co0, co1;

  wire [2:0]int_s;
  wire int_c;

	// First level adder
  fa fa0 (.x(x1), .y(y1), .ci(ci0), .s(int_s[0]), .co(int_c));
  fa fa1 (.x(x2), .y(y2), .ci(int_c), .s(int_s[1]), .co(co0));
	
	// Second level adder
  fa fa2 (.x(int_s[0]), .y(int_s[1]), .ci(ci1), .s(int_s[2]), .co(co1));

	assign s0 = t ? int_s[2] : int_s[0];
	assign s1 = int_s[1];
	
endmodule

module fa (x, y, ci, s, co);
  input x, y, ci;
  output s, co;

  //assign {co,s} = x + y + ci;
  assign {s,co} = x + y + ci;

endmodule

module fa_mock (x, y, ci, s, co);
  input x, y, ci;
  output s, co;

  assign {co,s} = x + y + ci;

endmodule

