module fifo(input logic clk,
            input logic rst_n,
            input logic wr_en,
            input logic rd_en,
            input logic [7:0]din,
            output logic [7:0]dout,
            output logic full,
            output logic empty);

            logic [7:0]mem[0:3];
            logic[2:0]wr_ptr;
            logic[2:0]rd_ptr;

            always_ff @(posedge clk or negedge rst_n ) 
            begin 

                if(!rst_n)
                begin
                wr_ptr <= 3'b000;
                end

                else if(wr_en && !full)
                begin
                     mem[wr_ptr[1:0]] <= din;
                     wr_ptr <= wr_ptr + 1;
                end     
            end

             always_ff @(posedge clk or negedge rst_n ) 
            begin 

                 if(!rst_n)
                begin
                rd_ptr <= 3'b000;
                dout <= 8'b00000000;
                end

                else if(rd_en && !empty)
                begin
                    dout <= mem[rd_ptr[1:0]];
                    rd_ptr <= rd_ptr + 1;
                end
            end
            
            assign empty = (wr_ptr == rd_ptr);

            assign full = (wr_ptr[2] != rd_ptr[2]) && (wr_ptr[1:0] == rd_ptr[1:0]);

endmodule