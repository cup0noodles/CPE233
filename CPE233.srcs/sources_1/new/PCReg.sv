`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal Poly
// Engineer: Matthew Wong
// 
// Create Date: 01/11/2022 01:15:32 PM
// Design Name: 
// Module Name: PCReg
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


module PCReg(pc_din, pc_address, pc_rst, pc_write, clk);

    input logic [31:0] pc_din;
    output logic [31:0] pc_address;
    input logic pc_rst, pc_write, clk;
    
    always_ff @(posedge clk) begin
        if (pc_rst == 1'b1) begin
        //Checks pc_rst before pc_write
            pc_address <= 8'h0000_0000;
        end
        else if ((pc_rst == 1'b0) && (pc_write == 1'b1)) begin
        //pc_rst must be low for pc_write to be considered
            pc_address <= pc_din;
        end
    end
endmodule
