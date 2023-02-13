`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2023 07:18:42 PM
// Design Name: 
// Module Name: mux_mem_to_reg
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


module mux_mem_to_reg(
input       read_data,
input       result,
input       mem_to_reg,
output      mem_to_reg_data
);

assign mem_to_reg_data = mem_to_reg ?   read_data: result;

endmodule
