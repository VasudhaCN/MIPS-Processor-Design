`timescale 1ns / 1ps
module Inst_Fetch(
input clk,
input reset,
input jump,
input nop,
input [25:0]branch,
output reg [31:0] instr_code
    );
    
    reg [31:0] PC;
    wire [31:0] instr_mem_code;
    
    instr_mem DUT(
    .PC(PC), .reset(reset),.instr_code(instr_mem_code)
    );
    
  always @(posedge clk or negedge reset)
    begin
    if (reset == 0)
    PC <=0;
    else if(!nop) begin
    if (jump)
    PC<= {PC[31:28], branch<<2};
    else
    PC<= PC + 32'h4;
    end
    else
    PC=PC;
    end
    always @(*)
    begin
    instr_code = instr_mem_code;
    end
endmodule
