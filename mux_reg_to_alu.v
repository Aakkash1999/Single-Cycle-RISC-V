`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2023 07:10:31 PM
// Design Name: 
// Module Name: mux_reg_to_alu
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


module mux_reg_to_alu(
input       read_data2,
input       immediate,
input       alu_src,
output      operand2
);

assign operand2 = alu_src ?   immediate: read_data2;
endmodule
