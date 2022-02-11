`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2022 06:13:01 PM
// Design Name: 
// Module Name: OtterMCU_tb
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


module OtterMCU_tb();
    //Input
    logic RST, INTR, clk;
    logic [31:0] IOBUS_IN;
    //Output
    logic IOBUS_WR;
    logic [31:0] IOBUS_OUT, IOBUS_ADDR;

    OtterMCU MCU0(.RST(RST), .INTR(INTR), 
                  .IOBUS_IN(IOBUS_IN), .clk(clk), 
                  .IOBUS_WR(IOBUS_WR), .IOBUS_OUT(IOBUS_OUT), 
                  .IOBUS_ADDR(IOBUS_ADDR));
    always begin
        #5 clk <= !clk;
    end
    
                  
    initial begin
        clk = 1;
        RST = 1;
        INTR = 0;
        #10;
        RST = 0;
    end
endmodule
