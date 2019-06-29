% Generated using GBSolver generator Copyright Martin Bujnak,
% Zuzana Kukelova, Tomas Pajdla CTU Prague 2008.
% 
% Please refer to the following paper, when using this code :
%     Kukelova Z., Bujnak M., Pajdla T., Automatic Generator of Minimal Problem Solvers,
%     ECCV 2008, Marseille, France, October 12-18, 2008

function [c, d, a, e, b] = solver_p3v3_dif_notensor3_2p_1l(A_11, B_11)

	% precalculate polynomial equations coefficients
    c = zeros(70,1);
	c(1) = A_11(17) - A_11(9) - A_11(1);
	c(2) = A_11(9) - A_11(1) - A_11(17);
	c(3) = A_11(1) - A_11(9) - A_11(17);
	c(4) = A_11(1) + A_11(9) + A_11(17);
	c(5) = 2*A_11(11) + 2*A_11(15);
	c(6) = 2*A_11(5) + 2*A_11(13);
	c(7) = 2*A_11(3) + 2*A_11(7);
	c(8) = 2*A_11(3) - 2*A_11(7);
	c(9) = 2*A_11(13) - 2*A_11(5);
	c(10) = 2*A_11(11) - 2*A_11(15);
	c(11) = A_11(19);
	c(12) = A_11(21);
	c(13) = A_11(18) - A_11(10) - A_11(2);
	c(14) = A_11(10) - A_11(2) - A_11(18);
	c(15) = A_11(2) - A_11(10) - A_11(18);
	c(16) = A_11(2) + A_11(10) + A_11(18);
	c(17) = 2*A_11(12) + 2*A_11(16);
	c(18) = 2*A_11(6) + 2*A_11(14);
	c(19) = 2*A_11(4) + 2*A_11(8);
	c(20) = 2*A_11(4) - 2*A_11(8);
	c(21) = 2*A_11(14) - 2*A_11(6);
	c(22) = 2*A_11(12) - 2*A_11(16);
	c(23) = A_11(20);
	c(24) = 2*B_11(29) + 2*B_11(33);
	c(25) = 2*B_11(23) + 2*B_11(31);
	c(26) = 2*B_11(21) + 2*B_11(25);
	c(27) = 2*B_11(21) - 2*B_11(25);
	c(28) = 2*B_11(31) - 2*B_11(23);
	c(29) = 2*B_11(29) - 2*B_11(33);
	c(30) = B_11(17) - B_11(9) - B_11(1);
	c(31) = B_11(9) - B_11(1) - B_11(17);
	c(32) = B_11(1) - B_11(9) - B_11(17);
	c(33) = B_11(1) + B_11(9) + B_11(17);
	c(34) = B_11(35) - B_11(27) - B_11(19);
	c(35) = B_11(27) - B_11(19) - B_11(35);
	c(36) = B_11(19) - B_11(27) - B_11(35);
	c(37) = B_11(19) + B_11(27) + B_11(35);
	c(38) = 2*B_11(11) + 2*B_11(15);
	c(39) = 2*B_11(5) + 2*B_11(13);
	c(40) = 2*B_11(3) + 2*B_11(7);
	c(41) = 2*B_11(3) - 2*B_11(7);
	c(42) = 2*B_11(13) - 2*B_11(5);
	c(43) = 2*B_11(11) - 2*B_11(15);
	c(44) = B_11(37);
	c(45) = 2*B_11(30) + 2*B_11(34);
	c(46) = 2*B_11(24) + 2*B_11(32);
	c(47) = 2*B_11(22) + 2*B_11(26);
	c(48) = 2*B_11(22) - 2*B_11(26);
	c(49) = 2*B_11(32) - 2*B_11(24);
	c(50) = 2*B_11(30) - 2*B_11(34);
	c(51) = B_11(18) - B_11(10) - B_11(2);
	c(52) = B_11(10) - B_11(2) - B_11(18);
	c(53) = B_11(2) - B_11(10) - B_11(18);
	c(54) = B_11(2) + B_11(10) + B_11(18);
	c(55) = B_11(36) - B_11(28) - B_11(20);
	c(56) = B_11(28) - B_11(20) - B_11(36);
	c(57) = B_11(20) - B_11(28) - B_11(36);
	c(58) = B_11(20) + B_11(28) + B_11(36);
	c(59) = 2*B_11(12) + 2*B_11(16);
	c(60) = 2*B_11(6) + 2*B_11(14);
	c(61) = 2*B_11(4) + 2*B_11(8);
	c(62) = 2*B_11(4) - 2*B_11(8);
	c(63) = 2*B_11(14) - 2*B_11(6);
	c(64) = 2*B_11(12) - 2*B_11(16);
	c(65) = B_11(38);
	c(66) = 1;
	c(67) = 1;
	c(68) = 1;
	c(69) = 1;
	c(70) = -1;

	M1 = zeros(20, 51);
	ci = [41, 62, 123, 244, 365, 656];
	M1(ci) = c(1);

	ci = [1, 22, 83, 204, 325, 616];
	M1(ci) = c(2);

	ci = [501, 522, 543, 564, 585, 896];
	M1(ci) = c(3);

	ci = [141, 162, 183, 304, 425, 716];
	M1(ci) = c(4);

	ci = [21, 42, 103, 224, 345, 636];
	M1(ci) = c(5);

	ci = [341, 362, 403, 464, 525, 836];
	M1(ci) = c(6);

	ci = [321, 342, 383, 444, 505, 816];
	M1(ci) = c(7);

	ci = [101, 122, 163, 284, 405, 696];
	M1(ci) = c(8);

	ci = [81, 102, 143, 264, 385, 676];
	M1(ci) = c(9);

	ci = [381, 402, 423, 484, 545, 856];
	M1(ci) = c(10);

	ci = [721, 742, 763, 784, 865, 976];
	M1(ci) = c(11);

	ci = [901, 922, 943, 964, 985, 1016];
	M1(ci) = c(12);

	ci = [46, 67, 128, 249, 370, 657];
	M1(ci) = c(13);

	ci = [6, 27, 88, 209, 330, 617];
	M1(ci) = c(14);

	ci = [506, 527, 548, 569, 590, 897];
	M1(ci) = c(15);

	ci = [146, 167, 188, 309, 430, 717];
	M1(ci) = c(16);

	ci = [26, 47, 108, 229, 350, 637];
	M1(ci) = c(17);

	ci = [346, 367, 408, 469, 530, 837];
	M1(ci) = c(18);

	ci = [326, 347, 388, 449, 510, 817];
	M1(ci) = c(19);

	ci = [106, 127, 168, 289, 410, 697];
	M1(ci) = c(20);

	ci = [86, 107, 148, 269, 390, 677];
	M1(ci) = c(21);

	ci = [386, 407, 428, 489, 550, 857];
	M1(ci) = c(22);

	ci = [726, 747, 768, 789, 870, 977];
	M1(ci) = c(23);

	M1(238) = c(24);
	M1(478) = c(25);
	M1(458) = c(26);
	M1(298) = c(27);
	M1(278) = c(28);
	M1(498) = c(29);
	M1(658) = c(30);
	M1(618) = c(31);
	M1(898) = c(32);
	M1(718) = c(33);
	M1(258) = c(34);
	M1(218) = c(35);
	M1(578) = c(36);
	M1(318) = c(37);
	M1(638) = c(38);
	M1(838) = c(39);
	M1(818) = c(40);
	M1(698) = c(41);
	M1(678) = c(42);
	M1(858) = c(43);
	M1(1018) = c(44);
	M1(239) = c(45);
	M1(479) = c(46);
	M1(459) = c(47);
	M1(299) = c(48);
	M1(279) = c(49);
	M1(499) = c(50);
	M1(659) = c(51);
	M1(619) = c(52);
	M1(899) = c(53);
	M1(719) = c(54);
	M1(259) = c(55);
	M1(219) = c(56);
	M1(579) = c(57);
	M1(319) = c(58);
	M1(639) = c(59);
	M1(839) = c(60);
	M1(819) = c(61);
	M1(699) = c(62);
	M1(679) = c(63);
	M1(859) = c(64);
	M1(1019) = c(65);
	ci = [51, 72, 133, 254, 375, 660];
	M1(ci) = c(66);

	ci = [11, 32, 93, 214, 335, 620];
	M1(ci) = c(67);

	ci = [511, 532, 553, 574, 595, 900];
	M1(ci) = c(68);

	ci = [151, 172, 193, 314, 435, 720];
	M1(ci) = c(69);

	ci = [911, 932, 953, 974, 995, 1020];
	M1(ci) = c(70);

% % % % % %     ts1 = tic;
%     M1f = frref(M1);
%     tf1 = toc(ts1);
%     ts2 = tic;
    M1 = qrdec(M1);    
%     tf2 = toc(ts2);

	M2 = zeros(25, 51);
	M2(6:25, [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51]) = M1(1:20, :);
	M2([101 127 178 329 480]) = M1(680);
	M2([126 152 203 354 505]) = M1(700);
	M2([176 202 228 379 530]) = M1(720);
	M2([401 427 478 554 630]) = M1(820);
	M2([426 452 503 579 655]) = M1(840);
	M2([476 502 528 604 680]) = M1(860);
	M2([626 652 678 704 730]) = M1(900);
	M2([901 927 953 979 1080]) = M1(980);
	M2([1126 1152 1178 1204 1230]) = M1(1020);
	M2 = qrdec(M2);

	M3 = zeros(84, 121);
	M3(60:84, [66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 86 87 88 89 90 91 92 93 94 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121]) = M2(1:25, :);
	M3([1681 1766 1935 2440 3785]) = M2(365);
	M3([1849 1934 2019 2524 3869]) = M2(390);
	M3([3445 3530 3699 3952 4709]) = M2(565);
	M3([3529 3614 3783 4036 4793]) = M2(590);
	M3([3697 3782 3867 4120 4877]) = M2(615);
	M3([4705 4790 4875 4960 5297]) = M2(715);
	M3([6 511 764 1269 1354 1607 2112 2617 2702 2955 3460 4217]) = M2(772);
	M3([102 187 608 861 1366 1451 1704 2209 2714 2799 3052 3557 4314]) = M2(798);
	M3([199 284 369 706 959 1464 1549 1802 2307 2812 2897 3150 3655 4412]) = M2(824);
	M3([465 550 635 804 889 1058 1647 1732 1901 2406 2995 3080 3249 3754 4511]) = M2(850);
	M3([5881 5966 6135 6640 7481]) = M2(865);
	M3([510 931 1100 1689 1774 1943 2448 3037 3122 3291 3796 4553]) = M2(872);
	M3([522 607 944 1113 1702 1787 1956 2461 3050 3135 3304 3809 4566]) = M2(873);
	M3([535 620 705 958 1127 1716 1801 1970 2475 3064 3149 3318 3823 4580]) = M2(874);
	M3([549 634 719 888 973 1142 1731 1816 1985 2490 3079 3164 3333 3838 4595]) = M2(875);
	M3([6049 6134 6219 6724 7565]) = M2(890);
	M3([762 1099 1184 1857 1942 2027 2532 3205 3290 3375 3880 4637]) = M2(897);
	M3([774 859 1112 1197 1870 1955 2040 2545 3218 3303 3388 3893 4650]) = M2(898);
	M3([787 872 957 1126 1211 1884 1969 2054 2559 3232 3317 3402 3907 4664]) = M2(899);
	M3([801 886 971 1056 1141 1226 1899 1984 2069 2574 3247 3332 3417 3922 4679]) = M2(900);
	M3([6805 6890 6975 7060 7901]) = M2(990);
	M3([7141 7226 7395 7648 7985]) = M2(1015);
	M3([2610 3031 3200 3453 3538 3707 3960 4213 4298 4467 4720 5057]) = M2(1022);
	M3([2622 2707 3044 3213 3466 3551 3720 3973 4226 4311 4480 4733 5070]) = M2(1023);
	M3([2635 2720 2805 3058 3227 3480 3565 3734 3987 4240 4325 4494 4747 5084]) = M2(1024);
	M3([2649 2734 2819 2988 3073 3242 3495 3580 3749 4002 4255 4340 4509 4762 5099]) = M2(1025);
	M3([7225 7310 7479 7732 8069]) = M2(1040);
	M3([2694 3115 3284 3537 3622 3791 4044 4297 4382 4551 4804 5141]) = M2(1047);
	M3([2706 2791 3128 3297 3550 3635 3804 4057 4310 4395 4564 4817 5154]) = M2(1048);
	M3([2719 2804 2889 3142 3311 3564 3649 3818 4071 4324 4409 4578 4831 5168]) = M2(1049);
	M3([2733 2818 2903 3072 3157 3326 3579 3664 3833 4086 4339 4424 4593 4846 5183]) = M2(1050);
	M3([7393 7478 7563 7816 8153]) = M2(1065);
	M3([2946 3283 3368 3705 3790 3875 4128 4465 4550 4635 4888 5225]) = M2(1072);
	M3([2958 3043 3296 3381 3718 3803 3888 4141 4478 4563 4648 4901 5238]) = M2(1073);
	M3([2971 3056 3141 3310 3395 3732 3817 3902 4155 4492 4577 4662 4915 5252]) = M2(1074);
	M3([2985 3070 3155 3240 3325 3410 3747 3832 3917 4170 4507 4592 4677 4930 5267]) = M2(1075);
	M3([7981 8066 8151 8236 8321]) = M2(1115);
	M3([4206 4543 4628 4713 4798 4883 4968 5053 5138 5223 5308 5393]) = M2(1122);
	M3([4218 4303 4556 4641 4726 4811 4896 4981 5066 5151 5236 5321 5406]) = M2(1123);
	M3([4231 4316 4401 4570 4655 4740 4825 4910 4995 5080 5165 5250 5335 5420]) = M2(1124);
	M3([4245 4330 4415 4500 4585 4670 4755 4840 4925 5010 5095 5180 5265 5350 5435]) = M2(1125);
	M3([8905 8990 9075 9160 9497]) = M2(1215);
	M3([6306 6643 6728 6813 6898 6983 7068 7657 7742 7827 7912 8249]) = M2(1222);
	M3([6318 6403 6656 6741 6826 6911 6996 7081 7670 7755 7840 7925 8262]) = M2(1223);
	M3([6331 6416 6501 6670 6755 6840 6925 7010 7095 7684 7769 7854 7939 8276]) = M2(1224);
	M3([6345 6430 6515 6600 6685 6770 6855 6940 7025 7110 7699 7784 7869 7954 8291]) = M2(1225);
	M3([9661 9746 9831 9916 10001]) = M2(1265);
	M3([8406 8743 8828 8913 8998 9083 9168 9253 9338 9423 9508 9593]) = M2(1272);
	M3([8418 8503 8756 8841 8926 9011 9096 9181 9266 9351 9436 9521 9606]) = M2(1273);
	M3([8431 8516 8601 8770 8855 8940 9025 9110 9195 9280 9365 9450 9535 9620]) = M2(1274);
	M3([8445 8530 8615 8700 8785 8870 8955 9040 9125 9210 9295 9380 9465 9550 9635]) = M2(1275);
	M3 = qrdec(M3);

	M = zeros(62, 78);
	M(16:62, [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78]) = M3([11 12 13 14 15 21 22 23 24 25 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 64 65 66 70 71 72 73 74 75 76 77 78 79 83 84], [11 12 13 14 15 21 22 23 24 25 36 37 38 39 40 41 42 43 44 45 46 47 51 52 53 54 55 56 57 58 59 61 62 63 64 65 73 74 75 79 80 81 82 83 84 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121]);
	M([993 1056 1181 1740]) = M3(7723);
	M([1055 1118 1243 1802]) = M3(7807);
	M([1179 1242 1305 1864]) = M3(7891);
	M([1737 1800 1863 2112]) = M3(8311);
	M([5 68 193 318 381 506 693 756 881 1254 1627]) = M3(8820);
	M([2233 2296 2359 3104]) = M3(8899);
	M([129 192 255 442 505 568 817 880 943 1316 1689]) = M3(8904);
	M([2605 2668 2731 3352]) = M3(9235);
	M([2791 2854 2979 3414]) = M3(9319);
	M([625 688 813 1000 1063 1188 1375 1438 1563 1750 1937]) = M3(9324);
	M([2853 2916 3041 3476]) = M3(9403);
	M([687 750 875 1062 1125 1250 1437 1500 1625 1812 1999]) = M3(9408);
	M([2977 3040 3103 3538]) = M3(9487);
	M([811 874 937 1186 1249 1312 1561 1624 1687 1874 2061]) = M3(9492);
	M([3411 3474 3537 3662]) = M3(9655);
	M([1555 1618 1681 1744 1807 1870 1933 1996 2059 2122 2185]) = M3(9660);
	M([3907 3970 4033 4344]) = M3(9991);
	M([2423 2486 2549 2612 2675 2738 3173 3236 3299 3362 3611]) = M3(9996);
	M([4465 4528 4591 4716]) = M3(10159);
	M([3725 3788 3851 3914 3977 4040 4165 4228 4291 4354 4417]) = M3(10164);
	M = qrdec(M);

	A = zeros(16);
	amcols = [78 77 76 75 74 73 72 71 70 69 68 67 66 65 64 63];
	A(1, 4) = 1;
	A(2, 9) = 1;
	A(3, 13) = 1;
	A(4, 16) = 1;
	A(5, :) = -M(62, amcols);
	A(6, :) = -M(61, amcols);
	A(7, :) = -M(58, amcols);
	A(8, :) = -M(54, amcols);
	A(9, :) = -M(51, amcols);
	A(10, :) = -M(50, amcols);
	A(11, :) = -M(49, amcols);
	A(12, :) = -M(45, amcols);
	A(13, :) = -M(42, amcols);
	A(14, :) = -M(41, amcols);
	A(15, :) = -M(40, amcols);
	A(16, :) = -M(39, amcols);

	[V D] = eig(A);
	sol =  V([6, 5, 4, 3, 2],:)./(ones(5, 1)*V(1,:));

	if (find(isnan(sol(:))) > 0)
		
		c = zeros(1, 0);
		d = zeros(1, 0);
		a = zeros(1, 0);
		e = zeros(1, 0);
		b = zeros(1, 0);
	else
		
		I = find(not(imag( sol(1,:) )));
		c = sol(1,I);
		d = sol(2,I);
		a = sol(3,I);
		e = sol(4,I);
		b = sol(5,I);
	end
end
