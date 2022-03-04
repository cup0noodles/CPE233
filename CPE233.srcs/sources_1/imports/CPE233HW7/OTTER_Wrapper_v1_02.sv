`timescale 1ns / 1ps
/////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer: J. Calllenes
//           P. Hummel
//
// Create Date: 01/20/2019 10:36:50 AM
// Module Name: OTTER_Wrapper
// Target Devices: OTTER MCU on Basys3
// Description: OTTER_WRAPPER with Switches, LEDs, and 7-segment display
//
// Revision:
// Revision 0.01 - File Created
// Revision 0.02 - Updated MMIO Addresses, signal names
/////////////////////////////////////////////////////////////////////////////

module OTTER_Wrapper(
   input CLK,
   input BTNL,
   input BTNC,
   input [15:0] SWITCHES,
   output logic [15:0] LED,
   output [7:0] CATHODES,
   output [3:0] ANODES,
   output [7:0] VGA_RGB,
   output VGA_HS,
   output VGA_VS
   );
       
    // INPUT PORT IDS ///////////////////////////////////////////////////////
    // Right now, the only possible inputs are the switches
    // In future labs you can add more MMIO, and you'll have
    // to add constants here for the mux below
    localparam SWITCHES_AD = 32'h11000000;
    localparam VGA_READ_AD = 32'h11000160;
           
    // OUTPUT PORT IDS //////////////////////////////////////////////////////
    // In future labs you can add more MMIO
    localparam LEDS_AD    = 32'h11000020; //32'h11000020
    localparam SSEG_AD    = 32'h11000040; //32'h11000040
    localparam VGA_ADDR_AD = 32'h11000120;
    localparam VGA_COLOR_AD = 32'h11000140; 
    
   // Signals for connecting OTTER_MCU to OTTER_wrapper /////////////////////
   logic clk_50 = 0;
    
   logic [31:0] IOBUS_out, IOBUS_in, IOBUS_addr;
   logic s_reset, s_intr, IOBUS_wr;
   
   // Registers for buffering outputs  /////////////////////////////////////
   logic [15:0] r_SSEG;
    
   // Declare OTTER_CPU ////////////////////////////////////////////////////
   OtterMCU CPU (.RST(s_reset), .INTR(s_intr), .clk(clk_50),
                  .IOBUS_OUT(IOBUS_out), .IOBUS_IN(IOBUS_in),
                  .IOBUS_ADDR(IOBUS_addr), .IOBUS_WR(IOBUS_wr));

   // Declare Seven Segment Display /////////////////////////////////////////
   SevSegDisp SSG_DISP (.DATA_IN(r_SSEG), .CLK(CLK), .MODE(1'b0),
                       .CATHODES(CATHODES), .ANODES(ANODES));
   
   
   // Signals for connecting VGA Framebuffer Driver
   logic r_vga_we;             // write enable
   logic [12:0] r_vga_wa;      // address of framebuffer to read and write
   logic [7:0] r_vga_wd;       // pixel color data to write to framebuffer
   logic [7:0] r_vga_rd;       // pixel color data read from framebuffer
 
   //logic [15:0]  r_SSEG;
   
      // Declare VGA Frame Buffer //////////////////////////////////////////////
   vga_fb_driver_80x60 VGA(.CLK_50MHz(clk_50), .WA(r_vga_wa), .WD(r_vga_wd),
                               .WE(r_vga_we), .RD(r_vga_rd), .ROUT(VGA_RGB[7:5]),
                               .GOUT(VGA_RGB[4:2]), .BOUT(VGA_RGB[1:0]),
                               .HS(VGA_HS), .VS(VGA_VS)); 
                           
   // Clock Divider to create 50 MHz Clock //////////////////////////////////
   always_ff @(posedge CLK) begin
       clk_50 <= ~clk_50;
   end
   
   // Connect Signals Debounce///////////////////////////////////////////////////////
   logic BTNC_DB;
   debounce_one_shot BTNCFilter(.CLK(clk_50), .BTN(BTNC), .DB_BTN(BTNC_DB));
   assign s_reset = BTNC_DB;
   
   logic BTNL_DB;
   debounce_one_shot BTNLFilter(.CLK(clk_50), .BTN(BTNL), .DB_BTN(BTNL_DB));
   assign s_intr = BTNL_DB;
   //assign s_intr = BTNL;
   
   // Connect Board input peripherals (Memory Mapped IO devices) to IOBUS
   always_comb begin
        case(IOBUS_addr)
            SWITCHES_AD: IOBUS_in = {16'b0,SWITCHES};
            VGA_READ_AD: IOBUS_in = {24'b0, r_vga_rd};
            default:     IOBUS_in = 32'b0;    // default bus input to 0
        endcase
    end
   
   
   // Connect Board output peripherals (Memory Mapped IO devices) to IOBUS
    always_ff @ (posedge clk_50) begin
        if(IOBUS_wr)
            case(IOBUS_addr)
                LEDS_AD: LED   <= IOBUS_out[15:0];
                SSEG_AD: r_SSEG <= IOBUS_out[15:0];
                VGA_ADDR_AD: r_vga_wa <= IOBUS_out[12:0];
                VGA_COLOR_AD: begin  
                        r_vga_wd <= IOBUS_out[7:0];
                        r_vga_we <= 1;
                    end
            endcase
    end
   
endmodule
