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
	
	assign	yi = cout0 + cout1;
	
endmodule

module xnor_popcount_arch1_256_reg (clk, xi, wi, yi);
	input clk;
  input [255:0]xi; 
  input [255:0]wi; 
  output [8:0]yi; 
  
  wire [255:0] xnor_out;
	wire  [7:0] cout0;
	wire  [7:0] cout1;

  xnor_popcount_arch1_128_reg xnor_popcount_128_reg0 (clk, xi[  0+:128], wi[  0+:128], cout0);
  xnor_popcount_arch1_128_reg xnor_popcount_128_reg1 (clk, xi[128+:128], wi[128+:128], cout1);

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
	
  assign {cout[7], cout[6]} = sum_6[0] + sum_6[1];

	assign yi = cout;
	
endmodule

// LATENCY: 2 cycles
module xnor_popcount_arch1_128_reg (clk, xi, wi, yi);
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
 
  reg s0, s0_2;
  reg s1;
  reg [63:0]sum;
  reg [31:0]sum_r2;

  always @ (posedge clk) begin
    {s0, sum} <= xnor_out[0+:64] + xnor_out[64+:64];
    {s1, sum_r2} <= sum_1[0+:32] + sum_1[32+:32];
    s0_2 <= s0;
  end 

  //assign {cout[0], sum_1} = xnor_out[0+:64] + xnor_out[64+:64] ;
  assign cout[0] = s0_2;
  assign sum_1 = sum;

  //assign {cout[1], sum_2} = sum_1[0+:32] + sum_1[32+:32];
  assign cout[1] = s1;
  assign sum2 = sum_r2;

  assign {cout[2], sum_3} = sum_2[0+:16] + sum_2[16+:16];
  assign {cout[3], sum_4} = sum_3[0+:8] + sum_3[8+:8];
  assign {cout[4], sum_5} = sum_4[0+:4] + sum_4[4+:4];
	assign {cout[5], sum_6} = sum_5[0+:2] + sum_5[2+:2];
	
  assign {cout[7], cout[6]} = sum_6[0] + sum_6[1];

	assign yi = cout;
	
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

// LATENCY: 1 cycle
module xnor_popcount_arch1_64_reg (clk, xi, wi, yi);
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

  reg s0;
  reg [31:0]sum;

  always @(posedge clk) begin
    {s0, sum} <= xnor_out[0+:32] + xnor_out[32+:32];

  end

  //assign {cout[0], sum_2} = xnor_out[0+:32] + xnor_out[32+:32];
  assign cout[0] = s0;
  assign sum_2 = sum;

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

// LATENCY: 1 cycle
module xnor_popcount_arch1_32_reg (clk, xi, wi, yi);
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

  reg s0;
  reg [15:0]sum;
  
  always @ (posedge clk) begin
    {s0, sum} <= xnor_out[0+:16] + xnor_out[16+:16];
  end

  //assign {cout[0], sum_3} = xnor_out[0+:16] + xnor_out[16+:16];
  assign cout[0] = s0;
  assign sum_3 = sum;

  assign {cout[1], sum_4} = sum_3[0+:8] + sum_3[8+:8];
  assign {cout[2], sum_5} = sum_4[0+:4] + sum_4[4+:4];
  assign {cout[3], sum_6} = sum_5[0+:2] + sum_5[2+:2];
  assign {cout[5], cout[4]} = sum_6[0] + sum_6[1];

	assign yi = cout;
	
endmodule


