`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/29/2018 11:41:53 AM
// Design Name: 
// Module Name: input_limit_test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module input_limit_test(
    input [31:0] in,
    input [31:0] in2,

    output [3:0] out,
    output [3:0] out2
);
    
    assign out[0] = |in[5:0];
    assign out[1] = &in[11:6] & in[0];
    assign out[2] = ^in[17:12] & in[0];
    assign out[3] = ~|in[23:18] & in[0];

    assign out2[0] = ~&in2[5:1] & in[0]; 
    assign out2[1] = !in2[11] & ^in2[10:7] & in[0];
    assign out2[2] = ~^in2[17:13] & in[0];
    assign out2[3] = (|in2[23:22]) & (|in2[20:18]) & in[0];
    
    
endmodule