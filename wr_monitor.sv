class wr_monitor;

virtual inf.wr_mon_mp wr_vif;
mailbox # (transaction)wr_mon2rm_mbox;

function new(virtual inf.wr_mon_mp wr_vif,mailbox # (transaction)wr_mon2rm_mbox);

this.wr_vif = wr_vif;
this.wr_mon2rm_mbox = wr_mon2rm_mbox;

endfunction

task run();

transaction txn;
forever
  begin
       
        @(wr_vif.wr_mon_cb);
       if(wr_vif.wr_mon_cb.wr_en && !wr_vif.wr_mon_cb.full)
       begin


           txn = new();
           txn.wr_en = wr_vif.wr_mon_cb.wr_en;
           txn.full = wr_vif.wr_mon_cb.full;
           txn.din = wr_vif.wr_mon_cb.din;

           txn.print("WRITE MONITOR");
           wr_mon2rm_mbox.put(txn);
           
       end
  end
endtask
endclass



