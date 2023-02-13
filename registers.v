`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2023 04:52:24 PM
// Design Name: 
// Module Name: registers
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


module registers(
input           clk,
input           reg_write,
input           reset,
input   [31:0]  instruction,
input           mem_to_reg_data,
input   [31:0]  write_data,
output  reg     read_data1,
output  reg     read_data2

);
localparam      R_TYPE       = 7'b 0110011;
localparam      I_TYPE_L     = 7'b 0000011;
localparam      I_TYPE_A     = 7'b 0010011;
localparam      S_TYPE       = 7'b 0100011;
localparam      SB_TYPE      = 7'b 1100011;
reg         rd;
reg         rs1;
reg         rs2;
reg         imm;
reg [11:0]  imm_data;
reg [31:0]   reg_mem [31:0];     
always@(instruction) begin
    case(instruction[6:0])
        R_TYPE:
            begin
            rd = instruction[11:7];
            rs1= instruction[19:15];
            rs2= instruction[24:20];
            imm= 0;
            end
       I_TYPE_L:
            begin
            rd = instruction[11:7];
            rs1= instruction[19:15];
            imm= 1;
            imm_data[11:0] = instruction[31:20];
            end
       I_TYPE_A:
            begin
            rd = instruction[11:7];
            rs1= instruction[19:15];
            imm= 1;
            imm_data[11:0] = instruction[31:20];
            end
       S_TYPE:
            begin
            rd = instruction[11:7];
            rs1= instruction[19:15];
            rs2= instruction[24:20];
            imm= 1;
            imm_data[11:5] = instruction[31:25];
            imm_data[4:0]  = instruction[11:7];
            end
       SB_TYPE://DOUBT with immediate
            begin
            rs1= instruction[19:15];
            rs2= instruction[24:20];
            imm= 1;
            imm_data[11:5] = instruction[31:25];
            imm_data[4:0]  = instruction[11:7];
            end
    endcase
end
integer count;          
always@(posedge clk) begin
if(reset) begin
    for(count=0;count<32; count=count+1)begin
        reg_mem[count]  <=  32'b 0;
    end
 end else if(reg_write) begin
    reg_mem[rd]     <= write_data;  //doubt   
 end
end

// NEED TO WRITE REG WRITE FROM MUX.       
always@(*) begin
    read_data1  =   reg_mem[rs1];
    read_data2  =   reg_mem[rs2];
end    
endmodule
