`timescale 1ns / 1ps

module ProgRomSim();

logic [31:0] nAdr, Adr, Ins;
logic clk;

ProgRom UUT (.PROG_CLK(clk), .PROG_ADDR(Adr), .INSTRUCT(Ins));

always begin
    #5 clk <= ! clk;
end

initial begin
    clk = 0;
    Adr = 8'h00000000;
    while (Adr < 8'h00000020) begin
        nAdr <= Adr + 8'h00000004;
        Adr <= nAdr;
    #10;
    end
end

endmodule
