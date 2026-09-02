/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : O-2018.06-SP1
// Date      : Sat Aug 29 05:05:21 2026
/////////////////////////////////////////////////////////////


module uart_tx_controller ( clk, rst_n, data_valid, par_en, ser_done, mux_sel, 
        busy, ser_en );
  output [1:0] mux_sel;
  input clk, rst_n, data_valid, par_en, ser_done;
  output busy, ser_en;
  wire   N18, N19, N20, n2, n4, n5, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n1, n3, n6;
  wire   [2:0] state;

  NAND2X0_RVT U10 ( .A1(mux_sel[0]), .A2(n8), .Y(busy) );
  NAND3X0_RVT U11 ( .A1(rst_n), .A2(n9), .A3(n10), .Y(n8) );
  NAND2X0_RVT U12 ( .A1(n11), .A2(n1), .Y(mux_sel[0]) );
  OA21X1_RVT U13 ( .A1(n5), .A2(state[1]), .A3(n12), .Y(n10) );
  NAND2X0_RVT U14 ( .A1(n13), .A2(n14), .Y(N20) );
  NAND4X0_RVT U15 ( .A1(n5), .A2(n4), .A3(rst_n), .A4(n15), .Y(n14) );
  AND2X1_RVT U16 ( .A1(data_valid), .A2(state[2]), .Y(n15) );
  NAND3X0_RVT U17 ( .A1(n16), .A2(n3), .A3(mux_sel[1]), .Y(n13) );
  NAND2X0_RVT U18 ( .A1(n17), .A2(n18), .Y(N19) );
  NAND4X0_RVT U19 ( .A1(n11), .A2(state[0]), .A3(n3), .A4(n4), .Y(n18) );
  AO21X1_RVT U20 ( .A1(n3), .A2(n16), .A3(n19), .Y(n17) );
  AO21X1_RVT U21 ( .A1(ser_done), .A2(n6), .A3(state[0]), .Y(n16) );
  NAND2X0_RVT U22 ( .A1(n20), .A2(n21), .Y(N18) );
  NAND3X0_RVT U23 ( .A1(par_en), .A2(mux_sel[1]), .A3(n22), .Y(n21) );
  AND3X1_RVT U24 ( .A1(n3), .A2(n5), .A3(ser_done), .Y(n22) );
  NAND2X0_RVT U25 ( .A1(n11), .A2(state[1]), .Y(n19) );
  NAND3X0_RVT U26 ( .A1(n11), .A2(n12), .A3(data_valid), .Y(n20) );
  NAND2X0_RVT U27 ( .A1(state[1]), .A2(n5), .Y(n12) );
  AND2X1_RVT U28 ( .A1(rst_n), .A2(n2), .Y(n11) );
  DFFX1_RVT \state_reg[2]  ( .D(N20), .CLK(clk), .Q(state[2]), .QN(n2) );
  DFFX1_RVT \state_reg[1]  ( .D(N19), .CLK(clk), .Q(state[1]), .QN(n4) );
  DFFX1_RVT \state_reg[0]  ( .D(N18), .CLK(clk), .Q(state[0]), .QN(n5) );
  INVX1_RVT U3 ( .A(mux_sel[0]), .Y(ser_en) );
  INVX1_RVT U4 ( .A(n10), .Y(n1) );
  XNOR2X1_RVT U5 ( .A1(n2), .A2(state[0]), .Y(n9) );
  INVX1_RVT U6 ( .A(n19), .Y(mux_sel[1]) );
  INVX1_RVT U7 ( .A(par_en), .Y(n6) );
  INVX1_RVT U8 ( .A(data_valid), .Y(n3) );
endmodule


module uart_tx_parity_bit ( clk, rst_n, p_data, par_typ, par_bit );
  input [7:0] p_data;
  input clk, rst_n, par_typ;
  output par_bit;
  wire   n2, n3, n4, n5, n6;

  DFFSSRX1_RVT par_bit_reg ( .D(rst_n), .SETB(1'b1), .RSTB(n2), .CLK(clk), .Q(
        par_bit) );
  XNOR3X1_RVT U4 ( .A1(par_typ), .A2(n3), .A3(n4), .Y(n2) );
  XNOR3X1_RVT U5 ( .A1(p_data[5]), .A2(p_data[4]), .A3(n6), .Y(n3) );
  XNOR3X1_RVT U6 ( .A1(p_data[1]), .A2(p_data[0]), .A3(n5), .Y(n4) );
  XNOR2X1_RVT U7 ( .A1(p_data[7]), .A2(p_data[6]), .Y(n6) );
  XOR2X1_RVT U8 ( .A1(p_data[3]), .A2(p_data[2]), .Y(n5) );
endmodule


module uart_tx_serializer ( clk, rst_n, p_data, ser_en, ser_done, ser_data );
  input [7:0] p_data;
  input clk, rst_n, ser_en;
  output ser_done, ser_data;
  wire   N2, N3, N4, N8, N12, N13, N14, N15, N17, n1, n2, n4, n5, n6, n3, n7,
         n8, n9, n10, n11, n12, n13;

  DFFARX1_RVT ser_data_reg ( .D(N12), .CLK(clk), .RSTB(rst_n), .Q(ser_data) );
  DFFARX1_RVT \ser_counter_reg[1]  ( .D(N14), .CLK(clk), .RSTB(rst_n), .Q(N3), 
        .QN(n2) );
  DFFARX1_RVT \ser_counter_reg[2]  ( .D(N15), .CLK(clk), .RSTB(rst_n), .Q(N4), 
        .QN(n1) );
  DFFARX1_RVT ser_done_reg ( .D(N17), .CLK(clk), .RSTB(rst_n), .Q(ser_done) );
  AND3X1_RVT U5 ( .A1(N3), .A2(N2), .A3(N4), .Y(N17) );
  AO22X1_RVT U6 ( .A1(N13), .A2(N4), .A3(ser_en), .A4(n4), .Y(N15) );
  AO22X1_RVT U7 ( .A1(N4), .A2(n2), .A3(n5), .A4(N3), .Y(n4) );
  AND2X1_RVT U8 ( .A1(N2), .A2(n1), .Y(n5) );
  AND2X1_RVT U9 ( .A1(ser_en), .A2(n6), .Y(N14) );
  NOR2X0_RVT U10 ( .A1(n13), .A2(N2), .Y(N13) );
  OR2X1_RVT U11 ( .A1(N8), .A2(n13), .Y(N12) );
  DFFARX1_RVT \ser_counter_reg[0]  ( .D(N13), .CLK(clk), .RSTB(rst_n), .Q(N2), 
        .QN(n3) );
  INVX1_RVT U3 ( .A(ser_en), .Y(n13) );
  XNOR2X1_RVT U4 ( .A1(n2), .A2(N2), .Y(n6) );
  AO22X1_RVT U12 ( .A1(p_data[7]), .A2(N2), .A3(p_data[6]), .A4(n3), .Y(n8) );
  AO22X1_RVT U13 ( .A1(p_data[5]), .A2(N2), .A3(p_data[4]), .A4(n3), .Y(n7) );
  AO22X1_RVT U14 ( .A1(N3), .A2(n8), .A3(n7), .A4(n2), .Y(n12) );
  AO22X1_RVT U15 ( .A1(p_data[3]), .A2(N2), .A3(p_data[2]), .A4(n3), .Y(n10)
         );
  AO22X1_RVT U16 ( .A1(p_data[1]), .A2(N2), .A3(p_data[0]), .A4(n3), .Y(n9) );
  AO22X1_RVT U17 ( .A1(n10), .A2(N3), .A3(n9), .A4(n2), .Y(n11) );
  AO22X1_RVT U18 ( .A1(N4), .A2(n12), .A3(n11), .A4(n1), .Y(N8) );
endmodule


module uart_tx_mux4x1 ( in0, in1, in2, in3, mux_out, mux_sel );
  input [1:0] mux_sel;
  input in0, in1, in2, in3;
  output mux_out;
  wire   n3, n4, n1, n2;

  AO22X1_RVT U3 ( .A1(mux_sel[1]), .A2(n3), .A3(n4), .A4(n2), .Y(mux_out) );
  AO22X1_RVT U4 ( .A1(mux_sel[0]), .A2(in1), .A3(in0), .A4(n1), .Y(n4) );
  AO22X1_RVT U5 ( .A1(in3), .A2(mux_sel[0]), .A3(in2), .A4(n1), .Y(n3) );
  INVX1_RVT U1 ( .A(mux_sel[0]), .Y(n1) );
  INVX1_RVT U2 ( .A(mux_sel[1]), .Y(n2) );
endmodule


module uart_tx ( clk, rst_n, p_data, data_valid, par_en, par_typ, tx_out, busy
 );
  input [7:0] p_data;
  input clk, rst_n, data_valid, par_en, par_typ;
  output tx_out, busy;
  wire   ser_done, ser_en, par_bit, ser_data, n1;
  wire   [1:0] mux_sel;

  uart_tx_controller uart_tx_controller_mod ( .clk(clk), .rst_n(n1), 
        .data_valid(data_valid), .par_en(par_en), .ser_done(ser_done), 
        .mux_sel(mux_sel), .busy(busy), .ser_en(ser_en) );
  uart_tx_parity_bit uart_tx_parity_bit_mod ( .clk(clk), .rst_n(n1), .p_data(
        p_data), .par_typ(par_typ), .par_bit(par_bit) );
  uart_tx_serializer uart_tx_serializer_mod ( .clk(clk), .rst_n(n1), .p_data(
        p_data), .ser_en(ser_en), .ser_done(ser_done), .ser_data(ser_data) );
  uart_tx_mux4x1 uart_tx_mux4x1_mod ( .in0(1'b0), .in1(1'b1), .in2(ser_data), 
        .in3(par_bit), .mux_out(tx_out), .mux_sel(mux_sel) );
  NBUFFX2_RVT U1 ( .A(rst_n), .Y(n1) );
endmodule


module uart_rx_controller ( clk, rst_n, rx_in, bit_cnt, edge_cnt, str_glitch, 
        stp_err, par_err, par_en, data_sampling_en, counter_en, cnt_zero, 
        par_chk_en, stp_chk_en, str_chk_en, deser_en, data_valid_cnt_en, 
        data_valid_cnt, calc_par_bit_en, data_valid, data_valid_par_chk );
  input [3:0] bit_cnt;
  input [2:0] edge_cnt;
  input [2:0] data_valid_cnt;
  input clk, rst_n, rx_in, str_glitch, stp_err, par_err, par_en;
  output data_sampling_en, counter_en, cnt_zero, par_chk_en, stp_chk_en,
         str_chk_en, deser_en, data_valid_cnt_en, calc_par_bit_en, data_valid,
         data_valid_par_chk;
  wire   n10, n11, n12, n21, n22, n23, n24, n25, n27, n28, n29, n30, n32, n33,
         n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47,
         n48, n49, n1, n2, n5, n7, n8, n9, n13, n14, n15, n16, n17, n20, n26,
         n31, n50;
  wire   [2:0] state;

  DFFSSRX1_RVT \state_reg[0]  ( .D(rst_n), .SETB(1'b1), .RSTB(n36), .CLK(clk), 
        .Q(state[0]), .QN(n12) );
  DFFSSRX1_RVT \state_reg[2]  ( .D(n25), .SETB(n2), .RSTB(rst_n), .CLK(clk), 
        .Q(state[2]), .QN(n10) );
  DFFSSRX1_RVT \state_reg[1]  ( .D(n30), .SETB(n1), .RSTB(rst_n), .CLK(clk), 
        .Q(state[1]), .QN(n11) );
  NOR4X1_RVT U7 ( .A1(n43), .A2(n44), .A3(stp_err), .A4(n45), .Y(n42) );
  NAND3X0_RVT U24 ( .A1(n21), .A2(n22), .A3(n23), .Y(counter_en) );
  NAND2X0_RVT U25 ( .A1(state[0]), .A2(n10), .Y(n23) );
  AO21X1_RVT U26 ( .A1(n20), .A2(n12), .A3(data_valid), .Y(cnt_zero) );
  NAND2X0_RVT U27 ( .A1(n21), .A2(n24), .Y(calc_par_bit_en) );
  AO22X1_RVT U28 ( .A1(data_valid_par_chk), .A2(n28), .A3(par_chk_en), .A4(n7), 
        .Y(n25) );
  AND3X1_RVT U30 ( .A1(n14), .A2(n50), .A3(n35), .Y(n28) );
  NAND3X0_RVT U31 ( .A1(n13), .A2(n15), .A3(str_chk_en), .Y(n33) );
  OR3X1_RVT U32 ( .A1(str_glitch), .A2(bit_cnt[3]), .A3(bit_cnt[0]), .Y(n32)
         );
  NAND4X0_RVT U33 ( .A1(n8), .A2(n27), .A3(n37), .A4(n38), .Y(n36) );
  OR3X1_RVT U34 ( .A1(state[0]), .A2(rx_in), .A3(n39), .Y(n38) );
  NAND2X0_RVT U35 ( .A1(str_chk_en), .A2(n40), .Y(n37) );
  NAND4X0_RVT U36 ( .A1(n13), .A2(n15), .A3(n14), .A4(n17), .Y(n40) );
  AND2X1_RVT U37 ( .A1(state[0]), .A2(n20), .Y(str_chk_en) );
  NAND2X0_RVT U38 ( .A1(n11), .A2(n10), .Y(n39) );
  AOI21X1_RVT U39 ( .A1(data_valid), .A2(n41), .A3(n42), .Y(n27) );
  OA22X1_RVT U40 ( .A1(n16), .A2(n46), .A3(n47), .A4(n14), .Y(n45) );
  OR2X1_RVT U41 ( .A1(bit_cnt[0]), .A2(bit_cnt[1]), .Y(n46) );
  NAND2X0_RVT U42 ( .A1(bit_cnt[3]), .A2(stp_chk_en), .Y(n43) );
  NAND2X0_RVT U43 ( .A1(n31), .A2(n12), .Y(n22) );
  NAND3X0_RVT U44 ( .A1(data_valid_cnt[1]), .A2(data_valid_cnt[0]), .A3(
        data_valid_cnt[2]), .Y(n41) );
  NAND2X0_RVT U46 ( .A1(state[2]), .A2(n11), .Y(n24) );
  NAND2X0_RVT U47 ( .A1(n48), .A2(n49), .Y(n30) );
  NAND4X0_RVT U48 ( .A1(par_en), .A2(data_valid_par_chk), .A3(n35), .A4(n14), 
        .Y(n49) );
  NAND2X0_RVT U49 ( .A1(n26), .A2(n12), .Y(n34) );
  NAND3X0_RVT U50 ( .A1(n29), .A2(n9), .A3(par_chk_en), .Y(n48) );
  AND2X1_RVT U51 ( .A1(n26), .A2(state[0]), .Y(par_chk_en) );
  NAND2X0_RVT U52 ( .A1(state[1]), .A2(n10), .Y(n21) );
  NAND4X0_RVT U53 ( .A1(n35), .A2(n13), .A3(bit_cnt[0]), .A4(n9), .Y(n29) );
  OR3X1_RVT U54 ( .A1(edge_cnt[2]), .A2(edge_cnt[1]), .A3(edge_cnt[0]), .Y(n44) );
  AND2X1_RVT U55 ( .A1(bit_cnt[3]), .A2(n15), .Y(n35) );
  NAND2X0_RVT U56 ( .A1(bit_cnt[1]), .A2(n16), .Y(n47) );
  INVX1_RVT U3 ( .A(data_valid), .Y(n5) );
  AND2X2_RVT U4 ( .A1(n31), .A2(state[0]), .Y(data_valid) );
  INVX1_RVT U6 ( .A(n24), .Y(n31) );
  INVX1_RVT U8 ( .A(n29), .Y(n7) );
  INVX1_RVT U9 ( .A(n34), .Y(data_valid_par_chk) );
  INVX1_RVT U10 ( .A(n21), .Y(n26) );
  INVX1_RVT U11 ( .A(n47), .Y(n15) );
  INVX1_RVT U12 ( .A(n39), .Y(n20) );
  INVX1_RVT U13 ( .A(n44), .Y(n13) );
  INVX1_RVT U14 ( .A(n30), .Y(n8) );
  INVX1_RVT U15 ( .A(par_en), .Y(n50) );
  OA22X1_RVT U16 ( .A1(n32), .A2(n33), .A3(n28), .A4(n34), .Y(n1) );
  INVX1_RVT U17 ( .A(bit_cnt[3]), .Y(n17) );
  INVX1_RVT U18 ( .A(n22), .Y(stp_chk_en) );
  INVX1_RVT U19 ( .A(bit_cnt[0]), .Y(n14) );
  INVX1_RVT U20 ( .A(bit_cnt[2]), .Y(n16) );
  INVX1_RVT U21 ( .A(par_err), .Y(n9) );
  OA21X1_RVT U22 ( .A1(n22), .A2(stp_err), .A3(n27), .Y(n2) );
  INVX1_RVT U23 ( .A(n5), .Y(data_valid_cnt_en) );
  NBUFFX2_RVT U29 ( .A(counter_en), .Y(data_sampling_en) );
  INVX1_RVT U45 ( .A(n34), .Y(deser_en) );
endmodule


module uart_rx_counters ( clk, rst_n, enable, data_valid_cnt_en, cnt_zero, 
        bit_cnt, edge_cnt, data_valid_cnt );
  output [3:0] bit_cnt;
  output [2:0] edge_cnt;
  output [2:0] data_valid_cnt;
  input clk, rst_n, enable, data_valid_cnt_en, cnt_zero;
  wire   n1, n2, n7, n10, n13, n14, n15, n17, n21, n22, n23, n24, n26, n27,
         n28, n29, n30, n31, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42,
         n43, n44, n45, n46, n3, n4, n5, n6, n8, n9;

  DFFARX1_RVT \edge_cnt_reg[0]  ( .D(n46), .CLK(clk), .RSTB(n5), .Q(
        edge_cnt[0]), .QN(n37) );
  DFFARX1_RVT \edge_cnt_reg[1]  ( .D(n45), .CLK(clk), .RSTB(n5), .Q(
        edge_cnt[1]), .QN(n36) );
  DFFARX1_RVT \edge_cnt_reg[2]  ( .D(n44), .CLK(clk), .RSTB(n5), .Q(
        edge_cnt[2]), .QN(n27) );
  DFFARX1_RVT \bit_cnt_reg[0]  ( .D(n43), .CLK(clk), .RSTB(n5), .Q(bit_cnt[0]), 
        .QN(n39) );
  DFFARX1_RVT \bit_cnt_reg[1]  ( .D(n42), .CLK(clk), .RSTB(n5), .Q(bit_cnt[1]), 
        .QN(n28) );
  DFFARX1_RVT \bit_cnt_reg[2]  ( .D(n41), .CLK(clk), .RSTB(n5), .Q(bit_cnt[2]), 
        .QN(n38) );
  DFFARX1_RVT \bit_cnt_reg[3]  ( .D(n40), .CLK(clk), .RSTB(n5), .Q(bit_cnt[3]), 
        .QN(n29) );
  DFFARX1_RVT \data_valid_cnt_reg[0]  ( .D(n35), .CLK(clk), .RSTB(n5), .Q(
        data_valid_cnt[0]) );
  DFFARX1_RVT \data_valid_cnt_reg[1]  ( .D(n34), .CLK(clk), .RSTB(n5), .Q(
        data_valid_cnt[1]), .QN(n31) );
  DFFARX1_RVT \data_valid_cnt_reg[2]  ( .D(n33), .CLK(clk), .RSTB(n5), .Q(
        data_valid_cnt[2]), .QN(n30) );
  OR2X1_RVT U4 ( .A1(n2), .A2(n31), .Y(n1) );
  NAND2X0_RVT U6 ( .A1(data_valid_cnt_en), .A2(data_valid_cnt[0]), .Y(n2) );
  AO22X1_RVT U13 ( .A1(n10), .A2(bit_cnt[2]), .A3(n38), .A4(n7), .Y(n41) );
  AND3X1_RVT U14 ( .A1(bit_cnt[0]), .A2(bit_cnt[1]), .A3(n6), .Y(n7) );
  AO21X1_RVT U16 ( .A1(n28), .A2(n6), .A3(n13), .Y(n10) );
  AO22X1_RVT U17 ( .A1(n13), .A2(bit_cnt[1]), .A3(n14), .A4(n28), .Y(n42) );
  AND2X1_RVT U18 ( .A1(n6), .A2(bit_cnt[0]), .Y(n14) );
  AO22X1_RVT U20 ( .A1(n15), .A2(n8), .A3(n39), .A4(n6), .Y(n13) );
  AO22X1_RVT U21 ( .A1(n39), .A2(n6), .A3(n17), .A4(n15), .Y(n43) );
  AND2X1_RVT U22 ( .A1(n8), .A2(bit_cnt[0]), .Y(n17) );
  NAND4X0_RVT U25 ( .A1(enable), .A2(edge_cnt[0]), .A3(edge_cnt[1]), .A4(
        edge_cnt[2]), .Y(n15) );
  AO21X1_RVT U26 ( .A1(n21), .A2(edge_cnt[2]), .A3(n22), .Y(n44) );
  AND4X1_RVT U27 ( .A1(n27), .A2(enable), .A3(edge_cnt[0]), .A4(edge_cnt[1]), 
        .Y(n22) );
  AO21X1_RVT U29 ( .A1(n36), .A2(enable), .A3(n23), .Y(n21) );
  AO22X1_RVT U30 ( .A1(n23), .A2(edge_cnt[1]), .A3(n24), .A4(n36), .Y(n45) );
  AND2X1_RVT U31 ( .A1(enable), .A2(edge_cnt[0]), .Y(n24) );
  AO22X1_RVT U33 ( .A1(n37), .A2(enable), .A3(n8), .A4(n9), .Y(n23) );
  AO22X1_RVT U34 ( .A1(n37), .A2(enable), .A3(n26), .A4(n8), .Y(n46) );
  AND2X1_RVT U36 ( .A1(n9), .A2(edge_cnt[0]), .Y(n26) );
  INVX1_RVT U3 ( .A(n15), .Y(n6) );
  NBUFFX2_RVT U5 ( .A(rst_n), .Y(n5) );
  INVX1_RVT U7 ( .A(enable), .Y(n9) );
  XOR2X1_RVT U8 ( .A1(data_valid_cnt_en), .A2(data_valid_cnt[0]), .Y(n35) );
  INVX1_RVT U9 ( .A(cnt_zero), .Y(n8) );
  XOR2X1_RVT U10 ( .A1(n2), .A2(n31), .Y(n34) );
  OAI22X1_RVT U11 ( .A1(n3), .A2(n29), .A3(n4), .A4(bit_cnt[3]), .Y(n40) );
  AOI21X1_RVT U12 ( .A1(n38), .A2(n6), .A3(n10), .Y(n3) );
  NAND2X0_RVT U15 ( .A1(n7), .A2(bit_cnt[2]), .Y(n4) );
  XOR2X1_RVT U19 ( .A1(n1), .A2(n30), .Y(n33) );
endmodule


module uart_rx_data_sampling ( clk, rst_n, rx_in, data_samp_en, edge_cnt, 
        bit_cnt, sampled_bit );
  input [2:0] edge_cnt;
  input [3:0] bit_cnt;
  input clk, rst_n, rx_in, data_samp_en;
  output sampled_bit;
  wire   n1, n3, n4, n5, n9, n11, n13, n14, n16, n17, n18, n19, n2, n6, n7, n8,
         n10, n12, n15;
  wire   [2:0] three_samps_data;

  DFFARX1_RVT \three_samps_data_reg[2]  ( .D(n19), .CLK(clk), .RSTB(rst_n), 
        .Q(three_samps_data[2]) );
  DFFARX1_RVT \three_samps_data_reg[1]  ( .D(n18), .CLK(clk), .RSTB(rst_n), 
        .Q(three_samps_data[1]) );
  DFFARX1_RVT \three_samps_data_reg[0]  ( .D(n17), .CLK(clk), .RSTB(rst_n), 
        .Q(three_samps_data[0]) );
  DFFARX1_RVT sampled_bit_reg ( .D(n16), .CLK(clk), .RSTB(rst_n), .Q(
        sampled_bit) );
  AO22X1_RVT U3 ( .A1(sampled_bit), .A2(n1), .A3(n2), .A4(n3), .Y(n16) );
  AO22X1_RVT U4 ( .A1(three_samps_data[1]), .A2(three_samps_data[0]), .A3(
        three_samps_data[2]), .A4(n4), .Y(n3) );
  OR2X1_RVT U5 ( .A1(three_samps_data[1]), .A2(three_samps_data[0]), .Y(n4) );
  NAND4X0_RVT U7 ( .A1(n5), .A2(n7), .A3(n12), .A4(n15), .Y(n1) );
  AO22X1_RVT U9 ( .A1(three_samps_data[0]), .A2(n9), .A3(rx_in), .A4(n8), .Y(
        n17) );
  NAND4X0_RVT U11 ( .A1(edge_cnt[1]), .A2(edge_cnt[0]), .A3(data_samp_en), 
        .A4(n15), .Y(n9) );
  AO22X1_RVT U13 ( .A1(three_samps_data[1]), .A2(n11), .A3(n6), .A4(rx_in), 
        .Y(n18) );
  NAND2X0_RVT U15 ( .A1(n13), .A2(n7), .Y(n11) );
  AO22X1_RVT U17 ( .A1(three_samps_data[2]), .A2(n14), .A3(n10), .A4(rx_in), 
        .Y(n19) );
  NAND2X0_RVT U19 ( .A1(n13), .A2(edge_cnt[0]), .Y(n14) );
  AND3X1_RVT U20 ( .A1(data_samp_en), .A2(n12), .A3(edge_cnt[2]), .Y(n13) );
  INVX1_RVT U6 ( .A(n14), .Y(n10) );
  INVX1_RVT U8 ( .A(n9), .Y(n8) );
  INVX1_RVT U10 ( .A(n11), .Y(n6) );
  INVX1_RVT U12 ( .A(edge_cnt[0]), .Y(n7) );
  INVX1_RVT U14 ( .A(edge_cnt[1]), .Y(n12) );
  INVX1_RVT U16 ( .A(n1), .Y(n2) );
  INVX1_RVT U18 ( .A(edge_cnt[2]), .Y(n15) );
  OR4X1_RVT U21 ( .A1(bit_cnt[1]), .A2(bit_cnt[0]), .A3(bit_cnt[3]), .A4(
        bit_cnt[2]), .Y(n5) );
endmodule


module uart_rx_parity_check ( clk, rst_n, par_typ, par_chk_en, sampled_bit, 
        calc_par_bit_en, data_valid_par_chk, edge_cnt, par_err, calc_par_bit
 );
  input [2:0] edge_cnt;
  input clk, rst_n, par_typ, par_chk_en, sampled_bit, calc_par_bit_en,
         data_valid_par_chk;
  output par_err, calc_par_bit;
  wire   n5, n6, n7, n8, n9, n10, n1, n2, n3, n4;

  DFFARX1_RVT calc_par_bit_reg ( .D(n10), .CLK(clk), .RSTB(rst_n), .Q(
        calc_par_bit) );
  AND4X1_RVT U8 ( .A1(edge_cnt[0]), .A2(n5), .A3(edge_cnt[1]), .A4(n6), .Y(
        par_err) );
  AND2X1_RVT U9 ( .A1(par_chk_en), .A2(edge_cnt[2]), .Y(n6) );
  AO22X1_RVT U10 ( .A1(n1), .A2(calc_par_bit), .A3(n7), .A4(n8), .Y(n10) );
  AO22X1_RVT U11 ( .A1(par_typ), .A2(n4), .A3(calc_par_bit_en), .A4(n5), .Y(n7) );
  NAND2X0_RVT U12 ( .A1(calc_par_bit_en), .A2(n9), .Y(n8) );
  NAND4X0_RVT U13 ( .A1(data_valid_par_chk), .A2(edge_cnt[2]), .A3(n2), .A4(n3), .Y(n9) );
  INVX1_RVT U3 ( .A(calc_par_bit_en), .Y(n4) );
  INVX1_RVT U4 ( .A(n8), .Y(n1) );
  INVX1_RVT U5 ( .A(edge_cnt[1]), .Y(n3) );
  INVX1_RVT U6 ( .A(edge_cnt[0]), .Y(n2) );
  XOR2X1_RVT U7 ( .A1(calc_par_bit), .A2(sampled_bit), .Y(n5) );
endmodule


module uart_rx_start_check ( clk, rst_n, sampled_bit, str_chk_en, str_glitch
 );
  input clk, rst_n, sampled_bit, str_chk_en;
  output str_glitch;
  wire   N1;

  DFFARX1_RVT str_glitch_reg ( .D(N1), .CLK(clk), .RSTB(rst_n), .Q(str_glitch)
         );
  AND2X1_RVT U3 ( .A1(str_chk_en), .A2(sampled_bit), .Y(N1) );
endmodule


module uart_rx_stop_check ( clk, rst_n, sampled_bit, stp_chk_en, stp_err );
  input clk, rst_n, sampled_bit, stp_chk_en;
  output stp_err;
  wire   n2, n1;

  DFFARX1_RVT stp_err_reg ( .D(n2), .CLK(clk), .RSTB(rst_n), .Q(stp_err) );
  AO21X1_RVT U3 ( .A1(stp_chk_en), .A2(n1), .A3(stp_err), .Y(n2) );
  INVX1_RVT U4 ( .A(sampled_bit), .Y(n1) );
endmodule


module uart_rx_deserializer ( clk, rst_n, deser_en, par_en, sampled_bit, 
        bit_cnt, edge_cnt, data_valid, calc_par_bit, p_data );
  input [3:0] bit_cnt;
  input [2:0] edge_cnt;
  output [10:0] p_data;
  input clk, rst_n, deser_en, par_en, sampled_bit, data_valid, calc_par_bit;
  wire   n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29,
         n30, n31, n32, n33, n34, n35, n36, n37, n38, n3, n5, n6, n7, n8, n9,
         n10, n11, n12, n13, n14, n15, n39, n40, n41;
  wire   [7:0] p_data_temp;

  DFFARX1_RVT \p_data_temp_reg[7]  ( .D(n38), .CLK(clk), .RSTB(n5), .Q(
        p_data_temp[7]) );
  DFFARX1_RVT \p_data_temp_reg[6]  ( .D(n37), .CLK(clk), .RSTB(n5), .Q(
        p_data_temp[6]) );
  DFFARX1_RVT \p_data_temp_reg[5]  ( .D(n36), .CLK(clk), .RSTB(n5), .Q(
        p_data_temp[5]) );
  DFFARX1_RVT \p_data_temp_reg[4]  ( .D(n35), .CLK(clk), .RSTB(n5), .Q(
        p_data_temp[4]) );
  DFFARX1_RVT \p_data_temp_reg[3]  ( .D(n34), .CLK(clk), .RSTB(n5), .Q(
        p_data_temp[3]) );
  DFFARX1_RVT \p_data_temp_reg[2]  ( .D(n33), .CLK(clk), .RSTB(n5), .Q(
        p_data_temp[2]) );
  DFFARX1_RVT \p_data_temp_reg[1]  ( .D(n32), .CLK(clk), .RSTB(n5), .Q(
        p_data_temp[1]) );
  DFFARX1_RVT \p_data_temp_reg[0]  ( .D(n31), .CLK(clk), .RSTB(n5), .Q(
        p_data_temp[0]) );
  AND2X1_RVT U16 ( .A1(p_data_temp[7]), .A2(data_valid), .Y(p_data[9]) );
  AND2X1_RVT U17 ( .A1(p_data_temp[6]), .A2(data_valid), .Y(p_data[8]) );
  AND2X1_RVT U18 ( .A1(p_data_temp[5]), .A2(data_valid), .Y(p_data[7]) );
  AND2X1_RVT U19 ( .A1(p_data_temp[4]), .A2(data_valid), .Y(p_data[6]) );
  AND2X1_RVT U20 ( .A1(p_data_temp[3]), .A2(data_valid), .Y(p_data[5]) );
  AND2X1_RVT U21 ( .A1(p_data_temp[2]), .A2(data_valid), .Y(p_data[4]) );
  AND2X1_RVT U22 ( .A1(p_data_temp[1]), .A2(data_valid), .Y(p_data[3]) );
  AND2X1_RVT U23 ( .A1(p_data_temp[0]), .A2(data_valid), .Y(p_data[2]) );
  OA21X1_RVT U24 ( .A1(calc_par_bit), .A2(n41), .A3(data_valid), .Y(p_data[1])
         );
  AO22X1_RVT U25 ( .A1(sampled_bit), .A2(n13), .A3(p_data_temp[2]), .A4(n16), 
        .Y(n33) );
  NAND3X0_RVT U26 ( .A1(n14), .A2(n15), .A3(n17), .Y(n16) );
  AO22X1_RVT U27 ( .A1(n12), .A2(sampled_bit), .A3(p_data_temp[3]), .A4(n18), 
        .Y(n34) );
  NAND3X0_RVT U28 ( .A1(n17), .A2(n15), .A3(bit_cnt[0]), .Y(n18) );
  AO22X1_RVT U29 ( .A1(n11), .A2(sampled_bit), .A3(p_data_temp[4]), .A4(n19), 
        .Y(n35) );
  NAND3X0_RVT U30 ( .A1(n17), .A2(n14), .A3(bit_cnt[1]), .Y(n19) );
  AO22X1_RVT U31 ( .A1(n10), .A2(sampled_bit), .A3(p_data_temp[5]), .A4(n20), 
        .Y(n36) );
  NAND3X0_RVT U32 ( .A1(bit_cnt[0]), .A2(n17), .A3(bit_cnt[1]), .Y(n20) );
  AND2X1_RVT U33 ( .A1(bit_cnt[2]), .A2(n21), .Y(n17) );
  AO22X1_RVT U34 ( .A1(n9), .A2(sampled_bit), .A3(p_data_temp[6]), .A4(n22), 
        .Y(n37) );
  NAND2X0_RVT U35 ( .A1(n23), .A2(n14), .Y(n22) );
  AO22X1_RVT U36 ( .A1(n8), .A2(sampled_bit), .A3(p_data_temp[7]), .A4(n24), 
        .Y(n38) );
  NAND2X0_RVT U37 ( .A1(n23), .A2(bit_cnt[0]), .Y(n24) );
  AND3X1_RVT U38 ( .A1(n15), .A2(n39), .A3(n21), .Y(n23) );
  AO22X1_RVT U39 ( .A1(n7), .A2(sampled_bit), .A3(p_data_temp[0]), .A4(n25), 
        .Y(n31) );
  NAND2X0_RVT U40 ( .A1(n26), .A2(n14), .Y(n25) );
  AO22X1_RVT U41 ( .A1(n6), .A2(sampled_bit), .A3(p_data_temp[1]), .A4(n27), 
        .Y(n32) );
  NAND2X0_RVT U42 ( .A1(n26), .A2(bit_cnt[0]), .Y(n27) );
  AND3X1_RVT U43 ( .A1(n21), .A2(n39), .A3(bit_cnt[1]), .Y(n26) );
  AND4X1_RVT U44 ( .A1(deser_en), .A2(n28), .A3(edge_cnt[2]), .A4(n29), .Y(n21) );
  NOR3X0_RVT U45 ( .A1(n30), .A2(edge_cnt[1]), .A3(edge_cnt[0]), .Y(n29) );
  AND3X1_RVT U46 ( .A1(n39), .A2(n40), .A3(n15), .Y(n30) );
  AO21X1_RVT U47 ( .A1(n15), .A2(n39), .A3(n40), .Y(n28) );
  INVX1_RVT U3 ( .A(1'b1), .Y(p_data[10]) );
  INVX1_RVT U5 ( .A(data_valid), .Y(n3) );
  NBUFFX2_RVT U6 ( .A(rst_n), .Y(n5) );
  INVX1_RVT U7 ( .A(par_en), .Y(n41) );
  INVX1_RVT U8 ( .A(n20), .Y(n10) );
  INVX1_RVT U9 ( .A(bit_cnt[0]), .Y(n14) );
  INVX1_RVT U10 ( .A(bit_cnt[1]), .Y(n15) );
  INVX1_RVT U11 ( .A(bit_cnt[2]), .Y(n39) );
  INVX1_RVT U12 ( .A(n16), .Y(n13) );
  INVX1_RVT U13 ( .A(bit_cnt[3]), .Y(n40) );
  INVX1_RVT U14 ( .A(n25), .Y(n7) );
  INVX1_RVT U15 ( .A(n27), .Y(n6) );
  INVX1_RVT U48 ( .A(n18), .Y(n12) );
  INVX1_RVT U49 ( .A(n19), .Y(n11) );
  INVX1_RVT U50 ( .A(n22), .Y(n9) );
  INVX1_RVT U51 ( .A(n24), .Y(n8) );
  INVX1_RVT U52 ( .A(n3), .Y(p_data[0]) );
endmodule


module uart_rx ( clk, rst_n, rx_in, par_en, par_typ, p_data, data_valid );
  output [10:0] p_data;
  input clk, rst_n, rx_in, par_en, par_typ;
  output data_valid;
  wire   data_sampling_en_top, counter_en_top, par_chk_en_top, stp_chk_en_top,
         str_chk_en_top, deser_en_top, data_valid_top, cnt_zero_top,
         data_valid_par_chk_top, data_valid_cnt_en_top, calc_par_bit_en_top,
         sampled_bit_top, par_err_top, calc_par_bit_top, str_glitch_top,
         stp_err_top, n3;
  wire   [2:0] edge_cnt_top;
  wire   [3:0] bit_cnt_top;
  wire   [2:0] data_valid_cnt_top;
  wire   [10:0] p_data_top;
  wire   SYNOPSYS_UNCONNECTED__0;
  assign data_valid = data_valid_top;
  assign p_data[9] = p_data_top[9];
  assign p_data[8] = p_data_top[8];
  assign p_data[7] = p_data_top[7];
  assign p_data[6] = p_data_top[6];
  assign p_data[5] = p_data_top[5];
  assign p_data[4] = p_data_top[4];
  assign p_data[3] = p_data_top[3];
  assign p_data[2] = p_data_top[2];
  assign p_data[1] = p_data_top[1];
  assign p_data[0] = p_data_top[0];

  uart_rx_controller uart_rx_controller_blk ( .clk(clk), .rst_n(n3), .rx_in(
        rx_in), .bit_cnt(bit_cnt_top), .edge_cnt(edge_cnt_top), .str_glitch(
        str_glitch_top), .stp_err(stp_err_top), .par_err(par_err_top), 
        .par_en(par_en), .data_sampling_en(data_sampling_en_top), .counter_en(
        counter_en_top), .cnt_zero(cnt_zero_top), .par_chk_en(par_chk_en_top), 
        .stp_chk_en(stp_chk_en_top), .str_chk_en(str_chk_en_top), .deser_en(
        deser_en_top), .data_valid_cnt_en(data_valid_cnt_en_top), 
        .data_valid_cnt(data_valid_cnt_top), .calc_par_bit_en(
        calc_par_bit_en_top), .data_valid(data_valid_top), 
        .data_valid_par_chk(data_valid_par_chk_top) );
  uart_rx_counters uart_rx_counters_blk ( .clk(clk), .rst_n(n3), .enable(
        counter_en_top), .data_valid_cnt_en(data_valid_cnt_en_top), .cnt_zero(
        cnt_zero_top), .bit_cnt(bit_cnt_top), .edge_cnt(edge_cnt_top), 
        .data_valid_cnt(data_valid_cnt_top) );
  uart_rx_data_sampling uart_rx_data_sampling_blk ( .clk(clk), .rst_n(n3), 
        .rx_in(rx_in), .data_samp_en(data_sampling_en_top), .edge_cnt(
        edge_cnt_top), .bit_cnt(bit_cnt_top), .sampled_bit(sampled_bit_top) );
  uart_rx_parity_check uart_rx_parity_check_blk ( .clk(clk), .rst_n(n3), 
        .par_typ(par_typ), .par_chk_en(par_chk_en_top), .sampled_bit(
        sampled_bit_top), .calc_par_bit_en(calc_par_bit_en_top), 
        .data_valid_par_chk(data_valid_par_chk_top), .edge_cnt(edge_cnt_top), 
        .par_err(par_err_top), .calc_par_bit(calc_par_bit_top) );
  uart_rx_start_check uart_rx_start_check_blk ( .clk(clk), .rst_n(n3), 
        .sampled_bit(sampled_bit_top), .str_chk_en(str_chk_en_top), 
        .str_glitch(str_glitch_top) );
  uart_rx_stop_check uart_rx_stop_check_blk ( .clk(clk), .rst_n(n3), 
        .sampled_bit(sampled_bit_top), .stp_chk_en(stp_chk_en_top), .stp_err(
        stp_err_top) );
  uart_rx_deserializer uart_rx_deserializer_blk ( .clk(clk), .rst_n(n3), 
        .deser_en(deser_en_top), .par_en(par_en), .sampled_bit(sampled_bit_top), .bit_cnt(bit_cnt_top), .edge_cnt(edge_cnt_top), .data_valid(data_valid_top), 
        .calc_par_bit(calc_par_bit_top), .p_data({SYNOPSYS_UNCONNECTED__0, 
        p_data_top[9:0]}) );
  INVX1_RVT U1 ( .A(1'b1), .Y(p_data[10]) );
  NBUFFX2_RVT U3 ( .A(rst_n), .Y(n3) );
endmodule


module uart ( clk, rst_n, p_data, data_valid, par_en, par_typ, tx_out, busy, 
        rx_in, rx_p_data, rx_data_valid );
  input [7:0] p_data;
  output [10:0] rx_p_data;
  input clk, rst_n, data_valid, par_en, par_typ, rx_in;
  output tx_out, busy, rx_data_valid;
  wire   n7, N3, N4, n1, n2, n6;
  wire   [2:0] baud_cnt;

  DFFARX1_RVT baud_cnt_reg_0_ ( .D(n1), .CLK(clk), .RSTB(n6), .Q(baud_cnt[0]), 
        .QN(n1) );
  DFFARX1_RVT baud_cnt_reg_1_ ( .D(N3), .CLK(clk), .RSTB(n6), .Q(baud_cnt[1])
         );
  NAND2X0_RVT U5 ( .A1(baud_cnt[1]), .A2(baud_cnt[0]), .Y(n2) );
  uart_tx uart_tx_inst ( .clk(baud_cnt[2]), .rst_n(n6), .p_data(p_data), 
        .data_valid(data_valid), .par_en(par_en), .par_typ(par_typ), .tx_out(
        tx_out), .busy(busy) );
  uart_rx uart_rx_inst ( .clk(clk), .rst_n(n6), .rx_in(rx_in), .par_en(par_en), 
        .par_typ(par_typ), .p_data({n7, rx_p_data[9:0]}), .data_valid(
        rx_data_valid) );
  DFFARX2_RVT baud_cnt_reg_2_ ( .D(N4), .CLK(clk), .RSTB(n6), .Q(baud_cnt[2])
         );
  INVX1_RVT U6 ( .A(1'b1), .Y(rx_p_data[10]) );
  NBUFFX2_RVT U8 ( .A(rst_n), .Y(n6) );
  XNOR2X1_RVT U9 ( .A1(n2), .A2(baud_cnt[2]), .Y(N4) );
  XOR2X1_RVT U10 ( .A1(baud_cnt[1]), .A2(baud_cnt[0]), .Y(N3) );
endmodule

