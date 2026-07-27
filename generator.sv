class generator;

mailbox # (transaction)gen2drv_mbox;
int unsigned txn_n = 30;
bit done;

function new(mailbox # (transaction)gen2drv_mbox);
this.gen2drv_mbox = gen2drv_mbox;
endfunction

task run();

transaction txn;

for(int i=0; i<txn_n; i++)
begin

    txn = new();
    if(!txn.randomize())
    begin
        $fatal(1,"the transaction failed after ");
    end
    else
    begin
        txn.print("GEN");
        gen2drv_mbox.put(txn);
    end

end

$display("all %0d the transaction completed",txn_n);
done = 1;
endtask
endclass