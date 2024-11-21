module tb_shift_reg;
  logic [7:0] q;
  logic clk = 0, rst_n, Control_bit, Serial_in;
  shift_reg DUT (
      .clk(clk),
      .rst_n(rst_n),
      .Control_bit(Control_bit),
      .Serial_in(Serial_in),
      .q(q)
  );

  always #5 clk = ~clk;

  initial begin
    rst_n = 1;
    #5 rst_n = 0;
    #5 rst_n = 1;
    Serial_in   = 1;
    Control_bit = 1;
    repeat (2) @(negedge clk);
    Serial_in   = 0;
    Control_bit = 1;
    repeat (2) @(negedge clk);
    Serial_in   = 0;
    Control_bit = 0;
    repeat (2) @(negedge clk);
    Serial_in   = 1;
    Control_bit = 0;
    repeat (2) @(negedge clk);
    $finish;
  end

endmodule
