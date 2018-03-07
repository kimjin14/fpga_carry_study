module popcount_mimic_circuit (inx, iny, sum);
	input [127:0] inx;
	input [127:0] iny;
	output [7:0] sum;	

  wire [35:0]int_sum;
  wire [17:0]int_sum_2;
 
  wire [5:0] int_s0;
  wire [5:0] int_s1;

  genvar i;
  generate
  for (i=0; i<6; i=i+1) begin: xnorpop20	
	  xnorpop20 xnorpop20 (
      .x(inx[i*20+:20]),
      .y(iny[i*20+:20]), 
      .cout(int_sum[i*5+:5]),
      .s1(int_s1[i]),
      .s0(int_s0[i])
    );
  end
  endgenerate
  xnorpop8_s0s1 xnorpop8 (
    .x(inx[127:120]),
    .y(iny[127:120]),
    .int_s0(int_s0),
    .int_s1(int_s1), 
    .cout(int_sum[35:30]), 
    .s1(sum[1]),
    .s0(sum[0])
  );

  add32 add32 (.x(int_sum), .s2(sum[2]), .cout(int_sum_2));
  addall addall (.x(int_sum_2), .sum(sum[7:3]));

/*  reg [4:0] int_final_sum; 
  integer j;
  always @ (*) begin
    int_final_sum = 0;
    for (j = 0; j < 18; j = j+1) begin
      int_final_sum= int_final_sum + int_sum_2[j];
    end
  end

  assign sum[7:3] = int_final_sum[4:0];
	*/
endmodule

//////////////////////////////////////////////////////////////////////////////////////////
/*
  last bit of adder tree for a LAB

  takes the output from add32 and sums the rest up
*/

module addall_fa(x, sum);
  input [17:0]x;
  output [4:0]sum;

  genvar i;

  // first adder tree 18 -> 9
  wire [8:0]sum_1;
  wire [8:0]cout_1;
  full_adder_1bit f1_0 (
    .a(x[0]), .b(x[9]), .cin(1'b0),
    .s(sum_1[0]), .cout(cout_1[0])
  ); 
  generate
  for (i = 1; i < 9; i=i+1) begin: adder_1
    full_adder_1bit f1 (
      .a(x[i]), .b(x[i+9]), .cin(cout_1[i-1]),
      .s(sum_1[i]), .cout(cout_1[i])
    );
  end
  endgenerate
  assign sum[0] = cout_1[8];

  // second adder tree 9 -> 4
  wire [3:0]sum_2;
  wire [3:0]cout_2;
  full_adder_1bit f2_0 (
    .a(sum_1[0]), .b(sum_1[4]), .cin(sum_1[8]),
    .s(sum_2[0]), .cout(cout_2[0])
  ); 
  generate
  for (i = 1; i < 4; i=i+1) begin: adder_2
    full_adder_1bit f2 (
      .a(sum_1[i]), .b(sum_1[i+4]), .cin(cout_2[i-1]),
      .s(sum_2[i]), .cout(cout_2[i])
    );
  end
  endgenerate
  assign sum[1] = cout_2[3];
  
  // third adder tree 4 -> 2
  wire [1:0]sum_3;
  wire [1:0]cout_3;
  full_adder_1bit f3_0 (
    .a(sum_2[0]), .b(sum_2[2]), .cin(1'b0),
    .s(sum_3[0]), .cout(cout_3[0])
  ); 
  full_adder_1bit f3_1 (
    .a(sum_2[1]), .b(sum_2[3]), .cin(cout_3[0]),
    .s(sum_3[1]), .cout(cout_3[1])
  ); 
  assign sum[2] = cout_3[1];

  // last adder
  wire sum_4;
  wire cout_4;
  full_adder_1bit f4_0 (
    .a(sum_3[0]), .b(sum_3[1]), .cin(1'b0),
    .s(sum_4), .cout(cout_4)
  ); 
  assign sum[3] = cout_4;
  assign sum[4] = sum_4;
  
endmodule

module addall(x, sum);
  input [17:0]x;
  output [4:0]sum;

  wire [8:0]sum_1;
  assign {sum[0], sum_1} = x[8:0] + x[17:9];

  wire [3:0]sum_2; 
  assign {sum[1], sum_2} = sum_1[3:0] + sum_1[7:4] + sum_1[8];

  wire [1:0]sum_3;
  assign {sum[2], sum_3} = sum_2[1:0] + sum_2[3:2];

  assign sum[4:3] = sum_3[0] + sum[1];

  
endmodule

//////////////////////////////////////////////////////////////////////////////////////////

/*
  32-bit pop mimic function for a LAB
  
  s2 is the least significant bit (2nd least after XNOR-pop)
  cout are the same significance to be added up
*/

module add32_fa (x, s2, cout);
  input [35:0] x;
  output s2;
  output [17:0] cout;

  // x adder tree
  wire [17:0]sum_1;
  wire [17:0]cout_1;
	full_adder_1bit f_0 (
    .a(x[0]),
    .b(x[18]),
    .cin(1'b0),
    .s(sum_1[0]),
    .cout(cout_1[0])
  );
  genvar i;
  generate
  for (i = 1; i < 18; i=i+1) begin: adder
	  full_adder_1bit f (
      .a(x[i]),
      .b(x[i+18]),
      .cin(cout_1[i-1]),
      .s(sum_1[i]),
      .cout(cout_1[i])
    );
  end
  endgenerate

  assign s2 = cout_1[17];
  assign cout = sum_1;

endmodule

module add32 (x, s2, cout);
  input [35:0] x;
  output s2;
  output [17:0] cout;

  wire [17:0]sum_1;
  assign {s2, sum_1} = x[17:0] + x[35:18]; 
  assign cout = sum_1;

endmodule

//////////////////////////////////////////////////////////////////////////////////////////
/*
  8 XNOR-pop and extra adders for s0 and s1
*/
module xnorpop8_s0s1_fa (x, y, int_s0, int_s1, s0, s1, cout);
  input [7:0]x;
  input [7:0]y;
  input [5:0]int_s0;
  input [5:0]int_s1;
  output s0, s1;
  output [5:0]cout;

  genvar i;

  // XNOR input
  wire [13:0]xnor_out; // 6 more for int_s0 8 + 6
  assign xnor_out[7:0] = x ~^ y;
  assign xnor_out[13:8] = int_s0;

  // Sum first level
  wire [12:0]sum_1; // 6 more for int_s1 7 + 6
  wire [6:0]cout_1;
  full_adder_1bit f1_0 (
    .a(xnor_out[0]),
    .b(xnor_out[7]),
    .cin(1'b0),
    .s(sum_1[0]),
    .cout(cout_1[0])
  );
  generate
  for (i = 1; i < 7; i=i+1) begin: xnorpop_adder_1
    full_adder_1bit f1 (
      .a(xnor_out[i]),
      .b(xnor_out[i+7]),
      .cin(cout_1[i-1]),
      .s(sum_1[i]),
      .cout(cout_1[i])
    ); 
  end
  endgenerate

  assign s0 = cout_1[6];
  assign sum_1[12:7] = int_s1;

  // Sum second level
  wire [5:0]sum_2;
  wire [5:0]cout_2; 
  full_adder_1bit f2_0 (
    .a(sum_1[0]),
    .b(sum_1[6]),
    .cin(sum_1[12]),
    .s(sum_2[0]),
    .cout(cout_2[0])
  );
  generate
  for (i = 1; i < 6; i=i+1) begin: xnorpop_adder_2
    full_adder_1bit f2 (
      .a(sum_1[i]),
      .b(sum_1[i+6]),
      .cin(cout_2[i-1]),
      .s(sum_2[i]),
      .cout(cout_2[i])
    ); 
  end
  endgenerate
 
  assign s1 = cout_2[5];
  assign cout = sum_2;

endmodule

module xnorpop8_s0s1 (x, y, int_s0, int_s1, s0, s1, cout);
  input [7:0]x;
  input [7:0]y;
  input [5:0]int_s0;
  input [5:0]int_s1;
  output s0, s1;
  output [5:0]cout;

  wire [13:0]xnor_out;
  assign xnor_out[7:0] = x ~^ y;
  assign xnor_out[13:8] = int_s0;

  wire [12:0]sum_1;
  assign {s0, sum_1[6:0]}  = xnor_out[6:0] + xnor_out[13:7];
  assign sum_1[12:7] = int_s1;

  wire [5:0]sum_2;
  assign {s1, sum_2} = sum_1[5:0] + sum_1[11:0] + sum_1[12];
  assign cout = sum_2;


endmodule

//////////////////////////////////////////////////////////////////////////////////////////
/* 
	20 XNOR-pop mimic function for a LAB
  
  s0 is the least significant bit of sum
  s1 is the second least significant bit of sum
  cout are the same significance to be summed up by next module
*/
module xnorpop20_fa (x, y, s0, s1, cout);
	input [19:0]x;
	input [19:0]y;
	output s0, s1;
	output [4:0]cout;

  genvar i;
	
	// Should fit into 5 ALM (half of LAB)
	wire [19:0]xnor_out;
	assign xnor_out = x ~^ y;

  // Sum first level	
	wire [9:0]sum_1;
  wire [9:0]cout_1;
	full_adder_1bit f1_0 (
    .a(xnor_out[0]),
    .b(xnor_out[10]),
    .cin(1'b0),
    .s(sum_1[0]),
    .cout(cout_1[0])
  );
  generate
  for (i = 1; i < 10; i=i+1) begin: xnorpop_adder_1 
	  full_adder_1bit f1 (
      .a(xnor_out[i]),
      .b(xnor_out[i+10]),
      .cin(cout_1[i-1]),
      .s(sum_1[i]),
      .cout(cout_1[i])
    );
  end
  endgenerate

  assign s0 = cout_1[9];

	// Should use the other half of LAB
  // Sum second level
  wire [4:0]sum_2;
	wire [4:0]cout_2;

	full_adder_1bit f2_0 (
    .a(sum_1[0]),
    .b(sum_1[5]),
    .cin(1'b0),
    .s(sum_2[0]),
    .cout(cout_2[0])
  );
  generate 
  for (i = 1; i < 5; i=i+1) begin: xnorpop_adder_2  
	  full_adder_1bit f2 (
      .a(sum_1[i]),
      .b(sum_1[i+5]),
      .cin(cout_2[i-1]),
      .s(sum_2[i]),
      .cout(cout_2[i])
    );
  end
  endgenerate

  assign s1 = cout_2[4];
  assign cout = sum_2;
	
endmodule

//////////////////////////////////////////////////////////////////////////////////////////

module xnorpop20 (x, y, s0, s1, cout);
	input [19:0]x;
	input [19:0]y;
	output s0;
	output s1;
	output [4:0]cout;
	
	wire[19:0]xnor_out;
	wire [9:0]sum_out;
	
	// Should fit into 5 ALM (half of LAB)
	assign xnor_out = x ~^ y;
  assign {s0, sum_out} = xnor_out[9:0] + xnor_out[19:10];

	// Should use the other half of LAB
  assign {s1, cout} = sum_out[4:0] + sum_out[9:5];

endmodule

//////////////////////////////////////////////////////////////////////////////////////////

module full_adder_1bit(
  input a, b, cin,
  output s, cout);

  assign {s, cout} = a + b + cin;
  //assign {cout, s} = a + b + cin;

endmodule

/* 
	20 XNOR-pop mimic function for a LAB
	Instead of s0 and s1 being sums, it will be cout0 and cout1
	Instead of cout, it will be sums
		
*/
module xnorpop20_old (x, y, s0, s1, cout);
	input [19:0]x;
	input [19:0]y;
	output s0;
	output s1;
	output [4:0]cout;
	
	wire[19:0]xnor_out;
	wire [9:0]sum_out;
	
	// Should fit into 5 ALM (half of LAB)
	assign xnor_out = x ~^ y;
  assign {s0, sum_out} = xnor_out[9:0] + xnor_out[19:10];

	// Should use the other half of LAB
  assign {s1, cout} = sum_out[4:0] + sum_out[9:5];
  /*
    Other methods trying to force carry chain
  */  
	//wire [4:0]cs_sin;
	//wire [4:0]cs_cin;
  //assign {cout_temp[0], cout[0]} = sum_out[0] + sum_out[1];
  //assign {cout_temp[1], cout[1]} = sum_out[2] + sum_out[3] + cout_temp[0];
  //assign {cout_temp[2], cout[2]} = sum_out[4] + sum_out[5] + cout_temp[1];
  //assign {cout_temp[3], cout[3]} = sum_out[6] + sum_out[7] + cout_temp[2];
  //assign {s1, cout[4]} = sum_out[8] + sum_out[9] + cout_temp[3];

	//full_adder f0 (.a(sum_out[0]), .b(sum_out[1]), .cin(1'b0), .s(cs_sin[0]), .cout(cs_cin[0]));
	//full_adder f1 (.a(sum_out[2]), .b(sum_out[3]), .cin(cout_temp[0]), .s(cs_sin[1]), .cout(cs_cin[1]));
	//full_adder f2 (.a(sum_out[2]), .b(sum_out[3]), .cin(cout_temp[1]), .s(cs_sin[2]), .cout(cs_cin[2]));
	//full_adder f3 (.a(sum_out[2]), .b(sum_out[3]), .cin(cout_temp[2]), .s(cs_sin[3]), .cout(cs_cin[3]));
	//full_adder f4 (.a(sum_out[2]), .b(sum_out[3]), .cin(cout_temp[3]), .s(cs_sin[4]), .cout(cs_cin[4]));
	
	//assign {cs_cin[0], cs_sin[0]} = sum_out[0] + sum_out[1];
	//assign {cs_cin[1], cs_sin[1]} = sum_out[2] + sum_out[3] + cout_temp[0];
	//assign {cs_cin[2], cs_sin[2]} = sum_out[4] + sum_out[5] + cout_temp[1];
	//assign {cs_cin[3], cs_sin[3]} = sum_out[6] + sum_out[7] + cout_temp[2];
	//assign {cs_cin[4], cs_sin[4]} = sum_out[8] + sum_out[9] + cout_temp[3];

	//carry_sum c0 (.sin(cs_sin[0]), .cin(cs_cin[0]), .sout(cout[0]), .cout(cout_temp[0]));
	//carry_sum c1 (.sin(cs_sin[1]), .cin(cs_cin[1]), .sout(cout[1]), .cout(cout_temp[1]));
	//carry_sum c2 (.sin(cs_sin[2]), .cin(cs_cin[2]), .sout(cout[2]), .cout(cout_temp[2]));
	//carry_sum c3 (.sin(cs_sin[3]), .cin(cs_cin[3]), .sout(cout[3]), .cout(cout_temp[3]));
	//carry_sum c4 (.sin(cs_sin[4]), .cin(cs_cin[4]), .sout(cout[4]), .cout(s1));
	
endmodule


