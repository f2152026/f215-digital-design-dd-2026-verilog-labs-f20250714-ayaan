// cla64_hier.v
// BONUS -- open-ended. No detailed scaffold is provided; this is meant to
// be a genuine design exercise. Not required for lab submission.
//
// You will likely need to modify cla4.v (or add signals alongside it) so
// that block-generate/block-propagate summaries of its own Gi, Pi signals
// are exposed as outputs, since the second-level lookahead unit below
// needs them. As with every module in this lab from Task 2 onward, every
// gate/assign you add should carry an explicit delay.
//
// Starting point (from Tutorial 3, Q4(d)):
//   - Reuse 16 four-bit CLA blocks (your cla4.v) -- their internal logic
//     doesn't change.
//   - For each block k, define:
//       Gblk_k = "this block produces a carry regardless of its incoming
//                 carry" -- a Boolean function of that block's own 4
//                 bit-level Gi, Pi signals.
//       Pblk_k = "an incoming carry sails straight through this whole
//                 block" -- likewise a function of its own Gi, Pi.
//   - Build a second-level lookahead unit -- structurally identical to
//     cla4.v, just one level up -- that computes each block's carry-in
//     directly from Gblk_0..Gblk_15, Pblk_0..Pblk_15, and cin, instead of
//     rippling block to block.
//
// To test this, wire it into dut.v as a fourth option (copy the pattern
// used for the other three) and run it through the same tb.v. Compare
// your final delay to cla64_blocked.v from Task 4.

module cla64_hier(
  input  [63:0] a,
  input  [63:0] b,
  input         cin,
  output [63:0] sum,
  output        cout
);

   // Block generate and propagate signals
  wire [15:0] Gblk;
  wire [15:0] Pblk;

  // Carry into each 4-bit block
  wire [16:0] bc;

  // External carry-in
  assign #(2) bc[0] = cin;

  // ------------------------------------------------------------
  // 16 four-bit CLA blocks
  // ------------------------------------------------------------

  cla4 block0 (
    .a(a[3:0]),
    .b(b[3:0]),
    .cin(bc[0]),
    .sum(sum[3:0]),
    .cout(),
    .Gblk(Gblk[0]),
    .Pblk(Pblk[0])
  );

  cla4 block1 (
    .a(a[7:4]),
    .b(b[7:4]),
    .cin(bc[1]),
    .sum(sum[7:4]),
    .cout(),
    .Gblk(Gblk[1]),
    .Pblk(Pblk[1])
  );

  cla4 block2 (
    .a(a[11:8]),
    .b(b[11:8]),
    .cin(bc[2]),
    .sum(sum[11:8]),
    .cout(),
    .Gblk(Gblk[2]),
    .Pblk(Pblk[2])
  );

  cla4 block3 (
    .a(a[15:12]),
    .b(b[15:12]),
    .cin(bc[3]),
    .sum(sum[15:12]),
    .cout(),
    .Gblk(Gblk[3]),
    .Pblk(Pblk[3])
  );

  cla4 block4 (
    .a(a[19:16]),
    .b(b[19:16]),
    .cin(bc[4]),
    .sum(sum[19:16]),
    .cout(),
    .Gblk(Gblk[4]),
    .Pblk(Pblk[4])
  );

  cla4 block5 (
    .a(a[23:20]),
    .b(b[23:20]),
    .cin(bc[5]),
    .sum(sum[23:20]),
    .cout(),
    .Gblk(Gblk[5]),
    .Pblk(Pblk[5])
  );

  cla4 block6 (
    .a(a[27:24]),
    .b(b[27:24]),
    .cin(bc[6]),
    .sum(sum[27:24]),
    .cout(),
    .Gblk(Gblk[6]),
    .Pblk(Pblk[6])
  );

  cla4 block7 (
    .a(a[31:28]),
    .b(b[31:28]),
    .cin(bc[7]),
    .sum(sum[31:28]),
    .cout(),
    .Gblk(Gblk[7]),
    .Pblk(Pblk[7])
  );

  cla4 block8 (
    .a(a[35:32]),
    .b(b[35:32]),
    .cin(bc[8]),
    .sum(sum[35:32]),
    .cout(),
    .Gblk(Gblk[8]),
    .Pblk(Pblk[8])
  );

  cla4 block9 (
    .a(a[39:36]),
    .b(b[39:36]),
    .cin(bc[9]),
    .sum(sum[39:36]),
    .cout(),
    .Gblk(Gblk[9]),
    .Pblk(Pblk[9])
  );

  cla4 block10 (
    .a(a[43:40]),
    .b(b[43:40]),
    .cin(bc[10]),
    .sum(sum[43:40]),
    .cout(),
    .Gblk(Gblk[10]),
    .Pblk(Pblk[10])
  );

  cla4 block11 (
    .a(a[47:44]),
    .b(b[47:44]),
    .cin(bc[11]),
    .sum(sum[47:44]),
    .cout(),
    .Gblk(Gblk[11]),
    .Pblk(Pblk[11])
  );

  cla4 block12 (
    .a(a[51:48]),
    .b(b[51:48]),
    .cin(bc[12]),
    .sum(sum[51:48]),
    .cout(),
    .Gblk(Gblk[12]),
    .Pblk(Pblk[12])
  );

  cla4 block13 (
    .a(a[55:52]),
    .b(b[55:52]),
    .cin(bc[13]),
    .sum(sum[55:52]),
    .cout(),
    .Gblk(Gblk[13]),
    .Pblk(Pblk[13])
  );

  cla4 block14 (
    .a(a[59:56]),
    .b(b[59:56]),
    .cin(bc[14]),
    .sum(sum[59:56]),
    .cout(),
    .Gblk(Gblk[14]),
    .Pblk(Pblk[14])
  );

  cla4 block15 (
    .a(a[63:60]),
    .b(b[63:60]),
    .cin(bc[15]),
    .sum(sum[63:60]),
    .cout(),
    .Gblk(Gblk[15]),
    .Pblk(Pblk[15])
  );

  // ------------------------------------------------------------
  // Second-level carry lookahead
  // ------------------------------------------------------------

  wire t1_0;

  and #(2) (t1_0, Pblk[0], bc[0]);
  or  #(2) (bc[1], Gblk[0], t1_0);

  wire t2_0, t2_1;

  and #(2) (t2_0, Pblk[1], Gblk[0]);
  and #(2) (t2_1, Pblk[1], Pblk[0], bc[0]);
  or  #(2) (bc[2], Gblk[1], t2_0, t2_1);

  wire t3_0, t3_1, t3_2;

  and #(2) (t3_0, Pblk[2], Gblk[1]);
  and #(2) (t3_1, Pblk[2], Pblk[1], Gblk[0]);
  and #(2) (t3_2, Pblk[2], Pblk[1], Pblk[0], bc[0]);
  or  #(2) (bc[3], Gblk[2], t3_0, t3_1, t3_2);

  wire t4_0, t4_1, t4_2, t4_3;

  and #(2) (t4_0, Pblk[3], Gblk[2]);
  and #(2) (t4_1, Pblk[3], Pblk[2], Gblk[1]);
  and #(2) (t4_2, Pblk[3], Pblk[2], Pblk[1], Gblk[0]);
  and #(2) (t4_3, Pblk[3], Pblk[2], Pblk[1], Pblk[0], bc[0]);
  or  #(2) (bc[4], Gblk[3], t4_0, t4_1, t4_2, t4_3);

  wire t5_0, t5_1, t5_2, t5_3, t5_4;

  and #(2) (t5_0, Pblk[4], Gblk[3]);
  and #(2) (t5_1, Pblk[4], Pblk[3], Gblk[2]);
  and #(2) (t5_2, Pblk[4], Pblk[3], Pblk[2], Gblk[1]);
  and #(2) (t5_3, Pblk[4], Pblk[3], Pblk[2], Pblk[1], Gblk[0]);
  and #(2) (t5_4, Pblk[4], Pblk[3], Pblk[2], Pblk[1], Pblk[0], bc[0]);
  or  #(2) (bc[5], Gblk[4], t5_0, t5_1, t5_2, t5_3, t5_4);

  wire t6_0, t6_1, t6_2, t6_3, t6_4, t6_5;

  and #(2) (t6_0, Pblk[5], Gblk[4]);
  and #(2) (t6_1, Pblk[5], Pblk[4], Gblk[3]);
  and #(2) (t6_2, Pblk[5], Pblk[4], Pblk[3], Gblk[2]);
  and #(2) (t6_3, Pblk[5], Pblk[4], Pblk[3], Pblk[2], Gblk[1]);
  and #(2) (t6_4, Pblk[5], Pblk[4], Pblk[3], Pblk[2], Pblk[1], Gblk[0]);
  and #(2) (t6_5, Pblk[5], Pblk[4], Pblk[3], Pblk[2], Pblk[1], Pblk[0], bc[0]);
  or  #(2) (bc[6], Gblk[5], t6_0, t6_1, t6_2, t6_3, t6_4, t6_5);

  wire t7_0, t7_1, t7_2, t7_3, t7_4, t7_5, t7_6;

  and #(2) (t7_0, Pblk[6], Gblk[5]);
  and #(2) (t7_1, Pblk[6], Pblk[5], Gblk[4]);
  and #(2) (t7_2, Pblk[6], Pblk[5], Pblk[4], Gblk[3]);
  and #(2) (t7_3, Pblk[6], Pblk[5], Pblk[4], Pblk[3], Gblk[2]);
  and #(2) (t7_4, Pblk[6], Pblk[5], Pblk[4], Pblk[3], Pblk[2], Gblk[1]);
  and #(2) (t7_5, Pblk[6], Pblk[5], Pblk[4], Pblk[3], Pblk[2], Pblk[1], Gblk[0]);
  and #(2) (t7_6, Pblk[6], Pblk[5], Pblk[4], Pblk[3], Pblk[2], Pblk[1], Pblk[0], bc[0]);
  or  #(2) (bc[7], Gblk[6], t7_0, t7_1, t7_2, t7_3, t7_4, t7_5, t7_6);

  wire t8_0, t8_1, t8_2, t8_3, t8_4, t8_5, t8_6, t8_7;

  and #(2) (t8_0, Pblk[7], Gblk[6]);
  and #(2) (t8_1, Pblk[7], Pblk[6], Gblk[5]);
  and #(2) (t8_2, Pblk[7], Pblk[6], Pblk[5], Gblk[4]);
  and #(2) (t8_3, Pblk[7], Pblk[6], Pblk[5], Pblk[4], Gblk[3]);
  and #(2) (t8_4, Pblk[7], Pblk[6], Pblk[5], Pblk[4], Pblk[3], Gblk[2]);
  and #(2) (t8_5, Pblk[7], Pblk[6], Pblk[5], Pblk[4], Pblk[3], Pblk[2], Gblk[1]);
  and #(2) (t8_6, Pblk[7], Pblk[6], Pblk[5], Pblk[4], Pblk[3], Pblk[2], Pblk[1], Gblk[0]);
  and #(2) (t8_7, Pblk[7], Pblk[6], Pblk[5], Pblk[4], Pblk[3], Pblk[2], Pblk[1], Pblk[0], bc[0]);
  or  #(2) (bc[8], Gblk[7], t8_0, t8_1, t8_2, t8_3, t8_4, t8_5, t8_6, t8_7);

  wire t9_0, t9_1, t9_2, t9_3, t9_4, t9_5, t9_6, t9_7, t9_8;

  and #(2) (t9_0, Pblk[8], Gblk[7]);
  and #(2) (t9_1, Pblk[8], Pblk[7], Gblk[6]);
  and #(2) (t9_2, Pblk[8], Pblk[7], Pblk[6], Gblk[5]);
  and #(2) (t9_3, Pblk[8], Pblk[7], Pblk[6], Pblk[5], Gblk[4]);
  and #(2) (t9_4, Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Gblk[3]);
  and #(2) (t9_5, Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Pblk[3], Gblk[2]);
  and #(2) (t9_6, Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Pblk[3], Pblk[2], Gblk[1]);
  and #(2) (t9_7, Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Pblk[3], Pblk[2], Pblk[1], Gblk[0]);
  and #(2) (t9_8, Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Pblk[3], Pblk[2], Pblk[1], Pblk[0], bc[0]);
  or  #(2) (bc[9], Gblk[8], t9_0, t9_1, t9_2, t9_3, t9_4, t9_5, t9_6, t9_7, t9_8);

  wire t10_0, t10_1, t10_2, t10_3, t10_4, t10_5, t10_6, t10_7, t10_8, t10_9;

  and #(2) (t10_0, Pblk[9], Gblk[8]);
  and #(2) (t10_1, Pblk[9], Pblk[8], Gblk[7]);
  and #(2) (t10_2, Pblk[9], Pblk[8], Pblk[7], Gblk[6]);
  and #(2) (t10_3, Pblk[9], Pblk[8], Pblk[7], Pblk[6], Gblk[5]);
  and #(2) (t10_4, Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Gblk[4]);
  and #(2) (t10_5, Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Gblk[3]);
  and #(2) (t10_6, Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Pblk[3], Gblk[2]);
  and #(2) (t10_7, Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Pblk[3], Pblk[2], Gblk[1]);
  and #(2) (t10_8, Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Pblk[3], Pblk[2], Pblk[1], Gblk[0]);
  and #(2) (t10_9, Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Pblk[3], Pblk[2], Pblk[1], Pblk[0], bc[0]);
  or  #(2) (bc[10], Gblk[9], t10_0, t10_1, t10_2, t10_3, t10_4, t10_5, t10_6, t10_7, t10_8, t10_9);

  wire t11_0, t11_1, t11_2, t11_3, t11_4, t11_5, t11_6, t11_7, t11_8, t11_9, t11_10;

  and #(2) (t11_0, Pblk[10], Gblk[9]);
  and #(2) (t11_1, Pblk[10], Pblk[9], Gblk[8]);
  and #(2) (t11_2, Pblk[10], Pblk[9], Pblk[8], Gblk[7]);
  and #(2) (t11_3, Pblk[10], Pblk[9], Pblk[8], Pblk[7], Gblk[6]);
  and #(2) (t11_4, Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Gblk[5]);
  and #(2) (t11_5, Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Gblk[4]);
  and #(2) (t11_6, Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Gblk[3]);
  and #(2) (t11_7, Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Pblk[3], Gblk[2]);
  and #(2) (t11_8, Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Pblk[3], Pblk[2], Gblk[1]);
  and #(2) (t11_9, Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Pblk[3], Pblk[2], Pblk[1], Gblk[0]);
  and #(2) (t11_10, Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Pblk[3], Pblk[2], Pblk[1], Pblk[0], bc[0]);
  or  #(2) (bc[11], Gblk[10], t11_0, t11_1, t11_2, t11_3, t11_4, t11_5, t11_6, t11_7, t11_8, t11_9, t11_10);

  wire t12_0, t12_1, t12_2, t12_3, t12_4, t12_5, t12_6, t12_7, t12_8, t12_9, t12_10, t12_11;

  and #(2) (t12_0, Pblk[11], Gblk[10]);
  and #(2) (t12_1, Pblk[11], Pblk[10], Gblk[9]);
  and #(2) (t12_2, Pblk[11], Pblk[10], Pblk[9], Gblk[8]);
  and #(2) (t12_3, Pblk[11], Pblk[10], Pblk[9], Pblk[8], Gblk[7]);
  and #(2) (t12_4, Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Gblk[6]);
  and #(2) (t12_5, Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Gblk[5]);
  and #(2) (t12_6, Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Gblk[4]);
  and #(2) (t12_7, Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Gblk[3]);
  and #(2) (t12_8, Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Pblk[3], Gblk[2]);
  and #(2) (t12_9, Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Pblk[3], Pblk[2], Gblk[1]);
  and #(2) (t12_10, Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Pblk[3], Pblk[2], Pblk[1], Gblk[0]);
  and #(2) (t12_11, Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Pblk[3], Pblk[2], Pblk[1], Pblk[0], bc[0]);
  or  #(2) (bc[12], Gblk[11], t12_0, t12_1, t12_2, t12_3, t12_4, t12_5, t12_6, t12_7, t12_8, t12_9, t12_10, t12_11);

  wire t13_0, t13_1, t13_2, t13_3, t13_4, t13_5, t13_6, t13_7, t13_8, t13_9, t13_10, t13_11, t13_12;

  and #(2) (t13_0, Pblk[12], Gblk[11]);
  and #(2) (t13_1, Pblk[12], Pblk[11], Gblk[10]);
  and #(2) (t13_2, Pblk[12], Pblk[11], Pblk[10], Gblk[9]);
  and #(2) (t13_3, Pblk[12], Pblk[11], Pblk[10], Pblk[9], Gblk[8]);
  and #(2) (t13_4, Pblk[12], Pblk[11], Pblk[10], Pblk[9], Pblk[8], Gblk[7]);
  and #(2) (t13_5, Pblk[12], Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Gblk[6]);
  and #(2) (t13_6, Pblk[12], Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Gblk[5]);
  and #(2) (t13_7, Pblk[12], Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Gblk[4]);
  and #(2) (t13_8, Pblk[12], Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Gblk[3]);
  and #(2) (t13_9, Pblk[12], Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Pblk[3], Gblk[2]);
  and #(2) (t13_10, Pblk[12], Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Pblk[3], Pblk[2], Gblk[1]);
  and #(2) (t13_11, Pblk[12], Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Pblk[3], Pblk[2], Pblk[1], Gblk[0]);
  and #(2) (t13_12, Pblk[12], Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Pblk[3], Pblk[2], Pblk[1], Pblk[0], bc[0]);
  or  #(2) (bc[13], Gblk[12], t13_0, t13_1, t13_2, t13_3, t13_4, t13_5, t13_6, t13_7, t13_8, t13_9, t13_10, t13_11, t13_12);

  wire t14_0, t14_1, t14_2, t14_3, t14_4, t14_5, t14_6, t14_7, t14_8, t14_9, t14_10, t14_11, t14_12, t14_13;

  and #(2) (t14_0, Pblk[13], Gblk[12]);
  and #(2) (t14_1, Pblk[13], Pblk[12], Gblk[11]);
  and #(2) (t14_2, Pblk[13], Pblk[12], Pblk[11], Gblk[10]);
  and #(2) (t14_3, Pblk[13], Pblk[12], Pblk[11], Pblk[10], Gblk[9]);
  and #(2) (t14_4, Pblk[13], Pblk[12], Pblk[11], Pblk[10], Pblk[9], Gblk[8]);
  and #(2) (t14_5, Pblk[13], Pblk[12], Pblk[11], Pblk[10], Pblk[9], Pblk[8], Gblk[7]);
  and #(2) (t14_6, Pblk[13], Pblk[12], Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Gblk[6]);
  and #(2) (t14_7, Pblk[13], Pblk[12], Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Gblk[5]);
  and #(2) (t14_8, Pblk[13], Pblk[12], Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Gblk[4]);
  and #(2) (t14_9, Pblk[13], Pblk[12], Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Gblk[3]);
  and #(2) (t14_10, Pblk[13], Pblk[12], Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Pblk[3], Gblk[2]);
  and #(2) (t14_11, Pblk[13], Pblk[12], Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Pblk[3], Pblk[2], Gblk[1]);
  and #(2) (t14_12, Pblk[13], Pblk[12], Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Pblk[3], Pblk[2], Pblk[1], Gblk[0]);
  and #(2) (t14_13, Pblk[13], Pblk[12], Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Pblk[3], Pblk[2], Pblk[1], Pblk[0], bc[0]);
  or  #(2) (bc[14], Gblk[13], t14_0, t14_1, t14_2, t14_3, t14_4, t14_5, t14_6, t14_7, t14_8, t14_9, t14_10, t14_11, t14_12, t14_13);

  wire t15_0, t15_1, t15_2, t15_3, t15_4, t15_5, t15_6, t15_7, t15_8, t15_9, t15_10, t15_11, t15_12, t15_13, t15_14;

  and #(2) (t15_0, Pblk[14], Gblk[13]);
  and #(2) (t15_1, Pblk[14], Pblk[13], Gblk[12]);
  and #(2) (t15_2, Pblk[14], Pblk[13], Pblk[12], Gblk[11]);
  and #(2) (t15_3, Pblk[14], Pblk[13], Pblk[12], Pblk[11], Gblk[10]);
  and #(2) (t15_4, Pblk[14], Pblk[13], Pblk[12], Pblk[11], Pblk[10], Gblk[9]);
  and #(2) (t15_5, Pblk[14], Pblk[13], Pblk[12], Pblk[11], Pblk[10], Pblk[9], Gblk[8]);
  and #(2) (t15_6, Pblk[14], Pblk[13], Pblk[12], Pblk[11], Pblk[10], Pblk[9], Pblk[8], Gblk[7]);
  and #(2) (t15_7, Pblk[14], Pblk[13], Pblk[12], Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Gblk[6]);
  and #(2) (t15_8, Pblk[14], Pblk[13], Pblk[12], Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Gblk[5]);
  and #(2) (t15_9, Pblk[14], Pblk[13], Pblk[12], Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Gblk[4]);
  and #(2) (t15_10,Pblk[14], Pblk[13], Pblk[12], Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Gblk[3]);
  and #(2) (t15_11,Pblk[14], Pblk[13], Pblk[12], Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Pblk[3], Gblk[2]);
  and #(2) (t15_12,Pblk[14], Pblk[13], Pblk[12], Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Pblk[3], Pblk[2], Gblk[1]);
  and #(2) (t15_13,Pblk[14], Pblk[13], Pblk[12], Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Pblk[3], Pblk[2], Pblk[1], Gblk[0]);
  and #(2) (t15_14,Pblk[14], Pblk[13], Pblk[12], Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Pblk[3], Pblk[2], Pblk[1], Pblk[0], bc[0]);
  or  #(2) (bc[15], Gblk[14], t15_0, t15_1, t15_2, t15_3, t15_4, t15_5, t15_6, t15_7, t15_8, t15_9, t15_10, t15_11, t15_12, t15_13, t15_14);

  wire t16_0, t16_1, t16_2, t16_3, t16_4, t16_5, t16_6, t16_7, t16_8, t16_9, t16_10, t16_11, t16_12, t16_13, t16_14, t16_15;

  and #(2) (t16_0, Pblk[15], Gblk[14]);
  and #(2) (t16_1, Pblk[15], Pblk[14], Gblk[13]);
  and #(2) (t16_2, Pblk[15], Pblk[14], Pblk[13], Gblk[12]);
  and #(2) (t16_3, Pblk[15], Pblk[14], Pblk[13], Pblk[12], Gblk[11]);
  and #(2) (t16_4, Pblk[15], Pblk[14], Pblk[13], Pblk[12], Pblk[11], Gblk[10]);
  and #(2) (t16_5, Pblk[15], Pblk[14], Pblk[13], Pblk[12], Pblk[11], Pblk[10], Gblk[9]);
  and #(2) (t16_6, Pblk[15], Pblk[14], Pblk[13], Pblk[12], Pblk[11], Pblk[10], Pblk[9], Gblk[8]);
  and #(2) (t16_7, Pblk[15], Pblk[14], Pblk[13], Pblk[12], Pblk[11], Pblk[10], Pblk[9], Pblk[8], Gblk[7]);
  and #(2) (t16_8, Pblk[15], Pblk[14], Pblk[13], Pblk[12], Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Gblk[6]);
  and #(2) (t16_9, Pblk[15], Pblk[14], Pblk[13], Pblk[12], Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Gblk[5]);
  and #(2) (t16_10, Pblk[15], Pblk[14], Pblk[13], Pblk[12], Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Gblk[4]);
  and #(2) (t16_11, Pblk[15], Pblk[14], Pblk[13], Pblk[12], Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Gblk[3]);
  and #(2) (t16_12, Pblk[15], Pblk[14], Pblk[13], Pblk[12], Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Pblk[3], Gblk[2]);
  and #(2) (t16_13, Pblk[15], Pblk[14], Pblk[13], Pblk[12], Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Pblk[3], Pblk[2], Gblk[1]);
  and #(2) (t16_14, Pblk[15], Pblk[14], Pblk[13], Pblk[12], Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Pblk[3], Pblk[2], Pblk[1], Gblk[0]);
  and #(2) (t16_15, Pblk[15], Pblk[14], Pblk[13], Pblk[12], Pblk[11], Pblk[10], Pblk[9], Pblk[8], Pblk[7], Pblk[6], Pblk[5], Pblk[4], Pblk[3], Pblk[2], Pblk[1], Pblk[0], bc[0]);
  or  #(2) (bc[16], Gblk[15], t16_0, t16_1, t16_2, t16_3, t16_4, t16_5, t16_6, t16_7, t16_8, t16_9, t16_10, t16_11, t16_12, t16_13, t16_14, t16_15);

  // Final carry output
  assign #(2) cout = bc[16];

endmodule
