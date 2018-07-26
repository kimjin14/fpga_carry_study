/////////////////////////////////////////////////////
///////////////////// clb /////////////////////////
/////////////////////////////////////////////////////
module clb (
	input [12:0]I1,
	input [12:0]I2,
	input [12:0]I3,
	input [12:0]I4,
	input [0:0]clk,
	input reset,
	output [19:0]O,
	input config_clk,
	input config_rst,
	input config_input,
	input add_config_input,
	output reg config_output,

	//input c2in,
	//output c2out,

	//input sin,
	//output sout,

	input cin,
	output cout

);

reg [1149:0]config_in;
reg [9:0]add_config_in;

always @ (posedge config_clk) begin
	if (!config_rst) begin
		config_in <= {config_in[1148:0], config_input};
		add_config_in <= {add_config_in[8:0], add_config_input};
	end
end

wire ground;
////////child (0,0,0)////////
wire [7:0]in_fle_0;//input to child
wire [0:0]clk_fle_0;//clock to child
wire [1:0]out_fle_0;//output from child
////////child (0,0,1)////////
wire [7:0]in_fle_1;//input to child
wire [0:0]clk_fle_1;//clock to child
wire [1:0]out_fle_1;//output from child
////////child (0,0,2)////////
wire [7:0]in_fle_2;//input to child
wire [0:0]clk_fle_2;//clock to child
wire [1:0]out_fle_2;//output from child
////////child (0,0,3)////////
wire [7:0]in_fle_3;//input to child
wire [0:0]clk_fle_3;//clock to child
wire [1:0]out_fle_3;//output from child
////////child (0,0,4)////////
wire [7:0]in_fle_4;//input to child
wire [0:0]clk_fle_4;//clock to child
wire [1:0]out_fle_4;//output from child
////////child (0,0,5)////////
wire [7:0]in_fle_5;//input to child
wire [0:0]clk_fle_5;//clock to child
wire [1:0]out_fle_5;//output from child
////////child (0,0,6)////////
wire [7:0]in_fle_6;//input to child
wire [0:0]clk_fle_6;//clock to child
wire [1:0]out_fle_6;//output from child
////////child (0,0,7)////////
wire [7:0]in_fle_7;//input to child
wire [0:0]clk_fle_7;//clock to child
wire [1:0]out_fle_7;//output from child
////////child (0,0,8)////////
wire [7:0]in_fle_8;//input to child
wire [0:0]clk_fle_8;//clock to child
wire [1:0]out_fle_8;//output from child
////////child (0,0,9)////////
wire [7:0]in_fle_9;//input to child
wire [0:0]clk_fle_9;//clock to child
wire [1:0]out_fle_9;//output from child
 
mux37 mux_0 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in [(0+(0*6))+:6]), .config_rst(config_rst), .out(in_fle_0[0]) );
mux37 mux_8 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in [(0+(1*6))+:6]), .config_rst(config_rst), .out(in_fle_0[1]) );
mux37 mux_16 ( .in({I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[(0+(2*6))+:6]), .config_rst(config_rst), .out(in_fle_0[2]) );
mux37 mux_24 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[(0+(3*6))+:6]), .config_rst(config_rst), .out(in_fle_0[3]) );
mux37 mux_32 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[(0+(4*6))+:6]), .config_rst(config_rst), .out(in_fle_0[4]) );
mux37 mux_40 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[(0+(5*6))+:6]), .config_rst(config_rst), .out(in_fle_0[5]) );
mux37 mux_48 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[(0+(6*6))+:6]), .config_rst(config_rst), .out(in_fle_0[6]) );
mux37 mux_56 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[(0+(7*6))+:6]), .config_rst(config_rst), .out(in_fle_0[7]) );
assign clk_fle_0[0] = clk[0];
 

mux37 mux_196 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[(48+(0*6))+:6]), .config_rst(config_rst), .out(in_fle_1[0]) );
mux37 mux_204 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[(48+(1*6))+:6]), .config_rst(config_rst), .out(in_fle_1[1]) );
mux37 mux_212 ( .in({I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[(48+(2*6))+:6]), .config_rst(config_rst), .out(in_fle_1[2]) );
mux37 mux_220 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[(48+(3*6))+:6]), .config_rst(config_rst), .out(in_fle_1[3]) );
mux37 mux_228 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[(48+(4*6))+:6]), .config_rst(config_rst), .out(in_fle_1[4]) );
mux37 mux_236 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[(48+(5*6))+:6]), .config_rst(config_rst), .out(in_fle_1[5]) );
mux37 mux_244 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[(48+(6*6))+:6]), .config_rst(config_rst), .out(in_fle_1[6]) );
mux37 mux_252 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[(48+(7*6))+:6]), .config_rst(config_rst), .out(in_fle_1[7]) );
assign clk_fle_1[0] = clk[0];
 

mux37 mux_392 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[(96+(0*6))+:6]), .config_rst(config_rst), .out(in_fle_2[0]) );
mux37 mux_400 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[(96+(1*6))+:6]), .config_rst(config_rst), .out(in_fle_2[1]) );
mux37 mux_408 ( .in({I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[(96+(2*6))+:6]), .config_rst(config_rst), .out(in_fle_2[2]) );
mux37 mux_416 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[(96+(3*6))+:6]), .config_rst(config_rst), .out(in_fle_2[3]) );
mux37 mux_424 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[(96+(4*6))+:6]), .config_rst(config_rst), .out(in_fle_2[4]) );
mux37 mux_432 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[(96+(5*6))+:6]), .config_rst(config_rst), .out(in_fle_2[5]) );
mux37 mux_440 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[(96+(6*6))+:6]), .config_rst(config_rst), .out(in_fle_2[6]) );
mux37 mux_448 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[(96+(7*6))+:6]), .config_rst(config_rst), .out(in_fle_2[7]) );
assign clk_fle_2[0] = clk[0];
 

mux37 mux_588 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[(144+(0*6))+:6]), .config_rst(config_rst), .out(in_fle_3[0]) );
mux37 mux_596 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[(144+(1*6))+:6]), .config_rst(config_rst), .out(in_fle_3[1]) );
mux37 mux_604 ( .in({I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[(144+(2*6))+:6]), .config_rst(config_rst), .out(in_fle_3[2]) );
mux37 mux_612 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[(144+(3*6))+:6]), .config_rst(config_rst), .out(in_fle_3[3]) );
mux37 mux_620 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[(144+(4*6))+:6]), .config_rst(config_rst), .out(in_fle_3[4]) );
mux37 mux_628 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[(144+(5*6))+:6]), .config_rst(config_rst), .out(in_fle_3[5]) );
mux37 mux_636 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[(144+(6*6))+:6]), .config_rst(config_rst), .out(in_fle_3[6]) );
mux37 mux_644 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[(144+(7*6))+:6]), .config_rst(config_rst), .out(in_fle_3[7]) );
assign clk_fle_3[0] = clk[0];
 

mux37 mux_784 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[(192+(0*6))+:6]), .config_rst(config_rst), .out(in_fle_4[0]) );
mux37 mux_792 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[(192+(1*6))+:6]), .config_rst(config_rst), .out(in_fle_4[1]) );
mux37 mux_800 ( .in({I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[(192+(2*6))+:6]), .config_rst(config_rst), .out(in_fle_4[2]) );
mux37 mux_808 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[(192+(3*6))+:6]), .config_rst(config_rst), .out(in_fle_4[3]) );
mux37 mux_816 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[(192+(4*6))+:6]), .config_rst(config_rst), .out(in_fle_4[4]) );
mux37 mux_824 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[(192+(5*6))+:6]), .config_rst(config_rst), .out(in_fle_4[5]) );
mux37 mux_832 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[(192+(6*6))+:6]), .config_rst(config_rst), .out(in_fle_4[6]) );
mux37 mux_840 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[(192+(7*6))+:6]), .config_rst(config_rst), .out(in_fle_4[7]) );
assign clk_fle_4[0] = clk[0];
 

mux37 mux_980 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in [(240+(0*6))+:6]), .config_rst(config_rst), .out(in_fle_5[0]) );
mux37 mux_988 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in [(240+(1*6))+:6]), .config_rst(config_rst), .out(in_fle_5[1]) );
mux37 mux_996 ( .in({I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in [(240+(2*6))+:6]), .config_rst(config_rst), .out(in_fle_5[2]) );
mux37 mux_1004 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[(240+(3*6))+:6]), .config_rst(config_rst), .out(in_fle_5[3]) );
mux37 mux_1012 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[(240+(4*6))+:6]), .config_rst(config_rst), .out(in_fle_5[4]) );
mux37 mux_1020 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[(240+(5*6))+:6]), .config_rst(config_rst), .out(in_fle_5[5]) );
mux37 mux_1028 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[(240+(6*6))+:6]), .config_rst(config_rst), .out(in_fle_5[6]) );
mux37 mux_1036 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[(240+(7*6))+:6]), .config_rst(config_rst), .out(in_fle_5[7]) );
assign clk_fle_5[0] = clk[0];
 

mux37 mux_1176 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[(288+(0*6))+:6]), .config_rst(config_rst), .out(in_fle_6[0]) );
mux37 mux_1184 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[(288+(1*6))+:6]), .config_rst(config_rst), .out(in_fle_6[1]) );
mux37 mux_1192 ( .in({I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[(288+(2*6))+:6]), .config_rst(config_rst), .out(in_fle_6[2]) );
mux37 mux_1200 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[(288+(3*6))+:6]), .config_rst(config_rst), .out(in_fle_6[3]) );
mux37 mux_1208 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[(288+(4*6))+:6]), .config_rst(config_rst), .out(in_fle_6[4]) );
mux37 mux_1216 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[(288+(5*6))+:6]), .config_rst(config_rst), .out(in_fle_6[5]) );
mux37 mux_1224 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[(288+(6*6))+:6]), .config_rst(config_rst), .out(in_fle_6[6]) );
mux37 mux_1232 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[(288+(7*6))+:6]), .config_rst(config_rst), .out(in_fle_6[7]) );
assign clk_fle_6[0] = clk[0];
 

mux37 mux_1372 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[(336+(0*6))+:6]), .config_rst(config_rst), .out(in_fle_7[0]) );
mux37 mux_1380 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[(336+(1*6))+:6]), .config_rst(config_rst), .out(in_fle_7[1]) );
mux37 mux_1388 ( .in({I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[(336+(2*6))+:6]), .config_rst(config_rst), .out(in_fle_7[2]) );
mux37 mux_1396 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[(336+(3*6))+:6]), .config_rst(config_rst), .out(in_fle_7[3]) );
mux37 mux_1404 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[(336+(4*6))+:6]), .config_rst(config_rst), .out(in_fle_7[4]) );
mux37 mux_1412 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[(336+(5*6))+:6]), .config_rst(config_rst), .out(in_fle_7[5]) );
mux37 mux_1420 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[(336+(6*6))+:6]), .config_rst(config_rst), .out(in_fle_7[6]) );
mux37 mux_1428 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[(336+(7*6))+:6]), .config_rst(config_rst), .out(in_fle_7[7]) );
assign clk_fle_7[0] = clk[0];
 

mux37 mux_1568 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[(384+(0*6))+:6]), .config_rst(config_rst), .out(in_fle_8[0]) );
mux37 mux_1576 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[(384+(1*6))+:6]), .config_rst(config_rst), .out(in_fle_8[1]) );
mux37 mux_1584 ( .in({I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[(384+(2*6))+:6]), .config_rst(config_rst), .out(in_fle_8[2]) );
mux37 mux_1592 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[(384+(3*6))+:6]), .config_rst(config_rst), .out(in_fle_8[3]) );
mux37 mux_1600 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[(384+(4*6))+:6]), .config_rst(config_rst), .out(in_fle_8[4]) );
mux37 mux_1608 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[(384+(5*6))+:6]), .config_rst(config_rst), .out(in_fle_8[5]) );
mux37 mux_1616 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[(384+(6*6))+:6]), .config_rst(config_rst), .out(in_fle_8[6]) );
mux37 mux_1624 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[(384+(7*6))+:6]), .config_rst(config_rst), .out(in_fle_8[7]) );
assign clk_fle_8[0] = clk[0];
 

mux37 mux_1764 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[(432+(0*6))+:6]), .config_rst(config_rst), .out(in_fle_9[0]) );
mux37 mux_1772 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[(432+(1*6))+:6]), .config_rst(config_rst), .out(in_fle_9[1]) );
mux37 mux_1780 ( .in({I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[(432+(2*6))+:6]), .config_rst(config_rst), .out(in_fle_9[2]) );
mux37 mux_1788 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[(432+(3*6))+:6]), .config_rst(config_rst), .out(in_fle_9[3]) );
mux37 mux_1796 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[(432+(4*6))+:6]), .config_rst(config_rst), .out(in_fle_9[4]) );
mux37 mux_1804 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_6[0], out_fle_6[1], out_fle_7[0], out_fle_7[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[(432+(5*6))+:6]), .config_rst(config_rst), .out(in_fle_9[5]) );
mux37 mux_1812 ( .in({I4[0], I4[1], I4[2], I4[3], I4[4], I4[5], I4[6], I4[7], I4[8], I4[9], I4[10], I4[11], I4[12], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], out_fle_0[0], out_fle_0[1], out_fle_1[0], out_fle_1[1], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_8[0], out_fle_8[1], ground}), .config_in(config_in[(432+(6*6))+:6]), .config_rst(config_rst), .out(in_fle_9[6]) );
mux37 mux_1820 ( .in({I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], out_fle_2[0], out_fle_2[1], out_fle_3[0], out_fle_3[1], out_fle_4[0], out_fle_4[1], out_fle_5[0], out_fle_5[1], out_fle_9[0], out_fle_9[1], ground}), .config_in(config_in[(432+(7*6))+:6]), .config_rst(config_rst), .out(in_fle_9[7]) );
assign clk_fle_9[0] = clk[0];

wire [9:0]carry;
wire [9:0]sum;
wire [9:0]sum2;
wire [9:0]carry2;
 
fle fle_0 (/*.cbit2(add_config_in[12]), .c2in(     c2in), .c2out(carry2[0]), .cbit(add_config_in[10]), .sin(   sin), .sout(sum[0]),*/ .cin(     cin), .cout(carry[0]), .add_config_in(add_config_in[0]), .clk(clk_fle_0), .reset(reset), .in(in_fle_0), .out(out_fle_0), .config_in(config_in[480+:67]), .config_rst(config_rst) ); //block instantiation
fle fle_1 (/*.cbit2(add_config_in[12]), .c2in(carry2[0]), .c2out(carry2[1]), .cbit(add_config_in[10]), .sin(sum[0]), .sout(sum[1]),*/ .cin(carry[0]), .cout(carry[1]), .add_config_in(add_config_in[1]), .clk(clk_fle_1), .reset(reset), .in(in_fle_1), .out(out_fle_1), .config_in(config_in[547+:67]), .config_rst(config_rst) ); //block instantiation
fle fle_2 (/*.cbit2(add_config_in[12]), .c2in(carry2[1]), .c2out(carry2[2]), .cbit(add_config_in[10]), .sin(sum[1]), .sout(sum[2]),*/ .cin(carry[1]), .cout(carry[2]), .add_config_in(add_config_in[2]), .clk(clk_fle_2), .reset(reset), .in(in_fle_2), .out(out_fle_2), .config_in(config_in[614+:67]), .config_rst(config_rst) ); //block instantiation
fle fle_3 (/*.cbit2(add_config_in[12]), .c2in(carry2[2]), .c2out(carry2[3]), .cbit(add_config_in[10]), .sin(sum[2]), .sout(sum[3]),*/ .cin(carry[2]), .cout(carry[3]), .add_config_in(add_config_in[3]), .clk(clk_fle_3), .reset(reset), .in(in_fle_3), .out(out_fle_3), .config_in(config_in[681+:67]), .config_rst(config_rst) ); //block instantiation
fle fle_4 (/*.cbit2(add_config_in[12]), .c2in(carry2[3]), .c2out(carry2[4]), .cbit(add_config_in[10]), .sin(sum[3]), .sout(sum[4]),*/ .cin(carry[3]), .cout(carry[4]), .add_config_in(add_config_in[4]), .clk(clk_fle_4), .reset(reset), .in(in_fle_4), .out(out_fle_4), .config_in(config_in[748+:67]), .config_rst(config_rst) ); //block instantiation
fle fle_5 (/*.cbit2(add_config_in[13]), .c2in(carry2[4]), .c2out(carry2[5]), .cbit(add_config_in[11]), .sin(sum[4]), .sout(sum[5]),*/ .cin(carry[4]), .cout(carry[5]), .add_config_in(add_config_in[5]), .clk(clk_fle_5), .reset(reset), .in(in_fle_5), .out(out_fle_5), .config_in(config_in[815+:67]), .config_rst(config_rst) ); //block instantiation
fle fle_6 (/*.cbit2(add_config_in[13]), .c2in(carry2[5]), .c2out(carry2[6]), .cbit(add_config_in[11]), .sin(sum[5]), .sout(sum[6]),*/ .cin(carry[5]), .cout(carry[6]), .add_config_in(add_config_in[6]), .clk(clk_fle_6), .reset(reset), .in(in_fle_6), .out(out_fle_6), .config_in(config_in[882+:67]), .config_rst(config_rst) ); //block instantiation
fle fle_7 (/*.cbit2(add_config_in[13]), .c2in(carry2[6]), .c2out(carry2[7]), .cbit(add_config_in[11]), .sin(sum[6]), .sout(sum[7]),*/ .cin(carry[6]), .cout(carry[7]), .add_config_in(add_config_in[7]), .clk(clk_fle_7), .reset(reset), .in(in_fle_7), .out(out_fle_7), .config_in(config_in[949+:67]), .config_rst(config_rst) ); //block instantiation
fle fle_8 (/*.cbit2(add_config_in[13]), .c2in(carry2[7]), .c2out(carry2[8]), .cbit(add_config_in[11]), .sin(sum[7]), .sout(sum[8]),*/ .cin(carry[7]), .cout(carry[8]), .add_config_in(add_config_in[8]), .clk(clk_fle_8), .reset(reset), .in(in_fle_8), .out(out_fle_8), .config_in(config_in[1016+:67]), .config_rst(config_rst) ); //block instantiation
fle fle_9 (/*.cbit2(add_config_in[13]), .c2in(carry2[8]), .c2out(carry2[9]), .cbit(add_config_in[11]), .sin(sum[8]), .sout(sum[9]),*/ .cin(carry[8]), .cout(carry[9]), .add_config_in(add_config_in[9]), .clk(clk_fle_9), .reset(reset), .in(in_fle_9), .out(out_fle_9), .config_in(config_in[1083+:67]), .config_rst(config_rst) ); //block instantiation

//assign c2out = carry2[9];
assign cout = carry[9];
//assign sout = sum[9];

//child output to block output
assign O[0] = out_fle_0[0];
assign O[1] = out_fle_1[0];
assign O[2] = out_fle_2[0];
assign O[3] = out_fle_3[0];
assign O[4] = out_fle_4[0];
assign O[5] = out_fle_5[0];
assign O[6] = out_fle_6[0];
assign O[7] = out_fle_7[0];
assign O[8] = out_fle_8[0];
assign O[9] = out_fle_9[0];
assign O[10] = out_fle_0[1];
assign O[11] = out_fle_1[1];
assign O[12] = out_fle_2[1];
assign O[13] = out_fle_3[1];
assign O[14] = out_fle_4[1];
assign O[15] = out_fle_5[1];
assign O[16] = out_fle_6[1];
assign O[17] = out_fle_7[1];
assign O[18] = out_fle_8[1];
assign O[19] = out_fle_9[1];

assign ground = 1'b0;

endmodule

/////////////////////////////////////////////////////
/////////////////////// fle /////////////////////////
/////////////////////////////////////////////////////
module fle (
	input [7:0]in,
	input [66:0]config_in,
	input config_rst,
	input clk,
	input reset,
	output [1:0]out, 
	
	//input sin,
	//output sout,
	//input c2in,
	//output c2out,
	//input cbit,
	//input cbit2,
	input cin,
	output cout,
	input [0:0]add_config_in
);

wire out_lut4_0;
wire out_lut4_1;
wire out_lut4_2;
wire out_lut4_3;

wire in_4;
wire in_5;

wire sum_0, sum_1;
wire out_fle_0, out_fle_1;

//assign in_4 = config_in[64]?in[2]:in[4];
//assign in_5 = config_in[64]?in[3]:in[5];

mux2_inner fracture_lut_in_4 ( .config_in(config_in[64]), .config_rst(1'b0), .in({in[4], in[2]}), .out(in_4) );
mux2_inner fracture_lut_in_5 ( .config_in(config_in[64]), .config_rst(1'b0), .in({in[5], in[3]}), .out(in_5) );

lut4 lut4_0 ( .config_in(config_in[15:0]), .config_rst(config_rst), .in(in[3:0]), .out(out_lut4_0) );
lut4 lut4_1 ( .config_in(config_in[31:16]), .config_rst(config_rst), .in(in[3:0]), .out(out_lut4_1) );
lut4 lut4_2 ( .config_in(config_in[47:32]), .config_rst(config_rst), .in({in_5, in_4, in[1:0]}), .out(out_lut4_2) );
lut4 lut4_3 ( .config_in(config_in[63:48]), .config_rst(config_rst), .in({in_5, in_4, in[1:0]}), .out(out_lut4_3) );

wire out_lut5_0;
wire out_lut5_1;
wire out_lut6;

mux2_lut5_0 lut5_0_0 ( .config_in(in[6]), .config_rst(config_rst), .in({out_lut4_1, out_lut4_0}), .out(out_lut5_0) ); //[6][3][2][1][0]
mux2_lut5_0 lut5_0_1 ( .config_in(in[6]), .config_rst(config_rst), .in({out_lut4_3, out_lut4_2}), .out(out_lut5_1) ); 
mux2_lut6 lut6 ( .config_in(in[7]), .config_rst(config_rst), .in({out_lut5_1, out_lut5_0}), .out(out_lut6) ); //[7][6][3][2][1][0]

wire out_lut_0;
wire out_lut_1;
wire out_ff_0;
wire out_ff_1;

mux2_flut fracture_lut ( .config_in(config_in[64]), .config_rst(config_rst), .in({out_lut5_0, out_lut6}), .out(out_lut_0) ); 
mux2_lut5_1 lut5_1 ( .config_in(in[7]), .config_rst(config_rst), .in({out_lut4_3, out_lut4_2}), .out(out_lut_1) ); //[7][5][4][1][0]

ff ff_0 ( .D(out_fle_0), .clk(clk), .Q(out_ff_0) );
ff ff_1 ( .D(out_fle_1), .clk(clk), .Q(out_ff_1) );

mux2_bypass mux_bypass_0 ( .config_in(config_in[65]), .config_rst(config_rst), .in({out_ff_0, out_fle_0}), .out(out[0]) );
mux2_bypass mux_bypass_1 ( .config_in(config_in[66]), .config_rst(config_rst), .in({out_ff_1, out_fle_1}), .out(out[1]) );


// Adding Carry Chain to FLE

carrychain cc0 (
	.cin(cin),
	.cout (cout),
	//.cbit(cbit),
	//.cbit2(cbit2),
	//.sin(sin),
	//.sout(sout),
	//.c2in(c2in),
	//.c2out(c2out),
	.data({out_lut4_3, out_lut4_2, out_lut4_1, out_lut4_0}),
	.sum({sum_1, sum_0})
);

mux2_adder mux_add_0 (.config_in(add_config_in[0]), .config_rst(config_rst), .in({sum_0, out_lut_0}), .out(out_fle_0));
mux2_adder mux_add_1 (.config_in(add_config_in[0]), .config_rst(config_rst), .in({sum_1, out_lut_1}), .out(out_fle_1));

endmodule


/////////////////////////////////////////////////////
/////////////////// carrychain //////////////////////
/////////////////////////////////////////////////////
module carrychain (
	input [3:0]data,
	input cin,
	output [1:0]sum,
	output cout
);

wire cout_t;

adder fa0 (.x(data[0]), .y(data[1]), .cin(cin), .cout(cout_t), .s(sum[0]));
adder fa1 (.x(data[2]), .y(data[3]), .cin(cout_t), .cout(cout), .s(sum[1]));

endmodule

module carrychain_1a (
	input [3:0]data,
	input cin,
	input cbit,
	output [1:0]sum,
	output cout
);


wire [1:0] carryout;
wire [1:0] sout;
wire [1:0] carryin;

wire cin_t;

adder fa0 (.x(data[0]), .y(data[1]), .cin(carryin[0]), .cout(carryout[0]), .s(sout[0]));
adder fa1 (.x(data[2]), .y(data[3]), .cin(carryin[1]), .cout(carryout[1]), .s(sout[1]));

assign sum[0] = cbit ? carryout[0] : sout[0];
assign sum[1] = cbit ? carryout[1] : sout[1];
assign carryin[0] = cin;
assign carryin[1] = cbit ? sout[0] : carryout[0];
assign cout = cbit ? sout[1] : carryout[1];

endmodule

module carrychain_1b (
	input [3:0]data,
	input cin,
	input sin,
	input cbit,
	output [1:0]sum,
	output cout,
	output sout
);


wire [1:0] carryout;
wire [1:0] sumout;

wire cout_t, sout_t; 

adder fa0 (.x(data[0]), .y(data[1]), .cin(cin), .cout(cout_t), .s(sumout[0]));
adder fa1 (.x(data[2]), .y(data[3]), .cin(cout_t), .cout(cout), .s(sumout[1]));

adder fa2 (.x(data[0]), .y(data[1]), .cin(sin), .cout(carryout[0]), .s(sout_t));
adder fa3 (.x(data[2]), .y(data[3]), .cin(sout_t), .cout(carryout[1]), .s(sout));


assign sum[0] = cbit ? carryout[0] : sumout[0];
assign sum[1] = cbit ? carryout[1] : sumout[1];

endmodule
module carrychain_2a (
	input [3:0]data,
	input cin,
	input c2in,
	input cbit,
	output [1:0]sum,
	output cout,
	output c2out
);

wire [1:0] carryout;
wire [1:0] sout;
wire [1:0] carryin;

wire cin_t;

assign carryin[0] = cin;

adder fa0 (.x(data[0]), .y(data[1]), .cin(carryin[0]), .cout(carryout[0]), .s(sout[0]));
adder fa1 (.x(data[2]), .y(data[3]), .cin(carryin[1]), .cout(carryout[1]), .s(sout[1]));

wire [1:0]int_sum;

assign int_sum[0] = cbit ? carryout[0] : sout[0];
assign int_sum[1] = cbit ? carryout[1] : sout[1];
assign carryin[1] = cbit ? sout[0] : carryout[0];
assign cout = cbit ? sout[1] : carryout[1];

wire fa2_sum;

adder fa2 (.x(int_sum[0]), .y(int_sum[1]), .cin(c2in), .cout(fa2_sum), .s(c2out));

assign sum[0] = int_sum[0];
assign sum[1] = cbit? fa2_sum: int_sum[1];

endmodule

module carrychain_2b (
	input [3:0]data,
	input cbit,
	input cbit2,
	output [1:0]sum,
	input cin,
	input c2in,
	input sin,
	output cout,
	output c2out,
	output sout
);

wire [1:0] carryout;
wire [1:0] sumout;

wire cout_t, sout_t; 
wire sumout2;

adder fa0 (.x(data[0]), .y(data[1]), .cin(cin), .cout(cout_t), .s(sumout[0]));
adder fa1 (.x(data[2]), .y(data[3]), .cin(cout_t), .cout(cout), .s(sumout[1]));

adder fa2 (.x(data[0]), .y(data[1]), .cin(sin), .cout(carryout[0]), .s(sout_t));
adder fa3 (.x(data[2]), .y(data[3]), .cin(sout_t), .cout(carryout[1]), .s(sout));

adder fa4 (.x(sout_t), .y(sout), .cin(c2in), .cout(sumout2), .s(c2out));

wire tempsum;
assign sum[0] = cbit ? carryout[0] : sumout[0];
assign tempsum = cbit ? carryout[1] : sumout[1];
assign sum[1] = cbit2 ? tempsum : sumout[1];

endmodule



/////////////////////////////////////////////////////
///////////////////// adder /////////////////////////
/////////////////////////////////////////////////////
module adder(x,y,cin,cout,s);

input x, y, cin;
output s, cout;

assign {cout,s} = x+y+cin;

endmodule


/////////////////////////////////////////////////////
///////////////////// ff /////////////////////////
/////////////////////////////////////////////////////
module ff ( input D, input reset, input clk, output reg Q );

always @ (posedge clk) begin
	if (!reset)
		Q <= 1'b0;
	else
		Q <= D;
end

endmodule

/////////////////////////////////////////////////////
///////////////////// mux2_inner /////////////////////////
/////////////////////////////////////////////////////
module mux2_lut5_0(
	input [1:0]in,
	input [0:0]config_in,
	input config_rst,
	output out
);

assign out = config_in[0]? in[1] : in[0];

endmodule
module mux2_lut5_1 (
	input [1:0]in,
	input [0:0]config_in,
	input config_rst,
	output out
);

assign out = config_in[0]? in[1] : in[0];

endmodule
module mux2_flut (
	input [1:0]in,
	input [0:0]config_in,
	input config_rst,
	output out
);

assign out = config_in[0]? in[1] : in[0];

endmodule
module mux2_lut6 (
	input [1:0]in,
	input [0:0]config_in,
	input config_rst,
	output out
);

assign out = config_in[0]? in[1] : in[0];

endmodule
module mux2_bypass (
	input [1:0]in,
	input [0:0]config_in,
	input config_rst,
	output out
);

assign out = config_in[0]? in[1] : in[0];

endmodule
module mux2_adder (
	input [1:0]in,
	input [0:0]config_in,
	input config_rst,
	output out
);

assign out = config_in[0]? in[1] : in[0];

endmodule
module mux2_swap (
	input [1:0]in,
	input [0:0]config_in,
	input config_rst,
	output out
);

assign out = config_in[0]? in[1] : in[0];

endmodule

module mux2_inner (
	input [1:0]in,
	input [0:0]config_in,
	input config_rst,
	output reg out
);

always @ (*) begin
	if (config_rst) begin
		out = 1'b1;
	end else begin
		case(config_in)
			1'd0: out = in[0];
			1'd1: out = in[1];
			default: out = 1'b1;
		endcase
	end
end

endmodule

/////////////////////////////////////////////////////
/////////////////////// lut /////////////////////////
/////////////////////////////////////////////////////
module lut4 ( 
	input [15:0]config_in, 
	input config_rst, 
	input [3:0]in, 
	output reg out
);

wire [3:0]in_flip;
assign in_flip = {in[0], in[1], in[2], in[3]};

always @ (*) begin
	if (config_rst) begin
		out = 1'b1;
	end else begin
		case(in)
			4'd0: out = config_in[0];
			4'd1: out = config_in[1];
			4'd2: out = config_in[2];
			4'd3: out = config_in[3];
			4'd4: out = config_in[4];
			4'd5: out = config_in[5];
			4'd6: out = config_in[6];
			4'd7: out = config_in[7];
			4'd8: out = config_in[8];
			4'd9: out = config_in[9];
			4'd10: out = config_in[10];
			4'd11: out = config_in[11];
			4'd12: out = config_in[12];
			4'd13: out = config_in[13];
			4'd14: out = config_in[14];
			4'd15: out = config_in[15];
		endcase
	end
end

endmodule

/////////////////////////////////////////////////////
////////////////////// mux37/////////////////////////
/////////////////////////////////////////////////////
module mux37 (
	input [36:0]in,
	output reg out,
	input [5:0]config_in,
	input config_rst
);

always @ (*) begin: MUX
	case(config_in)
		6'd0: out = in[0];
		6'd1: out = in[1];
		6'd2: out = in[2];
		6'd3: out = in[3];
		6'd4: out = in[4];
		6'd5: out = in[5];
		6'd6: out = in[6];
		6'd7: out = in[7];
		6'd8: out = in[8];
		6'd9: out = in[9];
		6'd10: out = in[10];
		6'd11: out = in[11];
		6'd12: out = in[12];
		6'd13: out = in[13];
		6'd14: out = in[14];
		6'd15: out = in[15];
		6'd16: out = in[16];
		6'd17: out = in[17];
		6'd18: out = in[18];
		6'd19: out = in[19];
		6'd20: out = in[20];
		6'd21: out = in[21];
		6'd22: out = in[22];
		6'd23: out = in[23];
		6'd24: out = in[24];
		6'd25: out = in[25];
		6'd26: out = in[26];
		6'd27: out = in[27];
		6'd28: out = in[28];
		6'd29: out = in[29];
		6'd30: out = in[30];
		6'd31: out = in[31];
		6'd32: out = in[32];
		6'd33: out = in[33];
		6'd34: out = in[34];
		6'd35: out = in[35];
		6'd36: out = in[36];
		default: out = 1'b0;
	endcase
end

endmodule
