module plugboard(clk, srst_n, load, encrypt, crypt_mode, table_idx, code_in, rotorB_forward_out, reflector_out, rotorB_shift_mode, plugboard_forward_out, plugboard_backward_out);
input clk;
input srst_n;
input load;
input encrypt;
input crypt_mode;
input [2-1:0] table_idx;
input [6-1:0] code_in;
input [6-1:0] rotorB_forward_out;
input [6-1:0] reflector_out;
output reg [2-1:0] rotorB_shift_mode;
output reg [6-1:0] plugboard_forward_out;
output reg [6-1:0] plugboard_backward_out;

reg [6-1:0] plugboard     [0:64-1];
reg [6-1:0] plugboard_tmp [0:64-1];
reg count;
reg count_tmp;
reg [6-1:0] load_cnt;
reg [6-1:0] load_cnt_tmp;
reg [6-1:0] save;
reg [6-1:0] save_tmp;

integer i;
integer j;



always@(posedge clk)begin
    if (~srst_n) begin
        count <= 1'b0;
        save <= 6'b0;
        for (i = 0; i < 64; i = i + 1) begin
            plugboard[i] <= i;
        end
    end else begin
        count <= count_tmp;
        save <= save_tmp;
        for (i = 0; i < 64; i = i + 1) begin
            plugboard[i] <= plugboard_tmp[i];
        end
    end
end

always@(*)begin
    if (load && table_idx == 2'b10) begin
        if (count) begin
            count_tmp = 0;
            save_tmp = 0;
            for (i = 0; i < 64; i = i + 1) begin
                plugboard_tmp[i] = plugboard[i];
            end
            plugboard_tmp[save] = plugboard[code_in];
            plugboard_tmp[code_in] = plugboard[save];
        end else begin
	        count_tmp = 1;
            save_tmp = code_in;
            for (i = 0; i < 64; i = i + 1) begin
                plugboard_tmp[i] = plugboard[i];
            end
        end
    end else begin
        for (i = 0; i < 64; i = i + 1) begin
            plugboard_tmp[i] = plugboard[i];
        end
        save_tmp = 0;
        count_tmp = count;
    end
end

always@(*)begin
    if (encrypt == 1) begin
        plugboard_forward_out = plugboard[rotorB_forward_out];
    end else begin
        plugboard_forward_out = 0;
    end
end

always@(*)begin
    plugboard_backward_out = plugboard[reflector_out];
end
always@(*)begin
    if (crypt_mode == 1'b1) begin
        rotorB_shift_mode = plugboard_backward_out[1:0];
    end else begin
        rotorB_shift_mode = rotorB_forward_out[1:0];
    end
end
endmodule
