`timescale 1ns / 1ps

module ImmedGen_tb();

    logic [31:0] INS, U, I, S, B, J;
    
    ImmedGen UUT(.INSTRUCT(INS), .U_TYPE(U),
                 .I_TYPE(S), .B_TYPE(B), 
                 .J_TYPE(J));
    
    initial begin
        // U Type Test
            #10 INS = {'hABCDEF, 1'b0, 7'b0110111};
            #10 INS = {'h123456, 1'b0, 7'b0110111};
        
        //I Type Test
            //13 bits should be ignored
            //Sign Extend 1
            #10 INS = {1'b1, 11'b11001100110, 13'b1111111111111, 7'b0010011};
            //Sign Extend 0
            #10 INS = {1'b0, 11'b11001100110, 13'b1111111111111, 7'b0010011};
        
        //S Type Test
            //Sign Extend 1
            //Check for 13-bits ignored
            #10 INS = {1'b1, 6'b000000, 13'b1111111111111, 5'b00000, 7'b0100011};
            //Sign Extend 0
            //Check for IR[30:25]
            #10 INS = {1'b0, 6'b010101, 13'b1111111111111, 5'b00000, 7'b0100011};
            //Check for IR[11:7]
            #10 INS = {1'b0, 6'b000000, 13'b1111111111111, 5'b01010, 7'b0100011};
        
        //B Type Test
            //Sign Extend 0
            //Check for IR[7]
            //13-bits should be ignored
            #10 INS = {1'b0, 6'b000000, 13'b1111111111111, 4'b0000, 1'b1, 7'b1100011};
            //Check for IR[30:25]
            #10 INS = {1'b0, 6'b101010, 13'b1111111111111, 4'b0000, 1'b0, 7'b1100011};
            //Check for IR[11:8]
            #10 INS = {1'b0, 6'b000000, 13'b1111111111111, 4'b1010, 1'b0, 7'b1100011};
            //Sign Extend 1
            #10 INS = {1'b1, 6'b000000, 13'b1111111111111, 4'b0000, 1'b0, 7'b1100011};
        
        //J Type Test
            //Sign Extend 0
            // 5-bits should be ignored
            //Check for IR[19:12]
            #10 INS = {1'b0, 10'b0000000000, 1'b0, 8'b10101010, 5'b11111, 7'b1101111};
            //Check for IR[20]
            #10 INS = {1'b0, 10'b0000000000, 1'b1, 8'b00000000, 5'b11111, 7'b1101111};
            //Check for IR[30:21]
            #10 INS = {1'b0, 10'b1010101010, 1'b0, 8'b00000000, 5'b11111, 7'b1101111};
            //Sign Extend 1
            #10 INS = {1'b1, 10'b0000000000, 1'b0, 8'b00000000, 5'b00000, 7'b1101111};
    end
    
endmodule
