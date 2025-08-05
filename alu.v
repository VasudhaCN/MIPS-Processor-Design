`timescale 1ns / 1ps
module alu(
    input [31:0] A,
    input [31:0] B,
    input [3:0] alu_C,
    output reg zero,
    output reg [31:0] alu_result
    );
    always@(*)
    begin
    case(alu_C)
    4'b1000 : alu_result = A * B;  //mul
    4'b1001 : alu_result = A >> B; //srl
    4'b1010 : alu_result = B << 16; // lui
    4'b0010 : alu_result = A + B;  //add
    4'b0110 : alu_result = A - B;  //sub
    
    endcase
    if (alu_result == 0) 
    zero <= 1;
    else
    zero<=0;
    end
endmodule