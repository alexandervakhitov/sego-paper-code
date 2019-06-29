function [projs, lprojs, vis_p, vis_l] = generate_case(case_num, projs_full, lprojs_full, ci1, ci2)
    if (case_num == 1)
        vis_p = zeros(2, 4);
        vis_p(1, 1:3) = 1;
        vis_p(2, 1:2) = 1;
        vis_p(2, ci1+2) = 1;

        vis_l = zeros(1, 4);
        vis_l(1, 3:4) = 1;
        vis_l(1, ci2) = 1;
    end
    if (case_num == 2)
        vis_p = zeros(2, 4);
        vis_p(1, 1:3) = 1;
        vis_p(2, 3:4) = 1;
        vis_p(2, ci1) = 1;

        vis_l = zeros(1, 4);
        vis_l(1, 1:2) = 1;
        vis_l(1, ci2+2) = 1;                
    end
    if (case_num == 3)
        vis_p = zeros(3, 4);
        vis_p(1, 1:3) = 1;

        vis_p(2, [1 2 ci1+2]) = 1;        
        vis_p(3, [ci2 3 4]) = 1;


        vis_l = zeros(0, 4);
    end

    if (case_num == 4)
        vis_p = zeros(1, 4);
        vis_p(1, 1:3) = 1;

        vis_l = zeros(2, 4);
        vis_l(1, 3:4) = 1;
        vis_l(1, ci1) = 1;
        vis_l(2, 3:4) = 1;
        vis_l(2, ci2) = 1;
    end

    if (case_num == 5)
        vis_p = [1 1 1 0];

        vis_l = zeros(2, 4);
        vis_l(1, [1 2 ci1+2]) = 1;                
        vis_l(2, [ci2 3 4]) = 1;
    end

    if (case_num == 6)
        vis_l = zeros(3, 4);
        vis_l(1, 1:3) = 1;
        vis_l(2, [1 2 ci1+2]) = 1;
        vis_l(3, [3 4 ci2]) = 1;
        vis_p = zeros(0, 4);
    end
    if (case_num == 7)
        vis_l = zeros(0, 4);               
        vis_p = zeros(3, 4);
        vis_p(1:3, 1:2) = 1;
        vis_p(1, 3) = 1;                
        vis_p(2, ci1+2) = 1;
        vis_p(3, ci2+2) = 1;
    end

    if (case_num == 8)
        vis_l = zeros(1, 4);               
        vis_p = zeros(2, 4);
        vis_p(1:2, 1:2) = 1;
        vis_p(1, 3) = 1;                
        vis_p(2, ci1+2) = 1;

        vis_l(1, 1:2) = 1;
        vis_l(1, ci2+2) = 1;
    end

    if (case_num == 9)
        vis_l = zeros(2, 4);               
        vis_p = zeros(1, 4);
        vis_p(1, 1:3) = 1;                              

        vis_l(1:2, 1:2) = 1;
        vis_l(1, ci1+2) = 1;
        vis_l(2, ci2+2) = 1;
    end    

    if (case_num == 10)
        vis_l = zeros(3, 4);
        vis_l(1, 1:3) = 1;
        vis_l(2, [1 2 ci1+2]) = 1;
        vis_l(3, [1 2 ci2+2]) = 1;
        vis_p = zeros(0, 4);
    end    
    

    [projs, lprojs] = model.clean_projs(projs_full, vis_p, lprojs_full, vis_l);

    for ci = 1:4
        for li = 1:size(lprojs, 2)
            if (vis_l(li, ci) == 1)
                v = lprojs(:, li, ci);
                lprojs(:, li, ci) = v / norm(v(1:2));

            end
        end
    end
end