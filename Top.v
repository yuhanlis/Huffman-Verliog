`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:28:56 06/11/2020 
// Design Name: 
// Module Name:    Top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Top(
    Clk,
    Reset,
    Data_in,
    Wr_En,
    Outputs,
    Re
    );
    input wire Clk;
    input wire Reset;
    input wire Wr_En;
    input wire [3:0]Data_in;
    output wire Outputs;
    output wire Re;
    reg Eco_en;
Encode eco(
    .Clk(Clk),
    .Reset(Reset),
    .En(Eco_en),
    .Wr_en(Wr_En),
    .Data_in(Data_in),
    .Outputs(Outputs),
    .Re(Re)
    ); 

always @(posedge Clk or negedge Reset)
begin
  if(~Reset)
  begin
  Eco_en<=0;
  end
  else
  Eco_en<=1;
end
endmodule
