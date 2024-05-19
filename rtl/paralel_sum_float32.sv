
module paralel_sum_float32 #(
	parameter NUMBER_OF_INPUTS      = 1024                                          ,
	parameter BITS_PER_SYMBOL       = 32                                            ,
	parameter LOG2_NUMBER_OF_INPUTS = 2**$clog2(NUMBER_OF_INPUTS)                   ,
	parameter DIFFERENCE_DATA       = 2**$clog2(NUMBER_OF_INPUTS) - NUMBER_OF_INPUTS
) (
	input                                               clk_i ,
	input                                               rst_n ,
	input  logic [NUMBER_OF_INPUTS*BITS_PER_SYMBOL-1:0] data_i,
	output logic [                 BITS_PER_SYMBOL-1:0] data_o
);

/*------------------------------------------------------------------------------
--
------------------------------------------------------------------------------*/
	logic [2**$clog2(NUMBER_OF_INPUTS)*BITS_PER_SYMBOL-1:0] data_reg       ;
	logic [                   $clog2(NUMBER_OF_INPUTS)-1:0] difference_data;

	assign data_reg = {{DIFFERENCE_DATA{1'b0}} ,data_i};
	
	genvar i,j;

	logic [LOG2_NUMBER_OF_INPUTS/2-1:0][$clog2(LOG2_NUMBER_OF_INPUTS)-1:0][BITS_PER_SYMBOL-1:0] data_sum;
	logic [LOG2_NUMBER_OF_INPUTS/2-1:0][$clog2(LOG2_NUMBER_OF_INPUTS)-1:0][BITS_PER_SYMBOL-1:0] sum     ;

	generate begin
			for (j = 0; j < $clog2(LOG2_NUMBER_OF_INPUTS); j++) begin : NUM1
				for (i = 0; i < LOG2_NUMBER_OF_INPUTS/2; i++) begin : NUM2

					if(j==0) begin

						Addition_Subtraction uut_Addition_Subtraction_first (
							.a_operand (data_reg[BITS_PER_SYMBOL*(i*2+1)-1:BITS_PER_SYMBOL*i*2]    ),
							.b_operand (data_reg[BITS_PER_SYMBOL*(i*2+2)-1:BITS_PER_SYMBOL*(i*2+1)]),
							.AddBar_Sub(1'b0                                                       ),
							.Exception (                                                           ),
							.result    (sum[i][j][BITS_PER_SYMBOL-1:0]                               )
						);

						always_ff @(posedge clk_i or negedge rst_n) begin : proc_data_sum
							if(!rst_n) begin
								data_sum[i][j][BITS_PER_SYMBOL-1:0] <= {(BITS_PER_SYMBOL+j+1){1'b0}};
							end else begin
								data_sum[i][j][BITS_PER_SYMBOL-1:0] <= sum[i][j][BITS_PER_SYMBOL-1:0];
							end
						end
					end

					else begin

						Addition_Subtraction uut_Addition_Subtraction_replay (
							.a_operand (data_sum[i*2][j-1][BITS_PER_SYMBOL-1:0]  ),
							.b_operand (data_sum[i*2+1][j-1][BITS_PER_SYMBOL-1:0]),
							.AddBar_Sub(1'b0                                       ),
							.Exception (                                           ),
							.result    (sum[i][j][BITS_PER_SYMBOL-1:0]             )
						);

						always_ff @(posedge clk_i or negedge rst_n) begin : proc_data_sum
							if(!rst_n) begin
								data_sum[i][j][BITS_PER_SYMBOL-1:0] <= {(BITS_PER_SYMBOL+j+1){1'b0}};
							end else begin
								data_sum[i][j][BITS_PER_SYMBOL-1:0] <= sum[i][j][BITS_PER_SYMBOL-1:0];
							end
						end
					end
				end
			end
		end
	endgenerate


	assign data_o = data_sum[0][$clog2(LOG2_NUMBER_OF_INPUTS)-1];

endmodule
