`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:25:43 06/11/2020 
// Design Name: 
// Module Name:    Huf 
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
//Huf模块
// 功能：通过各数字的频率对数字进行编码
// 引脚说明：Count0-9输入频率，Code0-1输出对应的哈夫曼编码
module Huf(
    Clk,
    Reset,
    Count0,
    Count1,
    Count2,
    Count3,
    Count4,
    Count5,
    Count6,
    Count7,
    Count8,
    Count9,
    En,
    Code0,
    Code1,   
    Code2,
    Code3,
    Code4,
    Code5,
    Code6,
    Code7,
    Code8,
    Code9,
    Re
    );
input wire Clk;
input wire Reset;
input wire [7:0] Count0;//count0-9是个数
input wire [7:0] Count1;
input wire [7:0] Count2;
input wire [7:0] Count3;
input wire [7:0] Count4;
input wire [7:0] Count5;
input wire [7:0] Count6;
input wire [7:0] Count7;
input wire [7:0] Count8;
input wire [7:0] Count9;
input wire En;

output reg Re;
output reg [5:0] Code0;//code是0-9的编码
output reg [5:0] Code1;
output reg [5:0] Code2;
output reg [5:0] Code3;
output reg [5:0] Code4;
output reg [5:0] Code5;
output reg [5:0] Code6;
output reg [5:0] Code7;
output reg [5:0] Code8;
output reg [5:0] Code9;

reg [3:0] Node[9:0];        //Node用来绑定各个连接在一个节点的数字，相当于哈夫曼树的节点
reg [7:0] Count [9:0];      
wire [3:0] Min_1;
wire [3:0] Min_2;
reg Sel_en;
wire Sel_don;
reg [1:0] state;

//例化选择模块，选择两个频率最小的数
Sel_min_2 Sel(
    .Clk(Clk),
    .En(Sel_en),
    .Count0(Count[0]),
    .Count1(Count[1]),
    .Count2(Count[2]),
    .Count3(Count[3]),
    .Count4(Count[4]),
    .Count5(Count[5]),
    .Count6(Count[6]),
    .Count7(Count[7]),
    .Count8(Count[8]),
    .Count9(Count[9]),
    .Min_1(Min_1),
    .Min_2(Min_2),
    .R_en(Sel_don)
);


always @(posedge Clk or negedge Reset)
begin
  if(~Reset)
    begin
      Re<=0;
      Code0<=6'b000001;//code赋初值
      Code1<=6'b000001;
      Code2<=6'b000001;
      Code3<=6'b000001;
      Code4<=6'b000001;
      Code5<=6'b000001;
      Code6<=6'b000001;
      Code7<=6'b000001;
      Code8<=6'b000001;
      Code9<=6'b000001;
      Node[0]<=4'b0000;//node赋初值二进制
      Node[1]<=4'b0001;
      Node[2]<=4'b0010;
      Node[3]<=4'b0011;
      Node[4]<=4'b0100;
      Node[5]<=4'b0101;
      Node[6]<=4'b0110;
      Node[7]<=4'b0111;
      Node[8]<=4'b1000;
      Node[9]<=4'b1001;
		Count[0]<=8'h00;//count计数赋初值0
		Count[1]<=8'h00;
		Count[2]<=8'h00;
		Count[3]<=8'h00;
		Count[4]<=8'h00;
		Count[5]<=8'h00;
		Count[6]<=8'h00;
		Count[7]<=8'h00;
		Count[8]<=8'h00;
		Count[9]<=8'h00;
		Sel_en<=0;
      state<=2'b00;//进入状态0
    end
    else if(En)
    begin
        case (state)
            2'b00:                  //状态0将各数字频率存到数组
                begin
                     Count[0]<=Count0;
                     Count[1]<=Count1;
                     Count[2]<=Count2;
                     Count[3]<=Count3;
                     Count[4]<=Count4;
                     Count[5]<=Count5;
                     Count[6]<=Count6;
                     Count[7]<=Count7;
                     Count[8]<=Count8;
                     Count[9]<=Count9;
                     state<=2'b01;//进入状态1
                     Sel_en<=1;//Sel_min_2的使能赋值为1
                 end
            2'b01:                  //状态1：等待选择完成，选择完成后拉低选择模块使能端进入状态二
                begin
                    if(Sel_don==1)
                        begin
                            Sel_en<=0;
                            state<=2'b10;//进入状态2
                        end
							else
								Sel_en<=1;
                end
            2'b10:                  //状态2：选出频率最小两个数字后进行编码
                begin
                    if(Count[Min_2]==8'hff)     //判断完成，如果频率最小的数字频率为256则达到顶点，建树完成，跳至状态3
                        state<=2'b11;
                    else
                    begin
                    Count[Min_1]<=8'hff;             //将频率最小的数字的频率置为最大
                    Count[Min_2]<=Count[Min_1]+Count[Min_2];//将频率第二小的数字的频率置为Min1+Min2作为两个节点的父节点

                    //此处将小的编码左移作为左孩子，大的编码左移一位并加一作为右孩子，将小的Node改为大的Node，使较大的一个数字作为两个的父节点
                    if(Node[0]==Min_1) 
						  begin 
						      Node[0]<=Min_2; 
						      Code0<=Code0<<1;//最小的数放在左边，左0右1，空的位自动补0
						  end
                    else if(Node[0]==Min_2) 
						  begin 
						      Code0<=(Code0<<1)+1;//第二小的在最小的数的右边，所以同样是左移，之后+1，因为是左0右1
						  end
                    if(Node[1]==Min_1) begin Node[1]<=Min_2; Code1<=Code1<<1;end//后面的同理以此类推
                    else if(Node[1]==Min_2) begin Code1<=(Code1<<1)+1;end
                    if(Node[2]==Min_1) begin Node[2]<=Min_2; Code2<=Code2<<1;end
                    else if(Node[2]==Min_2) begin Code2<=(Code2<<1)+1;end
                    if(Node[3]==Min_1) begin Node[3]<=Min_2; Code3<=Code3<<1;end
                    else if(Node[3]==Min_2) begin Code3<=(Code3<<1)+1;end
                    if(Node[4]==Min_1) begin Node[4]<=Min_2; Code4<=Code4<<1;end
                    else if(Node[4]==Min_2) begin Code4<=(Code4<<1)+1;end
                    if(Node[5]==Min_1) begin Node[5]<=Min_2; Code5<=Code5<<1;end
                    else if(Node[5]==Min_2) begin Code5<=(Code5<<1)+1;end
                    if(Node[6]==Min_1) begin Node[6]<=Min_2; Code6<=Code6<<1;end
                    else if(Node[6]==Min_2) begin Code6<=(Code6<<1)+1;end
                    if(Node[7]==Min_1) begin Node[7]<=Min_2; Code7<=Code7<<1;end
                    else if(Node[7]==Min_2) begin Code7<=(Code7<<1)+1;end
                    if(Node[8]==Min_1) begin Node[8]<=Min_2; Code8<=Code8<<1;end
                    else if(Node[8]==Min_2) begin Code8<=(Code8<<1)+1;end
                    if(Node[9]==Min_1) begin Node[9]<=Min_2; Code9<=Code9<<1;end
                    else if(Node[9]==Min_2) begin Code9<=(Code9<<1)+1;end
                    state<=2'b01;
                    end
                end
                2'b11:
                begin
                  Re<=1;//结束过程，将Re赋值为1
                end
                default:;
        endcase
    end
    else;    
end 

endmodule
