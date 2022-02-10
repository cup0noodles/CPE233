`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly
// Engineer: Matthew Wong
// 
// Create Date: 02/09/2022 11:27:42 AM
// Design Name: 
// Module Name: CuFSM
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

parameter lui   = 7'b0110111;
parameter auipc = 7'b0010111;
parameter jal   = 7'b1101111;
parameter jalr  = 7'b1100111;
parameter load  = 7'b0000011;
parameter aluImm = 7'b0010011;
parameter branch = 7'b1100011;
parameter store = 7'b0100011;
parameter alu   = 7'b0110011;
parameter csr   = 7'b1110011;


module CuFSM(
    input [6:0] opcode,
    input [2:0] funct3,
    input clk,
    input intr,
    input rst,
    output pcWrite,
    output regWrite,
    output memWE2,
    output memRDEN1,
    output memRDEN2,
    output reset,
    output csr_WE,
    output int_taken
    );
    
    typedef enum{ST_INIT, ST_FETCH, ST_EXEC, ST_WB}STATE_type;
    
    STATE_type NS, PS;
    
    always_ff @(posedge clk) begin
    
        if (RST == 1'b1) begin
            PS <= ST_INIT;
        end
        else begin
            PS <= NS;
        end
    end
    
    always_comb begin
        // Init all to 0
        pcWrite = 1'b0;
        regWrite = 1'b0;
        memWE2 = 1'b0;
        memRDEN1 = 1'b0;
        memRDEN2 = 1'b0;
        reset = 1'b0;
        csr = 1'b0;
        int_taken = 1'b0;
        
        case (PS)
            ST_INIT: begin
                reset = 1'b1;
                NS = ST_FETCH;
            end
            
            ST_FETCH: begin
                RDEN1 = 1'b1;
                NS = ST_EXEC;
            end
            
            ST_EXEC: begin
                case(opcode)
                    // LUI
                    lui: begin
                        pcWrite = 1'b1;
                        regWrite = 1'b1;
                        NS = ST_FETCH;
                    end
                    
                    // AUIPC
                    auipc: begin
                        pcWrite = 1'b1;
                        regWrite = 1'b1;
                        NS = ST_FETCH;
                    end
                    
                    // JAL
                    jal: begin
                        pcWrite = 1'b1;
                        regWrite = 1'b1;
                        NS = ST_FETCH;
                    end
                    
                    // JALR
                    jalr: begin
                        pcWrite = 1'b1;
                        regWrite = 1'b1;
                        NS = ST_FETCH;
                    end
                    
                    // Load
                    load: begin
                        memRDEN2 = 1'b1;
                        NS = ST_WB;
                    end
                    
                    // ALU Imm
                    aluImm: begin
                        pcWrite = 1'b1;
                        regWrite = 1'b1;
                        NS = ST_FETCH;
                    end
                    
                    // Branch
                    branch: begin
                        pcWrite = 1'b1;
                        NS = ST_FETCH;
                    end
                    
                    // Store
                    store: begin
                        pcWrite = 1'b1;
                        memWE2 = 1'b1;
                        NS = ST_FETCH;
                    end
                    
                    // ALU
                    alu: begin
                        pcWrite = 1'b1;
                        regWrite = 1'b1;
                        NS = ST_FETCH;
                    end
                    
                    //CSR
                    csr: begin
                        // Unused
                    NS = ST_FETCH;
                    end
                endcase
            end
            
            ST_WB: begin
                pcWrite = 1'b1;
                regWrite = 1'b1;
                NS = ST_FETCH;
            end
            
        endcase
    end
endmodule
