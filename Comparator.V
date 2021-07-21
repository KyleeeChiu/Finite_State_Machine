module VendingMachine( input_money, choice, total_money, give, refund, clk, reset );
	input clk, reset ;
	input [7:0] input_money ;
	input [3:0]  choice ;

	output reg [7:0] total_money ;
	output reg [3:0] give ; 
	output reg [7:0] refund ;

	reg [2:0] cur_state ;
	reg [2:0] next_state ;
	reg [7:0] drink ;
	reg notEnough ;

	parameter	S0 = 3'd0,
				S1 = 3'd1,
				S2 = 3'd2,
				S3 = 3'd3 ;

	initial begin
		total_money = 8'b0 ;
		refund = 4'b0 ;
		give = 4'b0 ;
		cur_state = S0 ;
		next_state = S0 ;
		drink = 8'b0 ;
		notEnough = 1'b0 ;
	end

	always @ ( posedge clk or posedge reset ) begin
		if ( reset )
			cur_state <= S3 ;
		else if ( input_money != 8'b0 && next_state == S1 )
			cur_state <= S0 ;
		else
			cur_state <= next_state ;
	end

	always @ ( negedge clk ) begin
		case ( cur_state ) 
			S0 : begin
				refund = 8'b0 ;
				total_money = total_money + input_money ;
				if ( total_money >= 10 ) begin
					notEnough = 1'b0 ;
					cur_state = S1 ;
				end	
			
			end
			S1 : begin
				if ( choice != 0 ) begin
					if ( choice == 1 ) drink = 8'd10 ; 
					else if ( choice == 2 ) drink = 8'd15 ;
					else if ( choice == 3 ) drink = 8'd20 ;
					else if ( choice == 4 ) drink = 8'd25 ;
					
					if ( total_money < drink ) begin
						notEnough = 1'b1 ;
						cur_state = S1 ;		
					end
					else begin
						cur_state = S2 ;
					end	
				end		
				else
					cur_state = S1 ;
			end
			S3 : begin
				refund = total_money - drink ;
				drink = 8'd0 ;
				total_money = 0 ;
				give = 4'b0 ;			
			end
		endcase
		
		case ( cur_state ) 
			S0 : begin
				$display( "coin %d,	total %d dollars", input_money, total_money );
			end
			S1 : begin
				if ( input_money == 0 ) begin
					if ( notEnough == 1'b1 ) begin
						if ( choice == 1 )
							$display( "total %d dollars is not enough to buy tea(10)", total_money );
						else if ( choice == 2 )
							$display( "total %d dollars is not enough to buy coke(15)", total_money );
						else if ( choice == 3 )
							$display( "total %d dollars is not enough to buy coffee(20)", total_money );
						else if ( choice == 4 )
							$display( "total %d dollars is not enough to buy milk(25)", total_money );
						notEnough = 1'b0 ;	
					end
				end
				else if ( total_money >= 25 )
					$display( "coin %d,	total %d dollars,	tea(10) | coke(15) | coffee(20) | milk(25)", input_money, total_money );
				else if ( total_money >= 20 && total_money < 25 )
					$display( "coin %d,	total %d dollars,	tea(10) | coke(15) | coffee(20)", input_money, total_money );
				else if ( total_money >= 15 && total_money < 20 )
					$display( "coin %d,	total %d dollars,	tea(10) | coke(15)", input_money, total_money );
				else if ( total_money >= 10 && total_money < 15 )
					$display( "coin %d,	total %d dollars,	tea(10)", input_money, total_money );
					
			end	
			S2 : begin
				if ( choice == 1 )
					$display( "tea out" );
				else if ( choice == 2 )
					$display( "coke out" );
				else if ( choice == 3 )
					$display( "coffee out" );
				else if ( choice == 4 )
					$display( "milk out" );
			end		
			S3 : begin
				$display( "exchange %d dollars", refund );
			end
		endcase
		
		case ( cur_state )
			S0 : begin
				next_state = S0 ;
			end	
			S1 : begin
				next_state = S1 ;
			end
			S2 : begin
				next_state = S3 ;
			end
			S3 : begin
				next_state = S0 ;
			end
		endcase
	end
endmodule





