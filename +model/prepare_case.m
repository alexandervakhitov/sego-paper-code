function [projs, lprojs, vis_p, vis_l] = prepare_case(case_num, projsh, lprojsh)
    ci1 = rand;
    ci1 = (ci1<0.5)+1;
    ci2 = rand;
    ci2 = (ci2<0.5)+1;
    [projs, lprojs, vis_p, vis_l] = model.generate_case(case_num, projsh, lprojsh, ci1, ci2);
end