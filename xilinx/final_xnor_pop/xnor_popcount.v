`timescale 2ns / 1ps

module fpga_top (clk, rstn, addr, we, out);
	localparam N = 256;
	localparam POP = 16;
	input clk;
	input [4:0]addr;
	input we;
	input rstn;
	output out; 

    reg [N-1:0] xi;
    reg [N-1:0] wi;
    reg [POP-1:0] ti;
    
    reg [N-1:0] input_activation [0:31];
    reg [N-1:0] weights [0:31];
    reg [POP-1:0] threshold [0:31];
    
	initial begin
        $readmemh("rom1_init.mif", input_activation);
        $readmemh("rom2_init.mif", weights);
        $readmemh("rom3_init.mif",threshold);
    end
	
	reg [N-1:0] datan;
	reg [POP-1:0] datap;

	always @ (posedge clk) begin
        if (we) begin
            input_activation[addr] <= datan;
            weights[addr] <= datan;
            threshold[addr] <= datap;
        end else begin
            xi <= input_activation[addr];
            wi <= weights[addr];
            ti <= threshold[addr];
        end     
	end
	
	(* keep_hierarchy = "yes" *) xnor_popcount #(N) dut (clk, rstn, xi, wi, ti, out);

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
    wire [$clog2(N):0] yi;

	xnor_popcount_verilog_2 #(N,$clog2(N)+1) xnor_pop (xi, wi, yi);
    
    // Final summation
    always @ (posedge clk) begin
        if (rstn) begin
            sum <= 0;
        end
        else begin
            sum <= sum + yi;
        end
    end
	
	// Output 1 if above threshold
	assign out = (sum > ti)? 1'b1 : 1'b0;

endmodule

// Parametrized XNOR-pop
module xnor_popcount_generic(xi, wi, yi);
  parameter N = 128;
  parameter D = 8;
  input [N-1:0]xi; 
  input [N-1:0]wi; 
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
			for (g = 0; g < P; g = g + 1) begin: gen_xnor_pop_3
        if (g == P-1) begin
			    xnor_popcount_3 xnorpop3 ({xi[g*3+:1], 2'b00}, {wi[g*3+:1], 2'b00}, partial_sum[g*2+:2]);
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
module xnor_popcount_verilog_2 (xi, wi, yi);
  parameter N = 128;
  parameter D = 8;
	localparam P = (N/2);
	
  input [N-1:0]xi; 
  input [N-1:0]wi; 
  output reg [D-1:0]yi /* synthesis preserve*/; 
  
	wire [(P*2)-1:0] partial_sum;
	
	// Generate N/2 2-XNOR-pop
	genvar g;
	generate
    	for (g = 0; g < P; g = g + 1) begin: gen_xnor_pop_2
    	   (* keep_hierarchy = "yes" *)  xnor_popcount_2 xnorpop2 (xi[g*2+:2], wi[g*2+:2], partial_sum[g*2+:2]);
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

module xnor_popcount_2 (x, w, y);
	input [1:0] x;
	input [1:0] w;
	output reg [1:0] y;
	
	always @ (*) begin
			y = x[0]~^w[0] + x[1]~^w[1];
	end

endmodule
