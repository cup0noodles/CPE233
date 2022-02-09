`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/01/2022 09:27:56 PM
// Design Name: 
// Module Name: BranchAdrGen_tb
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


module BranchAdrGen_tb();

    logic [31:0] J, B, I, RS1, PC, JAL, JALR, BRANCH;
    
    BranchAdrGen UUT (.J_TYPE(J), .B_TYPE(B),
                       .I_TYPE(I), .RS1(RS1),
                       .PC(PC), .JAL(JAL),
                       .JALR(JALR), .BRANCH(BRANCH));
    
    initial begin
        
        //0ns First Tests - See table for all expected
        PC = 32'h0000_5FFC;
        B = 32'hFFFF_A004;
        J = 32'hFFFF_A004;
        RS1 = 32'h0000_2004;
        I = 32'hFFFF_E214;
        
        //10ns
        #10;
        PC = 32'h0000_0000;
        B = 32'h0000_5FFC;
        J = 32'h0000_5FFC;
        RS1 = 32'hFFFF_E214;
        I = 32'h0000_2004;
        
        //20ns
        #10;
        PC = 32'h0000_3FCC;
        B = 32'h0000_0204;
        J = 32'h0000_0204;
        RS1 = 32'h0000_2004;
        I = 32'h0000_2004;
        
        //30ns
        #10;
        RS1 = 32'h0000_0000;
        I = 32'h0000_011C;
        
    end
    
endmodule
