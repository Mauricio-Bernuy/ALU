`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Description:    This is a poor attempt at writing an ALU
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module bad_ALU(
	input clk,
	input[31:0] A, B,
	input[3:0] Opin,
	output [31:0] result,
	output zero);
   
   reg 				slt;       
   reg [31:0]		result; 
   reg				zero;
   
   reg [31:0]		alu_val;					// we need to declare this reg
   reg [31:0]		diff;
   wire				ss0;
   wire 				ss1; 
   wire 				Ss2; 
   wire 				ss3;
   wire 				logicsel;
   
	assign {ss0,ss1,ss2,ss3} = Opin;	// make assigns

	

   // define the logicfunction 
	always @ ( * )
	begin
		if (ss1 == 1)
			if (ss2 == 1) 
				if (ss3 == 1)
					result<= ~(A | B);
				else
					result<= A ^ B;
			else
				if (ss3 == 1)	
					result<= A | B;
				else
					result<= A & B;				
    end   

	always @ ( posedge clk )
		if (Opin == 4'b1010)
		begin
			diff <= A - B;		
			slt=0;
								// calculate the difference			
			if (diff[31]>0)
				begin
					slt<=1;
				end				// if MSB is 1 slt is 1 
		end		
					

	always @ ( * )
	begin
		case (Opin)
			4'b0000 : alu_val = A + B;
			4'b0010 : alu_val = A - B;
			4'b1010 : alu_val = slt;
			default : alu_val = 32'b0;
		endcase		 
	result <= alu_val; 
	zero = (alu_val == 32'b0) ? 1: 0;
   
	end

   always @( * ) 
    begin
        if (result == 0)	zero = 1'b1;
        else				zero = 1'b0;
    end
	
endmodule
