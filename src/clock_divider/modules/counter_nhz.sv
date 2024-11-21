
module counter_nhz #(
    parameter divider,
    parameter count
) (
    clk,
    rst_n,
    en,
    clkOut,
    q
);
  localparam N = divider;
  localparam width = $clog2(N);
  localparam c = count;
  input clk,rst_n,en,clkOut;
  output logic [width-1:0] q;
  modN_clk #(
      .n(divider)
  ) clk_1MH (
      .clk(clk),
      .en(en),
      .rst_n(rst_n),
      .clk_out(clkOut)
  );
  modN_counter #(c) slowed_counter (
      .clk(clkOut),
      .rst_n(rst_n),
      .en(en),
      .q(q)
  );



endmodule
