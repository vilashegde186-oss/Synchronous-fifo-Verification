class environment;

generator gen;
driver drv;
wr_monitor wmon;
rd_monitor rmon;
reference_model rm;
scoreboard sb;

mailbox # (transaction)gen2drv_mbox;
mailbox # (transaction)wr_mon2rm_mbox;
mailbox # (transaction)mon2sb_mbox;
mailbox # (transaction)rm2sb_mbox;
mailbox #(transaction)rd_mon2rm_mbox;

virtual inf.drv_mp drv_vif;
virtual inf.wr_mon_mp wr_vif;
virtual inf.rd_mon_mp rd_vif; 

function new(virtual inf.drv_mp drv_vif,virtual inf.wr_mon_mp wr_vif,virtual inf.rd_mon_mp rd_vif);

this.drv_vif = drv_vif;
this.wr_vif = wr_vif;
this.rd_vif = rd_vif;

gen2drv_mbox = new();
wr_mon2rm_mbox = new();
mon2sb_mbox = new();
rm2sb_mbox = new();
rd_mon2rm_mbox = new();

endfunction

task build();

gen = new(gen2drv_mbox);
drv = new(drv_vif,gen2drv_mbox);
wmon = new(wr_vif,wr_mon2rm_mbox);
rmon = new(rd_vif,mon2sb_mbox,rd_mon2rm_mbox);
rm = new(wr_mon2rm_mbox,rm2sb_mbox,rd_mon2rm_mbox);
sb = new(mon2sb_mbox,rm2sb_mbox);

endtask

task run();

drv.reset();
fork
    drv.run();
    wmon.run();
    rmon.run();
    rm.run();
    sb.run();
join_none
    gen.run();
    wait(gen.done);
    #500;
    sb.report();
    $finish;
endtask
endclass


