`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/09/2022 01:46:49 PM
// Design Name: 
// Module Name: OtterMCU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module OtterMCU(RST, INTR, IOBUS_IN, clk, IOBUS_WR, IOBUS_OUT, IOBUS_ADDR);
    
    input logic RST, INTR, clk;
    input logic [31:0] IOBUS_IN;
    output logic IOBUS_WR;
    output logic [31:0] IOBUS_OUT, IOBUS_ADDR;
    
    //Mem/Reg Data
    logic [31:0] RD, IR, result, RS1, RS2, WD, PC4, DOUT2, PC, srcA, srcB;
    
    //Immed Data
    logic [31:0] U_Type, I_Type, S_Type, B_Type, J_Type;
    
    //Branch Addr
    logic [31:0] jalr, branch, jal, mtvec, mepc;
    
    //Sync Control
    logic memRDEN1, memRDEN2, memWE2, 
          regWrite, reset, PCWrite,
          int_taken, CSR_MIE, intr_fsm, csr_WE;
    
    //Async Control
    logic rf_wr_sel, alu_srcA, br_eq, br_ltu, br_lt;
    logic [2:0] pcSource;
    logic [1:0] alu_srcB;
    
    //Reg
    RegMux RegMux0(.PC4(PC4), .RD(RD), 
                   .DOUT2(DOUT2), .ALU_Result(result), 
                   .rf_wr_sel(rf_wr_sel), .WD(WD));
             
    RegFile Reg0(.RF_ADR1(IR[19:15]), .RF_ADR2(IR[24:20]), 
                 .RF_WA(IR[11:7]), .RF_WD(WD), 
                 .RF_RS1(RS1), .RF_RS2(RS2), 
                 .RF_EN(regWrite), .clk(clk));
    
    //Memory
    Memory mem0(.MEM_CLK(clk), .MEM_RDEN1(memRDEN1),
                .MEM_RDEN2(memRDEN2), .MEM_WE2(memWE2), //Sync R/W, connected to CUFSM
                .MEM_ADDR1(PC[15:2]), // Instruction Memory word Addr (Connect to PC[15:2])
                .MEM_ADDR2(result), // Read addr gen from ALU
                .MEM_DIN2(RS2),  // Data to save, will alwasy read from RS2
                .MEM_SIZE(IR[13:12]),   // encoded in ins
                .MEM_SIGN(IR[14]), //encoded in ins
                .IO_IN(IOBUS_IN),     // Data from IO
                .IO_WR(IOBUS_WR),     // IO 1-write 0-read
                .MEM_DOUT1(IR),  // Instruction
                .MEM_DOUT2(DOUT2)); // Data
    
    //PC
    PCTemp PCmod(.pc_address(PC), .jalr(jalr),
              .branch(branch), .jal(jal), 
              .mtvec(mtvec), .mepc(mepc), 
              .pc_source(pcSource), .pc_rst(reset), 
              .pc_write(PCWrite), .clk(clk),
              .pc4(PC4));
    
    //Immed Gen
    ImmedGen ImmGen(.INSTRUCT(IR),.U_TYPE(U_Type),
                    .I_TYPE(I_Type), .S_TYPE(S_Type),
                    .J_TYPE(J_Type), .B_TYPE(B_Type));
    
    // Branch Addr Gen
    BranchAdrGen BranchAdrGen(.J_TYPE(J_Type), .B_TYPE(B_Type),
                              .I_TYPE(I_Type), .RS1(RS1), 
                              .PC(PC), .JAL(jal), 
                              .JALR(jalr), .BRANCH(branch));
    
    // ALU
    ALUMux ALUMux0(.RS1(RS1), .RS2(RS2), 
                   .U_Type(U_Type), .I_Type(I_Type), 
                   .S_Type(S_Type), .PC(PC), 
                   .alu_srcA(alu_srcA), .alu_srcB(alu_srcB), 
                   .srcA(srcA), .srcB(srcB));
    
    ALU ALU0(.A_IN(srcA), .B_IN(srcB),
             .ALU_FUN(alu_fun), .RESULT(result));
             
    // IOBUS Connections         
    always_comb begin
        IOBUS_ADDR = result; //Connect IOBUS_ADDR and ALU result
        IOBUS_OUT = RS2;
    end
    
    //Branch Cond Gen
    BranchCondGen BranchCondGen0(.RS1(RS1), .RS2(RS2),
                                 .EQ(br_eq), .LTU(br_ltu), 
                                 .LTS(br_lt));
    //CU
    CuDcdr CUDCDR0(.opcode(IR[6:0]), .funct3(IR[14:12]), 
                   .funct30(IR[30]), .int_taken(int_taken), 
                   .br_eq(br_eq), .br_ltu(br_ltu), 
                   .br_lt(br_lt), .alu_fun(alu_fun), 
                   .alu_srcA(alu_srcA), .alu_srcB(alu_srcB), 
                   .pcSource(pcSource), .rf_wr_sel(rf_wr_sel));
                   
    always_comb intr_fsm = INTR && CSR_MIE;
    
    CuFSM CUFSM0(.opcode(IR[6:0]), .funct3(IR[14:12]),
                 .clk(clk), .intr(intr_fsm), 
                 .rst(RST), .pcWrite(PCWrite),
                 .regWrite(regWrite), .memWE2(memWE2),
                 .memRDEN1(memRDEN1), .memRDEN2(memRDEN2),
                 .reset(reset), .csr_WE(csr_WE), 
                 .int_taken(int_taken));
    //CSR - temp wire to GND
    CSR CSR0(.reset(reset), .int_taken(int_taken), 
             .ADDR(IR[31:20]), .WR_EN(csr_WE), 
             .CSR_MIE(CSR_MIE), .CSR_MEPC(mepc), 
             .CSR_MTVEC(mtvec), .RD(RD), 
             .PC(PC), .WD(RS1), 
             .clk(clk));
    
endmodule
