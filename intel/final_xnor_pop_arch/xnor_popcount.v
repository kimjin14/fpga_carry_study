
module fpga_top (clk, rstn, addr, out);
	localparam N = 128;
	localparam POP = 16;
	input clk;
	input [2:0]addr;
	input rstn;
	output out; 
	
  reg [N-1:0] xi /* synthesis keep */;
  reg [N-1:0] wi /* synthesis keep */;
  reg [POP-1:0] ti;
	
	reg [N-1:0] input_activation [7:0];
	reg [N-1:0] weights [7:0];
	reg [POP-1:0] threshold [7:0];
	
	always @ (*) begin
		xi = input_activation[addr];
		wi = weights[addr];
		ti = threshold[addr];
	end
	
	xnor_popcount #(N) dut (clk, rstn, xi, wi, ti, out);
	
endmodule

module xnor_popcount (clk, rstn, xi, wi, ti, out);
	parameter N;
	localparam POP = 16;

	input clk;
	input rstn;
  input [N-1:0] xi;
  input [N-1:0] wi;
  input [POP-1:0] ti;
	output out;
	
	reg [POP-1:0] sum;
  wire [$clog2(N)-1:0] yi /* synthesis keep */;

	// Final summation
	always @ (posedge clk) begin
		if (!rstn) begin
			sum <= 0;
		end
		else begin
			sum = sum + yi;
		end
	end
	
	xnor_popcount_arch2#(N,$clog2(N)+1) xnor_pop (clk, xi, wi, yi);
	
	// Output 1 if above threshold
	assign out = sum > ti? 1'b1 : 1'b0;
	
endmodule

module xnor_popcount_arch1 (clk, xi, wi, yi);
  parameter N = 128;
  parameter D = 8;
  localparam D128 = 0;
  localparam D32 = 0;

	input clk;
  input [N-1:0]xi; 
  input [N-1:0]wi; 
  output [D-1:0]yi; 

	generate
		if (N==32) xnor_popcount_arch1_32 xnor_popcount_0 (.clk(clk), .xi(xi), .wi(wi), .yi(yi));
		else if (N==64) xnor_popcount_arch1_64 xnor_popcount_0 (.clk(clk), .xi(xi), .wi(wi), .yi(yi));
		else if (N==128) xnor_popcount_arch1_128 xnor_popcount_0 (.clk(clk), .xi(xi), .wi(wi), .yi(yi));
		else if (N==256) xnor_popcount_arch1_256 xnor_popcount_0 (.clk(clk), .xi(xi), .wi(wi), .yi(yi));
		else if (N==1024) xnor_popcount_arch1_1024 xnor_popcount_0 (.clk(clk), .xi(xi), .wi(wi), .yi(yi));
		else if (N==1152) xnor_popcount_arch1_1152 xnor_popcount_0 (.clk(clk), .xi(xi), .wi(wi), .yi(yi));
		else if (N==1200) xnor_popcount_arch1_1200 xnor_popcount_0 (.clk(clk), .xi(xi), .wi(wi), .yi(yi));
	endgenerate
	
endmodule

module xnor_popcount_arch1_1200 (clk, xi, wi, yi);
	input clk;
  input [1199:0]xi; 
  input [1199:0]wi; 
  output reg [10:0]yi; 
		
	wire [77:0] cout;

	genvar g;
	generate
		for (g=0; g<9; g=g+1) begin: xnor_pop_128
			xnor_popcount_128 xnor_popcount (.clk(clk), .xi(xi[g*128+:128]), .wi(wi[g*128+:128]), .yi(cout[g*8+:8])); 
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
	
	
	
	always @ (posedge clk) begin
		yi <= cout[0+:8]+cout[8+:8]+cout[16+:8]+cout[24+:8]+cout[32+:8]+cout[40+:8]+cout[48+:8]+cout[56+:8]+cout[64+:8]+cout[72+:6];
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
			xnor_popcount_128 xnor_popcount (.clk(clk), .xi(xi[g*128+:128]), .wi(wi[g*128+:128]), .yi(cout[g*8+:8])); 
		end
	endgenerate
	
	always @ (posedge clk) begin
		yi <= cout[0+:8]+cout[8+:8]+cout[16+:8]+cout[24+:8]+cout[32+:8]+cout[40+:8]+cout[48+:8]+cout[56+:8]+cout[64+:8];
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
			xnor_popcount_128 xnor_popcount (.clk(clk), .xi(xi[g*128+:128]), .wi(wi[g*128+:128]), .yi(cout[g*8+:8])); 
		end
	endgenerate
	
	always @ (posedge clk) begin
		yi <= cout[0+:8]+cout[8+:8]+cout[16+:8]+cout[24+:8]+cout[32+:8]+cout[40+:8]+cout[48+:8]+cout[56+:8];
	end
	
endmodule

module xnor_popcount_arch1_256 (clk, xi, wi, yi);
	input clk;
  input [255:0]xi; 
  input [255:0]wi; 
  output reg [8:0]yi; 
  
  wire [255:0] xnor_out;

  assign xnor_out = xi ~^ wi;
    
  wire [63:0] sum0_1;
  wire [31:0] sum0_2;
  wire [15:0] sum0_3;
  wire [7:0] sum0_4;
  wire [3:0] sum0_5;
  wire [1:0] sum0_6;
	wire [7:0] cout0;
	
	wire [63:0] sum1_1;
  wire [31:0] sum1_2;
  wire [15:0] sum1_3;
  wire [7:0] sum1_4;
  wire [3:0] sum1_5;
  wire [1:0] sum1_6;
	wire [7:0] cout1;
	
  assign {cout0[0], sum0_1} = xnor_out[0+:64] + xnor_out[192+:64] ;
  assign {cout0[1], sum0_2} = sum0_1[0+:32] + sum0_1[32+:32];
  assign {cout0[2], sum0_3} = sum0_2[0+:16] + sum0_2[16+:16];
  assign {cout0[3], sum0_4} = sum0_3[0+:8] + sum0_3[8+:8];
  assign {cout0[4], sum0_5} = sum0_4[0+:4] + sum0_4[4+:4];
  assign {cout0[5], sum0_6} = sum0_5[0+:2] + sum0_5[2+:2];
  assign {cout0[7], cout0[6]} = sum0_6[0] + sum0_6[1];

	assign {cout1[0], sum1_1} = xnor_out[128+:64] + xnor_out[64+:64] ;
  assign {cout1[1], sum1_2} = sum1_1[0+:32] + sum1_1[32+:32];
  assign {cout1[2], sum1_3} = sum1_2[0+:16] + sum1_2[16+:16];
  assign {cout1[3], sum1_4} = sum1_3[0+:8] + sum1_3[8+:8];
  assign {cout1[4], sum1_5} = sum1_4[0+:4] + sum1_4[4+:4];
  assign {cout1[5], sum1_6} = sum1_5[0+:2] + sum1_5[2+:2];
  assign {cout1[7], cout1[6]} = sum1_6[0] + sum1_6[1];
	
	always @ (posedge clk) begin
		yi <= cout0 + cout1;
	end
	
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

module xnor_popcount_arch1_128_reg (clk, xi, wi, yi);
	input clk;
  input [127:0]xi; 
  input [127:0]wi; 
  output reg [7:0]yi; 
  
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

	always @ (posedge clk) begin
		yi <= cout;
	end
	
endmodule



module xnor_popcount_arch1_64 (clk, xi, wi, yi);
	input clk;
  input [63:0]xi; 
  input [63:0]wi; 
  output reg [6:0]yi; 
  
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

	always @ (posedge clk) begin
		yi <= cout;
	end
	
endmodule


module xnor_popcount_arch1_32 (clk, xi, wi, yi);
	input clk;
  input [31:0]xi; 
  input [31:0]wi; 
  output reg [5:0]yi; 
  
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

	always @ (posedge clk) begin
		yi <= cout;
	end
	
endmodule

module xnor_popcount_arch2 (clk, xi, wi, yi);
  parameter N = 128;
  parameter D = 8;
  localparam D128 = 0;
  localparam D32 = 0;

	input clk;
  input [N-1:0]xi; 
  input [N-1:0]wi; 
  output [D-1:0]yi; 

	generate
		if (N==32) xnor_popcount_arch2_32 xnor_popcount_0 (.clk(clk), .xi(xi), .wi(wi), .yi(yi));
		else if (N==64) xnor_popcount_arch2_64 xnor_popcount_0 (.clk(clk), .xi(xi), .wi(wi), .yi(yi));
		else if (N==128) xnor_popcount_arch2_128_testing xnor_popcount_0 (.clk(clk), .xi(xi), .wi(wi), .yi(yi));
		//else if (N==256) xnor_popcount_arch2_256 xnor_popcount_0 (.clk(clk), .xi(xi), .wi(wi), .yi(yi));
		//else if (N==1024) xnor_popcount_arch2_1024 xnor_popcount_0 (.clk(clk), .xi(xi), .wi(wi), .yi(yi));
		//else if (N==1152) xnor_popcount_arch2_1152 xnor_popcount_0 (.clk(clk), .xi(xi), .wi(wi), .yi(yi));
		//else if (N==1200) xnor_popcount_arch2_1200 xnor_popcount_0 (.clk(clk), .xi(xi), .wi(wi), .yi(yi));
	endgenerate

endmodule

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


module xnor_popcount_arch2_128_testing (clk, xi, wi, yi);
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
  
  wire [63:0] xnor_out /*synthesis keep*/;

  assign xnor_out = xi ~^ wi;
    
  wire [31:0] sum_1; /*synthesis keep*/
  wire [15:0] sum_2 /*synthesis keep*/;
  wire [7:0] sum_3 /*synthesis keep*/;
  wire [3:0] sum_4 /*synthesis keep*/;
  wire [1:0] sum_5 /*synthesis keep*/;
	wire [7:0] cout;

	assign {cout[0], sum_1} = xnor_out[0+:32] + xnor_out[32+:32];
	assign sum_2 = {sum_1[30], sum_1[28], sum_1[26], sum_1[24], sum_1[22], sum_1[20], sum_1[18], sum_1[16], 
									sum_1[14], sum_1[12], sum_1[10], sum_1[8], sum_1[6], sum_1[4], sum_1[2], sum_1[0]};
	assign cout[1] = cout[0];
	
  assign {cout[2], sum_3} = sum_2[0+:8] + sum_2[8+:8];
	assign sum_4 = {sum_3[6], sum_3[4], sum_3[2], sum_3[0]};
	assign cout[3] = cout[2];
	
  assign {cout[4], sum_5} = sum_4[0+:2] + sum_4[2+:2];
	assign cout[5] = sum_5[0];
	assign cout[6] = cout[4];
	
	assign yi = cout;
	
endmodule


module xnor_popcount_arch2_32 (clk, xi, wi, yi);
	input clk;
  input [31:0]xi; 
  input [31:0]wi; 
  output reg [5:0]yi; 
  
  wire [31:0] xnor_out /*synthesis keep*/;

  assign xnor_out = xi ~^ wi;
    
  wire [15:0] sum_1 /*synthesis keep*/;
  wire [7:0] sum_2 /*synthesis keep*/;
  wire [3:0] sum_3 /*synthesis keep*/;
  wire [1:0] sum_4 /*synthesis keep*/;
	wire [5:0] cout;

  assign {cout[0], sum_1} = xnor_out[0+:16] + xnor_out[16+:16];
	assign sum_2 = {sum_1[14], sum_1[12], sum_1[10], sum_1[8], sum_1[6], sum_1[4], sum_1[2], sum_1[0]};
	assign cout[1] = cout[0];
	
  assign {cout[2], sum_3} = sum_2[0+:4] + sum_2[4+:4];
	assign sum_4 = {sum_3[2], sum_3[0]};
	assign cout[3] = cout[2];
	
  assign {cout[5], cout[4]} = sum_4[0] + sum_4[1];

	always @ (posedge clk) begin
		yi <= cout;
	end
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

