`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/01/2022 09:28:45 PM
// Design Name: 
// Module Name: BranchCondGen_tb
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


module BranchCondGen_tb();
    
    logic [31:0] A_IN, B_IN;
    logic EQ, LTU, LTS;
    
    BranchCondGen UUT(.RS1(A_IN), .RS2(B_IN), .EQ(EQ), .LTU(LTU), .LTS(LTS));
    
    initial begin
    
    A_IN = 0;   // Initial Values
    B_IN = 0;   // Test 0 = 0, EQ = 1
    
    #10 A_IN = 32'h0000_0000;   //unsigned normal values
    B_IN = 32'h0000_00001;      //LTU = 1, LTS = 1, EQ = 0
    
    #10 A_IN = 32'h0000_0001;   //unsigned normal values
    B_IN = 32'h0000_00000;      //LTU = 0, LTS = 0, EQ = 0
    
    #10 A_IN = 32'hFFFF_FFFF;   //LTU = 0, LTS = 0, EQ = 0
    B_IN = 32'h9000_0000;
    
    #10 A_IN = 32'h9000_0000;   //LTU = 1, LTS = 1, EQ = 0
    B_IN = 32'hFFFF_FFFF;

    #10 A_IN = 32'h9100_0000;   //LTU = 0, LTS = 1, EQ = 0
    B_IN = 32'h0000_000F;
    
    #10 A_IN = 32'h0000_000F;   //LTU = 1, LTS = 0, EQ = 0
    B_IN = 32'h9100_000F;
    
    #10 A_IN = 32'hFFFF_FFFF;   //LTU = 0, LTS = 0, EQ = 1
    B_IN = 32'hFFFF_FFFF;       //Max Val
    
    end
    
endmodule
