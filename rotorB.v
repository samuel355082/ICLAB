module rotorB(clk, srst_n, load, encrypt, crypt_mode, table_idx, code_in, rotorA_forward_out, plugboard_backward_out, rotorB_shift_mode, rotorB_forward_out, rotorB_backward_out, rotorA_shift_amount);
input clk;
input srst_n;
input load;
input encrypt;
input crypt_mode;
input [2-1:0] table_idx;
input [6-1:0] code_in;
input [6-1:0] rotorA_forward_out;
input [6-1:0] plugboard_backward_out;
input [2-1:0] rotorB_shift_mode;
output reg [6-1:0] rotorB_forward_out;
output reg [6-1:0] rotorB_backward_out;
output reg [2-1:0] rotorA_shift_amount;

reg [6-1:0] rotorB     [0:64-1];
reg [6-1:0] rotorB_tmp [0:64-1];
reg [6-1:0] rotorB_fix [0:64-1];
reg [6-1:0] load_cnt;
reg [6-1:0] load_cnt_tmp;


integer i;
integer j;



always@(posedge clk)begin
    if (~srst_n) begin
        load_cnt <= 6'b0;
        for (i = 0; i < 64; i = i + 1) begin
            rotorB[i] <= 0;
        end
    end else begin
        load_cnt <= load_cnt_tmp;
        for (i = 0; i < 64; i = i + 1) begin
            rotorB[i] <= rotorB_fix[i];
        end
    end
end

always@(*)begin
    if (load && table_idx == 2'b01) begin
        for (i = 0; i < 64; i = i + 1) begin
            rotorB_fix[i] = rotorB[i];
        end
        rotorB_fix[load_cnt] = code_in;
        if (load_cnt != 6'd63) begin
            load_cnt_tmp = load_cnt + 1;
        end else begin
            load_cnt_tmp = load_cnt;
        end
    end else if (encrypt) begin
        if (rotorB_shift_mode == 3) begin
            for (j = 0; j < 16; j = j + 1) begin
                rotorB_tmp[j*4] =   rotorB[j*4];
                rotorB_tmp[j*4+1] = rotorB[j*4+3];
                rotorB_tmp[j*4+2] = rotorB[j*4+2];
                rotorB_tmp[j*4+3] = rotorB[j*4+1];
            end
        end else if (rotorB_shift_mode == 2) begin
            for (j = 0; j < 16; j = j + 1) begin
                rotorB_tmp[j*4] =   rotorB[j*4+1];
                rotorB_tmp[j*4+1] = rotorB[j*4+2];
                rotorB_tmp[j*4+2] = rotorB[j*4+3];
                rotorB_tmp[j*4+3] = rotorB[j*4];
            end
        end else if (rotorB_shift_mode == 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                rotorB_tmp[j*4] =   rotorB[j*4+2];
                rotorB_tmp[j*4+1] = rotorB[j*4];
                rotorB_tmp[j*4+2] = rotorB[j*4+3];
                rotorB_tmp[j*4+3] = rotorB[j*4+1];
            end
        end else begin
            for (j = 0; j < 16; j = j + 1) begin
                rotorB_tmp[j*4] =   rotorB[j*4+1];
                rotorB_tmp[j*4+1] = rotorB[j*4+3];
                rotorB_tmp[j*4+2] = rotorB[j*4];
                rotorB_tmp[j*4+3] = rotorB[j*4+2];
            end
        end
        rotorB_fix[0]  = rotorB_tmp[56];
        rotorB_fix[1]  = rotorB_tmp[61];
        rotorB_fix[2]  = rotorB_tmp[25];
        rotorB_fix[3]  = rotorB_tmp[17];
        rotorB_fix[4]  = rotorB_tmp[42];
        rotorB_fix[5]  = rotorB_tmp[48];
        rotorB_fix[6]  = rotorB_tmp[23];
        rotorB_fix[7]  = rotorB_tmp[43];
        rotorB_fix[8]  = rotorB_tmp[10];
        rotorB_fix[9]  = rotorB_tmp[28];
        rotorB_fix[10] = rotorB_tmp[58];
        rotorB_fix[11] = rotorB_tmp[24];
        rotorB_fix[12] = rotorB_tmp[21];
        rotorB_fix[13] = rotorB_tmp[29];
        rotorB_fix[14] = rotorB_tmp[18];
        rotorB_fix[15] = rotorB_tmp[38];
        rotorB_fix[16] = rotorB_tmp[26];
        rotorB_fix[17] = rotorB_tmp[13];
        rotorB_fix[18] = rotorB_tmp[57];
        rotorB_fix[19] = rotorB_tmp[6];
        rotorB_fix[20] = rotorB_tmp[22];
        rotorB_fix[21] = rotorB_tmp[47];
        rotorB_fix[22] = rotorB_tmp[8];
        rotorB_fix[23] = rotorB_tmp[40];
        rotorB_fix[24] = rotorB_tmp[54];
        rotorB_fix[25] = rotorB_tmp[2];
        rotorB_fix[26] = rotorB_tmp[32];
        rotorB_fix[27] = rotorB_tmp[63];
        rotorB_fix[28] = rotorB_tmp[14];
        rotorB_fix[29] = rotorB_tmp[34];
        rotorB_fix[30] = rotorB_tmp[60];
        rotorB_fix[31] = rotorB_tmp[55];
        rotorB_fix[32] = rotorB_tmp[49];
        rotorB_fix[33] = rotorB_tmp[16];
        rotorB_fix[34] = rotorB_tmp[9];
        rotorB_fix[35] = rotorB_tmp[44];
        rotorB_fix[36] = rotorB_tmp[5];
        rotorB_fix[37] = rotorB_tmp[3];
        rotorB_fix[38] = rotorB_tmp[53];
        rotorB_fix[39] = rotorB_tmp[46];
        rotorB_fix[40] = rotorB_tmp[51];
        rotorB_fix[41] = rotorB_tmp[39];
        rotorB_fix[42] = rotorB_tmp[30];
        rotorB_fix[43] = rotorB_tmp[11];
        rotorB_fix[44] = rotorB_tmp[15];
        rotorB_fix[45] = rotorB_tmp[4];
        rotorB_fix[46] = rotorB_tmp[36];
        rotorB_fix[47] = rotorB_tmp[59];
        rotorB_fix[48] = rotorB_tmp[50];
        rotorB_fix[49] = rotorB_tmp[19];
        rotorB_fix[50] = rotorB_tmp[35];
        rotorB_fix[51] = rotorB_tmp[52];
        rotorB_fix[52] = rotorB_tmp[62];
        rotorB_fix[53] = rotorB_tmp[1];
        rotorB_fix[54] = rotorB_tmp[37];
        rotorB_fix[55] = rotorB_tmp[7];
        rotorB_fix[56] = rotorB_tmp[12];
        rotorB_fix[57] = rotorB_tmp[45];
        rotorB_fix[58] = rotorB_tmp[31];
        rotorB_fix[59] = rotorB_tmp[27];
        rotorB_fix[60] = rotorB_tmp[41];
        rotorB_fix[61] = rotorB_tmp[20];
        rotorB_fix[62] = rotorB_tmp[0];
        rotorB_fix[63] = rotorB_tmp[33];
        load_cnt_tmp = load_cnt;
    end else begin
        for (i = 0; i < 64; i = i + 1) begin
            rotorB_fix[i] = rotorB[i];
        end
        load_cnt_tmp = load_cnt;
    end
end

always@(*)begin
    if (encrypt == 1) begin
        rotorB_forward_out = rotorB[rotorA_forward_out];
    end else begin
        rotorB_forward_out = 0;
    end
end

always@(*)begin
    case (plugboard_backward_out)
        rotorB[0]: rotorB_backward_out  = 6'd0;
        rotorB[1]: rotorB_backward_out  = 6'd1;
        rotorB[2]: rotorB_backward_out  = 6'd2;
        rotorB[3]: rotorB_backward_out  = 6'd3;
        rotorB[4]: rotorB_backward_out  = 6'd4;
        rotorB[5]: rotorB_backward_out  = 6'd5;
        rotorB[6]: rotorB_backward_out  = 6'd6;
        rotorB[7]: rotorB_backward_out  = 6'd7;
        rotorB[8]: rotorB_backward_out  = 6'd8;
        rotorB[9]: rotorB_backward_out  = 6'd9;
        rotorB[10]: rotorB_backward_out = 6'd10;
        rotorB[11]: rotorB_backward_out = 6'd11;
        rotorB[12]: rotorB_backward_out = 6'd12;
        rotorB[13]: rotorB_backward_out = 6'd13;
        rotorB[14]: rotorB_backward_out = 6'd14;
        rotorB[15]: rotorB_backward_out = 6'd15;
        rotorB[16]: rotorB_backward_out = 6'd16;
        rotorB[17]: rotorB_backward_out = 6'd17;
        rotorB[18]: rotorB_backward_out = 6'd18;
        rotorB[19]: rotorB_backward_out = 6'd19;
        rotorB[20]: rotorB_backward_out = 6'd20;
        rotorB[21]: rotorB_backward_out = 6'd21;
        rotorB[22]: rotorB_backward_out = 6'd22;
        rotorB[23]: rotorB_backward_out = 6'd23;
        rotorB[24]: rotorB_backward_out = 6'd24;
        rotorB[25]: rotorB_backward_out = 6'd25;
        rotorB[26]: rotorB_backward_out = 6'd26;
        rotorB[27]: rotorB_backward_out = 6'd27;
        rotorB[28]: rotorB_backward_out = 6'd28;
        rotorB[29]: rotorB_backward_out = 6'd29;
        rotorB[30]: rotorB_backward_out = 6'd30;
        rotorB[31]: rotorB_backward_out = 6'd31;
        rotorB[32]: rotorB_backward_out = 6'd32;
        rotorB[33]: rotorB_backward_out = 6'd33;
        rotorB[34]: rotorB_backward_out = 6'd34;
        rotorB[35]: rotorB_backward_out = 6'd35;
        rotorB[36]: rotorB_backward_out = 6'd36;
        rotorB[37]: rotorB_backward_out = 6'd37;
        rotorB[38]: rotorB_backward_out = 6'd38;
        rotorB[39]: rotorB_backward_out = 6'd39;
        rotorB[40]: rotorB_backward_out = 6'd40;
        rotorB[41]: rotorB_backward_out = 6'd41;
        rotorB[42]: rotorB_backward_out = 6'd42;
        rotorB[43]: rotorB_backward_out = 6'd43;
        rotorB[44]: rotorB_backward_out = 6'd44;
        rotorB[45]: rotorB_backward_out = 6'd45;
        rotorB[46]: rotorB_backward_out = 6'd46;
        rotorB[47]: rotorB_backward_out = 6'd47;
        rotorB[48]: rotorB_backward_out = 6'd48;
        rotorB[49]: rotorB_backward_out = 6'd49;
        rotorB[50]: rotorB_backward_out = 6'd50;
        rotorB[51]: rotorB_backward_out = 6'd51;
        rotorB[52]: rotorB_backward_out = 6'd52;
        rotorB[53]: rotorB_backward_out = 6'd53;
        rotorB[54]: rotorB_backward_out = 6'd54;
        rotorB[55]: rotorB_backward_out = 6'd55;
        rotorB[56]: rotorB_backward_out = 6'd56;
        rotorB[57]: rotorB_backward_out = 6'd57;
        rotorB[58]: rotorB_backward_out = 6'd58;
        rotorB[59]: rotorB_backward_out = 6'd59;
        rotorB[60]: rotorB_backward_out = 6'd60;
        rotorB[61]: rotorB_backward_out = 6'd61;
        rotorB[62]: rotorB_backward_out = 6'd62;
        rotorB[63]: rotorB_backward_out = 6'd63;
        default:    rotorB_backward_out = 6'd0;
    endcase
end

always@(*)begin
    if (crypt_mode == 1'b1) begin
        rotorA_shift_amount = rotorB_backward_out[5:4];
    end else begin
        rotorA_shift_amount = rotorA_forward_out[5:4];
    end
end

endmodule
