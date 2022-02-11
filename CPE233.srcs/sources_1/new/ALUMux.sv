`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2022 01:11:40 PM
// Design Name: 
// Module Name: ALUMux
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


module ALUMux(RS1, RS2, U_Type, I_Type, S_Type, PC, alu_srcA, alu_srcB, srcA, srcB);
    
    input logic [31:0] RS1, RS2, U_Type, I_Type, S_Type, PC;
    input logic alu_srcA;
    input logic [1:0] alu_srcB;
    
    output logic [31:0] srcA, srcB;
    
    always_comb begin
    
    //srcA Mux
        case(alu_srcA)
            1'b0: srcA = RS1;
            1'b1: srcA = U_Type;
        endcase
    //srcB Mux
        case(alu_srcB)
            2'b00: srcB = RS2;
            2'b01: srcB = I_Type;
            2'b10: srcB = S_Type;
            2'b11: srcB = PC;
        endcase
    end   
endmodule
