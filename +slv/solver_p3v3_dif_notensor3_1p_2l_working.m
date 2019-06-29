% Generated using GBSolver generator Copyright Martin Bujnak,
% Zuzana Kukelova, Tomas Pajdla CTU Prague 2008.
% 
% Please refer to the following paper, when using this code :
%     Kukelova Z., Bujnak M., Pajdla T., Automatic Generator of Minimal Problem Solvers,
%     ECCV 2008, Marseille, France, October 12-18, 2008

function [b, c, d, a, e] = solver_p3v3_dif_notensor3_1p_2l(A_11, B_11)

	% precalculate polynomial equations coefficients
    c = zeros(89, 1);
	c(1) = 2*A_11(29) + 2*A_11(33);
	c(2) = 2*A_11(23) + 2*A_11(31);
	c(3) = 2*A_11(21) + 2*A_11(25);
	c(4) = 2*A_11(21) - 2*A_11(25);
	c(5) = 2*A_11(31) - 2*A_11(23);
	c(6) = 2*A_11(29) - 2*A_11(33);
	c(7) = A_11(17) - A_11(9) - A_11(1);
	c(8) = A_11(9) - A_11(1) - A_11(17);
	c(9) = A_11(1) - A_11(9) - A_11(17);
	c(10) = A_11(1) + A_11(9) + A_11(17);
	c(11) = A_11(35) - A_11(27) - A_11(19);
	c(12) = A_11(27) - A_11(19) - A_11(35);
	c(13) = A_11(19) - A_11(27) - A_11(35);
	c(14) = A_11(19) + A_11(27) + A_11(35);
	c(15) = 2*A_11(11) + 2*A_11(15);
	c(16) = 2*A_11(5) + 2*A_11(13);
	c(17) = 2*A_11(3) + 2*A_11(7);
	c(18) = 2*A_11(3) - 2*A_11(7);
	c(19) = 2*A_11(13) - 2*A_11(5);
	c(20) = 2*A_11(11) - 2*A_11(15);
	c(21) = A_11(37);
	c(22) = 2*A_11(30) + 2*A_11(34);
	c(23) = 2*A_11(24) + 2*A_11(32);
	c(24) = 2*A_11(22) + 2*A_11(26);
	c(25) = 2*A_11(22) - 2*A_11(26);
	c(26) = 2*A_11(32) - 2*A_11(24);
	c(27) = 2*A_11(30) - 2*A_11(34);
	c(28) = A_11(18) - A_11(10) - A_11(2);
	c(29) = A_11(10) - A_11(2) - A_11(18);
	c(30) = A_11(2) - A_11(10) - A_11(18);
	c(31) = A_11(2) + A_11(10) + A_11(18);
	c(32) = A_11(36) - A_11(28) - A_11(20);
	c(33) = A_11(28) - A_11(20) - A_11(36);
	c(34) = A_11(20) - A_11(28) - A_11(36);
	c(35) = A_11(20) + A_11(28) + A_11(36);
	c(36) = 2*A_11(12) + 2*A_11(16);
	c(37) = 2*A_11(6) + 2*A_11(14);
	c(38) = 2*A_11(4) + 2*A_11(8);
	c(39) = 2*A_11(4) - 2*A_11(8);
	c(40) = 2*A_11(14) - 2*A_11(6);
	c(41) = 2*A_11(12) - 2*A_11(16);
	c(42) = A_11(38);
	c(43) = 2*B_11(29) + 2*B_11(33);
	c(44) = 2*B_11(23) + 2*B_11(31);
	c(45) = 2*B_11(21) + 2*B_11(25);
	c(46) = 2*B_11(21) - 2*B_11(25);
	c(47) = 2*B_11(31) - 2*B_11(23);
	c(48) = 2*B_11(29) - 2*B_11(33);
	c(49) = B_11(17) - B_11(9) - B_11(1);
	c(50) = B_11(9) - B_11(1) - B_11(17);
	c(51) = B_11(1) - B_11(9) - B_11(17);
	c(52) = B_11(1) + B_11(9) + B_11(17);
	c(53) = B_11(35) - B_11(27) - B_11(19);
	c(54) = B_11(27) - B_11(19) - B_11(35);
	c(55) = B_11(19) - B_11(27) - B_11(35);
	c(56) = B_11(19) + B_11(27) + B_11(35);
	c(57) = 2*B_11(11) + 2*B_11(15);
	c(58) = 2*B_11(5) + 2*B_11(13);
	c(59) = 2*B_11(3) + 2*B_11(7);
	c(60) = 2*B_11(3) - 2*B_11(7);
	c(61) = 2*B_11(13) - 2*B_11(5);
	c(62) = 2*B_11(11) - 2*B_11(15);
	c(63) = B_11(37);
	c(64) = 2*B_11(30) + 2*B_11(34);
	c(65) = 2*B_11(24) + 2*B_11(32);
	c(66) = 2*B_11(22) + 2*B_11(26);
	c(67) = 2*B_11(22) - 2*B_11(26);
	c(68) = 2*B_11(32) - 2*B_11(24);
	c(69) = 2*B_11(30) - 2*B_11(34);
	c(70) = B_11(18) - B_11(10) - B_11(2);
	c(71) = B_11(10) - B_11(2) - B_11(18);
	c(72) = B_11(2) - B_11(10) - B_11(18);
	c(73) = B_11(2) + B_11(10) + B_11(18);
	c(74) = B_11(36) - B_11(28) - B_11(20);
	c(75) = B_11(28) - B_11(20) - B_11(36);
	c(76) = B_11(20) - B_11(28) - B_11(36);
	c(77) = B_11(20) + B_11(28) + B_11(36);
	c(78) = 2*B_11(12) + 2*B_11(16);
	c(79) = 2*B_11(6) + 2*B_11(14);
	c(80) = 2*B_11(4) + 2*B_11(8);
	c(81) = 2*B_11(4) - 2*B_11(8);
	c(82) = 2*B_11(14) - 2*B_11(6);
	c(83) = 2*B_11(12) - 2*B_11(16);
	c(84) = B_11(38);
	c(85) = 1;
	c(86) = 1;
	c(87) = 1;
	c(88) = 1;
	c(89) = -1;

	M1 = zeros(10, 42);
	M1(206) = c(1);
	M1(196) = c(2);
	M1(176) = c(3);
	M1(246) = c(4);
	M1(236) = c(5);
	M1(226) = c(6);
	M1(316) = c(7);
	M1(286) = c(8);
	M1(266) = c(9);
	M1(356) = c(10);
	M1(216) = c(11);
	M1(186) = c(12);
	M1(166) = c(13);
	M1(256) = c(14);
	M1(306) = c(15);
	M1(296) = c(16);
	M1(276) = c(17);
	M1(346) = c(18);
	M1(336) = c(19);
	M1(326) = c(20);
	M1(416) = c(21);
	M1(207) = c(22);
	M1(197) = c(23);
	M1(177) = c(24);
	M1(247) = c(25);
	M1(237) = c(26);
	M1(227) = c(27);
	M1(317) = c(28);
	M1(287) = c(29);
	M1(267) = c(30);
	M1(357) = c(31);
	M1(217) = c(32);
	M1(187) = c(33);
	M1(167) = c(34);
	M1(257) = c(35);
	M1(307) = c(36);
	M1(297) = c(37);
	M1(277) = c(38);
	M1(347) = c(39);
	M1(337) = c(40);
	M1(327) = c(41);
	M1(417) = c(42);
	M1(208) = c(43);
	M1(198) = c(44);
	M1(178) = c(45);
	M1(248) = c(46);
	M1(238) = c(47);
	M1(228) = c(48);
	M1(318) = c(49);
	M1(288) = c(50);
	M1(268) = c(51);
	M1(358) = c(52);
	M1(218) = c(53);
	M1(188) = c(54);
	M1(168) = c(55);
	M1(258) = c(56);
	M1(308) = c(57);
	M1(298) = c(58);
	M1(278) = c(59);
	M1(348) = c(60);
	M1(338) = c(61);
	M1(328) = c(62);
	M1(418) = c(63);
	M1(209) = c(64);
	M1(199) = c(65);
	M1(179) = c(66);
	M1(249) = c(67);
	M1(239) = c(68);
	M1(229) = c(69);
	M1(319) = c(70);
	M1(289) = c(71);
	M1(269) = c(72);
	M1(359) = c(73);
	M1(219) = c(74);
	M1(189) = c(75);
	M1(169) = c(76);
	M1(259) = c(77);
	M1(309) = c(78);
	M1(299) = c(79);
	M1(279) = c(80);
	M1(349) = c(81);
	M1(339) = c(82);
	M1(329) = c(83);
	M1(419) = c(84);
	ci = [61, 72, 83, 114, 215, 320];
	M1(ci) = c(85);

	ci = [21, 32, 53, 104, 185, 290];
	M1(ci) = c(86);

	ci = [1, 12, 43, 94, 165, 270];
	M1(ci) = c(87);

	ci = [121, 132, 143, 154, 255, 360];
	M1(ci) = c(88);

	ci = [361, 372, 383, 394, 405, 420];
	M1(ci) = c(89);

    M1t = rref_qr(M1);
    M1 = frref(M1);
    norm(M1t-M1)
    
	M2 = zeros(20, 46);
	M2(11:20, [1 2 3 4 5 7 8 9 10 11 13 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46]) = M1(1:10, :);
	M2([21 42 103 224 425]) = M1(279);
	M2([46 67 128 249 450]) = M1(290);
	M2([81 102 143 264 465]) = M1(299);
	M2([86 107 148 269 470]) = M1(300);
	M2([101 122 163 284 485]) = M1(309);
	M2([106 127 168 289 490]) = M1(310);
	M2([141 162 183 304 505]) = M1(319);
	M2([146 167 188 309 510]) = M1(320);
	M2([201 222 263 324 525]) = M1(329);
	M2([206 227 268 329 530]) = M1(330);
	M2([221 242 283 344 545]) = M1(339);
	M2([226 247 288 349 550]) = M1(340);
	M2([261 282 303 364 565]) = M1(349);
	M2([266 287 308 369 570]) = M1(350);
	M2([321 342 363 384 585]) = M1(359);
	M2([326 347 368 389 590]) = M1(360);
	M2([801 822 843 864 885]) = M1(419);
	M2([806 827 848 869 890]) = M1(420);
    
    M2 = frref(M2);
    
	M3 = zeros(72, 116);
	M3(53:72, [66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 111 112 113 114 115 116]) = M2(1:20, :);
	M3([2809 2882 3027 3460 4181]) = M2(476);
	M3([2886 2959 3104 3537 4258]) = M2(497);
	M3([3025 3098 3171 3604 4325]) = M2(516);
	M3([3030 3103 3176 3609 4330]) = M2(517);
	M3([3241 3314 3459 3676 4397]) = M2(536);
	M3([3246 3319 3464 3681 4402]) = M2(537);
	M3([3313 3386 3531 3748 4469]) = M2(556);
	M3([3318 3391 3536 3753 4474]) = M2(557);
	M3([3457 3530 3603 3820 4541]) = M2(576);
	M3([3462 3535 3608 3825 4546]) = M2(577);
	M3([3673 3746 3819 3892 4613]) = M2(596);
	M3([3678 3751 3824 3897 4618]) = M2(597);
	M3([11 372 445 662 1095 1168 1385 1818 2539 2612 2829 3262 3983]) = M2(618);
	M3([96 169 458 531 748 1181 1254 1471 1904 2625 2698 2915 3348 4069]) = M2(639);
	M3([182 255 328 545 618 835 1268 1341 1558 1991 2712 2785 3002 3435 4156]) = M2(660);
	M3([4969 5042 5187 5620 6341]) = M2(676);
	M3([4974 5047 5192 5625 6346]) = M2(677);
	M3([371 660 733 878 1383 1456 1601 2034 2827 2900 3045 3478 4199]) = M2(678);
	M3([384 457 674 747 892 1397 1470 1615 2048 2841 2914 3059 3492 4213]) = M2(679);
	M3([398 471 544 689 762 907 1412 1485 1630 2063 2856 2929 3074 3507 4228]) = M2(680);
	M3([5041 5114 5259 5692 6413]) = M2(696);
	M3([5046 5119 5264 5697 6418]) = M2(697);
	M3([443 732 805 950 1455 1528 1673 2106 2899 2972 3117 3550 4271]) = M2(698);
	M3([456 529 746 819 964 1469 1542 1687 2120 2913 2986 3131 3564 4285]) = M2(699);
	M3([470 543 616 761 834 979 1484 1557 1702 2135 2928 3001 3146 3579 4300]) = M2(700);
	M3([5185 5258 5331 5764 6485]) = M2(716);
	M3([5190 5263 5336 5769 6490]) = M2(717);
	M3([659 876 949 1022 1599 1672 1745 2178 3043 3116 3189 3622 4343]) = M2(718);
	M3([672 745 890 963 1036 1613 1686 1759 2192 3057 3130 3203 3636 4357]) = M2(719);
	M3([686 759 832 905 978 1051 1628 1701 1774 2207 3072 3145 3218 3651 4372]) = M2(720);
	M3([5401 5474 5619 5836 6557]) = M2(736);
	M3([5406 5479 5624 5841 6562]) = M2(737);
	M3([1091 1380 1453 1598 1815 1888 2033 2250 3259 3332 3477 3694 4415]) = M2(738);
	M3([1104 1177 1394 1467 1612 1829 1902 2047 2264 3273 3346 3491 3708 4429]) = M2(739);
	M3([1118 1191 1264 1409 1482 1627 1844 1917 2062 2279 3288 3361 3506 3723 4444]) = M2(740);
	M3([5473 5546 5691 5908 6629]) = M2(756);
	M3([5478 5551 5696 5913 6634]) = M2(757);
	M3([1163 1452 1525 1670 1887 1960 2105 2322 3331 3404 3549 3766 4487]) = M2(758);
	M3([1176 1249 1466 1539 1684 1901 1974 2119 2336 3345 3418 3563 3780 4501]) = M2(759);
	M3([1190 1263 1336 1481 1554 1699 1916 1989 2134 2351 3360 3433 3578 3795 4516]) = M2(760);
	M3([5617 5690 5763 5980 6701]) = M2(776);
	M3([5622 5695 5768 5985 6706]) = M2(777);
	M3([1379 1596 1669 1742 2031 2104 2177 2394 3475 3548 3621 3838 4559]) = M2(778);
	M3([1392 1465 1610 1683 1756 2045 2118 2191 2408 3489 3562 3635 3852 4573]) = M2(779);
	M3([1406 1479 1552 1625 1698 1771 2060 2133 2206 2423 3504 3577 3650 3867 4588]) = M2(780);
	M3([5833 5906 5979 6052 6773]) = M2(796);
	M3([5838 5911 5984 6057 6778]) = M2(797);
	M3([1811 2028 2101 2174 2247 2320 2393 2466 3691 3764 3837 3910 4631]) = M2(798);
	M3([1824 1897 2042 2115 2188 2261 2334 2407 2480 3705 3778 3851 3924 4645]) = M2(799);
	M3([1838 1911 1984 2057 2130 2203 2276 2349 2422 2495 3720 3793 3866 3939 4660]) = M2(800);
	M3([7561 7634 7707 7780 7853]) = M2(896);
	M3([7566 7639 7712 7785 7858]) = M2(897);
	M3([7921 7994 8067 8140 8213]) = M2(916);
	M3([7926 7999 8072 8145 8218]) = M2(917);
	M3([6851 7068 7141 7214 7287 7360 7433 7506 7579 7652 7725 7798 7871]) = M2(918);
	M3([6864 6937 7082 7155 7228 7301 7374 7447 7520 7593 7666 7739 7812 7885]) = M2(919);
	M3([6878 6951 7024 7097 7170 7243 7316 7389 7462 7535 7608 7681 7754 7827 7900]) = M2(920);
    
    M3 = frref(M3);
    
	M4 = zeros(186, 242);
	M4(115:186, [122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242]) = M3(1:72, :);
	M4([12091 12278 12651 13954 14141 14514 15631 17678 17865 18238 19355 21216]) = M3(6404);
	M4([12289 12476 12849 14152 14339 14712 15829 17876 18063 18436 19553 21414]) = M3(6477);
	M4([12649 12836 13023 14512 14699 14886 16003 18236 18423 18610 19727 21588]) = M3(6548);
	M4([12661 12848 13035 14524 14711 14898 16015 18248 18435 18622 19739 21600]) = M3(6549);
	M4([13951 14138 14511 15070 15257 15630 16189 18794 18981 19354 19913 21774]) = M3(6620);
	M4([13963 14150 14523 15082 15269 15642 16201 18806 18993 19366 19925 21786]) = M3(6621);
	M4([14137 14324 14697 15256 15443 15816 16375 18980 19167 19540 20099 21960]) = M3(6692);
	M4([14149 14336 14709 15268 15455 15828 16387 18992 19179 19552 20111 21972]) = M3(6693);
	M4([14509 14696 14883 15628 15815 16002 16561 19352 19539 19726 20285 22146]) = M3(6764);
	M4([14521 14708 14895 15640 15827 16014 16573 19364 19551 19738 20297 22158]) = M3(6765);
	M4([15625 15812 15999 16186 16373 16560 16747 19910 20097 20284 20471 22332]) = M3(6836);
	M4([15637 15824 16011 16198 16385 16572 16759 19922 20109 20296 20483 22344]) = M3(6837);
	M4([25 2072 2259 2818 3935 4866 5053 5612 6729 6916 7475 8592 10453 11384 11571 12130 13247 13434 13993 15110 16971 17158 17717 18834 20695]) = M3(6910);
	M4([236 423 1354 1541 2286 2473 3032 4149 4336 5081 5268 5827 6944 7131 7690 8807 10668 10855 11600 11787 12346 13463 13650 14209 15326 17187 17374 17933 19050 20911]) = M3(6983);
	M4([452 639 826 1013 1572 1759 1946 2505 2692 3251 4368 4555 4742 5301 5488 6047 7164 7351 7910 9027 10888 11075 11262 11821 12008 12567 13684 13871 14430 15547 17408 17595 18154 19271 21132]) = M3(7056);
	M4([24181 24368 24741 26044 26231 26604 27721 29768 29955 30328 31445 33306]) = M3(7124);
	M4([24193 24380 24753 26056 26243 26616 27733 29780 29967 30340 31457 33318]) = M3(7125);
	M4([1141 2816 3003 3376 4865 5610 5797 6170 7473 7660 8033 9150 11383 12128 12315 12688 13991 14178 14551 15668 17715 17902 18275 19392 21253]) = M3(7126);
	M4([1166 1353 2098 2285 2844 3031 3404 4893 5080 5639 5826 6199 7502 7689 8062 9179 11412 11599 12158 12345 12718 14021 14208 14581 15698 17745 17932 18305 19422 21283]) = M3(7127);
	M4([1196 1383 1570 1757 2130 2317 2504 2877 3064 3437 4926 5113 5300 5673 5860 6233 7536 7723 8096 9213 11446 11633 11820 12193 12380 12753 14056 14243 14616 15733 17780 17967 18340 19457 21318]) = M3(7128);
	M4([24367 24554 24927 26230 26417 26790 27907 29954 30141 30514 31631 33492]) = M3(7196);
	M4([24379 24566 24939 26242 26429 26802 27919 29966 30153 30526 31643 33504]) = M3(7197);
	M4([1327 3002 3189 3562 5051 5796 5983 6356 7659 7846 8219 9336 11569 12314 12501 12874 14177 14364 14737 15854 17901 18088 18461 19578 21439]) = M3(7198);
	M4([1352 1539 2284 2471 3030 3217 3590 5079 5266 5825 6012 6385 7688 7875 8248 9365 11598 11785 12344 12531 12904 14207 14394 14767 15884 17931 18118 18491 19608 21469]) = M3(7199);
	M4([1382 1569 1756 1943 2316 2503 2690 3063 3250 3623 5112 5299 5486 5859 6046 6419 7722 7909 8282 9399 11632 11819 12006 12379 12566 12939 14242 14429 14802 15919 17966 18153 18526 19643 21504]) = M3(7200);
	M4([24739 24926 25113 26602 26789 26976 28093 30326 30513 30700 31817 33678]) = M3(7268);
	M4([24751 24938 25125 26614 26801 26988 28105 30338 30525 30712 31829 33690]) = M3(7269);
	M4([2071 3374 3561 3748 5609 6168 6355 6542 8031 8218 8405 9522 12127 12686 12873 13060 14549 14736 14923 16040 18273 18460 18647 19764 21625]) = M3(7270);
	M4([2096 2283 2842 3029 3402 3589 3776 5637 5824 6197 6384 6571 8060 8247 8434 9551 12156 12343 12716 12903 13090 14579 14766 14953 16070 18303 18490 18677 19794 21655]) = M3(7271);
	M4([2126 2313 2500 2687 2874 3061 3248 3435 3622 3809 5670 5857 6044 6231 6418 6605 8094 8281 8468 9585 12190 12377 12564 12751 12938 13125 14614 14801 14988 16105 18338 18525 18712 19829 21690]) = M3(7272);
	M4([26041 26228 26601 27160 27347 27720 28279 30884 31071 31444 32003 33864]) = M3(7340);
	M4([26053 26240 26613 27172 27359 27732 28291 30896 31083 31456 32015 33876]) = M3(7341);
	M4([3931 5606 5793 6166 6725 7470 7657 8030 8589 8776 9149 9708 13243 13988 14175 14548 15107 15294 15667 16226 18831 19018 19391 19950 21811]) = M3(7342);
	M4([3956 4143 4888 5075 5634 5821 6194 6753 6940 7499 7686 8059 8618 8805 9178 9737 13272 13459 14018 14205 14578 15137 15324 15697 16256 18861 19048 19421 19980 21841]) = M3(7343);
	M4([3986 4173 4360 4547 4920 5107 5294 5667 5854 6227 6786 6973 7160 7533 7720 8093 8652 8839 9212 9771 13306 13493 13680 14053 14240 14613 15172 15359 15732 16291 18896 19083 19456 20015 21876]) = M3(7344);
	M4([26227 26414 26787 27346 27533 27906 28465 31070 31257 31630 32189 34050]) = M3(7412);
	M4([26239 26426 26799 27358 27545 27918 28477 31082 31269 31642 32201 34062]) = M3(7413);
	M4([4117 5792 5979 6352 6911 7656 7843 8216 8775 8962 9335 9894 13429 14174 14361 14734 15293 15480 15853 16412 19017 19204 19577 20136 21997]) = M3(7414);
	M4([4142 4329 5074 5261 5820 6007 6380 6939 7126 7685 7872 8245 8804 8991 9364 9923 13458 13645 14204 14391 14764 15323 15510 15883 16442 19047 19234 19607 20166 22027]) = M3(7415);
	M4([4172 4359 4546 4733 5106 5293 5480 5853 6040 6413 6972 7159 7346 7719 7906 8279 8838 9025 9398 9957 13492 13679 13866 14239 14426 14799 15358 15545 15918 16477 19082 19269 19642 20201 22062]) = M3(7416);
	M4([26599 26786 26973 27718 27905 28092 28651 31442 31629 31816 32375 34236]) = M3(7484);
	M4([26611 26798 26985 27730 27917 28104 28663 31454 31641 31828 32387 34248]) = M3(7485);
	M4([4861 6164 6351 6538 7469 8028 8215 8402 9147 9334 9521 10080 13987 14546 14733 14920 15665 15852 16039 16598 19389 19576 19763 20322 22183]) = M3(7486);
	M4([4886 5073 5632 5819 6192 6379 6566 7497 7684 8057 8244 8431 9176 9363 9550 10109 14016 14203 14576 14763 14950 15695 15882 16069 16628 19419 19606 19793 20352 22213]) = M3(7487);
	M4([4916 5103 5290 5477 5664 5851 6038 6225 6412 6599 7530 7717 7904 8091 8278 8465 9210 9397 9584 10143 14050 14237 14424 14611 14798 14985 15730 15917 16104 16663 19454 19641 19828 20387 22248]) = M3(7488);
	M4([27715 27902 28089 28276 28463 28650 28837 32000 32187 32374 32561 34422]) = M3(7556);
	M4([27727 27914 28101 28288 28475 28662 28849 32012 32199 32386 32573 34434]) = M3(7557);
	M4([6721 8024 8211 8398 8585 9144 9331 9518 9705 9892 10079 10266 15103 15662 15849 16036 16223 16410 16597 16784 19947 20134 20321 20508 22369]) = M3(7558);
	M4([6746 6933 7492 7679 8052 8239 8426 8613 8800 9173 9360 9547 9734 9921 10108 10295 15132 15319 15692 15879 16066 16253 16440 16627 16814 19977 20164 20351 20538 22399]) = M3(7559);
	M4([6776 6963 7150 7337 7524 7711 7898 8085 8272 8459 8646 8833 9020 9207 9394 9581 9768 9955 10142 10329 15166 15353 15540 15727 15914 16101 16288 16475 16662 16849 20012 20199 20386 20573 22434]) = M3(7560);
	M4([38875 39062 39249 39436 39623 39810 39997 40184 40371 40558 40745 40932]) = M3(8276);
	M4([38887 39074 39261 39448 39635 39822 40009 40196 40383 40570 40757 40944]) = M3(8277);
	M4([41665 41852 42039 42226 42413 42600 42787 42974 43161 43348 43535 43722]) = M3(8348);
	M4([41677 41864 42051 42238 42425 42612 42799 42986 43173 43360 43547 43734]) = M3(8349);
	M4([34621 35924 36111 36298 36485 37044 37231 37418 37605 37792 37979 38166 38353 38912 39099 39286 39473 39660 39847 40034 40221 40408 40595 40782 40969]) = M3(8350);
	M4([34646 34833 35392 35579 35952 36139 36326 36513 36700 37073 37260 37447 37634 37821 38008 38195 38382 38569 38942 39129 39316 39503 39690 39877 40064 40251 40438 40625 40812 40999]) = M3(8351);
	M4([34676 34863 35050 35237 35424 35611 35798 35985 36172 36359 36546 36733 36920 37107 37294 37481 37668 37855 38042 38229 38416 38603 38790 38977 39164 39351 39538 39725 39912 40099 40286 40473 40660 40847 41034]) = M3(8352);
    M4 = frref(M4);
    

	M5 = zeros(222, 242);
	M5(37:222, [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242]) = M4(1:186, :);
	M5([25309]) = M4(33453);
	M5([25532]) = M4(33640);
	M5([25753]) = M4(33825);
	M5([25754]) = M4(33826);
	M5([25975]) = M4(34011);
	M5([25976]) = M4(34012);
	M5([26197]) = M4(34197);
	M5([26198]) = M4(34198);
	M5([26419]) = M4(34383);
	M5([26420]) = M4(34384);
	M5([26641]) = M4(34569);
	M5([26642]) = M4(34570);
	M5([25755]) = M4(39424);
	M5([25978]) = M4(39611);
	M5([26201]) = M4(39798);
	M5([26424]) = M4(39985);
	M5([19987 23762 23985 24208 24431 26652]) = M4(40172);
	M5([2899 3344 3567 4012 6233 6678 6901 7346 8901 9124 9569 10902 14455 14678 15123 16678 16901 17346 18679 21122 21345 21790 23123 25344]) = M4(41850);
	M5([46621]) = M4(42009);
	M5([46622]) = M4(42010);
	M5([39963]) = M4(42028);
	M5([39964]) = M4(42029);
	M5([39965]) = M4(42030);
	M5([39966]) = M4(42031);
	M5([33307 35750 35973 36418 37751 39972]) = M4(42032);
	M5([3121 3566 3789 4234 6455 6900 7123 7568 9123 9346 9791 11124 14677 14900 15345 16900 17123 17568 18901 21344 21567 22012 23345 25566]) = M4(42036);
	M5([46843]) = M4(42195);
	M5([46844]) = M4(42196);
	M5([40185]) = M4(42214);
	M5([40186]) = M4(42215);
	M5([40187]) = M4(42216);
	M5([40188]) = M4(42217);
	M5([33529 36194 36417 36640 37973 40194]) = M4(42218);
	M5([3787 4010 4233 4456 7121 7344 7567 7790 9567 9790 10013 11346 15121 15344 15567 17344 17567 17790 19123 21788 22011 22234 23567 25788]) = M4(42222);
	M5([47065]) = M4(42381);
	M5([47066]) = M4(42382);
	M5([40407]) = M4(42400);
	M5([40408]) = M4(42401);
	M5([40409]) = M4(42402);
	M5([40410]) = M4(42403);
	M5([33751 36860 37083 37528 38195 40416]) = M4(42404);
	M5([6229 6674 6897 7342 8453 8898 9121 9566 10233 10456 10901 11568 16675 16898 17343 18010 18233 18678 19345 22454 22677 23122 23789 26010]) = M4(42408);
	M5([47287]) = M4(42567);
	M5([47288]) = M4(42568);
	M5([40629]) = M4(42586);
	M5([40630]) = M4(42587);
	M5([40631]) = M4(42588);
	M5([40632]) = M4(42589);
	M5([33973 37082 37305 37750 38417 40638]) = M4(42590);
	M5([6451 6896 7119 7564 8675 9120 9343 9788 10455 10678 11123 11790 16897 17120 17565 18232 18455 18900 19567 22676 22899 23344 24011 26232]) = M4(42594);
	M5([47509]) = M4(42753);
	M5([47510]) = M4(42754);
	M5([40851]) = M4(42772);
	M5([40852]) = M4(42773);
	M5([40853]) = M4(42774);
	M5([40854]) = M4(42775);
	M5([34195 37526 37749 37972 38639 40860]) = M4(42776);
	M5([7117 7340 7563 7786 9341 9564 9787 10010 10899 11122 11345 12012 17341 17564 17787 18676 18899 19122 19789 23120 23343 23566 24233 26454]) = M4(42780);
	M5([47731]) = M4(42939);
	M5([47732]) = M4(42940);
	M5([41073]) = M4(42958);
	M5([41074]) = M4(42959);
	M5([41075]) = M4(42960);
	M5([41076]) = M4(42961);
	M5([34417 38192 38415 38638 38861 41082]) = M4(42962);
	M5([9337 9560 9783 10006 10673 10896 11119 11342 11565 11788 12011 12234 18673 18896 19119 19342 19565 19788 20011 23786 24009 24232 24455 26676]) = M4(42966);
	M5([48841]) = M4(43869);
	M5([48842]) = M4(43870);
	M5([52171]) = M4(44799);
	M5([52172]) = M4(44800);
	M5([48843]) = M4(44818);
	M5([48844]) = M4(44819);
	M5([48845]) = M4(44820);
	M5([48846]) = M4(44821);
	M5([47737 47960 48183 48406 48629 48852]) = M4(44822);
	M5([53281]) = M4(44985);
	M5([53282]) = M4(44986);
	M5([52173]) = M4(45004);
	M5([52174]) = M4(45005);
	M5([52175]) = M4(45006);
	M5([52176]) = M4(45007);
	M5([51067 51290 51513 51736 51959 52182]) = M4(45008);
	M5([42637 42860 43083 43306 43973 44196 44419 44642 44865 45088 45311 45534 46423 46646 46869 47092 47315 47538 47761 47984 48207 48430 48653 48876]) = M4(45012);
    
    M5 = frref(M5);

	M = zeros(30, 46);
	M(5:30, [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46]) = M5([91 119 120 121 178 179 180 181 182 183 184 200 201 202 203 204 206 207 208 209 210 211 212 213 214 218], [91 119 120 121 178 179 180 181 182 183 184 185 186 202 203 204 205 206 208 209 210 211 212 213 214 215 216 220 221 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242]);
	M([1]) = M5(45714);
	M([32 63 94]) = M5(48836);
	M([271]) = M5(51486);
	M([122 183 274]) = M5(51500);
	M([301]) = M5(51708);
	M([152 213 304]) = M5(51722);
	M([331]) = M5(51930);
	M([212 243 334]) = M5(51944);
	M([361]) = M5(52152);
	M([302 333 364]) = M5(52166);
	M([691]) = M5(52596);
	M([542 603 694]) = M5(52610);
	M([721]) = M5(52818);
	M([572 633 724]) = M5(52832);
	M([751]) = M5(53040);
	M([632 663 754]) = M5(53054);
	M([781]) = M5(53262);
	M([722 753 784]) = M5(53276);
    
    M = frref(M);
    
	A = zeros(16);
	amcols = [46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31];
	A(1, 3) = 1;
	A(2, 8) = 1;
	A(3, 12) = 1;
	A(4, 13) = 1;
	A(5, 14) = 1;
	A(6, 15) = 1;
	A(7, :) = -M(28, amcols);
	A(8, :) = -M(27, amcols);
	A(9, :) = -M(26, amcols);
	A(10, :) = -M(25, amcols);
	A(11, :) = -M(24, amcols);
	A(12, :) = -M(18, amcols);
	A(13, :) = -M(17, amcols);
	A(14, :) = -M(16, amcols);
	A(15, :) = -M(15, amcols);
	A(16, :) = -M(14, amcols);

	[V D] = eig(A);
	sol =  V([6, 5, 4, 3, 2],:)./(ones(5, 1)*V(1,:));

	if (find(isnan(sol(:))) > 0)
		
		b = zeros(1, 0);
		c = zeros(1, 0);
		d = zeros(1, 0);
		a = zeros(1, 0);
		e = zeros(1, 0);
	else
		
		I = find(not(imag( sol(1,:) )));
		b = sol(1,I);
		c = sol(2,I);
		d = sol(3,I);
		a = sol(4,I);
		e = sol(5,I);
    end
end
