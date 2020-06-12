`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:14:42 06/11/2020 
// Design Name: 
// Module Name:    Encode 
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
//Encode模块
// 功能：对输入编码
module Encode(
    Clk,//时钟信号
    Reset,//复位信号
    En,//使能信号
    Data_in,//数据输入
    Outputs,//数据输出
    Wr_en,//写入使能信号
    Re//判断状态是否完成
    );
    input wire Clk;
    input wire Reset;
    input wire En;
    input wire Wr_en;  
    input wire [3:0] Data_in;
    output reg Re;
    output reg Outputs;
    reg Count_en;//en ,Re是例化模块时的关联名称
    wire Count_Re;
    reg Huf_en;
    wire Huf_re;
    reg [4:0] Save[255:0];//保存256个数据
    wire [7:0] Count [9:0];//记录0-9的个数
    reg [1:0] state;//标记状态
    wire [5:0] Code[9:0];//0-9的编码
    reg [7:0] Num;//记录总数
    reg [3:0] Scnt;
    reg Valid;//标记是否有效
	 reg Ostate;//标记状态
Count CF//例化Count模块
(
    .Clk(Clk),
    .Reset(Reset),
    .Wr_en(Count_en),
    .Data_in(Data_in),
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
    .Re(Count_Re)
);
Huf huftree(//例化Huf模块
    .Clk(Clk),
    .Reset(Reset),
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
    .En(Huf_en),
    .Re(Huf_re),
    .Code0(Code[0]),
    .Code1(Code[1]),
    .Code2(Code[2]),
    .Code3(Code[3]),
    .Code4(Code[4]),
    .Code5(Code[5]),
    .Code6(Code[6]),
    .Code7(Code[7]),
    .Code8(Code[8]),
    .Code9(Code[9])
);
always @(posedge Clk or negedge Reset)
begin
  if(~Reset)//初始化
    begin
		Outputs<=0;
      Re<=0;
      state<=2'b00;//初始化状态0
      Count_en<=0;
      Huf_en<=0;
      Num<=0;
      Scnt<=3'd5;
      Valid<=0;
		Ostate<=0;
		Save[0]<=4'h0;
Save[1]<=4'h0;
Save[2]<=4'h0;
Save[3]<=4'h0;
Save[4]<=4'h0;
Save[5]<=4'h0;
Save[6]<=4'h0;
Save[7]<=4'h0;
Save[8]<=4'h0;
Save[9]<=4'h0;
Save[10]<=4'h0;
Save[11]<=4'h0;
Save[12]<=4'h0;
Save[13]<=4'h0;
Save[14]<=4'h0;
Save[15]<=4'h0;
Save[16]<=4'h0;
Save[17]<=4'h0;
Save[18]<=4'h0;
Save[19]<=4'h0;
Save[20]<=4'h0;
Save[21]<=4'h0;
Save[22]<=4'h0;
Save[23]<=4'h0;
Save[24]<=4'h0;
Save[25]<=4'h0;
Save[26]<=4'h0;
Save[27]<=4'h0;
Save[28]<=4'h0;
Save[29]<=4'h0;
Save[30]<=4'h0;
Save[31]<=4'h0;
Save[32]<=4'h0;
Save[33]<=4'h0;
Save[34]<=4'h0;
Save[35]<=4'h0;
Save[36]<=4'h0;
Save[37]<=4'h0;
Save[38]<=4'h0;
Save[39]<=4'h0;
Save[40]<=4'h0;
Save[41]<=4'h0;
Save[42]<=4'h0;
Save[43]<=4'h0;
Save[44]<=4'h0;
Save[45]<=4'h0;
Save[46]<=4'h0;
Save[47]<=4'h0;
Save[48]<=4'h0;
Save[49]<=4'h0;
Save[50]<=4'h0;
Save[51]<=4'h0;
Save[52]<=4'h0;
Save[53]<=4'h0;
Save[54]<=4'h0;
Save[55]<=4'h0;
Save[56]<=4'h0;
Save[57]<=4'h0;
Save[58]<=4'h0;
Save[59]<=4'h0;
Save[60]<=4'h0;
Save[61]<=4'h0;
Save[62]<=4'h0;
Save[63]<=4'h0;
Save[64]<=4'h0;
Save[65]<=4'h0;
Save[66]<=4'h0;
Save[67]<=4'h0;
Save[68]<=4'h0;
Save[69]<=4'h0;
Save[70]<=4'h0;
Save[71]<=4'h0;
Save[72]<=4'h0;
Save[73]<=4'h0;
Save[74]<=4'h0;
Save[75]<=4'h0;
Save[76]<=4'h0;
Save[77]<=4'h0;
Save[78]<=4'h0;
Save[79]<=4'h0;
Save[80]<=4'h0;
Save[81]<=4'h0;
Save[82]<=4'h0;
Save[83]<=4'h0;
Save[84]<=4'h0;
Save[85]<=4'h0;
Save[86]<=4'h0;
Save[87]<=4'h0;
Save[88]<=4'h0;
Save[89]<=4'h0;
Save[90]<=4'h0;
Save[91]<=4'h0;
Save[92]<=4'h0;
Save[93]<=4'h0;
Save[94]<=4'h0;
Save[95]<=4'h0;
Save[96]<=4'h0;
Save[97]<=4'h0;
Save[98]<=4'h0;
Save[99]<=4'h0;
Save[100]<=4'h0;
Save[101]<=4'h0;
Save[102]<=4'h0;
Save[103]<=4'h0;
Save[104]<=4'h0;
Save[105]<=4'h0;
Save[106]<=4'h0;
Save[107]<=4'h0;
Save[108]<=4'h0;
Save[109]<=4'h0;
Save[110]<=4'h0;
Save[111]<=4'h0;
Save[112]<=4'h0;
Save[113]<=4'h0;
Save[114]<=4'h0;
Save[115]<=4'h0;
Save[116]<=4'h0;
Save[117]<=4'h0;
Save[118]<=4'h0;
Save[119]<=4'h0;
Save[120]<=4'h0;
Save[121]<=4'h0;
Save[122]<=4'h0;
Save[123]<=4'h0;
Save[124]<=4'h0;
Save[125]<=4'h0;
Save[126]<=4'h0;
Save[127]<=4'h0;
Save[128]<=4'h0;
Save[129]<=4'h0;
Save[130]<=4'h0;
Save[131]<=4'h0;
Save[132]<=4'h0;
Save[133]<=4'h0;
Save[134]<=4'h0;
Save[135]<=4'h0;
Save[136]<=4'h0;
Save[137]<=4'h0;
Save[138]<=4'h0;
Save[139]<=4'h0;
Save[140]<=4'h0;
Save[141]<=4'h0;
Save[142]<=4'h0;
Save[143]<=4'h0;
Save[144]<=4'h0;
Save[145]<=4'h0;
Save[146]<=4'h0;
Save[147]<=4'h0;
Save[148]<=4'h0;
Save[149]<=4'h0;
Save[150]<=4'h0;
Save[151]<=4'h0;
Save[152]<=4'h0;
Save[153]<=4'h0;
Save[154]<=4'h0;
Save[155]<=4'h0;
Save[156]<=4'h0;
Save[157]<=4'h0;
Save[158]<=4'h0;
Save[159]<=4'h0;
Save[160]<=4'h0;
Save[161]<=4'h0;
Save[162]<=4'h0;
Save[163]<=4'h0;
Save[164]<=4'h0;
Save[165]<=4'h0;
Save[166]<=4'h0;
Save[167]<=4'h0;
Save[168]<=4'h0;
Save[169]<=4'h0;
Save[170]<=4'h0;
Save[171]<=4'h0;
Save[172]<=4'h0;
Save[173]<=4'h0;
Save[174]<=4'h0;
Save[175]<=4'h0;
Save[176]<=4'h0;
Save[177]<=4'h0;
Save[178]<=4'h0;
Save[179]<=4'h0;
Save[180]<=4'h0;
Save[181]<=4'h0;
Save[182]<=4'h0;
Save[183]<=4'h0;
Save[184]<=4'h0;
Save[185]<=4'h0;
Save[186]<=4'h0;
Save[187]<=4'h0;
Save[188]<=4'h0;
Save[189]<=4'h0;
Save[190]<=4'h0;
Save[191]<=4'h0;
Save[192]<=4'h0;
Save[193]<=4'h0;
Save[194]<=4'h0;
Save[195]<=4'h0;
Save[196]<=4'h0;
Save[197]<=4'h0;
Save[198]<=4'h0;
Save[199]<=4'h0;
Save[200]<=4'h0;
Save[201]<=4'h0;
Save[202]<=4'h0;
Save[203]<=4'h0;
Save[204]<=4'h0;
Save[205]<=4'h0;
Save[206]<=4'h0;
Save[207]<=4'h0;
Save[208]<=4'h0;
Save[209]<=4'h0;
Save[210]<=4'h0;
Save[211]<=4'h0;
Save[212]<=4'h0;
Save[213]<=4'h0;
Save[214]<=4'h0;
Save[215]<=4'h0;
Save[216]<=4'h0;
Save[217]<=4'h0;
Save[218]<=4'h0;
Save[219]<=4'h0;
Save[220]<=4'h0;
Save[221]<=4'h0;
Save[222]<=4'h0;
Save[223]<=4'h0;
Save[224]<=4'h0;
Save[225]<=4'h0;
Save[226]<=4'h0;
Save[227]<=4'h0;
Save[228]<=4'h0;
Save[229]<=4'h0;
Save[230]<=4'h0;
Save[231]<=4'h0;
Save[232]<=4'h0;
Save[233]<=4'h0;
Save[234]<=4'h0;
Save[235]<=4'h0;
Save[236]<=4'h0;
Save[237]<=4'h0;
Save[238]<=4'h0;
Save[239]<=4'h0;
Save[240]<=4'h0;
Save[241]<=4'h0;
Save[242]<=4'h0;
Save[243]<=4'h0;
Save[244]<=4'h0;
Save[245]<=4'h0;
Save[246]<=4'h0;
Save[247]<=4'h0;
Save[248]<=4'h0;
Save[249]<=4'h0;
Save[250]<=4'h0;
Save[251]<=4'h0;
Save[252]<=4'h0;
Save[253]<=4'h0;
Save[254]<=4'h0;
Save[255]<=4'h0;
		
    end
    else if(En)
    begin
      case (state)  //判断状态
        2'b00:      //状态0，写使能时将输入的256个字符保存，同时对频率计数
            begin
                if(Wr_en)
                begin
                if(~Count_Re)//当所有数都记录完之后Re会置1，所以Re为0 时会持续存数
                begin
                    Count_en<=1;//将Count_en(Wr_en)赋值为1，打开使能
                    Save[Num]<=Data_in;//将输入的数据存在Save中
                     Num<=Num+1;  
                end
					 end
                else if(Count_Re)
                begin
                    state<=2'b01;//进入状态2
                    Count_en<=0;//关闭Count模块的使能
                
                end
            end
        2'b01:          //状态2，拉低计数模块，打开Huf模块，进行编码
            begin
            if(~Huf_re)//
                Huf_en<=1;      //将Huf使能置为1
            else if(Huf_re)     //编码完成进入状态3
            begin
                Huf_en<=0;      //关闭Huf使能
                state<=2'b10;
                Num<=0;         //Num计数清零
            end
            end
       2'b10:          //状态3 先输出每个数字的编码
      begin
		if(Num!=9)//有0-9十个数字，Num要进行10次循环
			begin
			 case (Ostate)//判断状态
			 0:
			 begin
				Scnt <= Scnt - 1;
				if(Code[Num][Scnt] == 1) //找code中从左往右数的第一个1
					Valid <= 1;//给valid赋值为1，开始给output赋值
				if(Valid) 
					begin 
					Outputs <= Code[Num][Scnt];
					Re<=1;//当Re为1时对应的output就是编码，小端输出
					end
				if(Scnt == 0) 
					begin  
					Valid <= 0;//初始化数据
					Outputs <= Code[Num][Scnt];
					Scnt <= 3'd5;
					Num<=Num+1;//进行下一个数的编码输出
					Ostate<=1;
					end
				end
				1:
				begin//Ostate为1时关闭Re，Ostate为0
				  Re<=0;
				  Ostate<=0;
				end
			 endcase
			end
			else
			 begin
				state <= 2'b11;
			 end
		 end
        2'b11:      //状态4 输出编码串
            begin
              begin
			 case (Ostate)
			 0:
			 begin
				Scnt <= Scnt - 1;
				if(Code[Save[Num]][Scnt] == 1) //对save数组里的每一个元素进行编码，过程与上面类似
					Valid <= 1;
				if(Valid) 
					begin 
					Outputs <= Code[Save[Num]][Scnt];
					Re<=1;
					end
				if(Scnt == 0) 
					begin  
					Valid <= 0;
					Outputs <= Code[Save[Num]][Scnt];
					Scnt <= 3'd5;
					Num<=Num+1;
					Ostate<=1;
					end
				end
				1:
				begin
				  Re<=0;
				  Ostate<=0;
				end
			 endcase
			end
            end
          default: ;
      endcase
     

    end
end
endmodule
