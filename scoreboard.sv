class scoreboard;

mailbox #(transaction)mon2sb_mbox;
mailbox #(transaction)rm2sb_mbox;
int unsigned passed;
int unsigned failed;

function new(mailbox #(transaction)mon2sb_mbox,mailbox #(transaction)rm2sb_mbox);
this.mon2sb_mbox = mon2sb_mbox;
this.rm2sb_mbox = rm2sb_mbox;
endfunction

task check(transaction actual,transaction expected);

if(actual.dout == expected.dout)
begin
    passed++;
    $display("PASS : Expected=%0d Actual=%0d", expected.dout, actual.dout);
end

else
begin
    failed++;
   $display("FAILED : Expected=%0d Actual=%0d", expected.dout, actual.dout);
end

endtask

task run();

transaction actual ,expected;
forever
begin
    
    mon2sb_mbox.get(actual);
    rm2sb_mbox.get(expected);
    check(actual,expected);
end
endtask

function void report();

$display("==================================");
$display("---------FIFO SCOREBOARD----------");
$display("total number of transaction is %0d",failed+passed);
$display("trnsaction passed %0d",passed);
$display("trnsaction failed %0d",failed);
$display("==================================");

endfunction
endclass


