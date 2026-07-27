class transaction;


rand bit [7:0]din;
rand bit wr_en;
rand bit rd_en;
bit  [7:0]dout;
bit full;
bit  empty;

constraint  c1
{
    wr_en != rd_en;
}

function void print(string tag);

$display("[0%t] %s din:%0d dout:%0d wr_en:%0b rd_en:%0b full:%0b empty:%0b", $time,tag,din,dout,wr_en,rd_en,full,empty);

endfunction

endclass

