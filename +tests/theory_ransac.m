function theory_ransac
    vpf = [3; 3; 4];    
    wmps = [0.0:0.05:0.4];    
    succ_rate = [0.85; 1; 1];
    for wmpi = 1:length(wmps)
        wmp = wmps(wmpi);
        for mi = 1:length(vpf)
            p = (1-wmp)^(vpf(mi)-1);
            p = p^3*succ_rate(mi);%3 features
            p_wrong = 1-p;
            X(mi, wmpi) = log (0.01) / log(p_wrong);
        end
    end
    save('theory1.mat');
end