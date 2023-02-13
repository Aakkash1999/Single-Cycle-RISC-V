`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2023 05:02:54 PM
// Design Name: 
// Module Name: cpu
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


module cpu(
input   reset,
input   clk
);
//PC variables
wire            branch;
reg             pc;
reg             branch_target;
wire    [31:0]  next_pc;

//instruction memory
reg             read_addr;
reg             enable;
wire    [31:0]  instruction;

//control
reg             zero;
reg             negative;
wire            mem_to_reg;
wire            mem_write;
wire            mem_read;
wire            alu_src;
wire    [2:0]   alu_op;
wire            reg_write;
//wire             branch;

//registers
wire             mem_to_reg_data;
//reg              write_data;

reg             rena2;//need to define mux and mem_to_reg
wire            read_data1;
wire            read_data2;

//alu control
wire            func = {instruction[30],instruction[14:12]};
wire    [3:0]    alu_operation;

//ALU
reg             operand1;
wire            operand2;//alu_operation

//data_memory
reg             write_data;
//reg             read_addr;
wire            alu_result;
wire            flag;
wire            read_data;

//immGen
wire   [31:0]    immediate;


//branch sel
wire             en_branch;

program_counter program_counter(.clk(clk),.reset(reset),.branch(branch),.pc(pc),.branch_target(branch_target),.next_pc(next_pc));

//instruction_memory  instruction_memory(.clk(clk),.read_addr(read_addr),.reset(reset),.enable(enable),.instruction(instruction));
instruction_memory instruction_memory(.pc(next_pc),.instruction(instruction));

//instruction_memory  instruction_memory(.read_addr(next_pc),.instruction(instruction),.reset(reset));
controller controller(.opcode(instruction[6:0]),.zero(zero),.negative(negative),.mem_to_reg(mem_to_reg),.mem_write(mem_write),.alu_src(alu_src),.alu_op(alu_op),.reg_write(reg_write),.branch(branch));
//register 
registers registers(.clk(clk),.reg_write(reg_write),.reset(reset),.instruction(instruction),.mem_to_reg_data(mem_to_reg_data),.write_data(write_data),.read_data1(read_data1),.read_data2(read_data2));

mux_reg_to_alu mux1(.read_data2(read_data2),.immediate(immediate),.alu_src(alu_src),.operand2(operand2));

immediate_generator immediate_generator(.instruction(instruction),.immediate(immediate));

alu_control alu_control(.alu_op(alu_op),.func(func),.alu_operation(alu_operation));

alu alu(.alu_opr(alu_operation),.operand1(read_data1),.operand2(operand2),.result(alu_result),.flag(flag));

data_memory data_memory(.clk(clk),.reset(reset),.mem_write(mem_write),.write_addr(alu_result),.write_data(read_data2),.mem_read(mem_read),.read_addr(alu_result),.read_data(read_data));

mux_mem_to_reg mux_mem_to_reg(.read_data(read_data),.result(alu_result),.mem_to_reg(mem_to_reg),.mem_to_reg_data(mem_to_reg_data));

branch_sel  branch_sel(.branch(branch),.flag(flag),.func(func),.en_branch(en_branch));

//WB stage
assign  mem_to_reg_data =   mem_to_reg ? read_data: alu_result;
endmodule
