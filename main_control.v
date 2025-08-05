`timescale 1ns / 1ps
module main_control(
input [5:0]opcode,
output reg [1:0]AluOp,
output reg RegWrite,
output reg RegDSt,
output reg ALUsrc,
output reg MemRead,
output reg MemWrite,
output reg MemtoReg,
output reg jump
  );
  
always @(*) begin
    case(opcode)
    6'b100011: begin //lw
    jump = 0;
    AluOp = 2'b00 ; RegWrite = 1; RegDSt = 0 ; ALUsrc = 1; MemRead = 1 ; MemWrite = 0; MemtoReg = 1;
    end
    6'b101011: begin //sw
    jump = 0;
    AluOp = 2'b00 ; RegWrite = 0; RegDSt = 1'bx; ALUsrc = 1 ; MemRead = 0 ; MemWrite = 1; MemtoReg = 1'bx;
    end
    6'b001111: begin //lui
    jump = 0;
    AluOp = 2'b11; RegWrite = 1; RegDSt = 0;   ALUsrc = 1; MemRead = 0; MemWrite = 0; MemtoReg = 0;
    end
    6'b000010: begin //jump 
    jump = 1;
    AluOp = 2'bx ; RegWrite = 0; RegDSt = 1'bx;   ALUsrc = 1'bx; MemRead =0 ; MemWrite =0 ; MemtoReg = 1'bx;
    end
    6'b000000: begin //mul
    jump = 0;
    AluOp = 2'b10 ; RegWrite = 1; RegDSt = 1;   ALUsrc = 0; MemRead = 0; MemWrite = 0; MemtoReg = 0;
    end
    6'b000001: begin //srl
    jump = 0;
    AluOp = 2'b01; RegWrite =1 ; RegDSt =0 ;   ALUsrc = 0; MemRead = 0; MemWrite =0 ; MemtoReg = 0;
    end
    default: begin
    jump = 1'bx; 
    AluOp = 2'bxx; RegWrite = 1'bx; RegDSt =1'bx ; ALUsrc = 1'bx; MemRead = 1'bx; MemWrite =1'bx ; MemtoReg = 1'bx;
    end
    endcase
    end
endmodule
