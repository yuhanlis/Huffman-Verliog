`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:27:44 06/11/2020 
// Design Name: 
// Module Name:    Sel_min_2 
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
//Sel_min_2模块
//功能：选择频率最小的两个数字
//引脚说明:
//Count0-Count9 为数字0-9对应的频率
// Min_1为频率最小的数字，Min_2为频率第二小的数字
// En模块使能，R_en模块选择就绪
module Sel_min_2(
    Clk,  
    En, 
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
    Min_1,
    Min_2,  
    R_en
    );
input wire Clk;
input wire En;
input wire [7:0] Count0;
input wire [7:0] Count1;
input wire [7:0] Count2;
input wire [7:0] Count3; 
input wire [7:0] Count4;   
input wire [7:0] Count5;
input wire [7:0] Count6;
input wire [7:0] Count7;
input wire [7:0] Count8;
input wire [7:0] Count9;
output reg [3:0] Min_1;
output reg [3:0] Min_2;
output wire R_en;
reg [3:0] Order0;//order0是把a0-9加一起之后比较
reg [3:0] Order1;//以此类推
reg [3:0] Order2;
reg [3:0] Order3;
reg [3:0] Order4;
reg [3:0] Order5;
reg [3:0] Order6;
reg [3:0] Order7;
reg [3:0] Order8;
reg [3:0] Order9;
reg [8:0] a;//a对应count0 。。。j对应count9
reg [8:0] b;
reg [8:0] c;
reg [8:0] d;
reg [8:0] e;
reg [8:0] f;
reg [8:0] g;
reg [8:0] h;
reg [8:0] i;
reg [8:0] j;
reg [1:0] state;

always @(posedge Clk )
    begin
      if(~En)
        begin//初始化，将Min_1,Min_2赋值为0，a-j，order1-9赋值为0，state状态0 
         Min_1<=4'h00;
         Min_2<=4'h00;
         a<=9'h00;
         b<=9'h00;
         c<=9'h00;
         d<=9'h00;
         e<=9'h00;
         f<=9'h00;
         g<=9'h00;
         h<=9'h00;
         i<=9'h00;
         j<=9'h00;
         Order0<=4'h0;
         Order1<=4'h0;
         Order2<=4'h0;
         Order3<=4'h0;
         Order4<=4'h0;
         Order5<=4'h0;
         Order6<=4'h0;
         Order7<=4'h0;
         Order8<=4'h0;
         Order9<=4'h0;
         state<=2'b00;
			
        end
        //将每个数字出现的频率与其他数字出现的频率进行比较，小于则对应寄存器对应位置置1，最后9个数字全为1则说明该数字出现频率最小
        else if(En && state==2'b00)//状态0赋值
        begin
        if(Count0<=Count1) a[0]<=1;else a[0]<=0;//当Count0比Count1小时，对应的a赋值为1，否则赋值为0
        if(Count0<=Count2) a[1]<=1;else a[1]<=0;//以此类推
        if(Count0<=Count3) a[2]<=1;else a[2]<=0;
        if(Count0<=Count4) a[3]<=1;else a[3]<=0;
        if(Count0<=Count5) a[4]<=1;else a[4]<=0;
        if(Count0<=Count6) a[5]<=1;else a[5]<=0;
        if(Count0<=Count7) a[6]<=1;else a[6]<=0;
        if(Count0<=Count8) a[7]<=1;else a[7]<=0;
        if(Count0<=Count9) a[8]<=1;else a[8]<=0;


        if(Count1<Count0) b[0]<=1;else b[0]<=0;
        if(Count1<=Count2) b[1]<=1;else b[1]<=0;
        if(Count1<=Count3) b[2]<=1;else b[2]<=0;
        if(Count1<=Count4) b[3]<=1;else b[3]<=0;
        if(Count1<=Count5) b[4]<=1;else b[4]<=0;
        if(Count1<=Count6) b[5]<=1;else b[5]<=0;
        if(Count1<=Count7) b[6]<=1;else b[6]<=0;
        if(Count1<=Count8) b[7]<=1;else b[7]<=0;
        if(Count1<=Count9) b[8]<=1;else b[8]<=0;

        if(Count2<Count1) c[0]<=1;else c[0]<=0;
        if(Count2<Count0) c[1]<=1;else c[1]<=0;
        if(Count2<=Count3) c[2]<=1;else c[2]<=0;
        if(Count2<=Count4) c[3]<=1;else c[3]<=0;
        if(Count2<=Count5) c[4]<=1;else c[4]<=0;
        if(Count2<=Count6) c[5]<=1;else c[5]<=0;
        if(Count2<=Count7) c[6]<=1;else c[6]<=0;
        if(Count2<=Count8) c[7]<=1;else c[7]<=0;
        if(Count2<=Count9) c[8]<=1;else c[8]<=0;

        if(Count3<Count1) d[0]<=1;else d[0]<=0;
        if(Count3<Count2) d[1]<=1;else d[1]<=0;
        if(Count3<Count0) d[2]<=1;else d[2]<=0;
        if(Count3<=Count4) d[3]<=1;else d[3]<=0;
        if(Count3<=Count5) d[4]<=1;else d[4]<=0;
        if(Count3<=Count6) d[5]<=1;else d[5]<=0;
        if(Count3<=Count7) d[6]<=1;else d[6]<=0;
        if(Count3<=Count8) d[7]<=1;else d[7]<=0;
        if(Count3<=Count9) d[8]<=1;else d[8]<=0;

        if(Count4<Count1) e[0]<=1;else e[0]<=0;
        if(Count4<Count2) e[1]<=1;else e[1]<=0;
        if(Count4<Count3) e[2]<=1;else e[2]<=0;
        if(Count4<Count0) e[3]<=1;else e[3]<=0;
        if(Count4<=Count5) e[4]<=1;else e[4]<=0;
        if(Count4<=Count6) e[5]<=1;else e[5]<=0;
        if(Count4<=Count7) e[6]<=1;else e[6]<=0;
        if(Count4<=Count8) e[7]<=1;else e[7]<=0;
        if(Count4<=Count9) e[8]<=1;else e[8]<=0;

        if(Count5<Count1) f[0]<=1;else f[0]<=0;
        if(Count5<Count2) f[1]<=1;else f[1]<=0;
        if(Count5<Count3) f[2]<=1;else f[2]<=0;
        if(Count5<Count4) f[3]<=1;else f[3]<=0;
        if(Count5<Count0) f[4]<=1;else f[4]<=0;
        if(Count5<=Count6) f[5]<=1;else f[5]<=0;
        if(Count5<=Count7) f[6]<=1;else f[6]<=0;
        if(Count5<=Count8) f[7]<=1;else f[7]<=0;
        if(Count5<=Count9) f[8]<=1;else f[8]<=0;

        if(Count6<Count1) g[0]<=1;else g[0]<=0;
        if(Count6<Count2) g[1]<=1;else g[1]<=0;
        if(Count6<Count3) g[2]<=1;else g[2]<=0;
        if(Count6<Count4) g[3]<=1;else g[3]<=0;
        if(Count6<Count5) g[4]<=1;else g[4]<=0;
        if(Count6<Count0) g[5]<=1;else g[5]<=0;
        if(Count6<=Count7) g[6]<=1;else g[6]<=0;
        if(Count6<=Count8) g[7]<=1;else g[7]<=0;
        if(Count6<=Count9) g[8]<=1;else g[8]<=0;

        if(Count7<Count1) h[0]<=1;else h[0]<=0;
        if(Count7<Count2) h[1]<=1;else h[1]<=0;
        if(Count7<Count3) h[2]<=1;else h[2]<=0;
        if(Count7<Count4) h[3]<=1;else h[3]<=0;
        if(Count7<Count5) h[4]<=1;else h[4]<=0;
        if(Count7<Count6) h[5]<=1;else h[5]<=0;
        if(Count7<Count0) h[6]<=1;else h[6]<=0;
        if(Count7<=Count8) h[7]<=1;else h[7]<=0;
        if(Count7<=Count9) h[8]<=1;else h[8]<=0;

        if(Count8<Count1) i[0]<=1;else i[0]<=0;
        if(Count8<Count2) i[1]<=1;else i[1]<=0;
        if(Count8<Count3) i[2]<=1;else i[2]<=0;
        if(Count8<Count4) i[3]<=1;else i[3]<=0;
        if(Count8<Count5) i[4]<=1;else i[4]<=0;
        if(Count8<Count6) i[5]<=1;else i[5]<=0;
        if(Count8<Count7) i[6]<=1;else i[6]<=0;
        if(Count8<Count0) i[7]<=1;else i[7]<=0;
        if(Count8<=Count9) i[8]<=1;else i[8]<=0;

        if(Count9<Count1) j[0]<=1;else j[0]<=0;
        if(Count9<Count2) j[1]<=1;else j[1]<=0;
        if(Count9<Count3) j[2]<=1;else j[2]<=0;
        if(Count9<Count4) j[3]<=1;else j[3]<=0;
        if(Count9<Count5) j[4]<=1;else j[4]<=0;
        if(Count9<Count6) j[5]<=1;else j[5]<=0;
        if(Count9<Count7) j[6]<=1;else j[6]<=0;
        if(Count9<Count8) j[7]<=1;else j[7]<=0;
        if(Count9<Count0) j[8]<=1;else j[8]<=0;
		  state<=2'b01;
        end
        else if (En&&state==2'b01)//当状态1时，记录1的总数
        begin
            Order0<=(a[0]+a[1]+a[2]+a[3]+a[4]+a[5]+a[6]+a[7]+a[8]);//order记录count0获得1的个数
            Order1<=b[0]+b[1]+b[2]+b[3]+b[4]+b[5]+b[6]+b[7]+b[8];//以此类推
            Order2<=c[0]+c[1]+c[2]+c[3]+c[4]+c[5]+c[6]+c[7]+c[8];
            Order3<=d[0]+d[1]+d[2]+d[3]+d[4]+d[5]+d[6]+d[7]+d[8];
            Order4<=e[0]+e[1]+e[2]+e[3]+e[4]+e[5]+e[6]+e[7]+e[8];
            Order5<=f[0]+f[1]+f[2]+f[3]+f[4]+f[5]+f[6]+f[7]+f[8];
            Order6<=g[0]+g[1]+g[2]+g[3]+g[4]+g[5]+g[6]+g[7]+g[8];
            Order7<=h[0]+h[1]+h[2]+h[3]+h[4]+h[5]+h[6]+h[7]+h[8];
            Order8<=i[0]+i[1]+i[2]+i[3]+i[4]+i[5]+i[6]+i[7]+i[8];
            Order9<=j[0]+j[1]+j[2]+j[3]+j[4]+j[5]+j[6]+j[7]+j[8];
            state<=2'b10;
        end
        else if(En&&state==2'b10)//状态2时，比较order，当order为9时就是Min_1,当order为8时就是Min_2
        begin
        if(Order0==9) Min_1<=4'h0;else if (Order0==8) Min_2<=4'h0;else;
        if(Order1==9) Min_1<=4'h1;else if (Order1==8) Min_2<=4'h1;else;
        if(Order2==9) Min_1<=4'h2;else if (Order2==8) Min_2<=4'h2;else;
        if(Order3==9) Min_1<=4'h3;else if (Order3==8) Min_2<=4'h3;else;
        if(Order4==9) Min_1<=4'h4;else if (Order4==8) Min_2<=4'h4;else;
        if(Order5==9) Min_1<=4'h5;else if (Order5==8) Min_2<=4'h5;else;
        if(Order6==9) Min_1<=4'h6;else if (Order6==8) Min_2<=4'h6;else;
        if(Order7==9) Min_1<=4'h7;else if (Order7==8) Min_2<=4'h7;else;
        if(Order8==9) Min_1<=4'h8;else if (Order8==8) Min_2<=4'h8;else;
        if(Order9==9) Min_1<=4'h9;else if (Order9==8) Min_2<=4'h9;else;
        state<=2'b11;
        end
    end
assign R_en=&state;

endmodule
