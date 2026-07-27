class reference_model;

    mailbox #(transaction)wr_mon2rm_mbox;
    mailbox #(transaction)rm2sb_mbox;
    mailbox #(transaction)rd_mon2rm_mbox;

    bit [7:0] fifo_q[$];

    function new(mailbox #(transaction)wr_mon2rm_mbox,
                 mailbox #(transaction)rm2sb_mbox, mailbox #(transaction)rd_mon2rm_mbox);

        this.wr_mon2rm_mbox = wr_mon2rm_mbox;
        this.rm2sb_mbox = rm2sb_mbox;
        this.rd_mon2rm_mbox = rd_mon2rm_mbox;

    endfunction

    task run();

        transaction wr_txn;
        transaction rd_txn;
        transaction exp_txn;

        fork
        forever 
        begin

            wr_mon2rm_mbox.get(wr_txn);

             if(wr_txn.wr_en && !wr_txn.full)
            begin

                fifo_q.push_back(wr_txn.din);
            end
        end
            forever
            begin
                
                rd_mon2rm_mbox.get(rd_txn);
                 if(rd_txn.rd_en) 
                 begin

                    exp_txn = new();
                    exp_txn.dout = fifo_q.pop_front();
                    exp_txn.print("REFERENCE MODEL");
                    rm2sb_mbox.put(exp_txn);

                 end

            
             end
        join
    endtask

endclass