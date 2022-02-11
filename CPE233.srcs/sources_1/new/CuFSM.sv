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

module CuFSM(opcode, funct3, clk, intr, rst, 
             pcWrite, regWrite, memWE2, memRDEN1,
             memRDEN2, reset, csr_WE, int_taken);
             
    output logic pcWrite, regWrite, memWE2, memRDEN1, memRDEN2, reset, csr_WE, int_taken;
    input logic clk, intr, rst; 
    input logic [2:0] funct3;
    input logic [6:0] opcode;
    
    typedef enum{ST_INIT, ST_FETCH, ST_EXEC, ST_WB}STATE_type;
    
    STATE_type NS, PS;
    
    always_ff @(posedge clk) begin
    
        if (rst == 1'b1) begin
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
        csr_WE = 1'b0;
        int_taken = 1'b0;
        
        case (PS)
            ST_INIT: begin
                reset = 1'b1;
                NS = ST_FETCH;
            end
            
            ST_FETCH: begin
                memRDEN1 = 1'b1;
                NS = ST_EXEC;
            end
            
            ST_EXEC: begin
                case(opcode)
                    // LUI
                    7'b0110111: begin
                        pcWrite = 1'b1;
                        regWrite = 1'b1;
                        NS = ST_FETCH;
                    end
                    
                    // AUIPC
                    7'b0010111: begin
                        pcWrite = 1'b1;
                        regWrite = 1'b1;
                        NS = ST_FETCH;
                    end
                    
                    // JAL
                    7'b1101111: begin
                        pcWrite = 1'b1;
                        regWrite = 1'b1;
                        NS = ST_FETCH;
                    end
                    
                    // JALR
                    7'b1100111: begin
                        pcWrite = 1'b1;
                        regWrite = 1'b1;
                        NS = ST_FETCH;
                    end
                    
                    // Load
                    7'b0000011: begin
                        memRDEN2 = 1'b1;
                        NS = ST_WB;
                    end
                    
                    // ALU Imm
                    7'b0010011: begin
                        pcWrite = 1'b1;
                        regWrite = 1'b1;
                        NS = ST_FETCH;
                    end
                    
                    // Branch
                    7'b1100011: begin
                        pcWrite = 1'b1;
                        NS = ST_FETCH;
                    end
                    
                    // Store
                    7'b0100011: begin
                        pcWrite = 1'b1;
                        memWE2 = 1'b1;
                        NS = ST_FETCH;
                    end
                    
                    // ALU
                    7'b0110011: begin
                        pcWrite = 1'b1;
                        regWrite = 1'b1;
                        NS = ST_FETCH;
                    end
                    
                    //CSR
                    7'b1110011: begin
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
