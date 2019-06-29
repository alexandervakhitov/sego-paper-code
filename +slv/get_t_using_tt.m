function t3est = get_t_using_tt(projs, lprojs, vis_p, vis_l, R3, tt)
    f_ind = 1;
    if (size(vis_p, 1) > 0)
        feat_type = 1;
    else
        feat_type = 2;
    end   
    fti = 1;
    
    A_full = zeros(9, 3);
    B_full = zeros(9, 1);
    while f_ind < 4
                
        if (feat_type == 1)            
            %1. find ip
            if (vis_p(fti, 3) == 0 || vis_p(fti, 4) == 0)
                ip = 1;
            else
                ip = 2;
            end

        else
            
            if (vis_l(fti, 3) == 0 || vis_l(fti, 4) == 0)
                ip = 1;
            else
                ip = 2;
            end
            
            if (ip == 1)
                if (vis_l(fti, 3) == 0)
                    c3 = 4;
                else
                    c3 = 3;
                end
                l1 = lprojs(:, fti, 1);
                l2 = lprojs(:, fti, 2);
                l3 = lprojs(:, fti, c3);
            else
                if (vis_l(fti, 1) == 0)
                    c3 = 2;
                else
                    c3 = 1;
                end
                l1 = lprojs(:, fti, 3);
                l2 = lprojs(:, fti, 4);
                l3 = lprojs(:, fti, c3);
            end
                
            A = l2*l3';
            if (ip == 1)
                B = l2(1)*R3'*l3;
            else
                B = l2(1)*R3*l3;
            end
            if (c3 == 4 || c3 == 2)
                B = B - l2*l3(1);
            end
            L1x = util.cpmat(l1);
            A = L1x*A;
            B = L1x*B;
            if (ip == 2)
                A = -A*R3';
            end
            A_full(3*f_ind-2:3*f_ind, :) = A;
            B_full(3*f_ind-2:3*f_ind) = B;
            
%             A*t3true - B
            
        end             
        
        
        
        if (feat_type == 1)
            if (fti <size(projs, 2))
                feat_type = 1;
                fti = fti + 1;
            else
                feat_type = 2;
                fti = 1;
            end
        else
            fti = fti + 1;
        end
        f_ind = f_ind + 1;
    end
    
    if (rank(A_full) == 2)
        t3est = [];
        return;
    end
    t3est = A_full\B_full;
    
%     norm(t3est-t3true)
end