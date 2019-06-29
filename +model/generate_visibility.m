function [vis_p, vis_l] = generate_visibility(case_num)
    vis_p = [];
    vis_l = [];
    if (case_num == 1)
        vis_p = zeros(2, 4);
        vis_p(1, 1:3) = 1;
        vis_p(2, 1:2) = 1;
        vis_p(2, 2+2) = 1;

        vis_l = zeros(1, 4);
        vis_l(1, 3:4) = 1;
        vis_l(1, 2) = 1;
    end
    if (case_num == 2)
        vis_p = zeros(2, 4);
        vis_p(1, 1:3) = 1;
        vis_p(2, 3:4) = 1;
        vis_p(2, 2) = 1;

        vis_l = zeros(1, 4);
        vis_l(1, 1:2) = 1;
        vis_l(1, 4) = 1;
    end
    if (case_num == 3)
        vis_p = zeros(3, 4);
        vis_p(1, 1:3) = 1;
        vis_p(2, [1 2 4]) = 1;        
        vis_p(3, [2 3 4]) = 1;

        vis_l = zeros(0, 4);
    end

    if (case_num == 4)
        vis_p = [1 1 1 0];
        
        vis_l = zeros(2, 4);
        vis_l(1:2, 2:4) = 1;        
    end
    
    if (case_num == 5)
        vis_p = [1 1 1 0];
        
        vis_l = zeros(2, 4);
        vis_l(1, [1 2 4]) = 1;                
        vis_l(2, [2 3 4]) = 1;
    end
    
    if (case_num == 6)
        vis_l = zeros(3, 4);        
        vis_l(1, [1 2 4]) = 1;                
        vis_l(2, [2 3 4]) = 1;
        vis_l(3, [1 2 4]) = 1;                
    end
    
    if (case_num == 7)
        vis_l = zeros(0, 4);               
        vis_p = [1 1 1 0; 1 1 0 1; 1 1 0 1];                
    end
    
    if (case_num == 8)
        vis_l = [1 1 0 1];               
        vis_p = [1 1 1 0; 1 1 0 1];                
    end    
    
    if (case_num == 9)
        vis_l = zeros(2, 4);
        vis_p = zeros(1, 4);
        vis_p(1, 1:3) = 1;

        vis_l(1:2, 1:2) = 1;
        vis_l(1, 4) = 1;
        vis_l(2, 3) = 1;
    end          
end