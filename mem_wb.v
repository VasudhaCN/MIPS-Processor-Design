`timescale 1ns / 1ps
module mem_wb(
input clk,
input [31:0]alu_res,
input [31:0]mem_data,
input [4:0]writereg,
input RegWrite_m,
input MemtoReg_m,
output reg [31:0]alu_r,
output reg [31:0]memory,
output reg [4:0]dest,
output reg RegWrite_w,
output reg MemtoReg_w

    );
always @(posedge clk)
begin
{alu_r,memory, dest } <= {alu_res, mem_data,writereg};
{RegWrite_w, MemtoReg_w} <= {RegWrite_m, MemtoReg_m};
end
endmodule
