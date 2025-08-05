`timescale 1ns / 1ps

module fwdmux(
input [31:0]ID_EX_ReadData1,
input [31:0]ID_EX_ReadData2,
input [31:0]EX_MEM_ALUResult,
input [31:0]MEM_WB_WriteData,
input [1:0] forwardA,
input [1:0] forwardB,
output wire [31:0]alu_inA,
output wire [31:0]alu_inB
);
assign alu_inA = (forwardA == 2'b00) ? ID_EX_ReadData1 :
                 (forwardA == 2'b10) ? EX_MEM_ALUResult :
                 MEM_WB_WriteData;

assign alu_inB = (forwardB == 2'b00) ? ID_EX_ReadData2 :
                        (forwardB == 2'b10) ? EX_MEM_ALUResult :
                        MEM_WB_WriteData;
endmodule
