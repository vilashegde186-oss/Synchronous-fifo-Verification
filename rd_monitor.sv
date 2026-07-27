class rd_monitor;

virtual inf.rd_mon_mp rd_vif; 
mailbox # (transaction)mon2sb_mbox;
mailbox #(transaction)rd_mon2rm_mbox;

function new(virtual inf.rd_mon_mp rd_vif,mailbox # (transaction)mon2sb_mbox,mailbox #(transaction) rd_mon2rm_mbox);

this.rd_vif = rd_vif;
this.mon2sb_mbox = mon2sb_mbox;
this.rd_mon2rm_mbox = rd_mon2rm_mbox;

endfunction

task run();
transaction txn, rm_txn;
bit pending_read;         

forever
begin
    @(rd_vif.rd_mon_cb);

    if (pending_read)
    begin
        txn = new();
        txn.rd_en = 1'b1;
        txn.dout  = rd_vif.rd_mon_cb.dout;
        txn.empty = rd_vif.rd_mon_cb.empty;
        txn.print("READ MONITOR");
        mon2sb_mbox.put(txn);

        rm_txn = new();
        rm_txn.rd_en = 1'b1;
        rd_mon2rm_mbox.put(rm_txn);

        pending_read = 0;
    end

    if (rd_vif.rd_mon_cb.rd_en && !rd_vif.rd_mon_cb.empty)
        pending_read = 1;
end
endtask
endclass