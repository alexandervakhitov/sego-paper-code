function [R_ans, t_ans] = correct_changed_cams(changed_views , changed_cams, R_ans, t_ans)
    if (changed_views == 1)
        T = diag([-1 -1 1]);
        for i = 1:size(t_ans, 2)
            Ri = eye(3);
            if (length(size(R_ans)) > 2)
                Ri = R_ans(:, :, i);
            else
                Ri = R_ans(3*i-2:3*i, :);
            end
            ti = t_ans(:, i);
            
            R4 = T*Ri*T;
            if (length(size(R_ans)) > 2)
                R_ans(:, :, i) = R4;
            else
                R_ans(3*i-2:3*i, :) = R4;
            end
            t4 = T*ti;
            t_ans(:, i) = R4*[1;0;0]+t4-[1;0;0];
        end
    end
    if (changed_cams == 1)        
        for i = 1:size(t_ans, 2)
            Ri = eye(3);
            if (length(size(R_ans)) > 2)
                Ri = R_ans(:,:,i);
                R_ans(:,:,i) = Ri';
            else
                Ri = R_ans(3*i-2:3*i, :);
                R_ans(3*i-2:3*i, :) = Ri';
            end
            ti = t_ans(:, i);                        
            t_ans(:, i) = -Ri'*ti;
        end
        
    end
end