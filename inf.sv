interface inf(input clk);

logic rst_n;
logic wr_en;
logic rd_en;
logic [7:0]din;
logic [7:0]dout;
logic full;
logic empty;


clocking drv_cb @(posedge clk);

default input #1step output #0;
input dout;
input full;
input empty;
output wr_en;
output rd_en;
output rst_n;
output din;

endclocking

clocking wr_mon_cb @(posedge clk);

default input #1step output #1;
input din;
input full;
input rst_n;
input wr_en;

endclocking 

clocking rd_mon_cb @(posedge clk);

default input #1step output #0;
input dout;
input empty;
input rst_n;
input rd_en;

endclocking 

modport drv_mp(clocking drv_cb,input clk);
modport wr_mon_mp(clocking wr_mon_cb,input clk);
modport rd_mon_mp(clocking rd_mon_cb,input clk);

endinterface



