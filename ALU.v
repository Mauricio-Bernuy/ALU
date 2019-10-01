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
// parameters

// Logic params

parameter AND   = 4'b0100;
parameter OR    = 4'b0101;
parameter NOR   = 4'b0111;
parameter XOR   = 4'b0110;

// Arithmetic params

parameter add   = 4'b0000;
parameter sub   = 4'b0010;
parameter slt   = 4'b1010;

// Zero params
parameter zeronum = 32'b0;

// ALU Logic
always @(posedge clk or negedge clk)
    begin
        if (result == zeronum)  zero = 1'b1;
        else                    zero = 1'b0;
    end

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

            slt:    result = (A<B) ? 1'b1 : 1'b0;

            default: result <= zeronum;
        endcase        
    end
    
endmodule