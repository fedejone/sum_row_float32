
`timescale 1ns/1ps

parameter NUMBER_OF_INPUTS = 8 ;
parameter BITS_PER_SYMBOL  = 32;

module addition_float_tb ();

    logic                                        clk   ;
    logic                                        rst_n ;
    logic [NUMBER_OF_INPUTS*BITS_PER_SYMBOL-1:0] data  ;
    logic [                                31:0] result;

    paralel_sum_float32 #(
        .NUMBER_OF_INPUTS(NUMBER_OF_INPUTS),
        .BITS_PER_SYMBOL (32              )
    ) uut_paralel_sum_float32 (
        .clk_i (clk   ),
        .rst_n (rst_n ),
        .data_i(data  ),
        .data_o(result)
    );


    task wait_clk(int i);
        repeat (i) @(posedge clk);
    endtask : wait_clk

    initial begin
        clk = 0;
        rst_n = 1;
        forever #2 clk = ~clk ;
    end

    initial begin
        wait_clk(1);
        rst_n = 0;
        wait_clk(1);
        rst_n = 1;
        wait_clk(1);
    end

    initial begin
        for (int i =0; i <= NUMBER_OF_INPUTS; i++) begin
            data <= {NUMBER_OF_INPUTS{$urandom(NUMBER_OF_INPUTS)}};
        end
    end

endmodule
