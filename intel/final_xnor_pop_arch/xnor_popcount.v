
module fpga_top (clk, rstn, addr, we, dx, dw, dt, out);
	localparam N = 128;
	localparam POP = 16;
	input clk;
	input we;
	input [N-1:0] dx;
	input [N-1:0] dw;
	input [POP-1:0] dt;
	input [2:0]addr;
	input rstn;
	output out; 

  reg [N-1:0] xi;
  reg [N-1:0] wi;
  reg [POP-1:0] ti;
  reg [N-1:0] xi_reg;
  reg [N-1:0] wi_reg;
  reg [POP-1:0] ti_reg;
	
	
	reg [N-1:0] input_activation [7:0];
	reg [N-1:0] weights [7:0];
	reg [POP-1:0] threshold [7:0];
	
	always @ (posedge clk) begin
		if (we) begin
			input_activation[addr] <= dx;
			weights[addr] <= dw;
			threshold[addr] <= dt;
		end else begin
			xi_reg <= input_activation[addr];
			wi_reg <= weights[addr];
			ti_reg <= threshold[addr];
		end
	end

  always @ (posedge clk) begin
    xi <= xi_reg;
    wi <= wi_reg;
    ti <= ti_reg;
  end
	
	xnor_popcount #(N) dut (clk, rstn, xi, wi, ti, out);

endmodule
module xnor_popcount (clk, rstn, xi, wi, ti, out);
	parameter N = 256;
	localparam POP = 16;

	input clk;
	input rstn;
  input [N-1:0] xi;
  input [N-1:0] wi;
  input [POP-1:0] ti;
	output out;
	
	reg [POP-1:0] sum;
	reg [$clog2(N):0] yi_reg;
  wire [$clog2(N):0] yi;

	// Final summation
	always @ (posedge clk) begin
		if (rstn) begin
			sum <= 0;
      yi_reg <= 0;
		end
		else begin
			sum <= sum + yi_reg;
      yi_reg <= yi;
		end
	end
	
	xnor_popcount_arch2_reg #(N,$clog2(N)+1) xnor_pop (clk, xi, wi, yi);
	
	// Output 1 if above threshold
	assign out = sum > ti? 1'b1 : 1'b0;
	
endmodule

module xnor_popcount_arch1 (clk, xi, wi, yi);
  parameter N = 128; // input width
  parameter D = 8; // output width
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
		//else if (N==1024) xnor_popcount_arch1_1024 xnor_popcount_0 (.clk(clk), .xi(xi), .wi(wi), .yi(yi));
		//else if (N==1152) xnor_popcount_arch1_1152 xnor_popcount_0 (.clk(clk), .xi(xi), .wi(wi), .yi(yi));
		//else if (N==1200) xnor_popcount_arch1_1200 xnor_popcount_0 (.clk(clk), .xi(xi), .wi(wi), .yi(yi));
	endgenerate
	
endmodule
module xnor_popcount_arch1_reg (clk, xi, wi, yi);
  parameter N = 128;
  parameter D = 8;
  localparam D128 = 0;
  localparam D32 = 0;

	input clk;
  input [N-1:0]xi; 
  input [N-1:0]wi; 
  output [D-1:0]yi; 

	generate
		if (N==32)        xnor_popcount_arch1_32_reg xnor_popcount_0 (.clk(clk), .xi(xi), .wi(wi), .yi(yi));
		else if (N==64)   xnor_popcount_arch1_64_reg xnor_popcount_0 (.clk(clk), .xi(xi), .wi(wi), .yi(yi));
		else if (N==128)  xnor_popcount_arch1_128_reg xnor_popcount_0 (.clk(clk), .xi(xi), .wi(wi), .yi(yi));
		else if (N==256)  xnor_popcount_arch1_256_reg xnor_popcount_0 (.clk(clk), .xi(xi), .wi(wi), .yi(yi));
	endgenerate
	
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
		else if (N==128) xnor_popcount_arch2_128 xnor_popcount_0 (.clk(clk), .xi(xi), .wi(wi), .yi(yi));
		else if (N==256) xnor_popcount_arch2_256 xnor_popcount_0 (.clk(clk), .xi(xi), .wi(wi), .yi(yi));
		//else if (N==1024) xnor_popcount_arch2_1024 xnor_popcount_0 (.clk(clk), .xi(xi), .wi(wi), .yi(yi));
		//else if (N==1152) xnor_popcount_arch2_1152 xnor_popcount_0 (.clk(clk), .xi(xi), .wi(wi), .yi(yi));
		//else if (N==1200) xnor_popcount_arch2_1200 xnor_popcount_0 (.clk(clk), .xi(xi), .wi(wi), .yi(yi));
	endgenerate

endmodule
module xnor_popcount_arch2_reg (clk, xi, wi, yi);
  parameter N = 128;
  parameter D = 8;
  localparam D128 = 0;
  localparam D32 = 0;

	input clk;
  input [N-1:0]xi; 
  input [N-1:0]wi; 
  output [D-1:0]yi; 

	generate
		if (N==32) xnor_popcount_arch2_32_reg xnor_popcount_0 (.clk(clk), .xi(xi), .wi(wi), .yi(yi));
		else if (N==64) xnor_popcount_arch2_64_reg xnor_popcount_0 (.clk(clk), .xi(xi), .wi(wi), .yi(yi));
		else if (N==128) xnor_popcount_arch2_128_reg xnor_popcount_0 (.clk(clk), .xi(xi), .wi(wi), .yi(yi));
		else if (N==256) xnor_popcount_arch2_256_reg xnor_popcount_0 (.clk(clk), .xi(xi), .wi(wi), .yi(yi));
		//else if (N==1024) xnor_popcount_arch2_1024 xnor_popcount_0 (.clk(clk), .xi(xi), .wi(wi), .yi(yi));
		//else if (N==1152) xnor_popcount_arch2_1152 xnor_popcount_0 (.clk(clk), .xi(xi), .wi(wi), .yi(yi));
		//else if (N==1200) xnor_popcount_arch2_1200 xnor_popcount_0 (.clk(clk), .xi(xi), .wi(wi), .yi(yi));
	endgenerate

endmodule

