`timescale 1ns / 1ps
module ex_mem(
input clk,
input RegWrite,
input MemRead,
input MemWrite,
input MemtoReg,
input [31:0]alu_result,
input [31:0]data,
input [4:0]write_reg,
output reg RegWrite_m,
output reg MemRead_m,
output reg MemWrite_m,
output reg MemtoReg_m,
output reg [31:0]address,
output reg [31:0]data_m,
output reg [4:0]Write_Reg_Num_m
    );
    
always @(posedge clk) begin
{RegWrite_m, MemRead_m, MemWrite_m, MemtoReg_m} <= {RegWrite, MemRead, MemWrite, MemtoReg} ;
{address, data_m, Write_Reg_Num_m } <= {alu_result, data, write_reg};
end
endmodule