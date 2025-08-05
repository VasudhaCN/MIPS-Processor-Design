`timescale 1ns / 1ps
module main(
input reset,
input clk
    );
wire [31:0]instr_code; wire [31:0]instruction; wire [25:0]branch; 
wire [5:0]opcode; wire [5:0]funct; wire [3:0]alu_c;
wire [1:0]AluOp; wire RegWrite; wire RegDSt; wire jump;
wire ALUsrc; wire MemRead; wire MemWrite; wire MemtoReg;
wire [4:0]rs; wire [4:0]rt; wire[4:0]rd; wire [31:0]offset;
wire [4:0] Write_Reg_Num; wire [4:0] Write_Reg_Num_m; wire [4:0] Write_Reg_Num_w; 
wire [31:0] Write_Data; wire [31:0] Read_Data1; wire[31:0] Read_Data2;
wire[31:0]rd1; wire [31:0]rd2; wire [4:0]rt_e; wire [4:0]rd_e;wire [4:0]rs_e; wire [31:0]off_e;
wire RegWrite_e; wire RegDSt_e; wire ALUsrc_e; wire MemRead_e;wire MemWrite_e;wire MemtoReg_e;wire [3:0]aluC_e;
wire [31:0]B; wire zero; wire [31:0] alu_result;
wire [31:0]address, data_m; wire RegWrite_m, MemRead_m, MemWrite_m, MemtoReg_m;
wire [31:0]mem_data; wire RegWrite_w; wire MemtoReg_w; wire [31:0]alu_r, memory;
wire nop; wire [1:0] forwardA; wire [1:0] forwardB; wire [31:0]alu_inB; wire [31:0]alu_inA;


main_control DUT1(
.opcode(opcode),
.AluOp(AluOp),
.RegWrite(RegWrite),
.RegDSt(RegDSt),
.ALUsrc(ALUsrc),
.MemRead(MemRead),
.MemWrite(MemWrite),
.MemtoReg(MemtoReg),
.jump(jump)
  );
  
alu_control DUT2(
.ALUop(AluOp),
.funct(funct),
.alu_c(alu_c)
    );
    
stall DUTA(
    .rs(rs),           
    .rt(rt),           
    .rt_ex(rt_e),        
    .MemRead_ex(MemRead_e),   
    .nop(nop)        
);

forward DUTB(
    .rs_ex(rs_e), .rt_ex(rt_e),       
    .rd_mem(Write_Reg_Num_m), 
    .rd_wb(Write_Reg_Num_w),           
    .RegWrite_mem(RegWrite_m), 
    .RegWrite_wb(RegWrite_w),        
    .forwardA(forwardA), .forwardB(forwardB)
);

Inst_Fetch DUT3(
.clk(clk),
.reset(reset),
.jump(jump),
.branch(branch),
.nop(nop),
.instr_code(instr_code)
);

if_id DUT4(
.clk(clk),
.jump(jump),
.nop(nop),
.instruction(instr_code),
.instruction_d(instruction)
);

decode DUT(
.instruction(instruction),
.opcode(opcode),
.func(funct),
.rs(rs),
.rt(rt),
.rd(rd),
.offset(offset),
.branch(branch)
    );

reg_file DUT5(
    .Read_Reg_Num1(rs),
    .Read_Reg_Num2(rt),
    .Write_Reg_Num(Write_Reg_Num_w),
    .Write_Data(Write_Data),
    .regwrite(RegWrite_w),
    .Read_Data1(Read_Data1),
    .Read_Data2(Read_Data2),
    .reset(reset)
    );
 
id_ex DUT6(
.clk(clk),
 .data1(Read_Data1),.data2(Read_Data2),.rs(rs), .rt(rt),.rd(rd),
.offset(offset),.RegWrite(RegWrite),.RegDSt(RegDSt),
.ALUsrc(ALUsrc),
.MemRead(MemRead),.MemWrite(MemWrite),.MemtoReg(MemtoReg),
.aluC(alu_c), .nop(nop),
.rd1(rd1),.rd2(rd2),
.rs_e(rs_e),.rt_e(rt_e),
.rd_e(rd_e),.off_e(off_e),.RegWrite_e(RegWrite_e),
.RegDSt_e(RegDSt_e),.ALUsrc_e(ALUsrc_e),.MemRead_e(MemRead_e),.MemWrite_e(MemWrite_e),
.MemtoReg_e(MemtoReg_e),.aluC_e(aluC_e)
);

mux5 mux1(
    .in0(rt_e),
    .in1(rd_e),
    .sel(RegDSt_e),
    .out(Write_Reg_Num)
    ); //mux to choose the write reg destination
    
fwdmux mux4(
.ID_EX_ReadData1(rd1),
.ID_EX_ReadData2(rd2),
.EX_MEM_ALUResult(address),
.MEM_WB_WriteData(memory),
.forwardA(forwardA), .forwardB(forwardB),
.alu_inA(alu_inA),.alu_inB(alu_inB)
); //mux to choose if you need the forwarded value
    
mux mux2 (
    .in0(alu_inB),
    .in1(off_e),
    .sel(ALUsrc_e),
    .out(B)
    ); // mux to select reg value or offset as 2nd input to ALU
    
alu DUT7(
    .A(alu_inA),
    .B(B),
    .alu_C(aluC_e),
    .zero(zero),
    .alu_result(alu_result)
    );
 
ex_mem DUT8(
.clk(clk),
.RegWrite(RegWrite_e), .MemRead(MemRead_e), .MemWrite(MemWrite_e), .MemtoReg(MemtoReg_e),
.alu_result(alu_result), .data(B), .write_reg(Write_Reg_Num),
.RegWrite_m(RegWrite_m), .MemRead_m(MemRead_m), .MemWrite_m(MemWrite_m), .MemtoReg_m(MemtoReg_m),
.address(address), .data_m(data_m), .Write_Reg_Num_m(Write_Reg_Num_m)
);

D_mem DUT9(
    .address(address),
    .data(data_m),    .reset(reset),
    .memRead(MemRead_m),
    .memWrite(MemWrite_m),
    .mem_data(mem_data)  
    );
    
 mem_wb DUT10(
 .clk(clk),.alu_res(address), .mem_data(mem_data), .writereg(Write_Reg_Num_m),
 .RegWrite_m(RegWrite_m),.MemtoReg_m(MemtoReg_m),
 .alu_r(alu_r),.memory(memory), .dest(Write_Reg_Num_w), 
 .RegWrite_w(RegWrite_w), .MemtoReg_w(MemtoReg_w)
 );

mux mux3 (
    .in0(alu_r),
    .in1(memory),
    .sel(MemtoReg_w),
    .out(Write_Data)
    ); //mux which determines what data to be written into reg
endmodule
