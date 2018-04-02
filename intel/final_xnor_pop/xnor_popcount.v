module xnor_popcount (clk, rstn, in, lw1rdy, hw1rdy, lw2rdy, hw2rdy, out);
	localparam N = 1200;
	localparam POP = 16;
	input clk;
	input rstn;
	input [(N/2)-1:0] in;
	input lw1rdy, hw1rdy, lw2rdy, hw2rdy;
	output out; 
	
  reg [N-1:0] xi /* synthesis keep */;
  reg [N-1:0] wi /* synthesis keep */;
  wire [$clog2(N)-1:0] yi /* synthesis keep */;
  reg [$clog2(N)-1:0] yi_reg;
  
	reg [POP-1:0] sum;
	reg [POP-1:0] threshold = 16'h1F00;
	
	// Get inputs half by half for x and w since we don't have enough top ports
  always @ (posedge clk) begin
		if (lw1rdy) xi[0   +: N/2] = in;
		if (hw1rdy) xi[N/2 +: N/2] = in;
		if (lw2rdy) wi[0   +: N/2] = in;
		if (hw2rdy) wi[N/2 +: N/2] = in;
	end
	
	// Final summation
	always @ (posedge clk) begin
		if (!rstn) begin
			sum <= 0;
      yi_reg <= 0;
		end
		else begin
			sum = sum + yi_reg;
      yi_reg <= yi; 
		end
	end
	
	xnor_popcount_generic #(N,$clog2(N)) xnor_pop (xi, wi, yi);
	
	// Output 1 if above threshold
	assign out = sum > threshold? 1'b1 : 1'b0;
	
endmodule

// Parametrized XNOR-pop
module xnor_popcount_generic(xi, wi, yi);
  parameter N = 128;
  parameter D = 8;
  input [N-1:0]xi; 
  input [N-1:0]wi; 
  output reg [D-1:0]yi /* synthesis preserve*/; 
  
  wire [N-1:0] xnor_out;
  assign xnor_out = xi ~^ wi;

  integer i;
  always @(*) begin
    yi = 0;
    for (i=0; i<N; i=i+1) begin
      yi = yi + xnor_out[i];
    end  
  end

endmodule

// Parametrized XNOR-pop
module xnor_popcount_verilog (xi, wi, yi);
  parameter N = 128;
  parameter D = 8;
	localparam P = (N/3)+1;
	
  input [N-1:0]xi; 
  input [N-1:0]wi; 
  output reg [D-1:0]yi /* synthesis preserve*/; 
  
	wire [(P*2)-1:0] partial_sum;
	
	// Generate N/3 3-XNOR-pop
	genvar g;
	generate
		
		if (N%3==0) begin
			for (g = 0; g < P-1; g = g + 1) begin: gen_xnor_pop_3
				xnor_popcount_3 xnorpop3 (xi[g*3+:3], wi[g*3+:3], partial_sum[g*2+:2]);
			end
		end
		else if (N%3==1) begin
			for (g = 0; g < P-1; g = g + 1) begin: gen_xnor_pop_3
				xnor_popcount_3 xnorpop3 (xi[g*3+:3], wi[g*3+:3], partial_sum[g*2+:2]);
			end
			xnor_popcount_3 xnorpop3 ({xi[g*3+:1], 2'b00}, {wi[g*3+:1], 2'b00}, partial_sum[g*2+:2]);
		end
		else if (N%3==2) begin
			for (g = 0; g < P-1; g = g + 1) begin: gen_xnor_pop_3
				xnor_popcount_3 xnorpop3 (xi[g*3+:3], wi[g*3+:3], partial_sum[g*2+:2]);
			end
			xnor_popcount_3 xnorpop3 ({xi[g*3+:2], 1'b0}, {wi[g*3+:2], 1'b0}, partial_sum[g*2+:2]);
		end
	endgenerate
	
	// Sum up the partial sums
	integer i;
	always @ (*) begin
		yi = 0;
		for (i = 0; i < P; i = i+1) begin
			yi = yi + partial_sum[i*2+:2];
		end
	end

endmodule

module xnor_popcount_3 (x, w, y);
	input [2:0] x;
	input [2:0] w;
	output reg [1:0] y;
	
	always @ (*) begin
			y = x[0]~^w[0] + x[1]~^w[1] + x[2]~^w[2];
	end

endmodule
