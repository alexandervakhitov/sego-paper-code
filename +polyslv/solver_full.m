function [as, bs, cs, ds] = solver_full(M1, M2, case_num, a,b,c,d)
  
     
     if (case_num ~= 4)


Mc = polyslv.full_assign(M1', M2')';

% norm(Mc-Mc2)
% 
% Mc;
     else 
Mc = polyslv.full_assign_case4(M1', M2')';

% norm(Mc-Mc2)

% Mc;

     end 

if (case_num == 1 || case_num == 3)
    pi = [305,304,...
        306,305,...
        307,306,...
        308,307,...
        309,308,...
        310,309,...
        311,310,...
        312,311,...
        313,312,...
        314,313,...
        315,314,...
        316,315,...
        317,316,...
        318,317,...
        319,318,...
        320,319,...
        321,320,...
        322,321,...
        323,322,...
        324,323,...
        325,324,...
        326,325,...
        327,326,...
        328,327,...
        329,328,...
        330,329,...
        331,330,...
        332,331,...
        333,332,...
        334,333,...
        335,334,...
        336,335,...
        337,336,...
        338,337,...
        339,338,...
        340,339,...
        341,340,...
        342,341,...
        343,342,...
        344,343,...
        345,344,...
        346,345,...
        347,346,...
        348,347,...
        349,348,...
        350,349,...
        351,350,...
        352,351,...
        353,352,...
        354,353,...
        355,354,...
        356,355,...
        357,356,...
        358,357,...
        359,358,...
        360,359,...
        361,360,...
        362,361,...
        363,362,...
        364,363,...
        365,364,...
        366,365,...
        367,366,...
        368,367,...
        369,368,...
        370,369,...
        371,370,...
        372,371,...
        373,372,...
        374,373,...
        375,374,...
        376,375,...
        377,376,...
        378,377,...
        379,378,...
        380,379,...
        381,380,...
        382,381,...
        383,382,...
        384,383,...
        385,384,...
        386,385,...
        387,386,...
        388,387,...
        389,388,...
        390,389,...
        391,390,...
        392,391,...
        393,392,...
        394,393,...
        395,394,...
        413,395,...
        429,405,...
        405,406,...
        406,407,...
        304,408,...
        408,409,...
        409,410,...
        410,411,...
        411,412,...
        412,413,...
        407,418,...
        418,419,...
        419,420,...
        420,421,...
        421,422,...
        422,423,...
        423,424,...
        424,425,...
        425,426,...
        426,427,...
        427,428,...
        428,429];
    n = length(pi)/2;
    pi = reshape(pi, [2, n]);
    Mc(:, pi(2,:)) = Mc(:, pi(1,:));
end

%toc(t00)
if (case_num == 1)
    reduce_pos = 407;
    n_r = 6;
    action_inds = [-2,-3,-4,-5,356,-8,357,-9,358,-11,-12,359,360,-15,-16,361];
end
if (case_num == 2)
    reduce_pos = 406;
    n_r = 7;
    action_inds = [-2,-3,-4,355,-7,356,-8,357,-10,-11,358,359,-14,-15,360,361];
end
if (case_num == 3)
    reduce_pos = 407;
    n_r = 6;
    action_inds = [-2,-3,-4,-5,364,-8,365,-9,366,-11,-12,367,368,-15,-16,369];    
end
if (case_num == 4)
    reduce_pos = 407;
    n_r = 6;
    action_inds = [-2,-3,-4,-5,374,-8,375,-9,376,-11,-12,377,378,-15,-16,379];
    action_inds = [-2,-3,-4,-5,364,-8,365,-9,366,-11,-12,367,368,-15,-16,369];    
end
if (case_num == 5)
    reduce_pos = 406;
    n_r = 7;
    action_inds = [-2,-3,-4,355,-7,356,-8,357,-10,-11,358,359,-14,-15,360,361];
end

t0 = tic;
[L,U,P] = lu(Mc);
t1=toc(t0);

ind = 1;
row_num = size(U, 1);
while((ind <= row_num) && norm(U(ind, 1: reduce_pos), 2) >0)
    ind = ind+1;
end;
col_num = size(Mc, 2);
U1 = U(ind:row_num, reduce_pos+1:col_num);
Ud = U1(1:n_r, 1:n_r);
Cb = U1(1:n_r, n_r+1:n_r+16);
A_red = Ud\Cb;
%    Mc = frref(Mc);    


%action_inds =  [-2,-3,-4,355,-7,356,-8,357,-10,-11,358,359,-14,-15,360,361];
A = zeros(16, 16);
c_ind = 1;
for i = 1:16
    if (action_inds(i) < 0)
        A(i, -action_inds(i)) = 1;
    else 
        A(i, :) = -A_red(c_ind, :);
        c_ind = c_ind+1;
    end
end
    if (sum(isnan(A(:))) > 0)
        A;
        as = [];
        bs = [];
        cs = [];
        ds = [];
        return;
    end
    rank(A);
    [V,D] = eig(A);
%    min(abs(real(diag(D))-a))


    as_all = diag(D);
    as_inds = [];
    as = [];
    for i = 1:length(as_all)
        if (imag(as_all(i)) == 0)
            as = [as; as_all(i)];
            as_inds = [as_inds; i];
        end        
    end

    bs = zeros(length(as), 1);
    cs = zeros(length(as), 1);
    ds = zeros(length(as), 1);
if (case_num == 2 || case_num == 5)
%            2   3      2          2             2                  2
%    [1, a, a , a , b, b , a b, b a , c, a c, c a , b c, d, a d, d a , b d]

    for i = 1:length(as)
        ev = V(:, as_inds(i));
        bs(i) = ev(5)/ev(1);
        cs(i) = ev(9)/ev(1);
        ds(i) = ev(13)/ev(1);        
    end
    
else
%             2   3   4      2          2             2                  2
%     [1, a, a , a , a , b, b , a b, b a , c, a c, c a , b c, d, a d, d a ]
        
    for i = 1:length(as)
        ev = V(:, as_inds(i));
        bs(i) = ev(6)/ev(1);
        cs(i) = ev(10)/ev(1);
        ds(i) = ev(14)/ev(1);        
    end
end
    
    
%         2   3      2   3          2   2        2   3   4   5          2     3
% [1, b, b , b , c, c , c , b c, b c , b  c, d, d , d , d , d , b d, b d , b d ,
% 
%        4   2     2  2          2     3     4   2     2  2     3              2
%     b d , b  d, b  d , c d, c d , c d , c d , c  d, c  d , d c , b c d, b c d ,
% 
%          2     2
%     d b c , d b  c]

%  vt = [1,b,b^2,b^3,c,c^2,c^3,b*c,b*c^2,b^2*c,d,d^2,d^3,d^4,d^5,b*d,b*d^2,b*d^3,b*d^4,b^2*d,b^2*d^2,c*d, c*d^2,c*d^3,c*d^4,c^2*d,c^2*d^2,d*c^3,b*c*d,b*c*d^2,...
%      d*b*c^2,d*b^2*c];
%  vf = A*vt';
%  vf ./ vt'
% 
%  norm(A*vt'-b*vt')

end