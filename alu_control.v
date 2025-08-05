`timescale 1ns / 1ps
module alu_control(
input [1:0]ALUop,//comes from the main_control
input [5:0]funct,
output reg [3:0]alu_c
    );
    
always @(*) begin
    case (ALUop)
        2'b00: alu_c = 4'b0010; // lw, sw (add)
        2'b11: alu_c = 4'b1010; // lui
        2'b01: alu_c = 4'b1001; // srl
        2'b10: begin // R-type
            case (funct)
                6'b011000: alu_c = 4'b1000; // mul
                6'b100000: alu_c = 4'b0010; // add
                6'b100010: alu_c = 4'b0110; // sub
                default:   alu_c = 4'b1111; // invalid
            endcase
        end
        default: alu_c = 4'b1111; // invalid ALUop
    endcase
end
    

endmodule
