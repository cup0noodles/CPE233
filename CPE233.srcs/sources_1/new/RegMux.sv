`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly
// Engineer: Matthew Wong
// 
// Create Date: 02/09/2022 01:46:49 PM
// Design Name: 
// Module Name: OtterMCU
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

module RegMux(PC4, RD, DOUT2, ALU_Result, rf_wr_sel, WD);

    input logic [31:0] PC4, RD, DOUT2, ALU_Result;
    input logic [1:0] rf_wr_sel;
    output logic [31:0] WD;
    
    always_comb begin
        case(rf_wr_sel)
            2'b00: WD = PC4;
            2'b01: WD = RD;
            2'b10: WD = DOUT2;
            2'b11: WD = ALU_Result;
        endcase
    end
endmodule