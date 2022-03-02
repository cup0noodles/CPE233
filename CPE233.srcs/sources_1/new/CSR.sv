`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2022 01:45:17 PM
// Design Name: 
// Module Name: CSR
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
localparam MIE_ADDR = 12'h304;
localparam MTVEC_ADDR = 12'h305;
localparam MEPC_ADDR = 12'h341;

module CSR(reset, int_taken, ADDR, WR_EN, CSR_MIE, CSR_MEPC, CSR_MTVEC, RD, PC, WD, clk);
    input logic reset, int_taken, WR_EN, clk; //csr_WE
    input logic [11:0] ADDR; //IR[31:20]
    input logic [31:0] PC, WD; //RS1
    output logic CSR_MIE;
    output logic [31:0] CSR_MEPC, CSR_MTVEC, RD; //to PCMux, RegMux
    
    //Create Registers
    logic [31:0] register [2:0];
    //MIE, MTVEC, MEPC
    
    logic [1:0] wr_addr;
    
    always_comb begin //Translate addr from RISCV addr to ones used here
        case (ADDR)
            MIE_ADDR: wr_addr = 2'b00;
            MTVEC_ADDR: wr_addr = 2'b01;
            MEPC_ADDR: wr_addr = 2'b11;
            default: wr_addr = 2'b00;
        endcase
    end
    
    //Init to GND
    initial begin
        register[0] = 0;
        register[1] = 0;
        register[2] = 0;
    end
    
    always_ff @(posedge clk) begin
        if (reset) begin
            register[0] = 0;
            register[1] = 0;
            register[2] = 0;
        end
        
        else if (int_taken) begin
            register[2] = PC; //MEPC = PC
            register[0] = 0; //Disable INTR
        end
        
        else if (WR_EN) begin
            register[wr_addr] = WD;        
        end
    end
    
    always_comb begin //Read
        CSR_MIE = register[0];
        CSR_MTVEC = register[1];
        CSR_MEPC = register[2];
        RD = register[wr_addr];
    end
endmodule
