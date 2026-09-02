// IC Compiler II Verilog Writer
// Generated on 08/31/2026 at 21:08:10
// Library Name: uart.ndm
// Block Name: temp_clock_ends
// User Label: 
// Write Command: write_verilog -include { pg_netlist } /home/ICer/Mo_AZ/UART_Project/pnr/step_6_routing/outputs/uart_pt.v
module uart_rx_deserializer ( clk , rst_n , deser_en , par_en , sampled_bit , 
    bit_cnt , edge_cnt , placeHFSNET_4 , calc_par_bit , p_data , 
    placeHFSNET_7 , VDD , VSS , placeHFSNET_0 , placeHFSNET_2 ) ;
input  clk ;
input  rst_n ;
input  deser_en ;
input  par_en ;
input  sampled_bit ;
input  [3:0] bit_cnt ;
input  [2:0] edge_cnt ;
input  placeHFSNET_4 ;
input  calc_par_bit ;
output [10:1] p_data ;
input  placeHFSNET_7 ;
input  VDD ;
input  VSS ;
input  placeHFSNET_0 ;
input  placeHFSNET_2 ;

wire [7:0] p_data_temp ;

DFFARX1_RVT \p_data_temp_reg[7] ( .D ( n38 ) , .CLK ( clk ) , 
    .RSTB ( rst_n ) , .Q ( p_data_temp[7] ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
DFFARX1_RVT \p_data_temp_reg[6] ( .D ( n37 ) , .CLK ( clk ) , 
    .RSTB ( rst_n ) , .Q ( p_data_temp[6] ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
DFFARX1_RVT \p_data_temp_reg[5] ( .D ( n36 ) , .CLK ( clk ) , 
    .RSTB ( rst_n ) , .Q ( p_data_temp[5] ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
DFFARX1_RVT \p_data_temp_reg[4] ( .D ( n35 ) , .CLK ( clk ) , 
    .RSTB ( rst_n ) , .Q ( p_data_temp[4] ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
DFFARX1_RVT \p_data_temp_reg[3] ( .D ( n34 ) , .CLK ( clk ) , 
    .RSTB ( rst_n ) , .Q ( p_data_temp[3] ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
DFFARX1_RVT \p_data_temp_reg[2] ( .D ( n33 ) , .CLK ( clk ) , 
    .RSTB ( rst_n ) , .Q ( p_data_temp[2] ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
DFFARX1_RVT \p_data_temp_reg[1] ( .D ( n32 ) , .CLK ( clk ) , 
    .RSTB ( placeHFSNET_4 ) , .Q ( p_data_temp[1] ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
DFFARX1_RVT \p_data_temp_reg[0] ( .D ( n31 ) , .CLK ( clk ) , 
    .RSTB ( placeHFSNET_4 ) , .Q ( p_data_temp[0] ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
AND2X1_RVT U16 ( .A1 ( p_data_temp[7] ) , .A2 ( placeHFSNET_2 ) , 
    .Y ( p_data[9] ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AND2X1_RVT U17 ( .A1 ( p_data_temp[6] ) , .A2 ( placeHFSNET_2 ) , 
    .Y ( p_data[8] ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AND2X1_RVT U18 ( .A1 ( p_data_temp[5] ) , .A2 ( placeHFSNET_2 ) , 
    .Y ( p_data[7] ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AND2X1_RVT U19 ( .A1 ( p_data_temp[4] ) , .A2 ( placeHFSNET_2 ) , 
    .Y ( p_data[6] ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AND2X1_RVT U20 ( .A1 ( p_data_temp[3] ) , .A2 ( placeHFSNET_2 ) , 
    .Y ( p_data[5] ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AND2X1_RVT U21 ( .A1 ( p_data_temp[2] ) , .A2 ( placeHFSNET_2 ) , 
    .Y ( p_data[4] ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AND2X1_RVT U22 ( .A1 ( p_data_temp[1] ) , .A2 ( placeHFSNET_2 ) , 
    .Y ( p_data[3] ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AND2X1_RVT U23 ( .A1 ( p_data_temp[0] ) , .A2 ( placeHFSNET_2 ) , 
    .Y ( p_data[2] ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
OA21X1_RVT U24 ( .A1 ( calc_par_bit ) , .A2 ( n41 ) , .A3 ( placeHFSNET_2 ) , 
    .Y ( p_data[1] ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AO22X1_RVT U25 ( .A1 ( clockZBUF_0 ) , .A2 ( n13 ) , .A3 ( copt_net_12 ) , 
    .A4 ( n16 ) , .Y ( n33 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND3X0_RVT U26 ( .A1 ( placeHFSNET_0 ) , .A2 ( placeHFSNET_5 ) , 
    .A3 ( n17 ) , .Y ( n16 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AO22X1_RVT U27 ( .A1 ( n12 ) , .A2 ( clockZBUF_0 ) , .A3 ( copt_net_15 ) , 
    .A4 ( n18 ) , .Y ( n34 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND3X0_RVT U28 ( .A1 ( n17 ) , .A2 ( placeHFSNET_5 ) , .A3 ( bit_cnt[0] ) , 
    .Y ( n18 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AO22X1_RVT U29 ( .A1 ( n11 ) , .A2 ( clockZBUF_0 ) , .A3 ( copt_net_17 ) , 
    .A4 ( n19 ) , .Y ( n35 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND3X0_RVT U30 ( .A1 ( n17 ) , .A2 ( placeHFSNET_0 ) , .A3 ( bit_cnt[1] ) , 
    .Y ( n19 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AO22X1_RVT U31 ( .A1 ( n10 ) , .A2 ( clockZBUF_0 ) , .A3 ( copt_net_16 ) , 
    .A4 ( n20 ) , .Y ( n36 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND3X0_RVT U32 ( .A1 ( bit_cnt[0] ) , .A2 ( n17 ) , .A3 ( bit_cnt[1] ) , 
    .Y ( n20 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AND2X1_RVT U33 ( .A1 ( bit_cnt[2] ) , .A2 ( n21 ) , .Y ( n17 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
AO22X1_RVT U34 ( .A1 ( n9 ) , .A2 ( clockZBUF_0 ) , .A3 ( copt_net_13 ) , 
    .A4 ( n22 ) , .Y ( n37 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND2X0_RVT U35 ( .A1 ( n23 ) , .A2 ( placeHFSNET_0 ) , .Y ( n22 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
AO22X1_RVT U36 ( .A1 ( n8 ) , .A2 ( clockZBUF_0 ) , .A3 ( copt_net_10 ) , 
    .A4 ( n24 ) , .Y ( n38 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND2X0_RVT U37 ( .A1 ( n23 ) , .A2 ( bit_cnt[0] ) , .Y ( n24 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
AND3X1_RVT U38 ( .A1 ( placeHFSNET_5 ) , .A2 ( placeHFSNET_7 ) , .A3 ( n21 ) , 
    .Y ( n23 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AO22X1_RVT U39 ( .A1 ( n7 ) , .A2 ( clockZBUF_0 ) , .A3 ( copt_net_14 ) , 
    .A4 ( n25 ) , .Y ( n31 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND2X0_RVT U40 ( .A1 ( n26 ) , .A2 ( placeHFSNET_0 ) , .Y ( n25 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
AO22X1_RVT U41 ( .A1 ( n6 ) , .A2 ( clockZBUF_0 ) , .A3 ( copt_net_11 ) , 
    .A4 ( n27 ) , .Y ( n32 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND2X0_RVT U42 ( .A1 ( n26 ) , .A2 ( bit_cnt[0] ) , .Y ( n27 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
AND3X1_RVT U43 ( .A1 ( n21 ) , .A2 ( placeHFSNET_7 ) , .A3 ( bit_cnt[1] ) , 
    .Y ( n26 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AND4X1_RVT U44 ( .A1 ( deser_en ) , .A2 ( n28 ) , .A3 ( edge_cnt[2] ) , 
    .A4 ( n29 ) , .Y ( n21 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
NOR3X0_RVT U45 ( .A1 ( n30 ) , .A2 ( edge_cnt[1] ) , .A3 ( clockZBUF_1 ) , 
    .Y ( n29 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AND3X1_RVT U46 ( .A1 ( placeHFSNET_7 ) , .A2 ( bit_cnt[3] ) , 
    .A3 ( placeHFSNET_5 ) , .Y ( n30 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AO21X1_RVT U47 ( .A1 ( placeHFSNET_5 ) , .A2 ( placeHFSNET_7 ) , 
    .A3 ( bit_cnt[3] ) , .Y ( n28 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT placeHFSINV_130_6 ( .A ( bit_cnt[1] ) , .Y ( placeHFSNET_5 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NBUFFX2_RVT clockZBUF_inst_286 ( .A ( sampled_bit ) , .Y ( clockZBUF_0 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
DELLN1X2_RVT clockcopt_h_inst_307 ( .A ( p_data_temp[7] ) , 
    .Y ( copt_net_10 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT U7 ( .A ( par_en ) , .Y ( n41 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT U8 ( .A ( n20 ) , .Y ( n10 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
NBUFFX2_RVT clockZBUF_inst_296 ( .A ( edge_cnt[0] ) , .Y ( clockZBUF_1 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
DELLN1X2_RVT clockcopt_h_inst_308 ( .A ( p_data_temp[1] ) , 
    .Y ( copt_net_11 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
DELLN1X2_RVT clockcopt_h_inst_309 ( .A ( p_data_temp[2] ) , 
    .Y ( copt_net_12 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT U12 ( .A ( n16 ) , .Y ( n13 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
DELLN1X2_RVT clockcopt_h_inst_310 ( .A ( p_data_temp[6] ) , 
    .Y ( copt_net_13 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT U14 ( .A ( n25 ) , .Y ( n7 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT U15 ( .A ( n27 ) , .Y ( n6 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT U48 ( .A ( n18 ) , .Y ( n12 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT U49 ( .A ( n19 ) , .Y ( n11 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT U50 ( .A ( n22 ) , .Y ( n9 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT U51 ( .A ( n24 ) , .Y ( n8 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
DELLN1X2_RVT clockcopt_h_inst_311 ( .A ( p_data_temp[0] ) , 
    .Y ( copt_net_14 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
DELLN1X2_RVT clockcopt_h_inst_312 ( .A ( p_data_temp[3] ) , 
    .Y ( copt_net_15 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
DELLN1X2_RVT clockcopt_h_inst_313 ( .A ( p_data_temp[5] ) , 
    .Y ( copt_net_16 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
DELLN1X2_RVT clockcopt_h_inst_314 ( .A ( p_data_temp[4] ) , 
    .Y ( copt_net_17 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
endmodule


module uart_rx_stop_check ( clk , rst_n , stp_chk_en , stp_err , VDD , VSS , 
    placeHFSNET_7 ) ;
input  clk ;
input  rst_n ;
input  stp_chk_en ;
output stp_err ;
input  VDD ;
input  VSS ;
input  placeHFSNET_7 ;

DFFARX1_RVT stp_err_reg ( .D ( n2 ) , .CLK ( clk ) , .RSTB ( rst_n ) , 
    .Q ( stp_err ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AO21X1_RVT U3 ( .A1 ( stp_chk_en ) , .A2 ( placeHFSNET_6 ) , 
    .A3 ( copt_net_2 ) , .Y ( n2 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT placeHFSINV_28_8 ( .A ( clockZBUF_0 ) , .Y ( placeHFSNET_6 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NBUFFX2_RVT clockZBUF_inst_287 ( .A ( placeHFSNET_7 ) , .Y ( clockZBUF_0 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
DELLN1X2_RVT clockcopt_h_inst_299 ( .A ( stp_err ) , .Y ( copt_net_2 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
endmodule


module uart_rx_start_check ( clk , rst_n , sampled_bit , str_chk_en , 
    str_glitch , VDD , VSS ) ;
input  clk ;
input  rst_n ;
input  sampled_bit ;
input  str_chk_en ;
output str_glitch ;
input  VDD ;
input  VSS ;

DFFARX1_RVT str_glitch_reg ( .D ( copt_net_22 ) , .CLK ( clk ) , 
    .RSTB ( rst_n ) , .Q ( str_glitch ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AND2X1_RVT U3 ( .A1 ( str_chk_en ) , .A2 ( sampled_bit ) , .Y ( N1 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NBUFFX2_RVT clockcopt_h_inst_319 ( .A ( N1 ) , .Y ( copt_net_22 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
endmodule


module uart_rx_parity_check ( clk , rst_n , par_typ , par_chk_en , 
    sampled_bit , calc_par_bit_en , data_valid_par_chk , edge_cnt , par_err , 
    calc_par_bit , VDD , VSS , placeHFSNET_2 , placeHFSNET_3 , clockZBUF_0 ) ;
input  clk ;
input  rst_n ;
input  par_typ ;
input  par_chk_en ;
input  sampled_bit ;
input  calc_par_bit_en ;
input  data_valid_par_chk ;
input  [2:0] edge_cnt ;
output par_err ;
output calc_par_bit ;
input  VDD ;
input  VSS ;
input  placeHFSNET_2 ;
input  placeHFSNET_3 ;
input  clockZBUF_0 ;

DFFARX1_RVT calc_par_bit_reg ( .D ( n10 ) , .CLK ( clk ) , .RSTB ( rst_n ) , 
    .Q ( calc_par_bit ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AND4X1_RVT U8 ( .A1 ( edge_cnt[0] ) , .A2 ( n5 ) , .A3 ( edge_cnt[1] ) , 
    .A4 ( n6 ) , .Y ( par_err ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AND2X1_RVT U9 ( .A1 ( par_chk_en ) , .A2 ( edge_cnt[2] ) , .Y ( n6 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
AO22X1_RVT U10 ( .A1 ( n1 ) , .A2 ( copt_net_24 ) , .A3 ( n7 ) , .A4 ( n8 ) , 
    .Y ( n10 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AO22X1_RVT U11 ( .A1 ( par_typ ) , .A2 ( n4 ) , .A3 ( calc_par_bit_en ) , 
    .A4 ( n5 ) , .Y ( n7 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND2X0_RVT U12 ( .A1 ( calc_par_bit_en ) , .A2 ( n9 ) , .Y ( n8 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND4X0_RVT U13 ( .A1 ( data_valid_par_chk ) , .A2 ( clockZBUF_0 ) , 
    .A3 ( placeHFSNET_2 ) , .A4 ( placeHFSNET_3 ) , .Y ( n9 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
INVX0_RVT U3 ( .A ( calc_par_bit_en ) , .Y ( n4 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
INVX0_RVT U4 ( .A ( n8 ) , .Y ( n1 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
NBUFFX2_RVT clockcopt_h_inst_321 ( .A ( ropt_net_36 ) , .Y ( copt_net_24 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NBUFFX2_RVT clockropt_h_inst_333 ( .A ( calc_par_bit ) , .Y ( ropt_net_36 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
XOR2X1_RVT U7 ( .A1 ( calc_par_bit ) , .A2 ( sampled_bit ) , .Y ( n5 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
endmodule


module uart_rx_data_sampling ( clk , rst_n , rx_in , data_samp_en , edge_cnt , 
    bit_cnt , sampled_bit , VDD , VSS , placeHFSNET_2 , placeHFSNET_3 , 
    clockZBUF_0 ) ;
input  clk ;
input  rst_n ;
input  rx_in ;
input  data_samp_en ;
input  [2:0] edge_cnt ;
input  [3:0] bit_cnt ;
output sampled_bit ;
input  VDD ;
input  VSS ;
input  placeHFSNET_2 ;
input  placeHFSNET_3 ;
input  clockZBUF_0 ;

wire [2:0] three_samps_data ;

DFFARX1_RVT \three_samps_data_reg[2] ( .D ( n19 ) , .CLK ( clk ) , 
    .RSTB ( rst_n ) , .Q ( three_samps_data[2] ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
DFFARX1_RVT \three_samps_data_reg[1] ( .D ( n18 ) , .CLK ( clk ) , 
    .RSTB ( rst_n ) , .Q ( three_samps_data[1] ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
DFFARX1_RVT \three_samps_data_reg[0] ( .D ( n17 ) , .CLK ( clk ) , 
    .RSTB ( rst_n ) , .Q ( three_samps_data[0] ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
DFFARX1_RVT sampled_bit_reg ( .D ( ropt_net_38 ) , .CLK ( clk ) , 
    .RSTB ( rst_n ) , .Q ( sampled_bit ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AO22X1_RVT U3 ( .A1 ( copt_net_32 ) , .A2 ( n1 ) , .A3 ( n2 ) , .A4 ( n3 ) , 
    .Y ( n16 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AO22X1_RVT U4 ( .A1 ( three_samps_data[1] ) , .A2 ( three_samps_data[0] ) , 
    .A3 ( copt_net_18 ) , .A4 ( n4 ) , .Y ( n3 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
OR2X1_RVT U5 ( .A1 ( three_samps_data[1] ) , .A2 ( three_samps_data[0] ) , 
    .Y ( n4 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND4X0_RVT U7 ( .A1 ( n5 ) , .A2 ( placeHFSNET_2 ) , .A3 ( placeHFSNET_3 ) , 
    .A4 ( placeHFSNET_5 ) , .Y ( n1 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AO22X1_RVT U9 ( .A1 ( copt_net_21 ) , .A2 ( n9 ) , .A3 ( rx_in ) , 
    .A4 ( n8 ) , .Y ( n17 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND4X0_RVT U11 ( .A1 ( edge_cnt[1] ) , .A2 ( edge_cnt[0] ) , 
    .A3 ( data_samp_en ) , .A4 ( placeHFSNET_5 ) , .Y ( n9 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
AO22X1_RVT U13 ( .A1 ( copt_net_20 ) , .A2 ( n11 ) , .A3 ( n6 ) , 
    .A4 ( rx_in ) , .Y ( n18 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND2X0_RVT U15 ( .A1 ( n13 ) , .A2 ( placeHFSNET_2 ) , .Y ( n11 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
AO22X1_RVT U17 ( .A1 ( copt_net_18 ) , .A2 ( n14 ) , .A3 ( n10 ) , 
    .A4 ( rx_in ) , .Y ( n19 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND2X0_RVT U19 ( .A1 ( n13 ) , .A2 ( edge_cnt[0] ) , .Y ( n14 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
AND3X1_RVT U20 ( .A1 ( data_samp_en ) , .A2 ( placeHFSNET_3 ) , 
    .A3 ( clockZBUF_0 ) , .Y ( n13 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT U6 ( .A ( n14 ) , .Y ( n10 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT U8 ( .A ( n9 ) , .Y ( n8 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT U10 ( .A ( n11 ) , .Y ( n6 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT placeHFSINV_816_5 ( .A ( edge_cnt[2] ) , .Y ( placeHFSNET_5 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT U16 ( .A ( n1 ) , .Y ( n2 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
DELLN1X2_RVT clockcopt_h_inst_315 ( .A ( three_samps_data[2] ) , 
    .Y ( copt_net_18 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
OR4X1_RVT U21 ( .A1 ( bit_cnt[1] ) , .A2 ( bit_cnt[0] ) , .A3 ( bit_cnt[3] ) , 
    .A4 ( bit_cnt[2] ) , .Y ( n5 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
DELLN1X2_RVT clockcopt_h_inst_317 ( .A ( three_samps_data[1] ) , 
    .Y ( copt_net_20 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
DELLN1X2_RVT clockcopt_h_inst_318 ( .A ( three_samps_data[0] ) , 
    .Y ( copt_net_21 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
NBUFFX2_RVT clockcopt_h_inst_329 ( .A ( sampled_bit ) , .Y ( copt_net_32 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NBUFFX2_RVT clockropt_h_inst_335 ( .A ( n16 ) , .Y ( ropt_net_38 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
endmodule


module uart_rx_counters ( clk , rst_n , enable , data_valid_cnt_en , 
    cnt_zero , bit_cnt , edge_cnt , data_valid_cnt , VDD , VSS , placeZBUF_3 , 
    placeZBUF_0 ) ;
input  clk ;
input  rst_n ;
input  enable ;
input  data_valid_cnt_en ;
input  cnt_zero ;
output [3:0] bit_cnt ;
output [2:0] edge_cnt ;
output [2:0] data_valid_cnt ;
input  VDD ;
input  VSS ;
input  placeZBUF_3 ;
input  placeZBUF_0 ;

DFFARX1_RVT \edge_cnt_reg[0] ( .D ( copt_net_5 ) , .CLK ( clk ) , 
    .RSTB ( rst_n ) , .Q ( edge_cnt[0] ) , .QN ( n37 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
DFFARX1_RVT \edge_cnt_reg[1] ( .D ( copt_net_4 ) , .CLK ( clk ) , 
    .RSTB ( rst_n ) , .Q ( edge_cnt[1] ) , .QN ( n36 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
DFFARX1_RVT \edge_cnt_reg[2] ( .D ( copt_net_28 ) , .CLK ( clk ) , 
    .RSTB ( rst_n ) , .Q ( edge_cnt[2] ) , .QN ( n27 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
DFFARX1_RVT \bit_cnt_reg[0] ( .D ( n43 ) , .CLK ( clk ) , .RSTB ( rst_n ) , 
    .Q ( bit_cnt[0] ) , .QN ( n39 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
DFFARX1_RVT \bit_cnt_reg[1] ( .D ( copt_net_3 ) , .CLK ( clk ) , 
    .RSTB ( rst_n ) , .Q ( bit_cnt[1] ) , .QN ( n28 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
DFFARX1_RVT \bit_cnt_reg[2] ( .D ( n41 ) , .CLK ( clk ) , .RSTB ( rst_n ) , 
    .Q ( bit_cnt[2] ) , .QN ( n38 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
DFFARX1_RVT \bit_cnt_reg[3] ( .D ( n40 ) , .CLK ( clk ) , .RSTB ( rst_n ) , 
    .Q ( bit_cnt[3] ) , .QN ( n29 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
DFFARX1_RVT \data_valid_cnt_reg[0] ( .D ( copt_net_23 ) , .CLK ( clk ) , 
    .RSTB ( rst_n ) , .Q ( data_valid_cnt[0] ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
DFFARX1_RVT \data_valid_cnt_reg[1] ( .D ( copt_net_7 ) , .CLK ( clk ) , 
    .RSTB ( rst_n ) , .Q ( data_valid_cnt[1] ) , .QN ( n31 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
DFFARX1_RVT \data_valid_cnt_reg[2] ( .D ( copt_net_6 ) , .CLK ( clk ) , 
    .RSTB ( rst_n ) , .Q ( data_valid_cnt[2] ) , .QN ( n30 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
OR2X1_RVT U4 ( .A1 ( n2 ) , .A2 ( n31 ) , .Y ( n1 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
NAND2X0_RVT U6 ( .A1 ( data_valid_cnt_en ) , .A2 ( data_valid_cnt[0] ) , 
    .Y ( n2 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AO22X1_RVT U13 ( .A1 ( n10 ) , .A2 ( copt_net_34 ) , .A3 ( copt_net_9 ) , 
    .A4 ( n7 ) , .Y ( n41 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AND3X1_RVT U14 ( .A1 ( bit_cnt[0] ) , .A2 ( placeZBUF_3 ) , .A3 ( n6 ) , 
    .Y ( n7 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AO21X1_RVT U16 ( .A1 ( copt_net_31 ) , .A2 ( n6 ) , .A3 ( n13 ) , .Y ( n10 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
AO22X1_RVT U17 ( .A1 ( n13 ) , .A2 ( placeZBUF_3 ) , .A3 ( n14 ) , 
    .A4 ( n28 ) , .Y ( n42 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AND2X1_RVT U18 ( .A1 ( n6 ) , .A2 ( bit_cnt[0] ) , .Y ( n14 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
AO22X1_RVT U20 ( .A1 ( n15 ) , .A2 ( n8 ) , .A3 ( ropt_net_39 ) , .A4 ( n6 ) , 
    .Y ( n13 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AO22X1_RVT U21 ( .A1 ( copt_net_27 ) , .A2 ( n6 ) , .A3 ( n17 ) , 
    .A4 ( n15 ) , .Y ( n43 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AND2X1_RVT U22 ( .A1 ( n8 ) , .A2 ( bit_cnt[0] ) , .Y ( n17 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
NAND4X0_RVT U25 ( .A1 ( enable ) , .A2 ( edge_cnt[0] ) , .A3 ( edge_cnt[1] ) , 
    .A4 ( edge_cnt[2] ) , .Y ( n15 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AO21X1_RVT U26 ( .A1 ( n21 ) , .A2 ( edge_cnt[2] ) , .A3 ( n22 ) , 
    .Y ( n44 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AND4X1_RVT U27 ( .A1 ( n27 ) , .A2 ( enable ) , .A3 ( edge_cnt[0] ) , 
    .A4 ( placeZBUF_0 ) , .Y ( n22 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AO21X1_RVT U29 ( .A1 ( n36 ) , .A2 ( enable ) , .A3 ( n23 ) , .Y ( n21 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
AO22X1_RVT U30 ( .A1 ( n23 ) , .A2 ( edge_cnt[1] ) , .A3 ( n24 ) , 
    .A4 ( n36 ) , .Y ( n45 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AND2X1_RVT U31 ( .A1 ( enable ) , .A2 ( clockZBUF_1 ) , .Y ( n24 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
AO22X1_RVT U33 ( .A1 ( n37 ) , .A2 ( enable ) , .A3 ( n8 ) , 
    .A4 ( placeHFSNET_0 ) , .Y ( n23 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AO22X1_RVT U34 ( .A1 ( n37 ) , .A2 ( enable ) , .A3 ( n26 ) , .A4 ( n8 ) , 
    .Y ( n46 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AND2X1_RVT U36 ( .A1 ( placeHFSNET_0 ) , .A2 ( clockZBUF_1 ) , .Y ( n26 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT U3 ( .A ( n15 ) , .Y ( n6 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
DELLN1X2_RVT clockcopt_h_inst_300 ( .A ( n42 ) , .Y ( copt_net_3 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT placeHFSINV_66_1 ( .A ( enable ) , .Y ( placeHFSNET_0 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
XOR2X1_RVT U8 ( .A1 ( data_valid_cnt_en ) , .A2 ( data_valid_cnt[0] ) , 
    .Y ( n35 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT U9 ( .A ( cnt_zero ) , .Y ( n8 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
XOR2X1_RVT U10 ( .A1 ( n2 ) , .A2 ( n31 ) , .Y ( n34 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
OAI22X1_RVT U11 ( .A1 ( n3 ) , .A2 ( copt_net_8 ) , .A3 ( n4 ) , 
    .A4 ( copt_net_30 ) , .Y ( n40 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AOI21X1_RVT U12 ( .A1 ( ropt_net_37 ) , .A2 ( n6 ) , .A3 ( n10 ) , .Y ( n3 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND2X0_RVT U15 ( .A1 ( n7 ) , .A2 ( bit_cnt[2] ) , .Y ( n4 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
XOR2X1_RVT U19 ( .A1 ( n1 ) , .A2 ( n30 ) , .Y ( n33 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
NBUFFX2_RVT clockZBUF_inst_289 ( .A ( edge_cnt[0] ) , .Y ( clockZBUF_1 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
DELLN1X2_RVT clockcopt_h_inst_301 ( .A ( n45 ) , .Y ( copt_net_4 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
DELLN1X2_RVT clockcopt_h_inst_302 ( .A ( n46 ) , .Y ( copt_net_5 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
DELLN1X2_RVT clockcopt_h_inst_303 ( .A ( n33 ) , .Y ( copt_net_6 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
DELLN1X2_RVT clockcopt_h_inst_304 ( .A ( n34 ) , .Y ( copt_net_7 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
DELLN1X2_RVT clockcopt_h_inst_305 ( .A ( n29 ) , .Y ( copt_net_8 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
DELLN1X2_RVT clockcopt_h_inst_306 ( .A ( n38 ) , .Y ( copt_net_9 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NBUFFX2_RVT clockcopt_h_inst_320 ( .A ( n35 ) , .Y ( copt_net_23 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
DELLN1X2_RVT clockcopt_h_inst_324 ( .A ( ropt_net_39 ) , .Y ( copt_net_27 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
DELLN1X2_RVT clockcopt_h_inst_325 ( .A ( n44 ) , .Y ( copt_net_28 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NBUFFX2_RVT clockcopt_h_inst_327 ( .A ( bit_cnt[3] ) , .Y ( copt_net_30 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NBUFFX2_RVT clockcopt_h_inst_328 ( .A ( ropt_net_41 ) , .Y ( copt_net_31 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NBUFFX2_RVT clockcopt_h_inst_331 ( .A ( bit_cnt[2] ) , .Y ( copt_net_34 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NBUFFX2_RVT clockropt_h_inst_334 ( .A ( n38 ) , .Y ( ropt_net_37 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NBUFFX2_RVT clockropt_h_inst_336 ( .A ( n39 ) , .Y ( ropt_net_39 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NBUFFX2_RVT clockropt_h_inst_338 ( .A ( n28 ) , .Y ( ropt_net_41 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
endmodule


module uart_rx_controller ( clk , rst_n , rx_in , bit_cnt , edge_cnt , 
    str_glitch , stp_err , par_err , par_en , placeHFSNET_2 , placeHFSNET_5 , 
    cnt_zero , par_chk_en , stp_chk_en , str_chk_en , deser_en , placeZBUF_2 , 
    data_valid_cnt , calc_par_bit_en , data_valid_par_chk , VDD , VSS , 
    placeHFSNET_0 , placeHFSNET_1 ) ;
input  clk ;
input  rst_n ;
input  rx_in ;
input  [3:0] bit_cnt ;
input  [2:0] edge_cnt ;
input  str_glitch ;
input  stp_err ;
input  par_err ;
input  par_en ;
output placeHFSNET_2 ;
input  placeHFSNET_5 ;
output cnt_zero ;
output par_chk_en ;
output stp_chk_en ;
output str_chk_en ;
output deser_en ;
input  placeZBUF_2 ;
input  [2:0] data_valid_cnt ;
output calc_par_bit_en ;
output data_valid_par_chk ;
input  VDD ;
input  VSS ;
input  placeHFSNET_0 ;
output placeHFSNET_1 ;

wire [2:0] state ;

DFFSSRX1_RVT \state_reg[0] ( .D ( rst_n ) , .SETB ( VDD ) , .RSTB ( n36 ) , 
    .CLK ( clk ) , .Q ( state[0] ) , .QN ( n12 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
DFFSSRX1_RVT \state_reg[2] ( .D ( n25 ) , .SETB ( n2 ) , .RSTB ( rst_n ) , 
    .CLK ( clk ) , .Q ( state[2] ) , .QN ( n10 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
DFFSSRX1_RVT \state_reg[1] ( .D ( n30 ) , .SETB ( n1 ) , .RSTB ( rst_n ) , 
    .CLK ( clk ) , .Q ( state[1] ) , .QN ( n11 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
NOR4X1_RVT U7 ( .A1 ( n43 ) , .A2 ( n44 ) , .A3 ( stp_err ) , .A4 ( n45 ) , 
    .Y ( n42 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND3X2_RVT U24 ( .A1 ( n21 ) , .A2 ( n22 ) , .A3 ( n23 ) , 
    .Y ( placeHFSNET_1 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND2X0_RVT U25 ( .A1 ( state[0] ) , .A2 ( n10 ) , .Y ( n23 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
AO21X1_RVT U26 ( .A1 ( n20 ) , .A2 ( ropt_net_35 ) , .A3 ( placeHFSNET_2 ) , 
    .Y ( cnt_zero ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND2X0_RVT U27 ( .A1 ( n21 ) , .A2 ( n24 ) , .Y ( calc_par_bit_en ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
AO22X1_RVT U28 ( .A1 ( data_valid_par_chk ) , .A2 ( n28 ) , 
    .A3 ( par_chk_en ) , .A4 ( n7 ) , .Y ( n25 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
AND3X1_RVT U30 ( .A1 ( placeHFSNET_0 ) , .A2 ( n50 ) , .A3 ( n35 ) , 
    .Y ( n28 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND3X0_RVT U31 ( .A1 ( n13 ) , .A2 ( n15 ) , .A3 ( str_chk_en ) , 
    .Y ( n33 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
OR3X1_RVT U32 ( .A1 ( copt_net_33 ) , .A2 ( placeZBUF_2 ) , 
    .A3 ( bit_cnt[0] ) , .Y ( n32 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND4X0_RVT U33 ( .A1 ( n8 ) , .A2 ( n27 ) , .A3 ( n37 ) , .A4 ( n38 ) , 
    .Y ( n36 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
OR3X1_RVT U34 ( .A1 ( state[0] ) , .A2 ( rx_in ) , .A3 ( n39 ) , .Y ( n38 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND2X0_RVT U35 ( .A1 ( str_chk_en ) , .A2 ( n40 ) , .Y ( n37 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND4X0_RVT U36 ( .A1 ( n13 ) , .A2 ( n15 ) , .A3 ( placeHFSNET_0 ) , 
    .A4 ( placeHFSNET_5 ) , .Y ( n40 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AND2X1_RVT U37 ( .A1 ( state[0] ) , .A2 ( n20 ) , .Y ( str_chk_en ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND2X0_RVT U38 ( .A1 ( n11 ) , .A2 ( n10 ) , .Y ( n39 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
AOI21X1_RVT U39 ( .A1 ( placeHFSNET_2 ) , .A2 ( n41 ) , .A3 ( n42 ) , 
    .Y ( n27 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
OA22X1_RVT U40 ( .A1 ( bit_cnt[2] ) , .A2 ( n46 ) , .A3 ( n47 ) , 
    .A4 ( placeHFSNET_0 ) , .Y ( n45 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
OR2X1_RVT U41 ( .A1 ( bit_cnt[0] ) , .A2 ( bit_cnt[1] ) , .Y ( n46 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND2X0_RVT U42 ( .A1 ( bit_cnt[3] ) , .A2 ( stp_chk_en ) , .Y ( n43 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND2X0_RVT U43 ( .A1 ( n31 ) , .A2 ( ropt_net_35 ) , .Y ( n22 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND3X0_RVT U44 ( .A1 ( data_valid_cnt[1] ) , .A2 ( data_valid_cnt[0] ) , 
    .A3 ( data_valid_cnt[2] ) , .Y ( n41 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND2X0_RVT U46 ( .A1 ( state[2] ) , .A2 ( n11 ) , .Y ( n24 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
NAND2X0_RVT U47 ( .A1 ( n48 ) , .A2 ( n49 ) , .Y ( n30 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
NAND4X0_RVT U48 ( .A1 ( par_en ) , .A2 ( data_valid_par_chk ) , .A3 ( n35 ) , 
    .A4 ( placeHFSNET_0 ) , .Y ( n49 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND2X0_RVT U49 ( .A1 ( n26 ) , .A2 ( ropt_net_35 ) , .Y ( n34 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND3X0_RVT U50 ( .A1 ( n29 ) , .A2 ( n9 ) , .A3 ( par_chk_en ) , .Y ( n48 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
AND2X1_RVT U51 ( .A1 ( n26 ) , .A2 ( state[0] ) , .Y ( par_chk_en ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND2X0_RVT U52 ( .A1 ( state[1] ) , .A2 ( n10 ) , .Y ( n21 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
NAND4X0_RVT U53 ( .A1 ( n35 ) , .A2 ( n13 ) , .A3 ( bit_cnt[0] ) , 
    .A4 ( n9 ) , .Y ( n29 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
OR3X1_RVT U54 ( .A1 ( edge_cnt[2] ) , .A2 ( edge_cnt[1] ) , 
    .A3 ( edge_cnt[0] ) , .Y ( n44 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AND2X1_RVT U55 ( .A1 ( bit_cnt[3] ) , .A2 ( n15 ) , .Y ( n35 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND2X0_RVT U56 ( .A1 ( bit_cnt[1] ) , .A2 ( bit_cnt[2] ) , .Y ( n47 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
DELLN1X2_RVT clockcopt_h_inst_298 ( .A ( stp_err ) , .Y ( copt_net_1 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
AND2X4_RVT U4 ( .A1 ( n31 ) , .A2 ( state[0] ) , .Y ( placeHFSNET_2 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT U6 ( .A ( n24 ) , .Y ( n31 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT U8 ( .A ( n29 ) , .Y ( n7 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT U9 ( .A ( n34 ) , .Y ( data_valid_par_chk ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
INVX0_RVT U10 ( .A ( n21 ) , .Y ( n26 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT U11 ( .A ( n47 ) , .Y ( n15 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT U12 ( .A ( n39 ) , .Y ( n20 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT U13 ( .A ( n44 ) , .Y ( n13 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT U14 ( .A ( n30 ) , .Y ( n8 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT U15 ( .A ( par_en ) , .Y ( n50 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
OA22X1_RVT U16 ( .A1 ( ropt_net_40 ) , .A2 ( n33 ) , .A3 ( n28 ) , 
    .A4 ( copt_net_25 ) , .Y ( n1 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT U18 ( .A ( n22 ) , .Y ( stp_chk_en ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
NBUFFX2_RVT clockcopt_h_inst_322 ( .A ( n34 ) , .Y ( copt_net_25 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NBUFFX2_RVT clockcopt_h_inst_330 ( .A ( str_glitch ) , .Y ( copt_net_33 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT U21 ( .A ( par_err ) , .Y ( n9 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
OA21X1_RVT U22 ( .A1 ( n22 ) , .A2 ( copt_net_1 ) , .A3 ( n27 ) , .Y ( n2 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NBUFFX2_RVT clockropt_h_inst_332 ( .A ( n12 ) , .Y ( ropt_net_35 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NBUFFX2_RVT clockropt_h_inst_337 ( .A ( n32 ) , .Y ( ropt_net_40 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT U45 ( .A ( n34 ) , .Y ( deser_en ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
endmodule


module uart_rx ( clk , rst_n , rx_in , par_en , par_typ , \p_data[10] , 
    \p_data[9] , \p_data[8] , \p_data[7] , \p_data[6] , \p_data[5] , 
    \p_data[4] , \p_data[3] , \p_data[2] , \p_data[1] , placeZBUF_2 , VDD , 
    VSS , placeHFSNET_2 ) ;
input  clk ;
input  rst_n ;
input  rx_in ;
input  par_en ;
input  par_typ ;
output \p_data[10] ;
output \p_data[9] ;
output \p_data[8] ;
output \p_data[7] ;
output \p_data[6] ;
output \p_data[5] ;
output \p_data[4] ;
output \p_data[3] ;
output \p_data[2] ;
output \p_data[1] ;
input  placeZBUF_2 ;
input  VDD ;
input  VSS ;
output placeHFSNET_2 ;

wire [2:0] edge_cnt_top ;
wire [3:0] bit_cnt_top ;
wire [2:0] data_valid_cnt_top ;

uart_rx_controller uart_rx_controller_blk ( .clk ( clk ) , 
    .rst_n ( placeHFSNET_5 ) , .rx_in ( rx_in ) ,
    .bit_cnt ( { bit_cnt_top[3] , placeHFSNET_8 , placeZBUF_7 , 
        bit_cnt_top[0] } ) ,
    .edge_cnt ( edge_cnt_top ) , .str_glitch ( str_glitch_top ) , 
    .stp_err ( stp_err_top ) , .par_err ( par_err_top ) , .par_en ( par_en ) , 
    .placeHFSNET_2 ( placeHFSNET_2 ) , .placeHFSNET_5 ( placeHFSNET_6 ) , 
    .cnt_zero ( cnt_zero_top ) , .par_chk_en ( par_chk_en_top ) , 
    .stp_chk_en ( stp_chk_en_top ) , .str_chk_en ( str_chk_en_top ) , 
    .deser_en ( deser_en_top ) , .placeZBUF_2 ( bit_cnt_top[3] ) , 
    .data_valid_cnt ( data_valid_cnt_top ) , 
    .calc_par_bit_en ( calc_par_bit_en_top ) , 
    .data_valid_par_chk ( data_valid_par_chk_top ) , .VDD ( VDD ) , 
    .VSS ( VSS ) , .placeHFSNET_0 ( placeHFSNET_0 ) , 
    .placeHFSNET_1 ( placeHFSNET_1 ) ) ;
uart_rx_counters uart_rx_counters_blk ( .clk ( clk ) , 
    .rst_n ( placeHFSNET_5 ) , .enable ( placeHFSNET_1 ) , 
    .data_valid_cnt_en ( placeHFSNET_2 ) , .cnt_zero ( cnt_zero_top ) , 
    .bit_cnt ( bit_cnt_top ) , .edge_cnt ( edge_cnt_top ) , 
    .data_valid_cnt ( data_valid_cnt_top ) , .VDD ( VDD ) , .VSS ( VSS ) , 
    .placeZBUF_3 ( placeZBUF_7 ) , .placeZBUF_0 ( placeZBUF_3 ) ) ;
uart_rx_data_sampling uart_rx_data_sampling_blk ( .clk ( clk ) , 
    .rst_n ( placeZBUF_2 ) , .rx_in ( rx_in ) , 
    .data_samp_en ( placeHFSNET_1 ) ,
    .edge_cnt ( { edge_cnt_top[2] , edge_cnt_top[1] , placeZBUF_1 } ) ,
    .bit_cnt ( { bit_cnt_top[3] , bit_cnt_top[2] , placeZBUF_7 , placeZBUF_0 } ) ,
    .sampled_bit ( placeHFSNET_7 ) , .VDD ( VDD ) , .VSS ( VSS ) , 
    .placeHFSNET_2 ( placeHFSNET_3 ) , .placeHFSNET_3 ( placeHFSNET_4 ) , 
    .clockZBUF_0 ( clockZBUF_1 ) ) ;
uart_rx_parity_check uart_rx_parity_check_blk ( .clk ( clk ) , 
    .rst_n ( placeHFSNET_5 ) , .par_typ ( par_typ ) , 
    .par_chk_en ( par_chk_en_top ) , .sampled_bit ( placeHFSNET_7 ) , 
    .calc_par_bit_en ( calc_par_bit_en_top ) , 
    .data_valid_par_chk ( data_valid_par_chk_top ) , 
    .edge_cnt ( edge_cnt_top ) , .par_err ( par_err_top ) , 
    .calc_par_bit ( calc_par_bit_top ) , .VDD ( VDD ) , .VSS ( VSS ) , 
    .placeHFSNET_2 ( placeHFSNET_3 ) , .placeHFSNET_3 ( placeHFSNET_4 ) , 
    .clockZBUF_0 ( edge_cnt_top[2] ) ) ;
uart_rx_start_check uart_rx_start_check_blk ( .clk ( clk ) , 
    .rst_n ( placeZBUF_2 ) , .sampled_bit ( placeHFSNET_7 ) , 
    .str_chk_en ( str_chk_en_top ) , .str_glitch ( str_glitch_top ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
uart_rx_stop_check uart_rx_stop_check_blk ( .clk ( clk ) , 
    .rst_n ( placeHFSNET_5 ) , .stp_chk_en ( stp_chk_en_top ) , 
    .stp_err ( stp_err_top ) , .VDD ( VDD ) , .VSS ( VSS ) , 
    .placeHFSNET_7 ( placeHFSNET_7 ) ) ;
uart_rx_deserializer uart_rx_deserializer_blk ( .clk ( clk ) , 
    .rst_n ( placeZBUF_2 ) , .deser_en ( deser_en_top ) , .par_en ( par_en ) , 
    .sampled_bit ( placeHFSNET_7 ) ,
    .bit_cnt ( { placeHFSNET_6 , bit_cnt_top[2] , placeZBUF_7 , placeZBUF_0 } ) ,
    .edge_cnt ( { clockZBUF_1 , edge_cnt_top[1] , edge_cnt_top[0] } ) ,
    .placeHFSNET_4 ( placeHFSNET_5 ) , .calc_par_bit ( calc_par_bit_top ) ,
    .p_data ( { SYNOPSYS_UNCONNECTED_1 , \p_data[9] , \p_data[8] , 
        \p_data[7] , \p_data[6] , \p_data[5] , \p_data[4] , \p_data[3] , 
        \p_data[2] , \p_data[1] } ) ,
    .placeHFSNET_7 ( placeHFSNET_8 ) , .VDD ( VDD ) , .VSS ( VSS ) , 
    .placeHFSNET_0 ( placeHFSNET_0 ) , .placeHFSNET_2 ( placeHFSNET_2 ) ) ;
INVX2_RVT placeHFSINV_1162_0 ( .A ( placeZBUF_0 ) , .Y ( placeHFSNET_0 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NBUFFX4_RVT placeHFSBUF_2576_4 ( .A ( rst_n ) , .Y ( placeHFSNET_5 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT placeHFSINV_513_2 ( .A ( placeZBUF_1 ) , .Y ( placeHFSNET_3 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT placeHFSINV_407_3 ( .A ( placeZBUF_3 ) , .Y ( placeHFSNET_4 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT placeHFSINV_341_7 ( .A ( bit_cnt_top[3] ) , .Y ( placeHFSNET_6 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT placeHFSINV_738_9 ( .A ( bit_cnt_top[2] ) , .Y ( placeHFSNET_8 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NBUFFX2_RVT placeZBUF_inst_11 ( .A ( bit_cnt_top[0] ) , .Y ( placeZBUF_0 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NBUFFX2_RVT placeZBUF_inst_16 ( .A ( edge_cnt_top[0] ) , .Y ( placeZBUF_1 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NBUFFX2_RVT placeZBUF_inst_37 ( .A ( edge_cnt_top[1] ) , .Y ( placeZBUF_3 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NBUFFX2_RVT clockZBUF_inst_290 ( .A ( edge_cnt_top[2] ) , .Y ( clockZBUF_1 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NBUFFX2_RVT placeZBUF_inst_32 ( .A ( bit_cnt_top[1] ) , .Y ( placeZBUF_7 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
endmodule


module uart_tx_mux4x1 ( in0 , in1 , in2 , in3 , mux_out , mux_sel , VDD , 
    VSS ) ;
input  in0 ;
input  in1 ;
input  in2 ;
input  in3 ;
output mux_out ;
input  [1:0] mux_sel ;
input  VDD ;
input  VSS ;

AO22X1_RVT U3 ( .A1 ( mux_sel[1] ) , .A2 ( n3 ) , .A3 ( n4 ) , .A4 ( n2 ) , 
    .Y ( mux_out ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AO22X1_RVT U4 ( .A1 ( mux_sel[0] ) , .A2 ( in1 ) , .A3 ( in0 ) , .A4 ( n1 ) , 
    .Y ( n4 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AO22X1_RVT U5 ( .A1 ( in3 ) , .A2 ( mux_sel[0] ) , .A3 ( in2 ) , .A4 ( n1 ) , 
    .Y ( n3 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT U1 ( .A ( mux_sel[0] ) , .Y ( n1 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT U2 ( .A ( mux_sel[1] ) , .Y ( n2 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
endmodule


module uart_tx_serializer ( clk , rst_n , p_data , ser_en , ser_done , 
    ser_data , VDD , VSS , placeZBUF_2 ) ;
input  clk ;
input  rst_n ;
input  [7:0] p_data ;
input  ser_en ;
output ser_done ;
output ser_data ;
input  VDD ;
input  VSS ;
input  placeZBUF_2 ;

DFFARX1_RVT ser_data_reg ( .D ( N12 ) , .CLK ( clk ) , .RSTB ( rst_n ) , 
    .Q ( ser_data ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
DFFARX1_RVT \ser_counter_reg[1] ( .D ( N14 ) , .CLK ( clk ) , 
    .RSTB ( placeZBUF_2 ) , .Q ( N3 ) , .QN ( n2 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
DFFARX1_RVT \ser_counter_reg[2] ( .D ( N15 ) , .CLK ( clk ) , 
    .RSTB ( rst_n ) , .Q ( N4 ) , .QN ( n1 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
DFFARX1_RVT ser_done_reg ( .D ( N17 ) , .CLK ( clk ) , .RSTB ( rst_n ) , 
    .Q ( ser_done ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AND3X1_RVT U5 ( .A1 ( N3 ) , .A2 ( placeZBUF_0 ) , .A3 ( N4 ) , .Y ( N17 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
AO22X1_RVT U6 ( .A1 ( N13 ) , .A2 ( N4 ) , .A3 ( ser_en ) , .A4 ( n4 ) , 
    .Y ( N15 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AO22X1_RVT U7 ( .A1 ( N4 ) , .A2 ( n2 ) , .A3 ( n5 ) , .A4 ( N3 ) , 
    .Y ( n4 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AND2X1_RVT U8 ( .A1 ( placeZBUF_0 ) , .A2 ( n1 ) , .Y ( n5 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
AND2X1_RVT U9 ( .A1 ( ser_en ) , .A2 ( n6 ) , .Y ( N14 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
NOR2X0_RVT U10 ( .A1 ( n13 ) , .A2 ( placeZBUF_0 ) , .Y ( N13 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
OR2X1_RVT U11 ( .A1 ( N8 ) , .A2 ( n13 ) , .Y ( N12 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
DFFARX1_RVT \ser_counter_reg[0] ( .D ( N13 ) , .CLK ( clk ) , 
    .RSTB ( rst_n ) , .Q ( N2 ) , .QN ( n3 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT U3 ( .A ( ser_en ) , .Y ( n13 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
XNOR2X1_RVT U4 ( .A1 ( n2 ) , .A2 ( placeZBUF_0 ) , .Y ( n6 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
AO22X1_RVT U12 ( .A1 ( p_data[7] ) , .A2 ( placeZBUF_0 ) , .A3 ( p_data[6] ) , 
    .A4 ( n3 ) , .Y ( n8 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AO22X1_RVT U13 ( .A1 ( p_data[5] ) , .A2 ( placeZBUF_0 ) , .A3 ( p_data[4] ) , 
    .A4 ( n3 ) , .Y ( n7 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AO22X1_RVT U14 ( .A1 ( N3 ) , .A2 ( n8 ) , .A3 ( n7 ) , .A4 ( n2 ) , 
    .Y ( n12 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AO22X1_RVT U15 ( .A1 ( p_data[3] ) , .A2 ( placeZBUF_0 ) , .A3 ( p_data[2] ) , 
    .A4 ( n3 ) , .Y ( n10 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AO22X1_RVT U16 ( .A1 ( p_data[1] ) , .A2 ( placeZBUF_0 ) , .A3 ( p_data[0] ) , 
    .A4 ( n3 ) , .Y ( n9 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AO22X1_RVT U17 ( .A1 ( n10 ) , .A2 ( N3 ) , .A3 ( n9 ) , .A4 ( n2 ) , 
    .Y ( n11 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AO22X1_RVT U18 ( .A1 ( N4 ) , .A2 ( n12 ) , .A3 ( n11 ) , .A4 ( n1 ) , 
    .Y ( N8 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
NBUFFX2_RVT placeZBUF_inst_17 ( .A ( N2 ) , .Y ( placeZBUF_0 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
endmodule


module uart_tx_parity_bit ( clk , rst_n , p_data , par_typ , par_bit , VDD , 
    VSS ) ;
input  clk ;
input  rst_n ;
input  [7:0] p_data ;
input  par_typ ;
output par_bit ;
input  VDD ;
input  VSS ;

DFFSSRX1_RVT par_bit_reg ( .D ( rst_n ) , .SETB ( VDD ) , .RSTB ( n2 ) , 
    .CLK ( clk ) , .Q ( par_bit ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
XNOR3X1_RVT U4 ( .A1 ( p_data[7] ) , .A2 ( n3 ) , .A3 ( n4 ) , .Y ( n2 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
XNOR3X1_RVT U5 ( .A1 ( p_data[5] ) , .A2 ( par_typ ) , .A3 ( n6 ) , 
    .Y ( n3 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
XNOR3X1_RVT U6 ( .A1 ( p_data[2] ) , .A2 ( p_data[3] ) , .A3 ( n5 ) , 
    .Y ( n4 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
XNOR2X1_RVT U7 ( .A1 ( p_data[6] ) , .A2 ( p_data[4] ) , .Y ( n6 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
XOR2X1_RVT U8 ( .A1 ( p_data[0] ) , .A2 ( p_data[1] ) , .Y ( n5 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
endmodule


module uart_tx_controller ( clk , rst_n , data_valid , par_en , ser_done , 
    mux_sel , busy , ser_en , VDD , VSS ) ;
input  clk ;
input  rst_n ;
input  data_valid ;
input  par_en ;
input  ser_done ;
output [1:0] mux_sel ;
output busy ;
output ser_en ;
input  VDD ;
input  VSS ;

wire [2:0] state ;

NAND2X0_RVT U10 ( .A1 ( mux_sel[0] ) , .A2 ( n8 ) , .Y ( busy ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND3X0_RVT U11 ( .A1 ( rst_n ) , .A2 ( n9 ) , .A3 ( n10 ) , .Y ( n8 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND2X0_RVT U12 ( .A1 ( n11 ) , .A2 ( n1 ) , .Y ( mux_sel[0] ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
OA21X1_RVT U13 ( .A1 ( n5 ) , .A2 ( state[1] ) , .A3 ( n12 ) , .Y ( n10 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND2X0_RVT U14 ( .A1 ( n13 ) , .A2 ( n14 ) , .Y ( N20 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
NAND4X0_RVT U15 ( .A1 ( n5 ) , .A2 ( n4 ) , .A3 ( rst_n ) , .A4 ( n15 ) , 
    .Y ( n14 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AND2X1_RVT U16 ( .A1 ( data_valid ) , .A2 ( state[2] ) , .Y ( n15 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND3X0_RVT U17 ( .A1 ( n16 ) , .A2 ( n3 ) , .A3 ( mux_sel[1] ) , .Y ( n13 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND2X0_RVT U18 ( .A1 ( n17 ) , .A2 ( n18 ) , .Y ( N19 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
NAND4X0_RVT U19 ( .A1 ( n11 ) , .A2 ( state[0] ) , .A3 ( n3 ) , .A4 ( n4 ) , 
    .Y ( n18 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AO21X1_RVT U20 ( .A1 ( n3 ) , .A2 ( n16 ) , .A3 ( n19 ) , .Y ( n17 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
AO21X1_RVT U21 ( .A1 ( ser_done ) , .A2 ( n6 ) , .A3 ( state[0] ) , 
    .Y ( n16 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND2X0_RVT U22 ( .A1 ( n20 ) , .A2 ( n21 ) , .Y ( N18 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
NAND3X0_RVT U23 ( .A1 ( par_en ) , .A2 ( mux_sel[1] ) , .A3 ( n22 ) , 
    .Y ( n21 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
AND3X1_RVT U24 ( .A1 ( n3 ) , .A2 ( n5 ) , .A3 ( ser_done ) , .Y ( n22 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND2X0_RVT U25 ( .A1 ( n11 ) , .A2 ( state[1] ) , .Y ( n19 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
NAND3X0_RVT U26 ( .A1 ( n11 ) , .A2 ( n12 ) , .A3 ( data_valid ) , 
    .Y ( n20 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND2X0_RVT U27 ( .A1 ( state[1] ) , .A2 ( n5 ) , .Y ( n12 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
AND2X1_RVT U28 ( .A1 ( rst_n ) , .A2 ( n2 ) , .Y ( n11 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
DFFX1_RVT \state_reg[2] ( .D ( N20 ) , .CLK ( clk ) , .Q ( state[2] ) , 
    .QN ( n2 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
DFFX1_RVT \state_reg[1] ( .D ( N19 ) , .CLK ( clk ) , .Q ( state[1] ) , 
    .QN ( n4 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
DFFX1_RVT \state_reg[0] ( .D ( N18 ) , .CLK ( clk ) , .Q ( state[0] ) , 
    .QN ( n5 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT U3 ( .A ( mux_sel[0] ) , .Y ( ser_en ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
INVX0_RVT U4 ( .A ( n10 ) , .Y ( n1 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
XNOR2X1_RVT U5 ( .A1 ( n2 ) , .A2 ( state[0] ) , .Y ( n9 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
INVX0_RVT U6 ( .A ( n19 ) , .Y ( mux_sel[1] ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT U7 ( .A ( par_en ) , .Y ( n6 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX0_RVT U8 ( .A ( data_valid ) , .Y ( n3 ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
endmodule


module uart_tx ( clk , rst_n , p_data , data_valid , par_en , par_typ , 
    tx_out , busy , VDD , VSS , placeZBUF_0 ) ;
input  clk ;
input  rst_n ;
input  [7:0] p_data ;
input  data_valid ;
input  par_en ;
input  par_typ ;
output tx_out ;
output busy ;
input  VDD ;
input  VSS ;
input  placeZBUF_0 ;

wire [1:0] mux_sel ;

uart_tx_controller uart_tx_controller_mod ( .clk ( clk ) , .rst_n ( rst_n ) , 
    .data_valid ( data_valid ) , .par_en ( par_en ) , .ser_done ( ser_done ) , 
    .mux_sel ( mux_sel ) , .busy ( busy ) , .ser_en ( ser_en ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
uart_tx_parity_bit uart_tx_parity_bit_mod ( .clk ( clk ) , .rst_n ( rst_n ) , 
    .p_data ( p_data ) , .par_typ ( par_typ ) , .par_bit ( par_bit ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
uart_tx_serializer uart_tx_serializer_mod ( .clk ( clk ) , .rst_n ( rst_n ) , 
    .p_data ( p_data ) , .ser_en ( ser_en ) , .ser_done ( ser_done ) , 
    .ser_data ( ser_data ) , .VDD ( VDD ) , .VSS ( VSS ) , 
    .placeZBUF_2 ( placeZBUF_0 ) ) ;
uart_tx_mux4x1 uart_tx_mux4x1_mod ( .in0 ( VSS ) , .in1 ( VDD ) , 
    .in2 ( ser_data ) , .in3 ( par_bit ) , .mux_out ( tx_out ) , 
    .mux_sel ( mux_sel ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
endmodule


module uart ( clk , rst_n , p_data , data_valid , par_en , par_typ , tx_out , 
    busy , rx_in , rx_p_data , rx_data_valid , VSS_1 , VDD_1 , VDD , VSS ) ;
input  clk ;
input  rst_n ;
input  [7:0] p_data ;
input  data_valid ;
input  par_en ;
input  par_typ ;
output tx_out ;
output busy ;
input  rx_in ;
output [10:0] rx_p_data ;
output rx_data_valid ;
inout  VSS_1 ;
inout  VDD_1 ;
input  VDD ;
input  VSS ;

wire [2:0] baud_cnt ;

assign rx_p_data[0] = rx_data_valid ;
assign VSS_1 = VSS ;
assign VDD_1 = VDD ;

DFFARX1_RVT baud_cnt_reg_0_ ( .D ( copt_net_0 ) , .CLK ( clk ) , 
    .RSTB ( placeZBUF_3 ) , .Q ( baud_cnt[0] ) , .QN ( n1 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
DFFARX1_RVT baud_cnt_reg_1_ ( .D ( copt_net_19 ) , .CLK ( clk ) , 
    .RSTB ( placeZBUF_3 ) , .Q ( baud_cnt[1] ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
NAND2X1_RVT U5 ( .A1 ( baud_cnt[1] ) , .A2 ( baud_cnt[0] ) , .Y ( n2 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
uart_tx uart_tx_inst ( .clk ( baud_cnt[2] ) , .rst_n ( placeZBUF_3 ) , 
    .p_data ( p_data ) , .data_valid ( data_valid ) , .par_en ( par_en ) , 
    .par_typ ( par_typ ) , .tx_out ( tx_out ) , .busy ( busy ) , 
    .VDD ( VDD ) , .VSS ( VSS ) , .placeZBUF_0 ( placeZBUF_0 ) ) ;
uart_rx uart_rx_inst ( .clk ( clk ) , .rst_n ( placeZBUF_3 ) , 
    .rx_in ( rx_in ) , .par_en ( par_en ) , .par_typ ( par_typ ) , 
    .\p_data[9] ( rx_p_data[9] ) , .\p_data[8] ( rx_p_data[8] ) , 
    .\p_data[7] ( rx_p_data[7] ) , .\p_data[6] ( rx_p_data[6] ) , 
    .\p_data[5] ( rx_p_data[5] ) , .\p_data[4] ( rx_p_data[4] ) , 
    .\p_data[3] ( rx_p_data[3] ) , .\p_data[2] ( rx_p_data[2] ) , 
    .\p_data[1] ( rx_p_data[1] ) , .placeZBUF_2 ( placeZBUF_0 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) , .placeHFSNET_2 ( rx_data_valid ) ) ;
DFFARX2_RVT baud_cnt_reg_2_ ( .D ( N4 ) , .CLK ( clk ) , 
    .RSTB ( placeZBUF_3 ) , .Q ( baud_cnt[2] ) , .VDD ( VDD ) , .VSS ( VSS ) ) ;
INVX1_RVT U6 ( .A ( VDD ) , .Y ( rx_p_data[10] ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
NBUFFX4_RVT placeZBUF_inst_20 ( .A ( placeZBUF_3 ) , .Y ( placeZBUF_0 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
XNOR2X1_RVT U9 ( .A1 ( n2 ) , .A2 ( baud_cnt[2] ) , .Y ( N4 ) , .VDD ( VDD ) , 
    .VSS ( VSS ) ) ;
XOR2X1_RVT U10 ( .A1 ( baud_cnt[1] ) , .A2 ( baud_cnt[0] ) , .Y ( N3 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
DELLN1X2_RVT clockcopt_h_inst_297 ( .A ( n1 ) , .Y ( copt_net_0 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
DELLN1X2_RVT clockcopt_h_inst_316 ( .A ( N3 ) , .Y ( copt_net_19 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
NBUFFX4_RVT placeZBUF_inst_38 ( .A ( rst_n ) , .Y ( placeZBUF_3 ) , 
    .VDD ( VDD ) , .VSS ( VSS ) ) ;
endmodule


