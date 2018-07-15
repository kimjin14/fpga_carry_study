// XNOR modules for various widths
// Could be parameterized but might not map as easily
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

module xnor_popcount_arch2_256_reg (clk, xi, wi, yi);
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


module xnor_popcount_arch2_128 (clk, xi, wi, yi);
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

// LATENCY: 2
// xnorpop128 delays yi[1:0] by 2 cycles
// add32 delays yi[3:2] by 1 cycle
module xnor_popcount_arch2_128_reg (clk, xi, wi, yi);
	input clk;
  input [127:0]xi; 
  input [127:0]wi; 
  output [7:0]yi; 
	
	wire [31:0]int_sum;
	wire [7:0]int_sum2;
	wire [1:0]int_sum3;
	
	xnorpop128_reg xnorpop128 (clk, xi, wi, yi[1:0], int_sum);
	add32 add32 (int_sum, yi[3:2], int_sum2);
	add8 add8 (int_sum2, yi[5:4], int_sum3);
	
	assign {yi[6], yi[7]} = int_sum3[0] + int_sum3[1];
	
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
// LATENCY: 1 cycle
module xnor_popcount_arch2_64_reg (clk, xi, wi, yi);
	input clk;
  input [63:0]xi; 
  input [63:0]wi; 
  output [6:0]yi; 
  
	wire [15:0]int_sum;
	wire [3:0]int_sum2;
	
	xnorpop64_reg xnorpop64 (clk, xi, wi, yi[1:0], int_sum);
	add16 add16 (int_sum, yi[3:2], int_sum2);
	add4 add4 (int_sum2, yi[5:4], yi[6]);
	
endmodule

module xnorpop64_reg (clk, xi, wi, cout, sum);
  input clk;
  input [63:0]xi; 
  input [63:0]wi; 
	output [1:0]cout;
	output [15:0]sum;
	
	wire [63:0]xnor_out;
	wire [31:0]sum_3;
	
	assign xnor_out = xi ~^ wi;
	
  reg s0, s1;
  reg [31:0]sum_reg;

  always @(posedge clk) begin
    {s0, sum_reg} <= xnor_out[0+:32] + xnor_out[32+:32];
  end

	//assign {cout[0], sum_3} = xnor_out[0+:32] + xnor_out[32+:32];
	//assign cout[1] = cout[0];
	assign sum_3 = sum_reg;
  assign cout[0] = s0;
  assign cout[1] = s0;

	assign sum = {
		sum_3[30], sum_3[28], sum_3[26], sum_3[24], sum_3[22], sum_3[20], sum_3[18], sum_3[16], 
		sum_3[14], sum_3[12], sum_3[10], sum_3[8], sum_3[6], sum_3[4], sum_3[2], sum_3[0]
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

// LATENCY: 1 cycle
module xnor_popcount_arch2_32_reg (clk, xi, wi, yi);
	input clk;
  input [31:0]xi; 
  input [31:0]wi; 
  output [5:0]yi; 
	
	wire [7:0]int_sum;
	wire [1:0]int_sum2;
	
	xnorpop32_reg xnorpop32 (clk, xi, wi, yi[1:0], int_sum);
	add8 add8 (int_sum, yi[3:2], int_sum2);
	
	assign {yi[4], yi[5]} = int_sum2[0] + int_sum2[1];
	
endmodule

module xnorpop32_reg (clk,xi, wi, cout, sum);
  input clk;
	input [31:0]xi;
	input [31:0]wi;
	output [1:0]cout;
	output [7:0]sum;
	
	wire [31:0]xnor_out;
	wire [15:0]sum_3;
	
	assign xnor_out = xi ~^ wi;
	
	
  reg s0, s1;
  reg [15:0]sum_reg;

  always @ (posedge clk) begin
    {s0, sum_reg} <= xnor_out[0+:16] + xnor_out[16+:16];
  end

	//assign {cout[0], sum_3} = xnor_out[0+:16] + xnor_out[16+:16];
	//assign cout[1] = cout[0];
  assign sum_3 = sum_reg;
  assign cout[0] = s0;	
  assign cout[1] = s0;	

	assign sum = {
		sum_3[14], sum_3[12], sum_3[10], sum_3[8], sum_3[6], sum_3[4], sum_3[2], sum_3[0]
	};


endmodule

////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
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

module add32_32 (clk, x, cout, sum);
  input clk;
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

// cout out should be registered 2 times; NVM
module xnorpop128_reg (clk, xi, wi, cout, sum);
  input clk;
	input [127:0]xi;
	input [127:0]wi;
	output [1:0]cout;
	output [31:0]sum;
	
	wire [127:0]xnor_out;
	wire [63:0]sum_3;

  reg s0;//, s0_r2;
  reg [63:0]sum_reg;
	
	assign xnor_out = xi ~^ wi;
	
  always @ (posedge clk) begin
    {s0,sum_reg} <= xnor_out[0+:64] + xnor_out[64+:64];
    //s0_r2 <= s0;
  end

	//assign {cout[0], sum_3} = xnor_out[0+:64] + xnor_out[64+:64];
	//assign cout[1] = cout[0];
	assign cout[0] = s0;
  assign cout[1] = s0;
  assign sum_3 = sum_reg;
  
	assign sum = {
		sum_3[62], sum_3[60], sum_3[58], sum_3[56], sum_3[54], sum_3[52], sum_3[50], sum_3[48], 
		sum_3[46], sum_3[44], sum_3[42], sum_3[40], sum_3[38], sum_3[36], sum_3[34], sum_3[32], 
		sum_3[30], sum_3[28], sum_3[26], sum_3[24], sum_3[22], sum_3[20], sum_3[18], sum_3[16], 
		sum_3[14], sum_3[12], sum_3[10], sum_3[8], sum_3[6], sum_3[4], sum_3[2], sum_3[0]
	};

endmodule


