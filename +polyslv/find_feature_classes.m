%ip_num = main camera pair for feature, features are enumerated starting
%from points
%feat_type = feature type (1-point, 2-line)
%feat_ind = index of a feature in the corresponding array (ponit array or
%line array)
%ind1 = index of a camera pair which owns first point feature
%ind2 = index of another camera pair
function [feat_type, ip_num, feat_ind, ind1, ind2] = find_feature_classes(vis_p, vis_l)
    feat_type = [];
    ip_num = [];
    feat_ind = [];
    
    npt = size(vis_p, 1);        
    for i = 2:npt
        cur_pt_ip = 2;
        if (vis_p(i, 3) == 0 || vis_p(i, 4) == 0)                    
            cur_pt_ip = 1;
        end
        ip_num = [ip_num; cur_pt_ip];
        feat_type = [feat_type; 1];
        feat_ind = [feat_ind; i];        
    end
    nl = size(vis_l, 1);
    for i = 1:nl
        cur_ln_ip = 2;
        if (vis_l(i, 3) == 0 || vis_l(i, 4) == 0)
            cur_ln_ip = 1;
        end
        ip_num = [ip_num; cur_ln_ip];
        feat_type = [feat_type; 2];
        feat_ind = [feat_ind; i];        
    end
    
    ind1 = 1;
    ind2 = 2;
    if (ip_num(ind1) == 2)
        ind1 = 2;
        ind2 = 1;
    end
    
end
