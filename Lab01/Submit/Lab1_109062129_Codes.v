module Comparator_4bits (A, B, A_lt_B, A_gt_B, A_eq_B);
// declare input signals
input [4-1:0] A;
input [4-1:0] B;
// declare output signals
output A_lt_B, A_gt_B, A_eq_B;
// wires
wire not_A3, not_A2, not_A1, not_A0, not_B3, not_B2, not_B1, not_B0;
wire A3_lt_B3, A3_gt_B3, A2_lt_B2, A2_gt_B2, A1_lt_B1, A1_gt_B1, A0_lt_B0, A0_gt_B0;
wire nor_3, nor_2, nor_1, nor_0;
wire A2_lt_B2_2, A2_gt_B2_2, A1_lt_B1_2, A1_gt_B1_2, A0_lt_B0_2, A0_gt_B0_2;
// here is your design
//not gates
not(not_A3, A[3]);
not(not_A2, A[2]);
not(not_A1, A[1]);
not(not_A0, A[0]);
not(not_B3, B[3]);
not(not_B2, B[2]);
not(not_B1, B[1]);
not(not_B0, B[0]);
//level one and gates
and(A3_lt_B3, not_A3, B[3]);
and(A3_gt_B3, A[3], not_B3);
and(A2_lt_B2, not_A2, B[2]);
and(A2_gt_B2, A[2], not_B2);
and(A1_lt_B1, not_A1, B[1]);
and(A1_gt_B1, A[1], not_B1);
and(A0_lt_B0, not_A0, B[0]);
and(A0_gt_B0, A[0], not_B0);
//nor gates
nor(nor_3, A3_lt_B3, A3_gt_B3);
nor(nor_2, A2_lt_B2, A2_gt_B2);
nor(nor_1, A1_lt_B1, A1_gt_B1);
nor(nor_0, A0_lt_B0, A0_gt_B0);
//level two and gates
and(A2_lt_B2_2, nor_3, A2_lt_B2);
and(A2_gt_B2_2, nor_3, A2_gt_B2);
and(A1_lt_B1_2, nor_3, nor_2, A1_lt_B1);
and(A1_gt_B1_2, nor_3, nor_2, A1_gt_B1);
and(A0_lt_B0_2, nor_3, nor_2, nor_1, A0_lt_B0);
and(A0_gt_B0_2, nor_3, nor_2, nor_1, A0_gt_B0);
//results
and(A_eq_B, nor_3, nor_2, nor_1, nor_0);
or(A_lt_B, A3_lt_B3, A2_lt_B2_2, A1_lt_B1_2, A0_lt_B0_2);
or(A_gt_B, A3_gt_B3, A2_gt_B2_2, A1_gt_B1_2, A0_gt_B0_2);

endmodule
