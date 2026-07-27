class driver;
virtual inf.drv_mp drv_vif;
mailbox # (transaction)gen2drv_mbox;

function new(virtual inf.drv_mp drv_vif,mailbox # (transaction)gen2drv_mbox);
this.gen2drv_mbox = gen2drv_mbox;
this.drv_vif = drv_vif;
endfunction

task reset();

drv_vif.drv_cb.rst_n <= 0;
drv_vif.drv_cb.wr_en <= 0;
drv_vif.drv_cb.rd_en <= 0;
drv_vif.drv_cb.din <= 8'h00;

repeat(3) @(drv_vif.drv_cb);
drv_vif.drv_cb.rst_n <= 1;
$display("RESET DEASSERTED");

endtask

task drive (transaction txn);

@(drv_vif.drv_cb);

if (txn.wr_en && drv_vif.drv_cb.full)
    txn.wr_en = 0;
    
if (txn.rd_en && drv_vif.drv_cb.empty)
    txn.rd_en = 0;

drv_vif.drv_cb.wr_en <= txn.wr_en;
drv_vif.drv_cb.rd_en <= txn.rd_en;
drv_vif.drv_cb.din <= txn.din; 
txn.print("DRIVER");

endtask

task run();
transaction txn;
forever 
begin

     gen2drv_mbox.get(txn);
     drive(txn);

end
endtask
endclass


