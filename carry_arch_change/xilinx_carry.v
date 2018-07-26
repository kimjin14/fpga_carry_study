// 48 inputs to CLB
// 27 inputs to each 

/////////////////////////////////////////////////////
////////////////////// clb  /////////////////////////
/////////////////////////////////////////////////////
module clb (
	input [13:0]I0,
	input [13:0]I1,
	input [13:0]I2,
	input [13:0]I3,
	input [0:0]clk,
	input cin,
	output cout,
	input cin2,
	output cout2,
	input c2in,
	output c2out,
	input c2in2,
	output c2out2,
	input sin,
	output sout,
	input sin2,
	output sout2,
	output [23:0]O,
	input config_input,
	input add_config_input,
	input config_clk,
	input config_rst
);

reg [627:0]config_in;
reg [9:0]add_config_in;

always @ (posedge config_clk) begin
	if (!config_rst) begin
		config_in <= {config_in[626:0], config_input};
		add_config_in <= {add_config_in[8:0], add_config_input};
	end
end


////////child (0,0,0)////////
wire [27:0]in_notfle_0;//input to child
wire [0:0]clk_notfle_0;//clock to child
wire [11:0]out_notfle_0;//output from child
 
////////child (0,0,1)////////
wire [27:0]in_notfle_1;//input to child
wire [0:0]clk_notfle_1;//clock to child
wire [11:0]out_notfle_1;//output from child
 
wire ground;

mux29 mux_0 ( .in({I0[0], I0[1], I0[2], I0[3], I0[4], I0[5], I0[6], I0[7], I0[8], I0[9], I0[10], I0[11], I0[12], I0[13], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], I1[13], ground}),  .config_in(config_in[ 0+:5]), .out(in_notfle_0[0]) );
mux29 mux_6 ( .in({I0[0], I0[1], I0[2], I0[3], I0[4], I0[5], I0[6], I0[7], I0[8], I0[9], I0[10], I0[11], I0[12], I0[13], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], I1[13], ground}),  .config_in(config_in[ 5+:5]), .out(in_notfle_0[1]) );
mux29 mux_12 ( .in({I0[0], I0[1], I0[2], I0[3], I0[4], I0[5], I0[6], I0[7], I0[8], I0[9], I0[10], I0[11], I0[12], I0[13], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], I1[13], ground}), .config_in(config_in[10+:5]), .out(in_notfle_0[2]) );
mux29 mux_18 ( .in({I0[0], I0[1], I0[2], I0[3], I0[4], I0[5], I0[6], I0[7], I0[8], I0[9], I0[10], I0[11], I0[12], I0[13], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], I1[13], ground}), .config_in(config_in[15+:5]), .out(in_notfle_0[3]) );
mux29 mux_24 ( .in({I0[0], I0[1], I0[2], I0[3], I0[4], I0[5], I0[6], I0[7], I0[8], I0[9], I0[10], I0[11], I0[12], I0[13], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], I1[13], ground}), .config_in(config_in[20+:5]), .out(in_notfle_0[4]) );
mux29 mux_30 ( .in({I0[0], I0[1], I0[2], I0[3], I0[4], I0[5], I0[6], I0[7], I0[8], I0[9], I0[10], I0[11], I0[12], I0[13], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], I1[13], ground}), .config_in(config_in[25+:5]), .out(in_notfle_0[5]) );
mux29 mux_36 ( .in({I0[0], I0[1], I0[2], I0[3], I0[4], I0[5], I0[6], I0[7], I0[8], I0[9], I0[10], I0[11], I0[12], I0[13], I1[0], I1[1], I1[2], I1[3], I1[4], I1[5], I1[6], I1[7], I1[8], I1[9], I1[10], I1[11], I1[12], I1[13], ground}), .config_in(config_in[30+:5]), .out(in_notfle_0[6]) );
assign clk_notfle_0[0] = clk[0];
 

mux29 mux_298 ( .in({I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], I2[13], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I3[13], ground}), .config_in(config_in[35+:5]), .out(in_notfle_1[0]) );
mux29 mux_304 ( .in({I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], I2[13], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I3[13], ground}), .config_in(config_in[40+:5]), .out(in_notfle_1[1]) );
mux29 mux_310 ( .in({I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], I2[13], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I3[13], ground}), .config_in(config_in[45+:5]), .out(in_notfle_1[2]) );
mux29 mux_316 ( .in({I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], I2[13], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I3[13], ground}), .config_in(config_in[50+:5]), .out(in_notfle_1[3]) );
mux29 mux_322 ( .in({I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], I2[13], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I3[13], ground}), .config_in(config_in[55+:5]), .out(in_notfle_1[4]) );
mux29 mux_328 ( .in({I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], I2[13], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I3[13], ground}), .config_in(config_in[60+:5]), .out(in_notfle_1[5]) );
mux29 mux_334 ( .in({I2[0], I2[1], I2[2], I2[3], I2[4], I2[5], I2[6], I2[7], I2[8], I2[9], I2[10], I2[11], I2[12], I2[13], I3[0], I3[1], I3[2], I3[3], I3[4], I3[5], I3[6], I3[7], I3[8], I3[9], I3[10], I3[11], I3[12], I3[13], ground}), .config_in(config_in[65+:5]), .out(in_notfle_1[6]) );
assign clk_notfle_1[0] = clk[0];
 
slice slice_0 ( .sin(sin), .sout(sout), 
		.c2in(c2in), .c2out(c2out),
		.cin(cin), .cout(cout), .add_config_in(add_config_in[4:0]), 
		.clk(clk_notfle_0), .in(in_notfle_0), .out(out_notfle_0), 
		.config_in(config_in[348: 70]) ); //block instantiation
slice slice_1 ( .sin(sin2), .sout(sout2),
		.c2in(c2in2), .c2out(c2out2),
		.cin(cin2), .cout(cout2), .add_config_in(add_config_in[9:5]), 
		.clk(clk_notfle_1), .in(in_notfle_1), .out(out_notfle_1), 
		.config_in(config_in[627:349]) ); //block instantiation

//child output to block output
assign O[0] = out_notfle_0[0];
assign O[1] = out_notfle_0[1];
assign O[2] = out_notfle_0[2];
assign O[3] = out_notfle_0[3];
assign O[4] = out_notfle_0[4];
assign O[5] = out_notfle_0[5];
assign O[6] = out_notfle_0[6];
assign O[7] = out_notfle_0[7];
assign O[8] = out_notfle_0[8];
assign O[9] = out_notfle_0[9];
assign O[10] = out_notfle_0[10];
assign O[11] = out_notfle_0[11];
assign O[12] = out_notfle_1[0];
assign O[13] = out_notfle_1[1];
assign O[14] = out_notfle_1[2];
assign O[15] = out_notfle_1[3];
assign O[16] = out_notfle_1[4];
assign O[17] = out_notfle_1[5];
assign O[18] = out_notfle_1[6];
assign O[19] = out_notfle_1[7];
assign O[20] = out_notfle_1[8];
assign O[21] = out_notfle_1[9];
assign O[22] = out_notfle_1[10];
assign O[23] = out_notfle_1[11];

assign ground = 1'b0;

endmodule

/////////////////////////////////////////////////////
///////////////////// notfle /////////////////////////
/////////////////////////////////////////////////////
module slice (
	input [27:0]in,
	input [0:0]clk,
	output [11:0]out,
	input cin,
	output cout,
	input c2in,
	output c2out,
	input sin,
	output sout,
	input [4:0] add_config_in,
	input [278:0]config_in
);

////////child (0,0,0)////////
wire [5:0]in_ble6_0;//input to child
wire [0:0]clk_ble6_0;//clock to child
wire [1:0]out_ble6_0;//output from child
 
////////child (0,0,1)////////
wire [5:0]in_ble6_1;//input to child
wire [0:0]clk_ble6_1;//clock to child
wire [1:0]out_ble6_1;//output from child
 
////////child (0,0,2)////////
wire [5:0]in_ble6_2;//input to child
wire [0:0]clk_ble6_2;//clock to child
wire [1:0]out_ble6_2;//output from child
 
////////child (0,0,3)////////
wire [5:0]in_ble6_3;//input to child
wire [0:0]clk_ble6_3;//clock to child
wire [1:0]out_ble6_3;//output from child
 
wire ground;

assign in_ble6_0[0] = in[0];
assign in_ble6_0[1] = in[1];
assign in_ble6_0[2] = in[2];
assign in_ble6_0[3] = in[3];
assign in_ble6_0[4] = in[4];
assign in_ble6_0[5] = in[5];
assign clk_ble6_0[0] = clk[0];
 
assign in_ble6_1[0] = in[7];
assign in_ble6_1[1] = in[8];
assign in_ble6_1[2] = in[9];
assign in_ble6_1[3] = in[10];
assign in_ble6_1[4] = in[11];
assign in_ble6_1[5] = in[12];
assign clk_ble6_1[0] = clk[0];
 
assign in_ble6_2[0] = in[14];
assign in_ble6_2[1] = in[15];
assign in_ble6_2[2] = in[16];
assign in_ble6_2[3] = in[17];
assign in_ble6_2[4] = in[18];
assign in_ble6_2[5] = in[19];
assign clk_ble6_2[0] = clk[0];
 
assign in_ble6_3[0] = in[21];
assign in_ble6_3[1] = in[22];
assign in_ble6_3[2] = in[23];
assign in_ble6_3[3] = in[24];
assign in_ble6_3[4] = in[25];
assign in_ble6_3[5] = in[26];
assign clk_ble6_3[0] = clk[0];
 
// 4 fracturable LUTs
ble6 ble6_0 ( .clk(clk_ble6_0), .in(in_ble6_0), .out(out_ble6_0), .config_in(config_in[ 63: 0]) ); //block instantiation
ble6 ble6_1 ( .clk(clk_ble6_1), .in(in_ble6_1), .out(out_ble6_1), .config_in(config_in[127:64]) ); //block instantiation
ble6 ble6_2 ( .clk(clk_ble6_2), .in(in_ble6_2), .out(out_ble6_2), .config_in(config_in[191:128]) ); //block instantiation
ble6 ble6_3 ( .clk(clk_ble6_3), .in(in_ble6_3), .out(out_ble6_3), .config_in(config_in[255:192]) ); //block instantiation

// carry chain
wire [3:0] prop;
assign prop = {out_ble6_0[1], out_ble6_1[1], out_ble6_2[1], out_ble6_3[1]};
wire [3:0] gen;
assign gen = {out_ble6_0[0], out_ble6_1[0], out_ble6_2[0], out_ble6_3[0]};
wire [3:0] ix;
assign ix = {in[6], in[13], in[20], in[27]};

wire [3:0] sumout;
wire [3:0] carry;

carrychain_2b carrychain0 (
		.sin_slice(sin), .sout_slice(sout), 
		.add_config_in(add_config_in[4]),
		.c2in(c2in), .c2out_slice(c2out),
		.config_in(add_config_in[3:0]), .cout_slice(cout), 
		.cin(cin), .p(prop), .g(gen), .ix(ix), .sout(sumout), .cout(carry));

// extra MUXing for wider LUTs
wire lut7_bot, lut7_top, lut8;

assign lut7_bot = ix[0]? out_ble6_0[1] : out_ble6_1[1];
assign lut7_top = ix[2]? out_ble6_2[1] : out_ble6_3[1];
assign lut8 = ix[1]? lut7_bot : lut7_top;

// FF
wire D_ff_0, D_ff_1, D_ff_2, D_ff_3;
wire Q_ff_0, Q_ff_1, Q_ff_2, Q_ff_3;

mux6 mux6_out0 (.in({out_ble6_0, ix[0], sumout[0], carry[0], lut7_bot}),
	.out(D_ff_0), .config_in(config_in[258:256]));
mux6 mux6_out1 (.in({out_ble6_1, ix[1], sumout[1], carry[1], lut8}),
	.out(D_ff_1), .config_in(config_in[261:259]));
mux6 mux6_out2 (.in({out_ble6_2, ix[2], sumout[2], carry[2], lut7_top}),
	.out(D_ff_2), .config_in(config_in[264:262]));
mux5 mux5_out3 (.in({out_ble6_3, ix[3], sumout[3], carry[3]}),
	.out(D_ff_3), .config_in(config_in[267:265]));

ff ff_0 ( .clk(clk), .D(D_ff_0), .Q(Q_ff_0) );
ff ff_1 ( .clk(clk), .D(D_ff_1), .Q(Q_ff_1) );
ff ff_2 ( .clk(clk), .D(D_ff_2), .Q(Q_ff_2) );
ff ff_3 ( .clk(clk), .D(D_ff_3), .Q(Q_ff_3) );

assign out[1] = Q_ff_0;
assign out[3] = Q_ff_1;
assign out[5] = Q_ff_2;
assign out[7] = Q_ff_3;

mux5 mux5_out0 (.in({out_ble6_0, sumout[0], carry[0], lut7_bot}),
	.out(out[0]), .config_in(config_in[270:268]));
mux5 mux5_out1 (.in({out_ble6_1, sumout[1], carry[1], lut8}),
	.out(out[2]), .config_in(config_in[273:271]));
mux5 mux5_out2 (.in({out_ble6_2, sumout[2], carry[2], lut7_top}),
	.out(out[4]), .config_in(config_in[276:274]));
mux4 mux4_out3 (.in({out_ble6_3, sumout[3], carry[3]}),
	.out(out[5]), .config_in(config_in[278:277]));

assign ground = 1'b0;

endmodule



/////////////////////////////////////////////////////
///////////////////// carry /////////////////////////
/////////////////////////////////////////////////////


// Delay focussed carrychain
// 1. you could create 4 extra XORs where sumout and p are hard wired
// 2. you could create 4 MUXes controlled by p signal to select cin or !cin
// I chose to do 1st way.
module carrychain_1b (
	input [3:0]config_in,
	input sin_slice,
	output sout_slice,
	input cin,
	input [3:0]p,
	input [3:0]g,
	input [3:0]ix,
	output [3:0]sout,
	output [3:0]cout,
	output cout_slice
);

wire [3:0]gen;
assign gen[0] = config_in[0] ? g[0] : ix[0];
assign gen[1] = config_in[1] ? g[1] : ix[1];
assign gen[2] = config_in[2] ? g[2] : ix[2];
assign gen[3] = config_in[3] ? g[3] : ix[3];

wire [3:0]cout_internal;
wire [3:0]sout_internal;

assign cout[0] = p[0] ? gen[0] : cin;
assign cout[1] = p[1] ? gen[1] : cout[0];
assign cout[2] = p[2] ? gen[2] : cout[1];
assign cout[3] = p[3] ? gen[3] : cout[2];

assign sout[0] = p[0] ^ cin;    
assign sout[1] = p[1] ^ cout[0];
assign sout[2] = p[2] ^ cout[1];
assign sout[3] = p[3] ^ cout[2];

assign cout_slice = cout[3];

wire [3:0]sin_internal;

assign sin_internal[0] = sin_slice       ^ p[0];
assign sin_internal[1] = sin_internal[0] ^ p[1];
assign sin_internal[2] = sin_internal[1] ^ p[2];
assign sout_slice      = sin_internal[2] ^ p[3];

endmodule



// Area focussed
// Adding 4 more MUX
// 2 adders 
module carrychain_2a (
	input [3:0]config_in,
	input add_config_in,
	input cin,
	output cout_slice,
	input c2in,
	output c2out_slice,
	input [3:0]p,
	input [3:0]g,
	input [3:0]ix,
	output [3:0]sout,
	output [3:0]cout
);

wire [3:0]gen;
assign gen[0] = config_in[0] ? g[0] : ix[0];
assign gen[1] = config_in[1] ? g[1] : ix[1];
assign gen[2] = config_in[2] ? g[2] : ix[2];
assign gen[3] = config_in[3] ? g[3] : ix[3];

wire [3:0]cout_internal;
wire [3:0]sout_internal;
wire [3:0]cin_internal;

assign cin_internal[0] = cin; 
assign cin_internal[1] = add_config_in ? sout_internal[0] : cout[0];
assign cin_internal[2] = add_config_in ? sout_internal[1] : cout[1];
assign cin_internal[3] = add_config_in ? sout_internal[2] : cout[2];

assign cout[0] = p[0] ? gen[0] : cin_internal[0];
assign cout[1] = p[1] ? gen[1] : cin_internal[1];
assign cout[2] = p[2] ? gen[2] : cin_internal[2];
assign cout[3] = p[3] ? gen[3] : cin_internal[3];

assign sout_internal[0] = p[0] ^ cin_internal[0];
assign sout_internal[1] = p[1] ^ cin_internal[1];
assign sout_internal[2] = p[2] ^ cin_internal[2];
assign sout_internal[3] = p[3] ^ cin_internal[3];

wire temp_cout;
wire [1:0]temp_sum;

adder adder0 (.x(cout[0]), .y(cout[1]), .cin(c2in), .cout(temp_sum[0]), .s(temp_cout));
adder adder1 (.x(cout[2]), .y(cout[3]), .cin(temp_cout), .cout(temp_sum[1]), .s(c2out_slice));

assign cout_slice = add_config_in ? sout[3] : cout[3];

assign sout[0] = add_config_in ? temp_sum[0] : sout_internal[0];
assign sout[2] = add_config_in ? temp_sum[1] : sout_internal[2];
assign sout[1] = sout_internal[1];
assign sout[3] = sout_internal[3];

endmodule

// Delay focussed carrychain
// Create 4 extra XORs where sumout and p are hard wired
// 2 adders
module carrychain_2b (
	input [3:0]config_in,
	input add_config_in,
	input sin_slice,
	output sout_slice,
	input c2in,
	output c2out_slice,
	input cin,
	output cout_slice,
	input [3:0]p,
	input [3:0]g,
	input [3:0]ix,
	output [3:0]sout,
	output [3:0]cout
);

wire [3:0]gen;
assign gen[0] = config_in[0] ? g[0] : ix[0];
assign gen[1] = config_in[1] ? g[1] : ix[1];
assign gen[2] = config_in[2] ? g[2] : ix[2];
assign gen[3] = config_in[3] ? g[3] : ix[3];

wire [3:0]cout_internal;
wire [3:0]sout_internal;

assign cout[0] = p[0] ? gen[0] : cin;
assign cout[1] = p[1] ? gen[1] : cout[0];
assign cout[2] = p[2] ? gen[2] : cout[1];
assign cout[3] = p[3] ? gen[3] : cout[2];

assign sout_internal[0] = p[0] ^ cin;    
assign sout_internal[1] = p[1] ^ cout[0];
assign sout_internal[2] = p[2] ^ cout[1];
assign sout_internal[3] = p[3] ^ cout[2];


wire [3:0]sin_internal;

assign sin_internal[0] = sin_slice       ^ p[0];
assign sin_internal[1] = sin_internal[0] ^ p[1];
assign sin_internal[2] = sin_internal[1] ^ p[2];
assign sout_slice      = sin_internal[2] ^ p[3];

wire temp_cout;
wire [1:0]temp_sum;

adder adder0 (.x(cout[0]), .y(cout[1]), .cin(c2in), .cout(temp_sum[0]), .s(temp_cout));
adder adder1 (.x(cout[2]), .y(cout[3]), .cin(temp_cout), .cout(temp_sum[1]), .s(c2out_slice));

assign cout_slice = cout[3];

assign sout[0] = add_config_in ? temp_sum[0] : sout_internal[0];
assign sout[2] = add_config_in ? temp_sum[1] : sout_internal[2];
assign sout[1] = sout_internal[1];
assign sout[3] = sout_internal[3];

endmodule


// Area focussed
// Adding 4 more MUX 
module carrychain_1a (
	input [3:0]config_in,
	input add_config_in,
	input cin,
	input [3:0]p,
	input [3:0]g,
	input [3:0]ix,
	output [3:0]sout,
	output [3:0]cout,
	output cout_slice
);

wire [3:0]gen;
assign gen[0] = config_in[0] ? g[0] : ix[0];
assign gen[1] = config_in[1] ? g[1] : ix[1];
assign gen[2] = config_in[2] ? g[2] : ix[2];
assign gen[3] = config_in[3] ? g[3] : ix[3];

wire [3:0]cout_internal;
wire [3:0]sout_internal;
wire [3:0]cin_internal;

assign cin_internal[0] = cin; 
assign cin_internal[1] = add_config_in ? sout[0] : cout[0];
assign cin_internal[2] = add_config_in ? sout[1] : cout[1];
assign cin_internal[3] = add_config_in ? sout[2] : cout[2];

assign cout[0] = p[0] ? gen[0] : cin_internal[0];
assign cout[1] = p[1] ? gen[1] : cin_internal[1];
assign cout[2] = p[2] ? gen[2] : cin_internal[2];
assign cout[3] = p[3] ? gen[3] : cin_internal[3];

assign sout[0] = p[0] ^ cin_internal[0];
assign sout[1] = p[1] ^ cin_internal[1];
assign sout[2] = p[2] ^ cin_internal[2];
assign sout[3] = p[3] ^ cin_internal[3];

assign cout_slice = add_config_in ? sout[3] : cout[3];

endmodule

module carrychain (
	input [3:0]config_in,
	input cin,
	input [3:0]p,
	input [3:0]g,
	input [3:0]ix,
	output [3:0]sout,
	output [3:0]cout,
	output cout_slice
);

wire [3:0]gen;
assign gen[0] = config_in[0] ? g[0] : ix[0];
assign gen[1] = config_in[1] ? g[1] : ix[1];
assign gen[2] = config_in[2] ? g[2] : ix[2];
assign gen[3] = config_in[3] ? g[3] : ix[3];

assign cout[0] = p[0] ? gen[0] : cin;
assign cout[1] = p[1] ? gen[1] : cout[0];
assign cout[2] = p[2] ? gen[2] : cout[1];
assign cout[3] = p[3] ? gen[3] : cout[2];

assign sout[0] = p[0] ^ cin;
assign sout[1] = p[1] ^ cout[0];
assign sout[2] = p[2] ^ cout[1];
assign sout[3] = p[3] ^ cout[2];

assign cout_slice = cout[3];

endmodule


/////////////////////////////////////////////////////
///////////////////// ble6 /////////////////////////
/////////////////////////////////////////////////////
module ble6 (
	input [5:0]in,
	input [0:0]clk,
	output [1:0]out, // [1] is O6 and [0] is O5
	input [63:0]config_in
);

////////child (0,0,0)////////
wire [5:0]in_lut5_0;//input to child
wire [0:0]out_lut5_0;//output from child
wire [0:0]out_lut5_1;//output from child
 
wire ground;

assign in_lut5_0[0] = in[0];
assign in_lut5_0[1] = in[1];
assign in_lut5_0[2] = in[2];
assign in_lut5_0[3] = in[3];
assign in_lut5_0[4] = in[4];
assign in_lut5_0[5] = in[5];
 
lut5 lut5_0 ( .in(in_lut5_0[4:0]), .out(out_lut5_0), .config_in(config_in[31:0]) ); //block instantiation
lut5 lut5_1 ( .in(in_lut5_0[4:0]), .out(out_lut5_1), .config_in(config_in[63:32]) ); //block instantiation

assign out[0] = out_lut5_0;
assign out[1] = in_lut5_0[5] ? out_lut5_0 : out_lut5_1;

endmodule

////////////////////////////////////////////////////
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

module mux2_prop (
	input [1:0]in,
	input [0:0]config_in,
	input config_rst,
	output out
);

assign out = config_in[0]? in[1] : in[0];

endmodule

module mux2_gen (
	input [1:0]in,
	input [0:0]config_in,
	input config_rst,
	output out
);

assign out = config_in[0]? in[1] : in[0];

endmodule


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
///////////////////// lut6 /////////////////////////
/////////////////////////////////////////////////////
module lut5 ( input [31:0]config_in, input [4:0]in, output reg out );

wire [4:0]in_flip;
assign in_flip = {in[0], in[1], in[2], in[3], in[4]};

always @ (*) begin: MUX
	case(in_flip)
		5'd0: out = config_in[0];
		5'd1: out = config_in[1];
		5'd2: out = config_in[2];
		5'd3: out = config_in[3];
		5'd4: out = config_in[4];
		5'd5: out = config_in[5];
		5'd6: out = config_in[6];
		5'd7: out = config_in[7];
		5'd8: out = config_in[8];
		5'd9: out = config_in[9];
		5'd10: out = config_in[10];
		5'd11: out = config_in[11];
		5'd12: out = config_in[12];
		5'd13: out = config_in[13];
		5'd14: out = config_in[14];
		5'd15: out = config_in[15];
		5'd16: out = config_in[16];
		5'd17: out = config_in[17];
		5'd18: out = config_in[18];
		5'd19: out = config_in[19];
		5'd20: out = config_in[20];
		5'd21: out = config_in[21];
		5'd22: out = config_in[22];
		5'd23: out = config_in[23];
		5'd24: out = config_in[24];
		5'd25: out = config_in[25];
		5'd26: out = config_in[26];
		5'd27: out = config_in[27];
		5'd28: out = config_in[28];
		5'd29: out = config_in[29];
		5'd30: out = config_in[30];
		5'd31: out = config_in[31];
	endcase
end

endmodule
module lut6 ( input [63:0]config_in, input [5:0]in, output reg out );

wire [5:0]in_flip;
assign in_flip = {in[0], in[1], in[2], in[3], in[4], in[5]};

always @ (*) begin: MUX
	case(in_flip)
		6'd0: out = config_in[0];
		6'd1: out = config_in[1];
		6'd2: out = config_in[2];
		6'd3: out = config_in[3];
		6'd4: out = config_in[4];
		6'd5: out = config_in[5];
		6'd6: out = config_in[6];
		6'd7: out = config_in[7];
		6'd8: out = config_in[8];
		6'd9: out = config_in[9];
		6'd10: out = config_in[10];
		6'd11: out = config_in[11];
		6'd12: out = config_in[12];
		6'd13: out = config_in[13];
		6'd14: out = config_in[14];
		6'd15: out = config_in[15];
		6'd16: out = config_in[16];
		6'd17: out = config_in[17];
		6'd18: out = config_in[18];
		6'd19: out = config_in[19];
		6'd20: out = config_in[20];
		6'd21: out = config_in[21];
		6'd22: out = config_in[22];
		6'd23: out = config_in[23];
		6'd24: out = config_in[24];
		6'd25: out = config_in[25];
		6'd26: out = config_in[26];
		6'd27: out = config_in[27];
		6'd28: out = config_in[28];
		6'd29: out = config_in[29];
		6'd30: out = config_in[30];
		6'd31: out = config_in[31];
		6'd32: out = config_in[32];
		6'd33: out = config_in[33];
		6'd34: out = config_in[34];
		6'd35: out = config_in[35];
		6'd36: out = config_in[36];
		6'd37: out = config_in[37];
		6'd38: out = config_in[38];
		6'd39: out = config_in[39];
		6'd40: out = config_in[40];
		6'd41: out = config_in[41];
		6'd42: out = config_in[42];
		6'd43: out = config_in[43];
		6'd44: out = config_in[44];
		6'd45: out = config_in[45];
		6'd46: out = config_in[46];
		6'd47: out = config_in[47];
		6'd48: out = config_in[48];
		6'd49: out = config_in[49];
		6'd50: out = config_in[50];
		6'd51: out = config_in[51];
		6'd52: out = config_in[52];
		6'd53: out = config_in[53];
		6'd54: out = config_in[54];
		6'd55: out = config_in[55];
		6'd56: out = config_in[56];
		6'd57: out = config_in[57];
		6'd58: out = config_in[58];
		6'd59: out = config_in[59];
		6'd60: out = config_in[60];
		6'd61: out = config_in[61];
		6'd62: out = config_in[62];
		6'd63: out = config_in[63];
	endcase
end

endmodule

/////////////////////////////////////////////////////
///////////////////// mux33 /////////////////////////
/////////////////////////////////////////////////////
module mux29 (
	input [28:0]in,
	output reg out,
	input [4:0]config_in,
	input config_rst
);

always @ (*) begin: MUX
	case(config_in)
		5'd0: out = in[0];
		5'd1: out = in[1];
		5'd2: out = in[2];
		5'd3: out = in[3];
		5'd4: out = in[4];
		5'd5: out = in[5];
		5'd6: out = in[6];
		5'd7: out = in[7];
		5'd8: out = in[8];
		5'd9: out = in[9];
		5'd10: out = in[10];
		5'd11: out = in[11];
		5'd12: out = in[12];
		5'd13: out = in[13];
		5'd14: out = in[14];
		5'd15: out = in[15];
		5'd16: out = in[16];
		5'd17: out = in[17];
		5'd18: out = in[18];
		5'd19: out = in[19];
		5'd20: out = in[20];
		5'd21: out = in[21];
		5'd22: out = in[22];
		5'd23: out = in[23];
		5'd24: out = in[24];
		5'd25: out = in[25];
		5'd26: out = in[26];
		5'd27: out = in[27];
		5'd28: out = in[28];
		default: out = 1'b0;
	endcase
end

endmodule

module mux6 (
	input [5:0]in,
	output reg out,
	input [2:0]config_in
);
always @ (*) begin: MUX
	case(config_in)
		3'd0: out = in[0];
		3'd1: out = in[1];
		3'd2: out = in[2];
		3'd3: out = in[3];
		3'd4: out = in[4];
		3'd5: out = in[5];
		default: out = 1'b0;
	endcase
end
endmodule 

module mux5 (
	input [4:0]in,
	output reg out,
	input [2:0]config_in
);
always @ (*) begin: MUX
	case(config_in)
		3'd0: out = in[0];
		3'd1: out = in[1];
		3'd2: out = in[2];
		3'd3: out = in[3];
		3'd4: out = in[4];
		default: out = 1'b0;
	endcase
end
endmodule

module mux4 (
	input [3:0]in,
	output reg out,
	input [1:0]config_in
);
always @ (*) begin: MUX
	case(config_in)
		2'd0: out = in[0];
		2'd1: out = in[1];
		2'd2: out = in[2];
		2'd3: out = in[3];
		default: out = 1'b0;
	endcase
end
endmodule
