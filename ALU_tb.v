`timescale 1s/1ns
`include "ALU.v"

module ALU_tb;
//var declaration
    reg clk;
    reg[31:0] A;
    reg[31:0] B;
    reg[3:0] Opin;

    wire[31:0] result;
    wire zero;

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

//device under test
ALU dut(clk, A, B, Opin, result, zero);

initial begin
    $dumpfile("ALU.vcd");
    $dumpvars(0, ALU_tb);
//1s clock
    clk = 0;
    forever #0.5 clk=~clk;
end

initial begin
//inputs
    A = 32'b00000000000000000000000000011011;
    B = 32'b00000000000000000000000000011011;
end

initial begin
//Op inputs
    Opin = AND; #2
    Opin = OR; #2
    Opin = NOR; #2
    Opin = XOR; #2
    Opin = add; #2
    Opin = sub; #2
    Opin = slt; #2
    #4
    $finish;
end

endmodule