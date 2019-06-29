function Mg = form_a_t_1(A)

Mg = [A(:,1) - A(:,5) - A(:,9),    ...
    A(:,5) - A(:,1) - A(:,9),    ...
    A(:,9) - A(:,5) - A(:,1),   ...
    2*A(:,2) + 2*A(:,4),   ...
    2*A(:,3) + 2*A(:,7),   ...
    2*A(:,6) + 2*A(:,8),   ...
    A(:,1) + A(:,5) + A(:,9), ...
    2*A(:,6) - 2*A(:,8),  ...
    2*A(:,7) - 2*A(:,3),   ...
    2*A(:,2) - 2*A(:,4), ...
    A(:,10)];
return;

Mg = [];
for i = 1:size(A, 1)
    Mg = [Mg; 
        A(i,1) - A(i,5) - A(i,9),    A(i,5) - A(i,1) - A(i,9),    A(i,9) - A(i,5) - A(i,1),   2*A(i,2) + 2*A(i,4),   2*A(i,3) + 2*A(i,7),   2*A(i,6) + 2*A(i,8),    A(i,1) + A(i,5) + A(i,9),   2*A(i,6) - 2*A(i,8),   2*A(i,7) - 2*A(i,3),   2*A(i,2) - 2*A(i,4),  A(i,10)];
end
% Mg = [    A(i,1) - A(i,5) - A(i,9),    A(i,5) - A(i,1) - A(i,9),    A(i,9) - A(i,5) - A(i,1),   2*A(i,2) + 2*A(i,4),   2*A(i,3) + 2*A(i,7),   2*A(i,6) + 2*A(i,8),    A(i,1) + A(i,5) + A(i,9),   2*A(i,6) - 2*A(i,8),   2*A(i,7) - 2*A(i,3),   2*A(i,2) - 2*A(i,4),  A(i,10);
%     A(2,1) - A(2,5) - A(2,9),    A(2,5) - A(2,1) - A(2,9),    A(2,9) - A(2,5) - A(2,1),   2*A(2,2) + 2*A(2,4),   2*A(2,3) + 2*A(2,7),   2*A(2,6) + 2*A(2,8),    A(2,1) + A(2,5) + A(2,9),   2*A(2,6) - 2*A(2,8),   2*A(2,7) - 2*A(2,3),   2*A(2,2) - 2*A(2,4),  A(2,10);
%     A(3,1) - A(3,5) - A(3,9),    A(3,5) - A(3,1) - A(3,9),    A(3,9) - A(3,5) - A(3,1),   2*A(3,2) + 2*A(3,4),   2*A(3,3) + 2*A(3,7),   2*A(3,6) + 2*A(3,8),    A(3,1) + A(3,5) + A(3,9),   2*A(3,6) - 2*A(3,8),   2*A(3,7) - 2*A(3,3),   2*A(3,2) - 2*A(3,4),  A(3,10);
%     A(4,1) - A(4,5) - A(4,9),    A(4,5) - A(4,1) - A(4,9),    A(4,9) - A(4,5) - A(4,1),   2*A(4,2) + 2*A(4,4),   2*A(4,3) + 2*A(4,7),   2*A(4,6) + 2*A(4,8),    A(4,1) + A(4,5) + A(4,9),   2*A(4,6) - 2*A(4,8),   2*A(4,7) - 2*A(4,3),   2*A(4,2) - 2*A(4,4),  A(4,10);
%     A(5,1) - A(5,5) - A(5,9),    A(5,5) - A(5,1) - A(5,9),    A(5,9) - A(5,5) - A(5,1),   2*A(5,2) + 2*A(5,4),   2*A(5,3) + 2*A(5,7),   2*A(5,6) + 2*A(5,8),    A(5,1) + A(5,5) + A(5,9),   2*A(5,6) - 2*A(5,8),   2*A(5,7) - 2*A(5,3),   2*A(5,2) - 2*A(5,4),  A(5,10);
%     A(6,1) - A(6,5) - A(6,9),    A(6,5) - A(6,1) - A(6,9),    A(6,9) - A(6,5) - A(6,1),   2*A(6,2) + 2*A(6,4),   2*A(6,3) + 2*A(6,7),   2*A(6,6) + 2*A(6,8),    A(6,1) + A(6,5) + A(6,9),   2*A(6,6) - 2*A(6,8),   2*A(6,7) - 2*A(6,3),   2*A(6,2) - 2*A(6,4),  A(6,10);
%     A(7,1) - A(7,5) - A(7,9),    A(7,5) - A(7,1) - A(7,9),    A(7,9) - A(7,5) - A(7,1),   2*A(7,2) + 2*A(7,4),   2*A(7,3) + 2*A(7,7),   2*A(7,6) + 2*A(7,8),    A(7,1) + A(7,5) + A(7,9),   2*A(7,6) - 2*A(7,8),   2*A(7,7) - 2*A(7,3),   2*A(7,2) - 2*A(7,4),  A(7,10);
%     A(8,1) - A(8,5) - A(8,9),    A(8,5) - A(8,1) - A(8,9),    A(8,9) - A(8,5) - A(8,1),   2*A(8,2) + 2*A(8,4),   2*A(8,3) + 2*A(8,7),   2*A(8,6) + 2*A(8,8),    A(8,1) + A(8,5) + A(8,9),   2*A(8,6) - 2*A(8,8),   2*A(8,7) - 2*A(8,3),   2*A(8,2) - 2*A(8,4),  A(8,10);
%     A(9,1) - A(9,5) - A(9,9),    A(9,5) - A(9,1) - A(9,9),    A(9,9) - A(9,5) - A(9,1),   2*A(9,2) + 2*A(9,4),   2*A(9,3) + 2*A(9,7),   2*A(9,6) + 2*A(9,8),    A(9,1) + A(9,5) + A(9,9),   2*A(9,6) - 2*A(9,8),   2*A(9,7) - 2*A(9,3),   2*A(9,2) - 2*A(9,4),  A(9,10);
%  A(10,1) - A(10,5) - A(10,9), A(10,5) - A(10,1) - A(10,9), A(10,9) - A(10,5) - A(10,1), 2*A(10,2) + 2*A(10,4), 2*A(10,3) + 2*A(10,7), 2*A(10,6) + 2*A(10,8), A(10,1) + A(10,5) + A(10,9), 2*A(10,6) - 2*A(10,8), 2*A(10,7) - 2*A(10,3), 2*A(10,2) - 2*A(10,4), A(10,10);
%  A(11,1) - A(11,5) - A(11,9), A(11,5) - A(11,1) - A(11,9), A(11,9) - A(11,5) - A(11,1), 2*A(11,2) + 2*A(11,4), 2*A(11,3) + 2*A(11,7), 2*A(11,6) + 2*A(11,8), A(11,1) + A(11,5) + A(11,9), 2*A(11,6) - 2*A(11,8), 2*A(11,7) - 2*A(11,3), 2*A(11,2) - 2*A(11,4), A(11,10);
%  A(12,1) - A(12,5) - A(12,9), A(12,5) - A(12,1) - A(12,9), A(12,9) - A(12,5) - A(12,1), 2*A(12,2) + 2*A(12,4), 2*A(12,3) + 2*A(12,7), 2*A(12,6) + 2*A(12,8), A(12,1) + A(12,5) + A(12,9), 2*A(12,6) - 2*A(12,8), 2*A(12,7) - 2*A(12,3), 2*A(12,2) - 2*A(12,4), A(12,10);
%  A(13,1) - A(13,5) - A(13,9), A(13,5) - A(13,1) - A(13,9), A(13,9) - A(13,5) - A(13,1), 2*A(13,2) + 2*A(13,4), 2*A(13,3) + 2*A(13,7), 2*A(13,6) + 2*A(13,8), A(13,1) + A(13,5) + A(13,9), 2*A(13,6) - 2*A(13,8), 2*A(13,7) - 2*A(13,3), 2*A(13,2) - 2*A(13,4), A(13,10);
%  A(14,1) - A(14,5) - A(14,9), A(14,5) - A(14,1) - A(14,9), A(14,9) - A(14,5) - A(14,1), 2*A(14,2) + 2*A(14,4), 2*A(14,3) + 2*A(14,7), 2*A(14,6) + 2*A(14,8), A(14,1) + A(14,5) + A(14,9), 2*A(14,6) - 2*A(14,8), 2*A(14,7) - 2*A(14,3), 2*A(14,2) - 2*A(14,4), A(14,10);
%  A(15,1) - A(15,5) - A(15,9), A(15,5) - A(15,1) - A(15,9), A(15,9) - A(15,5) - A(15,1), 2*A(15,2) + 2*A(15,4), 2*A(15,3) + 2*A(15,7), 2*A(15,6) + 2*A(15,8), A(15,1) + A(15,5) + A(15,9), 2*A(15,6) - 2*A(15,8), 2*A(15,7) - 2*A(15,3), 2*A(15,2) - 2*A(15,4), A(15,10);
%  A(16,1) - A(16,5) - A(16,9), A(16,5) - A(16,1) - A(16,9), A(16,9) - A(16,5) - A(16,1), 2*A(16,2) + 2*A(16,4), 2*A(16,3) + 2*A(16,7), 2*A(16,6) + 2*A(16,8), A(16,1) + A(16,5) + A(16,9), 2*A(16,6) - 2*A(16,8), 2*A(16,7) - 2*A(16,3), 2*A(16,2) - 2*A(16,4), A(16,10);
%  A(17,1) - A(17,5) - A(17,9), A(17,5) - A(17,1) - A(17,9), A(17,9) - A(17,5) - A(17,1), 2*A(17,2) + 2*A(17,4), 2*A(17,3) + 2*A(17,7), 2*A(17,6) + 2*A(17,8), A(17,1) + A(17,5) + A(17,9), 2*A(17,6) - 2*A(17,8), 2*A(17,7) - 2*A(17,3), 2*A(17,2) - 2*A(17,4), A(17,10);
%  A(18,1) - A(18,5) - A(18,9), A(18,5) - A(18,1) - A(18,9), A(18,9) - A(18,5) - A(18,1), 2*A(18,2) + 2*A(18,4), 2*A(18,3) + 2*A(18,7), 2*A(18,6) + 2*A(18,8), A(18,1) + A(18,5) + A(18,9), 2*A(18,6) - 2*A(18,8), 2*A(18,7) - 2*A(18,3), 2*A(18,2) - 2*A(18,4), A(18,10)];
end