M = [ 0.765809,0.178473,2.94314,-0.634874,-0.147958,-2.43993,0.0259236,0.00604153,0.0996289,0.00892807,-0.0075079,-0.00186782,0.0179968,-0.0151341,-0.00376506,0.177001,-0.148846,-0.03703;
			0.765809,0.178473,2.94314,-0.640852,-0.149351,-2.4629,-0.0382843,-0.0089222,-0.147133,0.0239089,-0.0201058,-0.00500192,0.0179968,-0.0151341,-0.00376506,0.177001,-0.148846,-0.03703;
			0.0277949,0.362746,-1.32815,0,-0.513564,1.57533,0,0,0.580371,0,-0.0278057,0.102149,0,0.0109365,-0.035808,0,0,-0.0160498;
			-0.540042,-0.321204,4.77216,0,0.99337,-4.31982,0,0,-0.738041,0.0278057,-0.0109365,-0.16179,0,0,0.0619165,0,0,0.0247344];

% % [A, pt_shift] = model.eq_generator_plu_real(projs(1:2,:,:), lprojs, vis_p, vis_l);
%             if (length(A) == 0)
%                 R_ans = [];
%                 t_ans = [];
%                 return;
%             end
            R2Q = zeros(9, 10);
            R2Q(1, [7 8 9 10]) = [1 1 -1 -1];
            R2Q(2, [4 3]) = 2;
            R2Q(3, [5, 2]) = [2, -2];
            R2Q(4, [4 3]) = [2, -2];
            R2Q(5, [7 8 9 10]) = [1, -1, 1, -1];
            R2Q(6, [6, 1]) = 2;
            R2Q(7, [5 2]) = 2;
            R2Q(8, [6 1]) = [2, -2];
            R2Q(9, [7 8 9 10]) = [1, -1, -1, 1];
            M1 = M(:, 1:9)*R2Q;
            M2 = M(:, 10:18)*R2Q;            
%             t0 = tic;
            sols = polyslv.solver_pluecker(M1, M2);%, bt/at,ct/at,dt/at);        