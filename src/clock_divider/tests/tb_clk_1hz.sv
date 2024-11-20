module tb_clk_1hz;


  logic clk = 0, rst_n, clk_out;



  modN_clk #(8) DUT (
      .clk(clk),
      .rst_n(rst_n),
      .clk_out(clk_out)
  );


  always #2 clk = ~clk;

  initial begin
    rst_n = 1;
    #5 rst_n = 0;
    #5 rst_n = 1;
    repeat (60) @(negedge clk);
$finish;
  end


endmodule
