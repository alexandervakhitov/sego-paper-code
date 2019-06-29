function [ ind, y, Rf, tf ] = choose_best( R3, t3, R_ret, t_ret)
    ys = [];
    errs = [];
    if (size(R_ret, 1) == 0)
        Rf = [];
        tf = [];
        ind = -1;
        y = [];
        return;
    end
    for i = 1:size(t_ret, 2)
        y = [];
        R_test = [];
        if (size(R_ret, 1) > 3)
            R_test = R_ret(3*i-2:3*i, :);            
        else
            R_test = R_ret(:,:,i);                       
        end
        if (length(find(isnan(R_test(:))))>0 || length(find(isinf(R_test(:))))>0)
            Rf = [];
            tf = [];
            ind = -1;
            y = [];
            return;
        end
        [U,S,V] = svd(R_test);
        R_test = U*V';
        [y  y1]= util.cal_pose_err([R_test t_ret(:, i)],[R3 t3]);
        ys = [ys; y];
        %errs = [errs; norm(y)];
        errs = [errs; y(1)];
    end
    [v, ind] = min(errs);

    y = ys(ind, :);
    if (size(R_ret, 1) > 3)
        Rf = R_ret(3*ind-2:3*ind, :);
    else
        Rf = R_ret(:,:, ind);
    end
    tf = t_ret(:, ind);
    
end

