`timescale 1ns / 1ps
module mux5(
    input [4:0] in0,
    input [4:0] in1,
    input sel,
    output reg [4:0] out
    );
    always @(*)
    begin
    case(sel)
    1'b0: out = in0;
    1'b1: out =  in1;
    default: out = 5'b0;
    endcase
    end
endmodule