`timescale 1ns / 1ps
module id_ex(
input clk,
input [31:0]data1,
input [31:0]data2,
input [4:0]rs,
input [4:0]rt,
input [4:0]rd,
input [31:0]offset,
input RegWrite,
input RegDSt,
input ALUsrc,
input MemRead,
input MemWrite,
input MemtoReg,
input [3:0]aluC,
input nop,
output reg [31:0]rd1,
output reg [31:0]rd2,
output reg [4:0]rs_e,
output reg [4:0]rt_e,
output reg [4:0]rd_e,
output reg [31:0]off_e,
output reg RegWrite_e,
output reg RegDSt_e,
output reg ALUsrc_e,
output reg MemRead_e,
output reg MemWrite_e,
output reg MemtoReg_e,
output reg [3:0]aluC_e
    );
always @(posedge clk) begin
{rd1, rd2, rs_e, rt_e, rd_e, off_e} <= {data1, data2, rs, rt, rd, offset};
if(!nop) 
{RegWrite_e, RegDSt_e, ALUsrc_e, MemRead_e, MemWrite_e,MemtoReg_e, aluC_e} <= {RegWrite, RegDSt, ALUsrc, MemRead, MemWrite,MemtoReg, aluC};
else 
{RegWrite_e, RegDSt_e, ALUsrc_e, MemRead_e, MemWrite_e,MemtoReg_e, aluC_e} <= {1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,4'b0};
end
endmodule