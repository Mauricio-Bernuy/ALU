/////////////////////////////////////////
// 7 Op ALU Simulation
/////////////////////////////////////////

module ALU (clk, reset, A, B, Opin, result, zero);

// var declaration 

input clk;
input reset;

input[31:0] A;
input[31:0] B;
input[3:0] Opin;
output[31:0] result;
output zero;

reg[3:0] Opcode;
reg[31:0] result;
reg zero;
reg temp;
// parameters

// Logic params

parameter AND   = 0100;
parameter OR    = 0101;
parameter NOR   = 0111;
parameter XOR   = 0110;

// Arithmetic params

parameter add   = 0000;
parameter sub   = 0010;
parameter slt   = 1010;

// Zero params
parameter zeronum = 32'b00000000000000000000000000000000;

// ALU Logic

always @(posedge clk)
    begin
        Opcode <= Opin;
        case (Opcode)
            AND:    result <= A & B;
            OR:     result <= A | B;
            NOR:    result <= A ~| B;
            XOR:    result <= A ^ B;
            add:    result <= A + B;
            sub:    result <= A - B;
            slt:    
                result <= A-B;
                assign temp = result[31];
                result <= 32'(signed'(temp));
               
            default: result <= zeronum;
        endcase

        if (result <= zeronum)  zero = 1'b1;
        else                    zero = 1'b0;
    end
endmodule