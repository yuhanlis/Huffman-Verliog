`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:31:02 06/11/2020
// Design Name:   Top
// Module Name:   D:/veri/huf1/Top_tb.v
// Project Name:  huf1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Top_tb;

	// Inputs
	reg Clk;
	reg Reset;
	reg [3:0] Data_in;
	reg Wr_En;

	// Outputs
	wire Outputs;
	wire Re;

	// Instantiate the Unit Under Test (UUT)
	Top uut (
		.Clk(Clk), 
		.Reset(Reset), 
		.Data_in(Data_in), 
		.Wr_En(Wr_En), 
		.Outputs(Outputs), 
		.Re(Re)
	);

	initial begin
		// Initialize Inputs
		Clk = 0;
		Reset = 0;
		Data_in = 0;
		Wr_En = 0;

		// Wait 100 ns for global reset to finish
		#100;
      Reset = 1;  
		// Add stimulus here
      #100;
		write(1);
	end
   always #5 Clk=~Clk;

task write;
		input enable;
		integer i;
		begin
			Wr_En=1;
			for(i=0;i<20;i=i+1)
			@(posedge Clk)
			begin
			Wr_En=1;
			Data_in=4'b0001;
			end
			for(i=20;i<50;i=i+1)
			@(posedge Clk)
			begin
			Wr_En=1;
			Data_in=4'b0010;
			end
			for(i=50;i<70;i=i+1)
			@(posedge Clk)
			begin
			Wr_En=1;
			Data_in=4'b0011;
			end
			for(i=70;i<100;i=i+1)
			@(posedge Clk)
			begin
			Wr_En=1;
			Data_in=4'b0100;
			end
			for(i=100;i<120;i=i+1)
			@(posedge Clk)
			begin
			Wr_En=1;
			Data_in=4'b0101;
			end
			for(i=120;i<150;i=i+1)
			@(posedge Clk)
			begin
			Wr_En=1;
			Data_in=4'b0110;
			end
			for(i=150;i<200;i=i+1)
			@(posedge Clk)
			begin
			Wr_En=1;
			Data_in=4'b0111;
			end
			for(i=200;i<210;i=i+1)
			@(posedge Clk)
			begin
			Wr_En=1;
			Data_in=4'b1000;
			end
			for(i=210;i<230;i=i+1)
			@(posedge Clk)
			begin
			Wr_En=1;
			Data_in=4'b1001;
			end
			for(i=230;i<255;i=i+1)
			@(posedge Clk)
			begin
			Wr_En=1;
			Data_in=4'b1001;
			end
			
			@(posedge Clk)
			Wr_En=0;
			end
		endtask   
endmodule

