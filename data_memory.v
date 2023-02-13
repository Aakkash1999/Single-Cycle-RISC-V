`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2023 03:15:02 PM
// Design Name: 
// Module Name: data_memory
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


module data_memory(
input   clk, 
input   reset,
input   mem_write,
input   write_addr,
input   write_data,
input   mem_read,
input   read_addr,
output  reg     read_data

);
localparam      MEM_WIDTH       =64;
localparam      MEM_DEPTH       =128;

reg [MEM_WIDTH-1:0] mem [MEM_DEPTH-1:0];

always@(*) begin
    if(reset) begin
        read_data <= 0;
    end
    else begin
        if(mem_read) begin
            read_data <= mem[read_addr];
        end else begin
            read_data <= 0;
        end
    end
end

always@(*) begin
    if (mem_write) begin
        mem[write_addr] <= write_data;
    end else begin
        mem[write_addr] <= mem[write_addr];
    end
end


endmodule
