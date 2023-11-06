module rotorA(clk, srst_n, load, encrypt, table_idx, code_in, rotorB_backward_out, rotorA_shift_amount, rotorA_forward_out, rotorA_backward_out);
input clk;
input srst_n;
input load;
input encrypt;
input [2-1:0] table_idx;
input [6-1:0] code_in;
input [6-1:0] rotorB_backward_out;
input [2-1:0] rotorA_shift_amount;
output reg [6-1:0] rotorA_forward_out;
output reg [6-1:0] rotorA_backward_out;

reg [6-1:0] rotorA     [0:64-1];
reg [6-1:0] rotorA_tmp [0:64-1];
reg [6-1:0] load_cnt;
reg [6-1:0] load_cnt_tmp;


integer i;
integer j;



always@(posedge clk)begin
    if (~srst_n) begin
        load_cnt <= 6'b0;
        for (i = 0; i < 64; i = i + 1) begin
            rotorA[i] <= 0;
        end
    end else begin
        load_cnt <= load_cnt_tmp;
        for (i = 0; i < 64; i = i + 1) begin
            rotorA[i] <= rotorA_tmp[i];
        end
    end
end

always@(*)begin
    if (load && table_idx == 2'b00) begin
        for (i = 0; i < 64; i = i + 1) begin
            rotorA_tmp[i] = rotorA[i];
        end
        rotorA_tmp[load_cnt] = code_in;
        if (load_cnt != 6'd63) begin
            load_cnt_tmp = load_cnt + 1;
        end else begin
            load_cnt_tmp = load_cnt;
        end
    end else if (encrypt) begin
        if (rotorA_shift_amount == 3) begin
            for (j = 63; j > 2; j = j - 1) begin
                rotorA_tmp[j] = rotorA[j - 3];
            end
            rotorA_tmp[0] = rotorA[61];
            rotorA_tmp[1] = rotorA[62];
            rotorA_tmp[2] = rotorA[63];
        end else if (rotorA_shift_amount == 2) begin
            for (j = 63; j > 1; j = j - 1) begin
                rotorA_tmp[j] = rotorA[j - 2];
            end
            rotorA_tmp[0] = rotorA[62];
            rotorA_tmp[1] = rotorA[63];
        end else if (rotorA_shift_amount == 1) begin
            for (j = 63; j > 0; j = j - 1) begin
                rotorA_tmp[j] = rotorA[j - 1];
            end
            rotorA_tmp[0] = rotorA[63];
        end else begin
            for (j = 63; j >= 0; j = j - 1) begin
                rotorA_tmp[j] = rotorA[j];
            end
        end
        load_cnt_tmp = load_cnt;
    end else begin
        for (j = 63; j >= 0; j = j - 1) begin
            rotorA_tmp[j] = rotorA[j];
        end
        load_cnt_tmp = load_cnt;
    end
end

always@(*)begin
    if (encrypt == 1) begin
        rotorA_forward_out = rotorA[code_in];
    end else begin
        rotorA_forward_out = 0;
    end
end

always@(*)begin
    case (rotorB_backward_out)
        rotorA[0]: rotorA_backward_out  = 6'd0;
        rotorA[1]: rotorA_backward_out  = 6'd1;
        rotorA[2]: rotorA_backward_out  = 6'd2;
        rotorA[3]: rotorA_backward_out  = 6'd3;
        rotorA[4]: rotorA_backward_out  = 6'd4;
        rotorA[5]: rotorA_backward_out  = 6'd5;
        rotorA[6]: rotorA_backward_out  = 6'd6;
        rotorA[7]: rotorA_backward_out  = 6'd7;
        rotorA[8]: rotorA_backward_out  = 6'd8;
        rotorA[9]: rotorA_backward_out  = 6'd9;
        rotorA[10]: rotorA_backward_out = 6'd10;
        rotorA[11]: rotorA_backward_out = 6'd11;
        rotorA[12]: rotorA_backward_out = 6'd12;
        rotorA[13]: rotorA_backward_out = 6'd13;
        rotorA[14]: rotorA_backward_out = 6'd14;
        rotorA[15]: rotorA_backward_out = 6'd15;
        rotorA[16]: rotorA_backward_out = 6'd16;
        rotorA[17]: rotorA_backward_out = 6'd17;
        rotorA[18]: rotorA_backward_out = 6'd18;
        rotorA[19]: rotorA_backward_out = 6'd19;
        rotorA[20]: rotorA_backward_out = 6'd20;
        rotorA[21]: rotorA_backward_out = 6'd21;
        rotorA[22]: rotorA_backward_out = 6'd22;
        rotorA[23]: rotorA_backward_out = 6'd23;
        rotorA[24]: rotorA_backward_out = 6'd24;
        rotorA[25]: rotorA_backward_out = 6'd25;
        rotorA[26]: rotorA_backward_out = 6'd26;
        rotorA[27]: rotorA_backward_out = 6'd27;
        rotorA[28]: rotorA_backward_out = 6'd28;
        rotorA[29]: rotorA_backward_out = 6'd29;
        rotorA[30]: rotorA_backward_out = 6'd30;
        rotorA[31]: rotorA_backward_out = 6'd31;
        rotorA[32]: rotorA_backward_out = 6'd32;
        rotorA[33]: rotorA_backward_out = 6'd33;
        rotorA[34]: rotorA_backward_out = 6'd34;
        rotorA[35]: rotorA_backward_out = 6'd35;
        rotorA[36]: rotorA_backward_out = 6'd36;
        rotorA[37]: rotorA_backward_out = 6'd37;
        rotorA[38]: rotorA_backward_out = 6'd38;
        rotorA[39]: rotorA_backward_out = 6'd39;
        rotorA[40]: rotorA_backward_out = 6'd40;
        rotorA[41]: rotorA_backward_out = 6'd41;
        rotorA[42]: rotorA_backward_out = 6'd42;
        rotorA[43]: rotorA_backward_out = 6'd43;
        rotorA[44]: rotorA_backward_out = 6'd44;
        rotorA[45]: rotorA_backward_out = 6'd45;
        rotorA[46]: rotorA_backward_out = 6'd46;
        rotorA[47]: rotorA_backward_out = 6'd47;
        rotorA[48]: rotorA_backward_out = 6'd48;
        rotorA[49]: rotorA_backward_out = 6'd49;
        rotorA[50]: rotorA_backward_out = 6'd50;
        rotorA[51]: rotorA_backward_out = 6'd51;
        rotorA[52]: rotorA_backward_out = 6'd52;
        rotorA[53]: rotorA_backward_out = 6'd53;
        rotorA[54]: rotorA_backward_out = 6'd54;
        rotorA[55]: rotorA_backward_out = 6'd55;
        rotorA[56]: rotorA_backward_out = 6'd56;
        rotorA[57]: rotorA_backward_out = 6'd57;
        rotorA[58]: rotorA_backward_out = 6'd58;
        rotorA[59]: rotorA_backward_out = 6'd59;
        rotorA[60]: rotorA_backward_out = 6'd60;
        rotorA[61]: rotorA_backward_out = 6'd61;
        rotorA[62]: rotorA_backward_out = 6'd62;
        rotorA[63]: rotorA_backward_out = 6'd63;
        default:    rotorA_backward_out = 6'd0;
    endcase
end

endmodule