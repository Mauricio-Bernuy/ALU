/////////////////////////////////////////
// 7 Op ALU Simulation
/////////////////////////////////////////

module ALU (clk, reset, A, B, Opcode, result);

// var declaration 

input clk;
input reset;

input[31:0] A;
input[31:0] B;
input[3:0] Opcode;
output[31:0] result;

reg[31:0] Opcode;

// parameters

// Logic params

parameter AND   = 0100;
parameter OR    = 0101;
parameter NOR   = 0111;
parameter XOR   = 0110

// Arithmetic params

parameter add   = 0000;
parameter sub   = 0010;
parameter slt   = 1010;

