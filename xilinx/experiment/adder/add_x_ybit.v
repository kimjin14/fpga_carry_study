
module add_x_ybit (in, sum);
parameter XLEN = 64; // number of values
parameter YLEN = 3; // binary bit width

input [(XLEN*YLEN)-1:0] in;
output reg [($clog2(XLEN)+YLEN)-1:0] sum;

integer j;
	
always @ (*) begin
	sum = 0;
	for (j=0; j<XLEN; j=j+1) begin
		sum = sum + in[(YLEN*j)+:YLEN];
	end
end
	
endmodule

