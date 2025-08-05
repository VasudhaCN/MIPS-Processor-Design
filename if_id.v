`timescale 1ns / 1ps
module if_id(
input clk,
input jump,
input nop,
input [31:0]instruction,
output reg[31:0]instruction_d
 );
 always @(posedge clk)
 begin
if (jump)
instruction_d <= 32'bx;
else begin
if(!nop)
instruction_d <= instruction;
else 
instruction_d <= instruction_d;
end
end
endmodule