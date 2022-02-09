`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/01/2022 09:26:58 PM
// Design Name: 
// Module Name: BranchAdrGen
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


module BranchAdrGen(J_TYPE, B_TYPE, I_TYPE,
                    RS1, PC, JAL, JALR, BRANCH
                    );
    input logic [31:0] J_TYPE, B_TYPE, I_TYPE, RS1, PC;
    output logic [31:0] JAL, JALR, BRANCH;
    
    always_comb begin
    
        BRANCH = PC + B_TYPE;
        JAL = PC + J_TYPE;
        JALR = RS1 + I_TYPE;
    
    end
    
endmodule
