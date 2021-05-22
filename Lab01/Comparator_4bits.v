module comparator_4bits(A, B, A_lt_B, A_gt_B, A_eq_B);
 input[4-1:0] A;
 input[4-1:0] B;
 output A_lt_B, A_gt_B, A_eq_B;
 wire not_A0, not_A1, not_A2, not_A3;
 wire not_B0, not_B1, not_B2, not_B3;
 wire eq0_0, eq0_1, eq1_0, eq1_1, eq2_0, eq2_1, eq3_0, eq3_1;
 wire eq0, eq1, eq2, eq3;
 wire Ag0, Ag1, Ag2, Ag3;
 wire Bg0, Bg1, Bg2, Bg3;
 
 // not gates
 not(not_A0, A[0]);
 not(not_A1, A[1]);
 not(not_A2, A[2]);
 not(not_A3, A[3]);
 not(not_B0, B[0]);
 not(not_B1, B[1]);
 not(not_B2, B[2]);
 not(not_B3, B[3]);

 // compare A[0] and B[0]
 and(eq0_0, A[0], B[0]);
 and(eq0_1, not_A0,  not_B0);
 and(Ag0, A[0], not_B0);
 and(Bg0, not_A0, B[0]);
 
 // compare A[1] and B[1]
 and(eq1_0, A[1], B[1]);
 and(eq1_1, not_A1,  not_B1);
 and(Ag1, A[1], not_B1);
 and(Bg1, not_A1, B[1]);
 
 // compare A[2] and B[2]
 and(eq2_0, A[2], B[2]);
 and(eq2_1, not_A2,  not_B2);
 and(Ag2, A[2], not_B2);
 and(Bg2, not_A2, B[2]);
 
 // compare A[3] and B[3]
 and(eq3_0, A[3], B[3]);
 and(eq3_1, not_A3,  not_B3);
 and(Ag3, A[3], not_B3);
 and(Bg3, not_A3, B[3]);
 
 // assign  wire eq0, eq1, eq2, eq3
 or(eq0, eq0_0, eq0_1);
 or(eq1, eq1_0, eq1_1);
 or(eq2, eq2_0, eq2_1);
 or(eq3, eq3_0, eq3_1);
 
 // A_lt_B = (Bg3 | (Bg2 & eq3) | (Bg1 & eq3 & eq2) |(Bg0 & eq3 & eq2 & eq1))
 wire cond_ALTB_0, cond_ALTB_1, cond_ALTB_2;
 wire tmp_0, tmp_1, tmp_2, tmp_3, tmp_4;
 // for (Bg2 & eq3)
 and(cond_ALTB_0, Bg2, eq3);
 // for (Bg1 & eq3 & eq2)
 and(tmp_0, eq3, eq2);
 and(cond_ALTB_1, Bg1, tmp_0);
 // for (Bg0 & eq3 & eq2 & eq1)
 and(tmp_1, eq2, eq1);
 and(tmp_2, eq3, tmp_1);
 and(cond_ALTB_2, Bg0, tmp_2);
 // for Bg3 | (Bg2 & eq3) | (Bg1 & eq3 & eq2) |(Bg0 & eq3 & eq2 & eq1)
 or(tmp_3, cond_ALTB_1, cond_ALTB_2);
 or(tmp_4, cond_ALTB_0, tmp_3);
 or(A_lt_B, Bg3, tmp_4);
 
  // A_gt_B = (Ag3 | (Ag2 & eq3) | (Ag1 & eq3 & eq2) |(Ag0 & eq3 & eq2 & eq1))
 wire cond_AGTB_0, cond_AGTB_1, cond_AGTB_2;
 wire tmp_5, tmp_6, tmp_7, tmp_8, tmp_9;
 // for (Ag2 & eq3)
 and(cond_AGTB_0, Ag2, eq3);
 // for (Ag1 & eq3 & eq2)
 and(tmp_5, eq3, eq2);
 and(cond_AGTB_1, Ag1, tmp_5);
 // for (Ag0 & eq3 & eq2 & eq1)
 and(tmp_6, eq2, eq1);
 and(tmp_7, eq3, tmp_6);
 and(cond_AGTB_2, Ag0, tmp_7);
 // for Ag3 | (Ag2 & eq3) | (Ag1 & eq3 & eq2) |(Ag0 & eq3 & eq2 & eq1)
 or(tmp_8, cond_AGTB_1, cond_AGTB_2);
 or(tmp_9, cond_AGTB_0, tmp_8);
 or(A_gt_B, Ag3, tmp_9);
 
 // A_eq_B = (eq0 & eq1 & eq2 & eq3)
 wire tmp_10, tmp_11, tmp_12;
 and(tmp_10, eq2, eq3);
 and(tmp_11, eq1, tmp_10);
 and(A_eq_B, eq0, tmp_11);

endmodule