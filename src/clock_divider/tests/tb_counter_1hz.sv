module tb_counter_1hz;



  logic clk = 0, rst_n, en;
  logic [3:0] q;
  counter_1hz DUT (
      .clk(clk),
      .rst_n(rst_n),
      .en(en),
      .q(q)
  );


  always #1 clk = ~clk;

initial begin
    en = 1;
    rst_n = 1;
    #5;
    rst_n = 0;
    #5 rst_n = 1;

    repeat(200000000) @(negedge clk);
    $finish;
end

endmodule
