import fifo_pkg ::*;

module tb_top;

logic clk = 0;
always #5 clk = ~clk;

inf vif(clk);

fifo dut(.clk(clk),
        .rst_n(vif.rst_n),
        .wr_en(vif.wr_en),
        .rd_en(vif.rd_en),
        .full(vif.full),
        .empty(vif.empty),
        .din(vif.din),
        .dout(vif.dout)
);

environment env;
initial 
begin

    env = new(vif.drv_mp,vif.wr_mon_mp,vif.rd_mon_mp);
    env.build();
    env.run();

end

initial
begin
     
     $dumpfile("fifo.vcd");
     $dumpvars(0,tb_top);

end
endmodule
