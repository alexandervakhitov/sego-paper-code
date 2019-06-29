function case_num = find_case(vis_p, vis_l)
    [feat_type, ip_num, feat_ind, ind1, ind2] = slv.find_feature_classes(vis_p, vis_l);
    case_num = 6;
    if (feat_type(1) == 1 && feat_type(2) == 2)
        if (ip_num(1) == 1 && ip_num(2) == 2)
            case_num = 1;
        else
            case_num = 2;
        end
    end
    if (feat_type(1) == 1 && feat_type(2) == 1)
        case_num = 3;
    end
    if (feat_type(1) == 2 && feat_type(2) == 2 && length(feat_type) == 2)
        if (ip_num(1) == 2 && ip_num(2) == 2)
            case_num = 4;
        else
            case_num = 5;
        end
    end
    if (length(ip_num) == 2 && ip_num(1) == 1 && ip_num(2) == 1)
        if( feat_type(1) == 1 && feat_type(2) == 1)
            case_num = 7;
        end
        if( feat_type(1) == 1 && feat_type(2) == 2)
            case_num = 8;
        end
        if (feat_type(1) == 2 && feat_type(2) == 2)
            case_num = 9;
        end
    end
end