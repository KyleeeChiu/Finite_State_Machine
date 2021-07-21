module Stimulus();


reg clk, reset ;
reg [7:0] input_money ;
reg [3:0]  choice ;

wire [7:0] total_money ;
wire [3:0] give ; 
wire [7:0] refund ;


VendingMachine vm( input_money, choice, total_money, give, refund, clk, reset );


initial clk = 1'b1;
initial input_money = 8'b0 ;
initial choice = 3'b0 ;
always #5 clk = ~clk;

initial
begin
	
	reset = 1'b0 ;
	
	///*test1
	#10 input_money = 10 ;//投入十元
	#10 input_money = 1 ;//投入一元
	#10 input_money = 10 ;//投入十元
	#10 input_money = 0 ;
	#10 choice = 3 ;//選擇購買咖啡
	#10 choice = 0 ;
	//*/
	
	///*test2
	#10 input_money = 5 ;
	#10 input_money = 10 ;
	#10 input_money = 0 ;
	#10 reset = 1'b1 ;
	#5 reset = 1'b0 ;
	#5 input_money = 10 ;
	#10 input_money = 10 ;
	#10 input_money = 1 ;
	#10 input_money = 1 ;
	#10 input_money = 1 ;
	#10 input_money = 1 ;
	#10 input_money = 1 ;
	#10 input_money = 0 ;
	#10 choice = 4 ;
	#10 choice = 0 ;
	//*/
	
	///*test3
	#10 input_money = 5 ;
	#10 input_money = 10 ;
	#10 input_money = 0 ;
	#10 reset = 1'b1 ;
	#5 reset = 1'b0 ;
	#5 input_money = 10 ;
	#10 input_money = 10 ;
	#10 input_money = 0 ;
	#10 choice = 2 ;
	#10 choice = 0 ;
	#10 input_money = 10 ;
	#10 input_money = 10 ;
	#10 input_money = 0 ;
	#10 choice = 4 ;
	#10 choice = 0 ;
	#10 input_money = 10 ;
	#10 input_money = 0 ;
	#10 choice = 1 ;
	#10 choice = 0 ;
	#10 input_money = 50 ;
	#10 input_money = 0 ;
	#10 choice = 3 ;
	#10 choice = 0 ;
	//*/
end





endmodule