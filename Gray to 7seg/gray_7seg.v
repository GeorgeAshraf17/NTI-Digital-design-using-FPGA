module gray_7seg_top (
    input      [3:0] gray_in,
    output     [3:0] bin_out,
    output     [6:0] seg_out   // active-low, drive FPGA pins directly
);
    gray_bin u1 (.gray(gray_in), .bin(bin_out));
    bin_seg  u2 (.bin(bin_out),  .seg(seg_out));
endmodule