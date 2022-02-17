`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/16/2022 03:55:01 PM
// Design Name: 
// Module Name: OTTER_Wrapper_tb
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


module OTTER_Wrapper_tb();
   logic CLK;
   //input BTNL,
   logic BTNC;
   logic [15:0] SWITCHES;
   logic [15:0] LEDS;
   logic [7:0] CATHODES;
   logic [3:0] ANODES;
   
   always begin
        #5 clk <= !clk;
    end
    
                  
    //initial begin
      //  clk = 1;
        //RST = 1;
        //INTR = 0;
        //#10;
        //RST = 0;
        //IOBUS_IN = 32'h0000_0000;
    //end
endmodule
