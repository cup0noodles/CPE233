`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/01/2022 09:26:58 PM
// Design Name: 
// Module Name: BranchCondGen
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


module BranchCondGen(RS1, RS2, EQ, LTU, LTS);

    input logic [31:0] RS1, RS2;
    output logic EQ, LTU, LTS;
    
    always_comb begin
        EQ = (RS1 == RS2);
        LTU = (RS1 < RS2);
        LTS = ($signed(RS1) < $signed(RS2));
    end

endmodule