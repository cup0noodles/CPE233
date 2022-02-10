`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly
// Engineer: Matthew Wong
// 
// Create Date: 02/08/2022 01:25:33 PM
// Design Name: 
// Module Name: CuDcdr
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

module CuDcdr(opcode, funct3, funct30, int_taken, br_eq, 
              br_ltu, br_lt, alu_fun, 
              alu_srcA, alu_srcB, pcSource, 
              rf_wr_sel);
    
    input logic [6:0] opcode;
    input logic [2:0]funct3;
    input logic funct30, int_taken, br_eq, br_ltu, br_lt;
    
    output logic [3:0] alu_fun;
    output logic [2:0] pcSource;
    output logic [1:0] alu_srcB, rf_wr_sel;
    output logic alu_srcA;
    
    logic branchLogic;
    
    always_comb begin
    //Case by opcode
        case(opcode)
            
            // LUI Type
            lui: begin
            //LUI
                alu_fun = 4'b1001; //LUI Copy
                pcSource = 3'b000; //PC+4
                alu_srcA = 1'b1; //U tpe
                alu_srcB = 2'b00; //Don't Care
                rf_wr_sel = 2'd11; //ALU Result
            end
            
            // AUIPC
            auipc: begin
            //AUIPC
                alu_fun = 4'b0000; //Add
                pcSource = 3'b000; //PC+4
                alu_srcA = 1'b1; //U type
                alu_srcB = 2'b11; //PC
                rf_wr_sel = 2'd11; //ALU Result
            end
            
            // JAL
            jal: begin
            // Jal
                alu_fun = 4'b0000; // Don't Care
                pcSource = 3'b011; // jal
                alu_srcA = 1'b0; //Don't Care
                alu_srcB = 2'b00; //Don't Care
                rf_wr_sel = 2'b00; //PC+4
            end
            
            // JALR
            jalr: begin
            // JALR
                alu_fun = 4'b0000; //DC
                pcSource = 3'b001; //JALR
                alu_srcA = 1'b0; //DC
                alu_srcB = 2'b00; //DC
                rf_wr_sel = 2'd00; //PC+4
            end
            
            // Load
            load: begin
                // All cases (sign/size) handled by Mem
                alu_fun = 4'b0000; //Add
                pcSource = 3'b000; //PC+4
                alu_srcA = 1'b0; //RS1
                alu_srcB = 2'b01; //I Type
                rf_wr_sel = 2'd10; // DOUT2
            end
            
            // ALU with IMM
            aluImm: begin
                case (funct3)
                    //Shift Right Special Case
                    3'b101: alu_fun = {funct30, funct3};
                    //All other cases
                    default: alu_fun = {1'b0, funct3};
                endcase
                
                pcSource = 3'b000; //PC+4
                alu_srcA = 1'b0; //RS1
                alu_srcB = 2'b01; //I Type
                rf_wr_sel = 2'd11; // ALU Result
            end
            
            // Branch
            branch: begin
            //All DC except pcSource
                alu_fun = 4'b0000; //DC
                alu_srcA = 1'b0; //DC
                alu_srcB = 2'b00; //DC
                rf_wr_sel = 2'd00; //DC
                case(funct3[2:1])
                    2'b00: begin //BEQ/BNE
                        branchLogic = funct3[0] || br_eq;
                    end
                    2'b10:begin //BLT/BGE
                        branchLogic = funct3[0] || br_lt;
                    end
                    2'b11: begin
                        branchLogic = funct3[0] || br_ltu;
                    end
                endcase
                pcSource = {0, branchLogic, 0};
            end
            
            // Store
            store: begin
            //All cases controlled by funct3 by Mem Module
                alu_fun = 4'b0000; //Add
                pcSource = 3'b000; //PC+4
                alu_srcA = 1'b0; //RS1
                alu_srcB = 2'b01; //I Type
                rf_wr_sel = 2'd00; //DC
            end
            
            // ALU
            alu: begin
                alu_fun = {funct30, funct3};
                pcSource = 3'b000; //PC+4
                alu_srcA = 1'b0; //RS1
                alu_srcB = 2'b00; //RS2
                rf_wr_sel = 2'd11; // ALU Result
            end
            
            // CSR - Unused
            csr: begin
                alu_fun = 4'b0000;
                pcSource = 3'b000;
                alu_srcA = 1'b0;
                alu_srcB = 2'b00;
                rf_wr_sel = 2'd00;
            end
        
        default: begin
        //Error Case
            alu_fun = 4'b0000;
            pcSource = 3'b000;
            alu_srcA = 1'b0;
            alu_srcB = 2'b00;
            rf_wr_sel = 2'b00;
        end
        
        endcase
    
    end
    
endmodule