
module fpga_top (clk, rstn, addr, we, dx, dw, dt, out);
	localparam N = 8;
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
	
	xnor_popcount_generic #(N,$clog2(N)+1) xnor_pop (clk, xi, wi, yi);
	
	// Output 1 if above threshold
	assign out = sum > ti? 1'b1 : 1'b0;
	
endmodule

// Parametrized XNOR-pop
module xnor_popcount_generic(clk, xi, wi, yi);
  parameter N = 128;
  parameter D = 8;
  input [N-1:0]xi; 
  input [N-1:0]wi; 
  input clk;
  output reg [D-1:0]yi; 
  
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
module xnor_popcount_verilog (clk, xi, wi, yi);
  parameter N = 128;
  parameter D = 8;
	localparam P = (N/3)+1;
	
  input [N-1:0]xi; 
  input [N-1:0]wi; 
  input clk;
  output reg [D-1:0]yi; 
  
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
			for (g = 0; g < P; g = g + 1) begin: gen_xnor_pop_3
        if (g == P-1) begin
					assign partial_sum[g*2+:1] = xi[61] ^ wi[61];
			    //xnor_popcount_3 xnorpop3 ({xi[g*3+:1], 2'b00}, {wi[g*3+:1], 2'b00}, partial_sum[g*2+:2]);
        end
        else begin
				  xnor_popcount_3 xnorpop3 (xi[g*3+:3], wi[g*3+:3], partial_sum[g*2+:2]);
        end
			end
		end
		else if (N%3==2) begin
			for (g = 0; g < P; g = g + 1) begin: gen_xnor_pop_3
        if (g == P-1) begin
			    xnor_popcount_3 xnorpop3 ({xi[g*3+:2], 1'b0}, {wi[g*3+:2], 1'b0}, partial_sum[g*2+:2]);
        end
        else begin
				  xnor_popcount_3 xnorpop3 (xi[g*3+:3], wi[g*3+:3], partial_sum[g*2+:2]);
        end
			end
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

// Parametrized XNOR-pop
module xnor_popcount_verilog_reg (clk, xi, wi, yi);
  parameter N = 128;
  parameter D = 8;
	localparam P = (N/3)+1;
	
  input [N-1:0]xi; 
  input [N-1:0]wi; 
  input clk;
  output reg [D-1:0]yi ; 
  
	wire [(P*2)-1:0] partial_sum;
	
	// Generate N/3 3-XNOR-pop
	genvar g;
	generate
		
		if (N%3==0) begin
			for (g = 0; g < P-1; g = g + 1) begin: gen_xnor_pop_3
				xnor_popcount_3_reg xnorpop3 (clk, xi[g*3+:3], wi[g*3+:3], partial_sum[g*2+:2]);
			end
		end
		else if (N%3==1) begin
			for (g = 0; g < P; g = g + 1) begin: gen_xnor_pop_3
        if (g == P-1) begin
			    xnor_popcount_3_reg xnorpop3 (clk, {xi[g*3+:1], 2'b00}, {wi[g*3+:1], 2'b00}, partial_sum[g*2+:2]);
        end
        else begin
				  xnor_popcount_3_reg xnorpop3 (clk, xi[g*3+:3], wi[g*3+:3], partial_sum[g*2+:2]);
        end
			end
		end
		else if (N%3==2) begin
			for (g = 0; g < P; g = g + 1) begin: gen_xnor_pop_3
        if (g == P-1) begin
			    xnor_popcount_3_reg xnorpop3 (clk, {xi[g*3+:2], 1'b0}, {wi[g*3+:2], 1'b0}, partial_sum[g*2+:2]);
        end
        else begin
				  xnor_popcount_3_reg xnorpop3 (clk, xi[g*3+:3], wi[g*3+:3], partial_sum[g*2+:2]);
        end
			end
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

module xnor_popcount_3_reg (clk, x, w, y);
	input [2:0] x;
	input [2:0] w;
  input clk;
	output reg [1:0] y;
	
	always @ (posedge clk) begin
			y <= x[0]~^w[0] + x[1]~^w[1] + x[2]~^w[2];
	end

endmodule


