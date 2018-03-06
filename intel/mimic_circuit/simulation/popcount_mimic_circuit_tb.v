`timescale 1ns/100ps

/*
    popcount mimic circuit testbench
    this module compares 3 versions of xnorpop:
      - desired xnorpop
      - desired xnorpop with FA (this allows for a quick switch between s and cout)
      - desired xnorpop golden
*/

module popcount_mimic_circuit_tb();

  reg [127:0] top_inx;
  reg [127:0] top_iny;
  wire [7:0] top_sum;
  wire [7:0] golden_sum;

  reg [19:0] inx;
  reg [19:0] iny;
  wire [6:0] sum;
  wire [6:0] sum_fa;
  wire [6:0] sum_golden;

  wire match;

  initial begin

    inx = 20'h00000;
    iny = 20'h00000;
    top_inx = 128'h00000000000000000000000000000000;
    top_iny = 128'hFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;
  
    #10

    inx = 20'h00000;
    iny = 20'h00001;
    top_inx = 128'h00000000000000000000000000000000;
    top_iny = 128'h00000000000000000000000000000000;
    
    #10

    inx = 20'h00000;
    iny = 20'hfffff;
    top_inx = 128'h00000000000000000000000000000000;
    top_iny = 128'h11111111111111111111111111111111;

    #10

    inx = 20'h00000;
    iny = 20'hBBBBB;
    top_inx = 128'h00000000000000000000000000000000;
    top_iny = 128'h33333333333333333333333333333333;

    #10

    inx = 20'h01234;
    iny = 20'h43210;
    top_inx = 128'h00000000000000000000000000000000;
    top_iny = 128'h12345678123456781234567812345678;
  end

  popcount_mimic_circuit dut (.inx(top_inx), .iny(top_iny), .sum(top_sum)); 
  xnorpop128_golden dut_golden(.x(top_inx), .y(top_iny), .sum(golden_sum));

  //xnorpop20 dut(.x(inx), .y(iny), .s0(sum[6]), .s1(sum[5]), .cout(sum[4:0]));
  //xnorpop20_fa dut_fa(.x(inx), .y(iny), .s0(sum_fa[6]), .s1(sum_fa[5]), .cout(sum_fa[4:0]));
  //xnorpop20_golden dut_golden(.x(inx), .y(iny), .sum(sum_golden));

  compare #(8) match_check (.x(top_sum), .y(golden_sum), .match(match));

endmodule

module compare(x, y, match);
  parameter N = 7;
  input [N-1:0]x;
  input [N-1:0]y;
  output reg match;

  always @ (*) begin
    match = x == y? 1:0;
  end

endmodule

module xnorpop20_golden (x, y, sum);
	input [19:0]x;
	input [19:0]y;
	output reg [6:0]sum;

  wire [19:0] xnor_out;
 
  assign xnor_out = x ~^ y;

  integer i;

 
  always @ (*) begin
    sum = 0;
    for (i = 0; i < 20; i=i+1) begin
      sum = sum + xnor_out[i];
    end
  end

endmodule	

module xnorpop128_golden (x, y, sum);
  input [127:0]x;
  input [127:0]y;
  output reg [7:0]sum;

  wire [127:0]xnor_out;
  assign xnor_out = x ~^ y;

  integer i;
  
  always @ (*) begin
    sum = 0;
    for (i = 0; i < 128; i=i+1) begin
      sum = sum + xnor_out[i];
    end
  end

endmodule
  
