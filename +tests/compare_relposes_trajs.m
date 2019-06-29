function compare_relposes_trajs
    Xso = textread('/home/alexander/orb_track_log_4');
    Xs = textread('/home/alexander/orb_track_log');
    Xsof = textread('/home/alexander/orb_track_after_log_4');
    Xsf = textread('/home/alexander/orb_track_after_log');        
    Xg = textread('/home/alexander/materials/sego/kitti_odometry/dataset/poses/01.txt');
    X1 = textread('/home/alexander/oo_tracklog');
    X1f = textread('/home/alexander/oo_tracklog_after');
    
    Tg = extract_Ts(Xg);
    T1 = extract_Ts(X1);
    Ts = extract_Ts(Xs);
    Tso = extract_Ts(Xso);
    Tsf = extract_Ts(Xsf);
    Tsof = extract_Ts(Xsof);
    T1f = extract_Ts(X1f);
    Tg_12s = [];
    for i=2:size(Xg, 1)
        T12 = [Tg(:,:,i); 0 0 0 1]\[Tg(:,:,i-1); 0 0 0 1];
        Tg_12s(:,:,i-1) = T12(1:3, 1:4);
    end
    
    [errs, gi] = compute_errs(Ts, Tg_12s);
    [errso, gi] = compute_errs(Tso, Tg_12s);
    [errsf, gisf] = compute_errs(Tsf, Tg_12s);
    [errsof, gisof] = compute_errs(Tsof, Tg_12s);
    [err1f, gi1f] = compute_errs(T1f, Tg_12s);
    [err1, gi1] = compute_errs(T1, Tg_12s);
%     d = errs(gisf,:)-errso(gisf,:);
%     d = d(gi, :);
%     figure(1);
%     plot(d(:,1));
%     figure(2);
%     plot(d(:,2));
    
%     median(d(:,1))
%     median(d(:,2))
%     median(errs(gisf,:))
    [median(errs(gisf,:)) median(errsf(gisf,:))]
    [median(errso(gisf,:)) median(errsof(gisf,:))]
    [median(err1(gisf,:)) median(err1f(gisf,:))]
    
    
end

function [errs, gi] = compute_errs(Ts, T_gts)
    errs = [];
    gi = [];
    for i = 1:size(Ts, 3)
        errs(i, 1:2) = -1;
        if(norm(Ts(:,:,i)) > 0)
%             Ts(:,:,i)
%             T_gts(:,:,i)
%             i
            y = util.cal_pose_err(Ts(:,:,i), T_gts(:,:,i));
            errs(i,:) = y;
            gi = [gi i];
        end
    end
end

function Ts = extract_Ts(X)    
    for i = 1:size(X, 1)
        d = X(i, :);
        T = reshape(d, 4, 3)';
        Ts(:,:,i) = T;
    end    
end
