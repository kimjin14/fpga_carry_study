
module xnor_popcount_arch1_1200 (clk, xi, wi, yi);
	input clk;
  input [1199:0]xi; 
  input [1199:0]wi; 
  output reg [10:0]yi; 
		
	wire [77:0] cout;

	genvar g;
	generate
		for (g=0; g<9; g=g+1) begin: xnor_pop_128
			xnor_popcount_arch1_128 xnor_popcount (.clk(clk), .xi(xi[g*128+:128]), .wi(wi[g*128+:128]), .yi(cout[g*8+:8])); 
		end
	endgenerate

  wire [47:0] xnor_out;

  assign xnor_out = xi[1199:1152] ~^ wi[1199:1152];
    	
	wire [23:0] sum_1;
  wire [11:0] sum_2;
  wire [5:0] sum_3;
  wire [2:0] sum_4;
	
  assign {cout[72], sum_1} = xnor_out[0+:24] + xnor_out[24+:24] ;
  assign {cout[73], sum_2} = sum_1[0+:12] + sum_1[12+:12];
  assign {cout[74], sum_3} = sum_2[0+:6] + sum_2[6+:6];
  assign {cout[75], sum_4} = sum_3[0+:3] + sum_3[3+:3];
  assign {cout[77], cout[76]} = sum_4[0] + sum_4[1] + sum_4[2];
	
	
	
	//always @ (posedge clk) begin
	always @ (*) begin
		yi = cout[0+:8]+cout[8+:8]+cout[16+:8]+cout[24+:8]+cout[32+:8]+cout[40+:8]+cout[48+:8]+cout[56+:8]+cout[64+:8]+cout[72+:6];
	end
	
endmodule


module xnor_popcount_arch1_1152 (clk, xi, wi, yi);
	input clk;
  input [1151:0]xi; 
  input [1151:0]wi; 
  output reg [10:0]yi; 
		
	wire [71:0] cout;
	
	genvar g;
	generate
		for (g=0; g<9; g=g+1) begin: xnor_pop_128
			xnor_popcount_arch1_128 xnor_popcount (.clk(clk), .xi(xi[g*128+:128]), .wi(wi[g*128+:128]), .yi(cout[g*8+:8])); 
		end
	endgenerate
	
	//always @ (posedge clk) begin
	always @ (*) begin
		yi = cout[0+:8]+cout[8+:8]+cout[16+:8]+cout[24+:8]+cout[32+:8]+cout[40+:8]+cout[48+:8]+cout[56+:8]+cout[64+:8];
	end
	
endmodule


module xnor_popcount_arch1_1024 (clk, xi, wi, yi);
	input clk;
  input [1023:0]xi; 
  input [1023:0]wi; 
  output reg [10:0]yi; 
		
	wire [63:0] cout;
	
	genvar g;
	generate
		for (g=0; g<8; g=g+1) begin: xnor_pop_128
			xnor_popcount_arch1_128 xnor_popcount (.clk(clk), .xi(xi[g*128+:128]), .wi(wi[g*128+:128]), .yi(cout[g*8+:8])); 
		end
	endgenerate
	
	always @ (*) begin
		yi = cout[0+:8]+cout[8+:8]+cout[16+:8]+cout[24+:8]+cout[32+:8]+cout[40+:8]+cout[48+:8]+cout[56+:8];
	end
	
endmodule

module xnor_popcount_arch1_128_test (clk, xi, wi, yi);
	input [127:0] xi;
	input [127:0] wi;
	input clk;
	output[7:0] yi;	

  wire [35:0]int_sum;
  wire [17:0]int_sum_2;
 
  wire [5:0] int_s0;
  wire [5:0] int_s1;
	
	
  genvar i;
  generate
  for (i=0; i<6; i=i+1) begin: xnorpop20	
	  xnorpop20 xnorpop20 (
      .x(xi[i*20+:20]),
      .y(wi[i*20+:20]), 
      .cout(int_sum[i*5+:5]),
      .s1(int_s1[i]),
      .s0(int_s0[i])
    );
  end
  endgenerate
  xnorpop8_s0s1 xnorpop8 (
    .x(xi[127:120]),
    .y(wi[127:120]),
    .int_s0(int_s0),
    .int_s1(int_s1), 
    .cout(int_sum[35:30]), 
    .s1(yi[1]),
    .s0(yi[0])
  );

  add36 add36 (.x(int_sum), .sum(yi[2]), .cout(int_sum_2));
  addall addall (.x(int_sum_2), .sum(yi[7:3]));

endmodule

module xnor_popcount_arch1_128_test4 (clk, xi, wi, yi);
	input [127:0] xi;
	input [127:0] wi;
	input clk;
	output[7:0] yi;	

  wire [66:0]int_cout; // first level output
  wire [34:0]int_cout2;
  wire [16:0]int_cout3;
  wire [5:0] int_s0;
  wire [2:0] int_s1;
	
  genvar i;
  generate
  for (i=0; i<6; i=i+1) begin: xnorpop20	
	  xnorpop20_test xnorpop20 (
        .x(xi[i*20+:20]), .y(wi[i*20+:20]), 
        .cout(int_cout[i*10+:10]), .s0(int_s0[i]));
  end
  endgenerate
  xnorpop8_s0_test xnorpop8 (
      .x(xi[127:120]), .y(wi[127:120]), .int_s0(int_s0),
      .cout(int_cout[66:60]), .s0(yi[0]));


  add20_test add20_0 (.x(int_cout[ 0+:20]), .s(int_s1[0]), .cout(int_cout2[ 0+:10]));
  add20_test add20_1 (.x(int_cout[20+:20]), .s(int_s1[1]), .cout(int_cout2[10+:10]));
  add20_test add20_2 (.x(int_cout[40+:20]), .s(int_s1[2]), .cout(int_cout2[20+:10]));
  add7_test add7   (.x(int_cout[60+: 7]), .int_s1(int_s1), .s(yi[1]), .cout(int_cout2[30+:5]));

  add35_test add35 (.x(int_cout2), .s(yi[2]), .cout(int_cout3));
  addall addall (.x(int_cout3), .sum(yi[7:3]));
endmodule

module add35_test (x, s, cout);
  input [34:0] x;
  output s;
  output [16:0] cout;

  assign {s, cout} = x[16:0] + x[33:17] + x[34]; 
endmodule

module add7_test (x, int_s1, s, cout);
  input [6:0]x;
  input [2:0]int_s1;
  output s;
  output [4:0]cout;

  wire [9:0]int_x;
  assign int_x = {x,int_s1};

  assign {s, cout} = int_x[4:0] + int_x[9:5]; 

endmodule

module xnor_popcount_arch1_128_test3 (clk, xi, wi, yi);
	input [127:0] xi;
	input [127:0] wi;
	input clk;
	output[7:0] yi;	

  wire [66:0]int_cout; // first level output
  wire [32:0]int_cout_2;
  wire [15:0]int_cout_3;
  wire [5:0] int_s0;
	
	
  genvar i;
  generate
  for (i=0; i<6; i=i+1) begin: xnorpop20	
	  xnorpop20_test xnorpop20 (
        .x(xi[i*20+:20]), .y(wi[i*20+:20]), 
        .cout(int_cout[i*10+:10]), .s0(int_s0[i]));
  end
  endgenerate
  xnorpop8_s0_test xnorpop8 (
      .x(xi[127:120]), .y(wi[127:120]), .int_s0(int_s0),
      .cout(int_cout[66:60]), .s0(yi[0]));


  add67_arch1_test add67 (.x(int_cout), .s(yi[1]), .cout(int_cout_2));
  add33_arch1_test add33 (.x(int_cout_2), .s(yi[2]), .cout(int_cout_3));
  addall addall (.x(int_cout_3), .sum(yi[7:3]));

endmodule

module add33_arch1_test (x, s, cout);
  input [32:0] x;
  output s;
  output [15:0] cout;

  assign {s, cout} = x[15:0] + x[31:16] + x[32]; 

endmodule

module add67_arch1_test (x, s, cout);
  input [66:0]x;
  output s;
  output [32:0]cout;

  assign {s, cout} = x[32:0] + x[65:33] + x[66];
endmodule

module s0add_arch1_test (x, s, cout);
  input [6:0]x;
  output s;
  output [2:0]cout;
  
  assign {s, cout} = x[2:0] + x[5:3] + x[6];
endmodule

module xnorpop8_test (x, y, s0, cout);
  input [7:0]x;
  input [7:0]y;
  output s0;
  output [3:0]cout;

  wire [7:0]xnor_out;
	
  assign xnor_out = x ~^ y;
  assign {s0, cout}  = xnor_out[3:0] + xnor_out[7:4];
endmodule

module xnorpop8_s0_test (x, y, int_s0, s0, cout);
  input [7:0]x;
  input [7:0]y;
  input [5:0]int_s0;
  output s0;
  output [6:0]cout;

  wire [7:0]xnor_out;
	
  assign xnor_out = x ~^ y;

  wire [13:0]int_add;

  assign int_add = {xnor_out,int_s0};

  assign {s0, cout}  = int_add[6:0] + int_add[13:7];
endmodule

module xnorpop20_test (x, y, s0, cout);
  input [19:0]x;
  input [19:0]y;
  output s0;
  output [9:0]cout;

  wire [19:0]xnor_out;
	
  // XNOR and first adder tree
  assign xnor_out = x ~^ y;
  assign {s0, cout} = xnor_out[9:0] + xnor_out[19:10]; 

endmodule

module add20_test (x, s, cout);
  input [19:0]x;
  output s;
  output [9:0]cout;

  assign {s, cout} = x[9:0] + x[19:10]; 

endmodule




module xnor_popcount_arch1_128_test2 (clk, xi, wi, yi);
	input [127:0] xi;
	input [127:0] wi;
	input clk;
	output[7:0] yi;	

  wire [35:0]int_sum;
  wire [17:0]int_sum_2;

  wire [5:0] int_s0;
  wire [5:0] int_s1;
	
	
  genvar i;
  generate
  for (i=0; i<5; i=i+1) begin: xnorpop24	
	  xnorpop24_arch1 xnorpop24 (
      .x(xi[i*24+:24]),
      .y(wi[i*24+:24]), 
      .cout(int_sum[i*6+:6]),
      .s0(int_s0[i]),
      .s1(int_s1[i])
    );
  end
  endgenerate
  xnorpop8_arch1 xnorpop8 (
    .x(xi[127:120]),
    .y(wi[127:120]),
    .cout(int_sum[31:30]), 
    .s1(int_s1[5]),
    .s0(int_s0[5])
  );

	s0s1_arch1 s0s1(
	  .int_s0(int_s0),
    .int_s1(int_s1),
		.s1(yi[1]),
		.s0(yi[0]),
		.cout(int_sum[35:32])
	);
	
  add36_arch1 add36 (.x(int_sum), .s2(yi[2]), .cout(int_sum_2));
  addall_arch1 addall (.x(int_sum_2), .sum(yi[7:3]));
endmodule

module addall_arch1(x, sum);
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


module add36_arch1 (x, s2, cout);
  input [35:0] x;
  output s2;
  output [17:0] cout;

  assign {s2, cout} = x[17:0] + x[35:18]; 

endmodule

module s0s1_arch1 (int_s0, int_s1, s0, s1, cout);
  input [5:0]int_s0;
  input [5:0]int_s1;
  output s0, s1;
  output [3:0]cout;

	wire [8:0]sum_0; // 3 + 6
	
  assign {s0, sum_0[2:0]}  = int_s0[2:0] + int_s0[5:3];
	assign sum_0[8:3] = int_s1;
	
	assign {s1, cout} = sum_0[3:0] + sum_0[7:4] + sum_0[8];
	
endmodule

module xnorpop8_arch1 (x, y, s0, s1, cout);
  input [7:0]x;
  input [7:0]y;
  output s0, s1;
  output [1:0]cout;

  wire [7:0]xnor_out;
	wire [3:0]sum_0;
	
  assign xnor_out[7:0] = x ~^ y;

  assign {s0, sum_0}  = xnor_out[3:0] + xnor_out[7:4];
	
	//assign {s1, cout} = sum_0[1:0] + sum_0[3:2];
	add2_arch1 add2 (.x(sum_0[1:0]), .y(sum_0[3:2]), .s(s1), .cout(cout));
endmodule

module add2_arch1 (x, y, s, cout);
	input [1:0]x;
	input [1:0]y;
	output s;
	output [1:0]cout;

	assign {s, cout} = x[1:0] + y[1:0];
	
endmodule

module xnorpop24_arch1(x, y, s1, s0, cout);
  input [23:0]x;
  input [23:0]y;
  output s0, s1;
  output [5:0]cout;

  wire [23:0]xnor_out;
	wire [11:0]sum_0;
	
  // XNOR and first adder tree
  assign xnor_out = x ~^ y;
  assign {s0, sum_0} = xnor_out[12+:12] + xnor_out[0+:12]; 
	
  // second adder tree
	assign {s1, cout} = sum_0[6+:6] + sum_0[0+:6]; 

endmodule


module xnor_popcount_arch1_256 (clk, xi, wi, yi);
	input clk;
  input [255:0]xi; 
  input [255:0]wi; 
  output [8:0]yi; 
  
  wire [255:0] xnor_out;

  assign xnor_out = xi ~^ wi;
    
  wire  [63:0] sum0_1;
  wire  [31:0] sum0_2;
  wire  [15:0] sum0_3;
  wire  [7:0] sum0_4;
  wire  [3:0] sum0_5;
  wire  [1:0] sum0_6;
	wire  [7:0] cout0;
	
	wire  [63:0] sum1_1;
  wire  [31:0] sum1_2;
  wire  [15:0] sum1_3;
  wire  [7:0] sum1_4;
  wire  [3:0] sum1_5;
  wire  [1:0] sum1_6;
	wire  [7:0] cout1;
	
  //always @(posedge clk) begin
  assign   {cout0[0], sum0_1}   = xnor_out[0+:64] + xnor_out[192+:64] ;
  assign   {cout0[1], sum0_2}   = sum0_1[0+:32] + sum0_1[32+:32];
  assign   {cout0[2], sum0_3}   = sum0_2[0+:16] + sum0_2[16+:16];
  assign   {cout0[3], sum0_4}   = sum0_3[0+:8] + sum0_3[8+:8];
  assign   {cout0[4], sum0_5}   = sum0_4[0+:4] + sum0_4[4+:4];
  assign   {cout0[5], sum0_6}   = sum0_5[0+:2] + sum0_5[2+:2];
  assign   {cout0[7], cout0[6]} = sum0_6[0] + sum0_6[1];

	assign   {cout1[0], sum1_1}   = xnor_out[128+:64] + xnor_out[64+:64] ;
  assign   {cout1[1], sum1_2}   = sum1_1[0+:32] + sum1_1[32+:32];
  assign   {cout1[2], sum1_3}   = sum1_2[0+:16] + sum1_2[16+:16];
  assign   {cout1[3], sum1_4}   = sum1_3[0+:8] + sum1_3[8+:8];
  assign   {cout1[4], sum1_5}   = sum1_4[0+:4] + sum1_4[4+:4];
  assign   {cout1[5], sum1_6}   = sum1_5[0+:2] + sum1_5[2+:2];
  assign   {cout1[7], cout1[6]} = sum1_6[0] + sum1_6[1];
  //end
	
	assign	yi = cout0 + cout1;
	
endmodule


module xnor_popcount_arch1_128 (clk, xi, wi, yi);
	input clk;
  input [127:0]xi; 
  input [127:0]wi; 
  output [7:0]yi; 
  
  wire [127:0] xnor_out;

  assign xnor_out = xi ~^ wi;
    
  wire [63:0] sum_1;
  wire [31:0] sum_2;
  wire [15:0] sum_3;
  wire [7:0] sum_4;
  wire [3:0] sum_5;
  wire [1:0] sum_6;
	wire [7:0] cout;

  assign {cout[0], sum_1} = xnor_out[0+:64] + xnor_out[64+:64] ;
  assign {cout[1], sum_2} = sum_1[0+:32] + sum_1[32+:32];
  assign {cout[2], sum_3} = sum_2[0+:16] + sum_2[16+:16];
  assign {cout[3], sum_4} = sum_3[0+:8] + sum_3[8+:8];
  assign {cout[4], sum_5} = sum_4[0+:4] + sum_4[4+:4];
	assign {cout[5], sum_6} = sum_5[0+:2] + sum_5[2+:2];

  //addN_flat #(64) (xnor_out[0+:64], xnor_out[64+:64], cout[0], sum_1);
  //addN_flat #(32) (sum_1[0+:32], sum_1[32+:32], cout[1], sum_2);
  //addN_flat #(16) (sum_2[0+:16], sum_2[16+:16], cout[2], sum_3);
  //addN_flat #( 8) (sum_3[0+: 8], sum_3[ 8+: 8], cout[3], sum_4);
  //addN_flat #( 4) (sum_4[0+: 4], sum_4[ 4+: 4], cout[4], sum_5);
  //addN_flat #( 2) (sum_5[0+: 2], sum_5[ 2+: 2], cout[5], sum_6);
	
  assign {cout[7], cout[6]} = sum_6[0] + sum_6[1];

	assign yi = cout;
	
endmodule

module addN_flat (x, y, s, cout);
  parameter N = 64;
  input [N-1:0]x;
  input [N-1:0]y;
  output s;
  output [N-1:0]cout;

  assign {s,cout} = x + y;
endmodule


module xnor_popcount_arch1_64 (clk, xi, wi, yi);
	input clk;
  input [63:0]xi; 
  input [63:0]wi; 
  output [6:0]yi; 
  
  wire [63:0] xnor_out;

  assign xnor_out = xi ~^ wi;
    
  wire [31:0] sum_2;
  wire [15:0] sum_3;
  wire [7:0] sum_4;
  wire [3:0] sum_5;
  wire [1:0] sum_6;
	wire [7:0] cout;

  assign {cout[0], sum_2} = xnor_out[0+:32] + xnor_out[32+:32];
  assign {cout[1], sum_3} = sum_2[0+:16] + sum_2[16+:16];
  assign {cout[2], sum_4} = sum_3[0+:8] + sum_3[8+:8];
  assign {cout[3], sum_5} = sum_4[0+:4] + sum_4[4+:4];
  assign {cout[4], sum_6} = sum_5[0+:2] + sum_5[2+:2];
  assign {cout[6], cout[5]} = sum_6[0] + sum_6[1];

  assign	yi = cout;
	
endmodule


module xnor_popcount_arch1_32 (clk, xi, wi, yi);
	input clk;
  input [31:0]xi; 
  input [31:0]wi; 
  output [5:0]yi; 
  
  wire [31:0] xnor_out;

  assign xnor_out = xi ~^ wi;
    
  wire [15:0] sum_3;
  wire [7:0] sum_4;
  wire [3:0] sum_5;
  wire [1:0] sum_6;
	wire [7:0] cout;

  assign {cout[0], sum_3} = xnor_out[0+:16] + xnor_out[16+:16];
  assign {cout[1], sum_4} = sum_3[0+:8] + sum_3[8+:8];
  assign {cout[2], sum_5} = sum_4[0+:4] + sum_4[4+:4];
  assign {cout[3], sum_6} = sum_5[0+:2] + sum_5[2+:2];
  assign {cout[5], cout[4]} = sum_6[0] + sum_6[1];

	assign yi = cout;
	
endmodule

module xnor_popcount_arch1_256_reg (clk, xi, wi, yi);
	input clk;
  input [255:0]xi; 
  input [255:0]wi; 
  output [8:0]yi; 
  
  wire [255:0] xnor_out;

  assign xnor_out = xi ~^ wi;
    
  reg  [63:0] sum0_1;
  reg  [31:0] sum0_2;
  reg  [15:0] sum0_3;
  reg  [7:0] sum0_4;
  reg  [3:0] sum0_5;
  reg  [1:0] sum0_6;
	reg  [7:0] cout0;
	
	reg  [63:0] sum1_1;
  reg  [31:0] sum1_2;
  reg  [15:0] sum1_3;
  reg  [7:0] sum1_4;
  reg  [3:0] sum1_5;
  reg  [1:0] sum1_6;
	reg  [7:0] cout1;
	
  always @(posedge clk) begin
    {cout0[0], sum0_1}   <= xnor_out[0+:64] + xnor_out[192+:64] ;
    {cout0[1], sum0_2}   <= sum0_1[0+:32] + sum0_1[32+:32];
    {cout0[2], sum0_3}   <= sum0_2[0+:16] + sum0_2[16+:16];
    {cout0[3], sum0_4}   <= sum0_3[0+:8] + sum0_3[8+:8];
    {cout0[4], sum0_5}   <= sum0_4[0+:4] + sum0_4[4+:4];
    {cout0[5], sum0_6}   <= sum0_5[0+:2] + sum0_5[2+:2];
    {cout0[7], cout0[6]} <= sum0_6[0] + sum0_6[1];

	  {cout1[0], sum1_1}   <= xnor_out[128+:64] + xnor_out[64+:64] ;
    {cout1[1], sum1_2}   <= sum1_1[0+:32] + sum1_1[32+:32];
    {cout1[2], sum1_3}   <= sum1_2[0+:16] + sum1_2[16+:16];
    {cout1[3], sum1_4}   <= sum1_3[0+:8] + sum1_3[8+:8];
    {cout1[4], sum1_5}   <= sum1_4[0+:4] + sum1_4[4+:4];
    {cout1[5], sum1_6}   <= sum1_5[0+:2] + sum1_5[2+:2];
    {cout1[7], cout1[6]} <= sum1_6[0] + sum1_6[1];
  end
	
	assign	yi = cout0 + cout1;
	
endmodule


module xnor_popcount_arch1_128_reg (clk, xi, wi, yi);
	input clk;
  input [127:0]xi; 
  input [127:0]wi; 
  output [7:0]yi; 
  
  wire [127:0] xnor_out;

  assign xnor_out = xi ~^ wi;
    
  wire [64:0] sum_1;
  wire [31:0] sum_2;
  wire [15:0] sum_3;
  wire [7:0] sum_4;
  wire [3:0] sum_5;
  wire [1:0] sum_6;
	wire [7:0] cout;

  wire cout_temp0, cout_temp1;

  add32_reg add32_0 (clk, xnor_out[ 0+:32], xnor_out[32+:32], 1'b0, cout_temp0, sum_1[ 0+:32]);
  add32_reg add32_1 (clk, xnor_out[64+:32], xnor_out[96+:32], 1'b0, cout_temp1, sum_1[32+:32]);
  //add64_reg add64 (clk, xnor_out[0+:64], xnor_out[64+:64], cout[0], sum_1);

  assign {cout[0],sum_1[64]} = cout_temp0 + cout_temp1;
  add32_reg add32_2 (clk, sum_1[0+:32], sum_1[32+:32], sum_1[64+:0], cout[1], sum_2);
  //add16_reg add16 (clk, sum_2[0+:16], sum_2[16+:16], yi[2], sum_3);
  //assign {cout[0], sum_1} = xnor_out[0+:64] + xnor_out[64+:64] ;
  //assign {cout[1], sum_2} = sum_1[0+:32] + sum_1[32+:32];
  assign {cout[2], sum_3} = sum_2[0+:16] + sum_2[16+:16];
  assign {cout[3], sum_4} = sum_3[0+:8] + sum_3[8+:8];
  assign {cout[4], sum_5} = sum_4[0+:4] + sum_4[4+:4];
	assign {cout[5], sum_6} = sum_5[0+:2] + sum_5[2+:2];
  assign {cout[6], cout[7]} = sum_6[0] + sum_6[1];

  /*always @ (posedge clk) begin
    {cout[0], sum_1}   <= xnor_out[0+:64] + xnor_out[64+:64] ;
    {cout[1], sum_2}   <= sum_1[0+:32] + sum_1[32+:32];
    {cout[2], sum_3}   <= sum_2[0+:16] + sum_2[16+:16];
    {cout[3], sum_4}   <= sum_3[0+:8] + sum_3[8+:8];
    {cout[4], sum_5}   <= sum_4[0+:4] + sum_4[4+:4];
    {cout[5], sum_6}   <= sum_5[0+:2] + sum_5[2+:2];
    {cout[7], cout[6]} <= sum_6[0] + sum_6[1];
  end
    cout[2], sum_3   <= sum_2[0+:16] + sum_2[16+:16];
    cout[3], sum_4   <= sum_3[0+:8] + sum_3[8+:8];
    cout[4], sum_5   <= sum_4[0+:4] + sum_4[4+:4];
    cout[5], sum_6   <= sum_5[0+:2] + sum_5[2+:2];
    cout[7], cout[6] <= sum_6[0] + sum_6[1];
*/
	assign yi = cout;
	
endmodule

module add64_reg (clk, x, y, cin, s, cout);
  input clk;
  input [63:0]x;
  input [63:0]y;
  input cin;
  output reg s;
  output reg [63:0]cout;

  always @ (posedge clk) begin
    {s,cout} = x + y + cin;
  end

endmodule

module add32_reg (clk, x, y, cin, s, cout);
  input clk;
  input [31:0]x;
  input [31:0]y;
  input cin;
  output reg s;
  output reg [31:0]cout;

  always @ (posedge clk) begin
    {s,cout} = x + y + cin;
  end

endmodule

module add16_reg (clk, x, y, s, cout);
  input clk;
  input [15:0]x;
  input [15:0]y;
  output reg s;
  output reg [15:0]cout;

  always @ (posedge clk) begin
    {s,cout} = x + y;
  end

endmodule


module xnor_popcount_arch1_64_reg (clk, xi, wi, yi);
	input clk;
  input [63:0]xi; 
  input [63:0]wi; 
  output [6:0]yi; 
  
  wire [63:0] xnor_out;

  assign xnor_out = xi ~^ wi;
    
  reg [31:0] sum_2;
  reg [15:0] sum_3;
  reg [7:0] sum_4;
  reg [3:0] sum_5;
  reg [1:0] sum_6;
	reg [7:0] cout;

  always @ (posedge clk) begin
    {cout[0], sum_2}   <= xnor_out[0+:32] + xnor_out[32+:32];
    {cout[1], sum_3}   <= sum_2[0+:16] + sum_2[16+:16];
    {cout[2], sum_4}   <= sum_3[0+:8] + sum_3[8+:8];
    {cout[3], sum_5}   <= sum_4[0+:4] + sum_4[4+:4];
    {cout[4], sum_6}   <= sum_5[0+:2] + sum_5[2+:2];
    {cout[6], cout[5]} <= sum_6[0] + sum_6[1];
  end

  assign	yi = cout;
	
endmodule


module xnor_popcount_arch1_32_reg (clk, xi, wi, yi);
	input clk;
  input [31:0]xi; 
  input [31:0]wi; 
  output [5:0]yi; 
  
  wire [31:0] xnor_out;

  assign xnor_out = xi ~^ wi;
    
  reg [15:0] sum_3;
  reg [7:0] sum_4;
  reg [3:0] sum_5;
  reg [1:0] sum_6;
	reg [7:0] cout;

  always @ (posedge clk) begin
    {cout[0], sum_3}   <= xnor_out[0+:16] + xnor_out[16+:16];
    {cout[1], sum_4}   <= sum_3[0+:8] + sum_3[8+:8];
    {cout[2], sum_5}   <= sum_4[0+:4] + sum_4[4+:4];
    {cout[3], sum_6}   <= sum_5[0+:2] + sum_5[2+:2];
    {cout[5], cout[4]} <= sum_6[0] + sum_6[1];
  end

	assign yi = cout;
	
endmodule



//////////////////////////////// ARCH 2 /////////////////////////////////////


module xnor_popcount_arch2_128 (clk, xi, wi, yi);
	input clk;
  input [127:0]xi; 
  input [127:0]wi; 
  output [7:0]yi; 
	
  wire [35:0]int_sum;
	
	wire [4:0]int_s1;
	wire [4:0]int_s0;
  wire [7:0] cout;
		
  genvar i;
  generate
  for (i=0; i<6; i=i+1) begin: xnorpop24
    if (i==5) begin
      xnorpop8 xnorpop8 (
        .x(xi[i*24+:8]),
        .y(wi[i*24+:8]),
        .int_s0(int_s0),
        .int_s1(int_s1),
        .s0(cout[0]),
        .s1(cout[1]),
        .cout(int_sum[i*6+:6])
      );
    end else begin
      xnorpop24 xnorpop24 (
        .x(xi[i*24+:24]),
        .y(wi[i*24+:24]),
        .s0(int_s1[i]),
        .s1(int_s0[i]),
        .cout(int_sum[i*6+:6])
      );
    end
  end
  endgenerate


  xnorpop_addall (.in(int_sum), .sum(cout[7:2]));

	assign yi = cout;
	
endmodule


module xnor_popcount_arch2_128_flat (clk, xi, wi, yi);
	input clk;
  input [127:0]xi; 
  input [127:0]wi; 
  output [7:0]yi; 
	
	wire [31:0]int_sum;
	wire [7:0]int_sum2;
	wire [1:0]int_sum3;
	
	xnorpop128 xnorpop128 (xi, wi, yi[1:0], int_sum);
	add32 add32 (int_sum, yi[3:2], int_sum2);
	add8 add8 (int_sum2, yi[5:4], int_sum3);
	
	assign {yi[6], yi[7]} = int_sum3[0] + int_sum3[1];
	
endmodule

module xnorpop128 (xi, wi, cout, sum);
	input [127:0]xi;
	input [127:0]wi;
	output [1:0]cout;
	output [31:0]sum;
	
	wire [127:0]xnor_out;
	wire [63:0]sum_3;
	
	assign xnor_out = xi ~^ wi;
	
	assign {cout[0], sum_3} = xnor_out[0+:64] + xnor_out[64+:64];
	
	assign cout[1] = cout[0];
	
	assign sum = {
		sum_3[62], sum_3[60], sum_3[58], sum_3[56], sum_3[54], sum_3[52], sum_3[50], sum_3[48], 
		sum_3[46], sum_3[44], sum_3[42], sum_3[40], sum_3[38], sum_3[36], sum_3[34], sum_3[32], 
		sum_3[30], sum_3[28], sum_3[26], sum_3[24], sum_3[22], sum_3[20], sum_3[18], sum_3[16], 
		sum_3[14], sum_3[12], sum_3[10], sum_3[8], sum_3[6], sum_3[4], sum_3[2], sum_3[0]
	};

endmodule

module add32 (x, cout, sum);
	input [31:0]x;
	output [1:0]cout;
	output [7:0]sum;
	
	wire [15:0]sum_3;
		
	assign {cout[0], sum_3} = x[0+:16] + x[16+:16];
	
	assign cout[1] = cout[0];
	
	assign sum = {
		sum_3[14], sum_3[12], sum_3[10], sum_3[8], sum_3[6], sum_3[4], sum_3[2], sum_3[0]
	};

endmodule



module add36 (x, sum, cout);
  input [35:0] x;
  output sum;
  output [17:0] cout;

  wire [17:0]sum_1;
  assign {sum, sum_1} = x[17:0] + x[35:18]; 
  assign cout = sum_1;

endmodule



module add8 (x, cout, sum);
	input [7:0]x;
	output [1:0]cout;
	output [1:0]sum;
	
	wire [3:0]sum_3;
		
	assign {cout[0], sum_3} = x[0+:4] + x[4+:4];
	
	assign cout[1] = cout[0];
	
	assign sum = {
		sum_3[2], sum_3[0]
	};

endmodule

module xnor_popcount_arch2_64 (clk, xi, wi, yi);
	input clk;
  input [63:0]xi; 
  input [63:0]wi; 
  output [6:0]yi; 
  
	wire [15:0]int_sum;
	wire [3:0]int_sum2;
	
	xnorpop64 xnorpop64 (xi, wi, yi[1:0], int_sum);
	add16 add16 (int_sum, yi[3:2], int_sum2);
	add4 add4 (int_sum2, yi[5:4], yi[6]);
	
endmodule

module xnorpop64 (xi, wi, cout, sum);
  input [63:0]xi; 
  input [63:0]wi; 
	output [1:0]cout;
	output [15:0]sum;
	
	wire [63:0]xnor_out;
	wire [31:0]sum_3;
	
	assign xnor_out = xi ~^ wi;
	
	assign {cout[0], sum_3} = xnor_out[0+:32] + xnor_out[32+:32];
	
	assign cout[1] = cout[0];
	
	assign sum = {
		sum_3[30], sum_3[28], sum_3[26], sum_3[24], sum_3[22], sum_3[20], sum_3[18], sum_3[16], 
		sum_3[14], sum_3[12], sum_3[10], sum_3[8], sum_3[6], sum_3[4], sum_3[2], sum_3[0]
	};

endmodule

module add16 (x, cout, sum);
	input [15:0]x;
	output [1:0]cout;
	output [3:0]sum;
	
	wire [7:0]sum_3;
		
	assign {cout[0], sum_3} = x[0+:8] + x[8+:8];
	
	assign cout[1] = cout[0];
	
	assign sum = {
		sum_3[6], sum_3[4], sum_3[2], sum_3[0]
	};

endmodule

module add4 (x, cout, sum);
	input [3:0]x;
	output [1:0]cout;
	output [0:0]sum;
	
	wire [1:0]sum_3;
		
	assign {cout[0], sum_3} = x[0+:2] + x[2+:2];
	
	assign cout[1] = cout[0];
	
	assign sum = {
		sum_3[0]
	};

endmodule

module xnor_popcount_arch2_32 (clk, xi, wi, yi);
	input clk;
  input [31:0]xi; 
  input [31:0]wi; 
  output [5:0]yi; 
	
	wire [7:0]int_sum;
	wire [1:0]int_sum2;
	
	xnorpop32 xnorpop32 (xi, wi, yi[1:0], int_sum);
	add8 add8 (int_sum, yi[3:2], int_sum2);
	
	assign {yi[4], yi[5]} = int_sum2[0] + int_sum2[1];
	
endmodule

module xnorpop32 (xi, wi, cout, sum);
	input [31:0]xi;
	input [31:0]wi;
	output [1:0]cout;
	output [7:0]sum;
	
	wire [31:0]xnor_out;
	wire [15:0]sum_3;
	
	assign xnor_out = xi ~^ wi;
	
	assign {cout[0], sum_3} = xnor_out[0+:16] + xnor_out[16+:16];
	
	assign cout[1] = cout[0];
	
	assign sum = {
		sum_3[14], sum_3[12], sum_3[10], sum_3[8], sum_3[6], sum_3[4], sum_3[2], sum_3[0]
	};

endmodule

module xnorpop24(x, y, s1, s0, cout);
  input [23:0]x;
  input [23:0]y;
  output s1;
  output s0;
  output [5:0]cout;

  wire [23:0]xnor_out;
  wire [11:0]sum_out;

  wire [2:0]sum_out_2; 

  // XNOR and first adder tree level
  // Should fit into 5 ALMs
  assign xnor_out = x ~^ y;
 
  assign {s0, sum_out} = xnor_out[12+:12] + xnor_out[0+:12]; 
	assign s1 = s0;
  assign cout = {sum_out[10], sum_out[8], sum_out[6], sum_out[4], sum_out[2], sum_out[0]};

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

module xnorpop8_clean(x, y, s1, s0, cin, cout);
	input [7:0]x;
	input [7:0]y;
  input cin;
	output s1;
	output s0;
	output [1:0]cout;

	wire [7:0]xnor_out;
	wire [3:0]sum_out;
	
	assign xnor_out = x ~^ y;
	
	assign {s0, sum_out} = xnor_out[0+:4] + xnor_out[4+:4] + cin;
  assign s1 = s0;
  assign cout = {sum_out[2], sum_out[0]};
	
endmodule

module xnorpop_addall(in, sum);
	input [35:0]in;
	output [5:0]sum;
	
	wire [17:0] sum_3;
  wire [8:0] sum_4;
  wire [3:0] sum_5;
  wire [1:0] sum_6;
	wire [7:0] cout;

  assign {cout[2], sum_3} = in[0+:18] + in[18+:18];
	assign sum_4 = {sum_3[16], sum_3[14], sum_3[12], sum_3[10], sum_3[8], sum_3[6], sum_3[4], sum_3[2], sum_3[0]};
	assign cout[3] = cout[2];
	
  assign {cout[4], sum_5} = sum_4[0+:4] + sum_4[4+:4] + sum_4[8];
	assign sum_6 = {sum_5[2], sum_5[0]};
	assign cout[5] = cout[4];
	
  assign {cout[6], cout[7]} = sum_6[0] + sum_6[1];
	
	assign sum = cout[7:2];
	
endmodule



module xnor_popcount_arch2_1200 (clk, xi, wi, yi);
	input clk;
  input [1199:0]xi; 
  input [1199:0]wi; 
  output reg [10:0]yi; 
		
	wire [77:0] cout;

	genvar g;
	generate
		for (g=0; g<9; g=g+1) begin: xnor_pop_128
			xnor_popcount_arch2_128 xnor_popcount (.clk(clk), .xi(xi[g*128+:128]), .wi(wi[g*128+:128]), .yi(cout[g*8+:8])); 
		end
	endgenerate

	xnor_popcount_arch2_48 xnor_popcount_extra (.clk(clk), .xi(xi[1199:1152]), .wi(wi[1199:1152]), .yi(cout[77:72]));

	
	always @ (posedge clk) begin
		yi <= cout[0+:8]+cout[8+:8]+cout[16+:8]+cout[24+:8]+cout[32+:8]+cout[40+:8]+cout[48+:8]+cout[56+:8]+cout[64+:8]+cout[72+:6];
	end
	
endmodule

module xnor_popcount_arch2_48 (clk, xi, wi, yi);
	input clk;
  input [47:0]xi; 
  input [47:0]wi; 
  output [5:0]yi; 
	
	wire [11:0]int_sum;
	wire [2:0]int_sum2;
	
	xnorpop48 xnorpop48 (xi, wi, yi[1:0], int_sum);
	add12 add12 (int_sum, yi[3:2], int_sum2);
	
	assign {yi[4], yi[5]} = int_sum2[0] + int_sum2[1] + int_sum2[2];
	
endmodule

module xnorpop48 (xi, wi, cout, sum);
	input [47:0]xi;
	input [47:0]wi;
	output [1:0]cout;
	output [11:0]sum;
	
	wire [47:0]xnor_out;
	wire [23:0]sum_3;
	
	assign xnor_out = xi ~^ wi;
	
	assign {cout[0], sum_3} = xnor_out[0+:24] + xnor_out[24+:24];
	
	assign cout[1] = cout[0];
	
	assign sum = {
		sum_3[22], sum_3[20], sum_3[18], sum_3[16], sum_3[14], sum_3[12], sum_3[10], sum_3[8], sum_3[6], sum_3[4], sum_3[2], sum_3[0]
	};

endmodule

module add12 (x, cout, sum);
	input [11:0]x;
	output [1:0]cout;
	output [2:0]sum;
	
	wire [5:0]sum_3;
		
	assign {cout[0], sum_3} = x[0+:6] + x[6+:6];
	
	assign cout[1] = cout[0];
	
	assign sum = {
		sum_3[4], sum_3[2], sum_3[0]
	};

endmodule


module xnor_popcount_arch2_1152 (clk, xi, wi, yi);
	input clk;
  input [1151:0]xi; 
  input [1151:0]wi; 
  output reg [10:0]yi; 
		
	wire [71:0] cout;
	
	genvar g;
	generate
		for (g=0; g<9; g=g+1) begin: xnor_pop_128
			xnor_popcount_arch2_128 xnor_popcount (.clk(clk), .xi(xi[g*128+:128]), .wi(wi[g*128+:128]), .yi(cout[g*8+:8])); 
		end
	endgenerate
	
	always @ (posedge clk) begin
		yi <= cout[0+:8]+cout[8+:8]+cout[16+:8]+cout[24+:8]+cout[32+:8]+cout[40+:8]+cout[48+:8]+cout[56+:8]+cout[64+:8];
	end
	
endmodule


module xnor_popcount_arch2_1024 (clk, xi, wi, yi);
	input clk;
  input [1023:0]xi; 
  input [1023:0]wi; 
  output reg [10:0]yi; 
		
	wire [63:0] cout;
	
	genvar g;
	generate
		for (g=0; g<8; g=g+1) begin: xnor_pop_128
			xnor_popcount_arch2_128 xnor_popcount (.clk(clk), .xi(xi[g*128+:128]), .wi(wi[g*128+:128]), .yi(cout[g*8+:8])); 
		end
	endgenerate
	
	always @ (posedge clk) begin
		yi <= cout[0+:8]+cout[8+:8]+cout[16+:8]+cout[24+:8]+cout[32+:8]+cout[40+:8]+cout[48+:8]+cout[56+:8];
	end
	
endmodule


module xnor_popcount_arch2_256 (clk, xi, wi, yi);
	input clk;
  input [255:0]xi; 
  input [255:0]wi; 
  output reg [8:0]yi; 
  
	wire [15:0] cout;
	
	genvar g;
	generate
		for (g=0; g<2; g=g+1) begin: xnor_pop_128
			xnor_popcount_arch2_128 xnor_popcount (.clk(clk), .xi(xi[g*128+:128]), .wi(wi[g*128+:128]), .yi(cout[g*8+:8])); 
		end
	endgenerate
	
	always @ (posedge clk) begin
		yi <= cout[0+:8]+cout[8+:8];
	end
		
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

/*module add32 (x, s2, cout);
  input [35:0] x;
  output s2;
  output [17:0] cout;

  wire [17:0]sum_1;
  assign {s2, sum_1} = x[17:0] + x[35:18]; 
  assign cout = sum_1;

endmodule
*/
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
  assign {s1, sum_2} = sum_1[5:0] + sum_1[11:6] + sum_1[12];
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



