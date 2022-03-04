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
   logic BTNL;
   logic BTNC;
   logic [15:0] SWITCHES;
   logic [15:0] LED;
   logic [7:0] CATHODES;
   logic [3:0] ANODES;
   
   OTTER_Wrapper UUT(.CLK(CLK), .BTNC(BTNC), .BTNL(BTNL), .SWITCHES(SWITCHES), .LED(LEDS), .CATHODES(CATHODES), .ANODES(ANODES));
   
   always begin
        #5 CLK <= !CLK;
    end
    
                  
    initial begin
        CLK = 1;
        SWITCHES = 16'h0000;
        BTNL = 0;
        #10 BTNC = 1;
        BTNC = 0;
        //#500 BTNL = 1;
        //#200 BTNL = 0;
    end
endmodule
