`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/11/2022 01:15:32 PM
// Design Name: 
// Module Name: PCMux
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


module PCMux(pc_address, jalr, branch, jal, mtvec, mepc, pc_din, pc_source);

    input logic [31:0] pc_address, jalr, branch, jal, mtvec, mepc;
    output logic [31:0] pc_din;
    input logic [3:0] pc_source;
    
    always_comb begin        
        case (pc_source)
        //cases for each of 8 possible states of pc_source
            3'b001    : pc_din = jalr;
            3'b010    : pc_din = branch;
            3'b011    : pc_din = jal;
            3'b100    : pc_din = mtvec;
            3'b101    : pc_din = mepc;
            default : pc_din = pc_address + 'h4;
            //default used to catch 0, 6, 7
        endcase
    end
endmodule
