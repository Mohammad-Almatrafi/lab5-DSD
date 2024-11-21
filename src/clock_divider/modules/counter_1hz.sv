// `include "modN_clk.sv"
// `include "modN_counter.sv"
module counter_1hz (
    input clk,
    input rst_n,
    input en,
    output  [7:0]q,
    output clkOut
);
  modN_clk #(50_000_000) clk_1MH (
      .clk(clk),
      .en(en),
      .rst_n(rst_n),
      .clk_out(clkOut)
  );
  modN_counter #(256) slowed_counter (
      .clk(clkOut),
      .rst_n(rst_n),
      .en(en),
      .q(q)
  );



endmodule
