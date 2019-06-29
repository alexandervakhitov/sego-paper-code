function Cf = build_C_mat(A)
Cf = [ A(1,2)*(A(4,2)^2 - A(1,2)*A(2,2)) + A(2,2)*(A(4,3)^2 - A(1,3)*A(2,3)) + A(3,2)*(A(4,4)^2 - A(1,4)*A(2,4)) - A(4,2)*(A(1,2)*A(2,3) + A(1,3)*A(2,2) - 2*A(4,2)*A(4,3)) - A(5,2)*(A(1,2)*A(2,4) + A(1,4)*A(2,2) - 2*A(4,2)*A(4,4)) - A(6,2)*(A(1,3)*A(2,4) + A(1,4)*A(2,3) - 2*A(4,3)*A(4,4)) - A(1,1)*A(2,2) - A(1,2)*A(2,1) + 2*A(4,1)*A(4,2), 2*A(4,2)*A(4,5) - A(1,5)*A(2,2) - A(1,2)*A(2,5), A(1,3)*(A(4,2)^2 - A(1,2)*A(2,2)) + A(2,3)*(A(4,3)^2 - A(1,3)*A(2,3)) + A(3,3)*(A(4,4)^2 - A(1,4)*A(2,4)) - A(4,3)*(A(1,2)*A(2,3) + A(1,3)*A(2,2) - 2*A(4,2)*A(4,3)) - A(5,3)*(A(1,2)*A(2,4) + A(1,4)*A(2,2) - 2*A(4,2)*A(4,4)) - A(6,3)*(A(1,3)*A(2,4) + A(1,4)*A(2,3) - 2*A(4,3)*A(4,4)) - A(1,1)*A(2,3) - A(1,3)*A(2,1) + 2*A(4,1)*A(4,3), 2*A(4,3)*A(4,5) - A(1,5)*A(2,3) - A(1,3)*A(2,5), A(1,4)*(A(4,2)^2 - A(1,2)*A(2,2)) + A(2,4)*(A(4,3)^2 - A(1,3)*A(2,3)) + A(3,4)*(A(4,4)^2 - A(1,4)*A(2,4)) - A(4,4)*(A(1,2)*A(2,3) + A(1,3)*A(2,2) - 2*A(4,2)*A(4,3)) - A(5,4)*(A(1,2)*A(2,4) + A(1,4)*A(2,2) - 2*A(4,2)*A(4,4)) - A(6,4)*(A(1,3)*A(2,4) + A(1,4)*A(2,3) - 2*A(4,3)*A(4,4)) - A(1,1)*A(2,4) - A(1,4)*A(2,1) + 2*A(4,1)*A(4,4), 2*A(4,4)*A(4,5) - A(1,5)*A(2,4) - A(1,4)*A(2,5), A(1,1)*(A(4,2)^2 - A(1,2)*A(2,2)) + A(2,1)*(A(4,3)^2 - A(1,3)*A(2,3)) + A(3,1)*(A(4,4)^2 - A(1,4)*A(2,4)) + A(4,1)^2 - A(4,1)*(A(1,2)*A(2,3) + A(1,3)*A(2,2) - 2*A(4,2)*A(4,3)) - A(5,1)*(A(1,2)*A(2,4) + A(1,4)*A(2,2) - 2*A(4,2)*A(4,4)) - A(6,1)*(A(1,3)*A(2,4) + A(1,4)*A(2,3) - 2*A(4,3)*A(4,4)) - A(1,1)*A(2,1), A(1,5)*(A(4,2)^2 - A(1,2)*A(2,2)) + A(2,5)*(A(4,3)^2 - A(1,3)*A(2,3)) + A(3,5)*(A(4,4)^2 - A(1,4)*A(2,4)) - A(4,5)*(A(1,2)*A(2,3) + A(1,3)*A(2,2) - 2*A(4,2)*A(4,3)) - A(5,5)*(A(1,2)*A(2,4) + A(1,4)*A(2,2) - 2*A(4,2)*A(4,4)) - A(6,5)*(A(1,3)*A(2,4) + A(1,4)*A(2,3) - 2*A(4,3)*A(4,4)) - A(1,1)*A(2,5) - A(1,5)*A(2,1) + 2*A(4,1)*A(4,5), A(4,5)^2 - A(1,5)*A(2,5);
 A(1,2)*(A(5,2)^2 - A(1,2)*A(3,2)) + A(2,2)*(A(5,3)^2 - A(1,3)*A(3,3)) + A(3,2)*(A(5,4)^2 - A(1,4)*A(3,4)) - A(4,2)*(A(1,2)*A(3,3) + A(1,3)*A(3,2) - 2*A(5,2)*A(5,3)) - A(5,2)*(A(1,2)*A(3,4) + A(1,4)*A(3,2) - 2*A(5,2)*A(5,4)) - A(6,2)*(A(1,3)*A(3,4) + A(1,4)*A(3,3) - 2*A(5,3)*A(5,4)) - A(1,1)*A(3,2) - A(1,2)*A(3,1) + 2*A(5,1)*A(5,2), 2*A(5,2)*A(5,5) - A(1,5)*A(3,2) - A(1,2)*A(3,5), A(1,3)*(A(5,2)^2 - A(1,2)*A(3,2)) + A(2,3)*(A(5,3)^2 - A(1,3)*A(3,3)) + A(3,3)*(A(5,4)^2 - A(1,4)*A(3,4)) - A(4,3)*(A(1,2)*A(3,3) + A(1,3)*A(3,2) - 2*A(5,2)*A(5,3)) - A(5,3)*(A(1,2)*A(3,4) + A(1,4)*A(3,2) - 2*A(5,2)*A(5,4)) - A(6,3)*(A(1,3)*A(3,4) + A(1,4)*A(3,3) - 2*A(5,3)*A(5,4)) - A(1,1)*A(3,3) - A(1,3)*A(3,1) + 2*A(5,1)*A(5,3), 2*A(5,3)*A(5,5) - A(1,5)*A(3,3) - A(1,3)*A(3,5), A(1,4)*(A(5,2)^2 - A(1,2)*A(3,2)) + A(2,4)*(A(5,3)^2 - A(1,3)*A(3,3)) + A(3,4)*(A(5,4)^2 - A(1,4)*A(3,4)) - A(4,4)*(A(1,2)*A(3,3) + A(1,3)*A(3,2) - 2*A(5,2)*A(5,3)) - A(5,4)*(A(1,2)*A(3,4) + A(1,4)*A(3,2) - 2*A(5,2)*A(5,4)) - A(6,4)*(A(1,3)*A(3,4) + A(1,4)*A(3,3) - 2*A(5,3)*A(5,4)) - A(1,1)*A(3,4) - A(1,4)*A(3,1) + 2*A(5,1)*A(5,4), 2*A(5,4)*A(5,5) - A(1,5)*A(3,4) - A(1,4)*A(3,5), A(1,1)*(A(5,2)^2 - A(1,2)*A(3,2)) + A(2,1)*(A(5,3)^2 - A(1,3)*A(3,3)) + A(3,1)*(A(5,4)^2 - A(1,4)*A(3,4)) + A(5,1)^2 - A(4,1)*(A(1,2)*A(3,3) + A(1,3)*A(3,2) - 2*A(5,2)*A(5,3)) - A(5,1)*(A(1,2)*A(3,4) + A(1,4)*A(3,2) - 2*A(5,2)*A(5,4)) - A(6,1)*(A(1,3)*A(3,4) + A(1,4)*A(3,3) - 2*A(5,3)*A(5,4)) - A(1,1)*A(3,1), A(1,5)*(A(5,2)^2 - A(1,2)*A(3,2)) + A(2,5)*(A(5,3)^2 - A(1,3)*A(3,3)) + A(3,5)*(A(5,4)^2 - A(1,4)*A(3,4)) - A(4,5)*(A(1,2)*A(3,3) + A(1,3)*A(3,2) - 2*A(5,2)*A(5,3)) - A(5,5)*(A(1,2)*A(3,4) + A(1,4)*A(3,2) - 2*A(5,2)*A(5,4)) - A(6,5)*(A(1,3)*A(3,4) + A(1,4)*A(3,3) - 2*A(5,3)*A(5,4)) - A(1,1)*A(3,5) - A(1,5)*A(3,1) + 2*A(5,1)*A(5,5), A(5,5)^2 - A(1,5)*A(3,5);
 A(1,2)*(A(6,2)^2 - A(2,2)*A(3,2)) + A(2,2)*(A(6,3)^2 - A(2,3)*A(3,3)) + A(3,2)*(A(6,4)^2 - A(2,4)*A(3,4)) - A(4,2)*(A(2,2)*A(3,3) + A(2,3)*A(3,2) - 2*A(6,2)*A(6,3)) - A(5,2)*(A(2,2)*A(3,4) + A(2,4)*A(3,2) - 2*A(6,2)*A(6,4)) - A(6,2)*(A(2,3)*A(3,4) + A(2,4)*A(3,3) - 2*A(6,3)*A(6,4)) - A(2,1)*A(3,2) - A(2,2)*A(3,1) + 2*A(6,1)*A(6,2), 2*A(6,2)*A(6,5) - A(2,5)*A(3,2) - A(2,2)*A(3,5), A(1,3)*(A(6,2)^2 - A(2,2)*A(3,2)) + A(2,3)*(A(6,3)^2 - A(2,3)*A(3,3)) + A(3,3)*(A(6,4)^2 - A(2,4)*A(3,4)) - A(4,3)*(A(2,2)*A(3,3) + A(2,3)*A(3,2) - 2*A(6,2)*A(6,3)) - A(5,3)*(A(2,2)*A(3,4) + A(2,4)*A(3,2) - 2*A(6,2)*A(6,4)) - A(6,3)*(A(2,3)*A(3,4) + A(2,4)*A(3,3) - 2*A(6,3)*A(6,4)) - A(2,1)*A(3,3) - A(2,3)*A(3,1) + 2*A(6,1)*A(6,3), 2*A(6,3)*A(6,5) - A(2,5)*A(3,3) - A(2,3)*A(3,5), A(1,4)*(A(6,2)^2 - A(2,2)*A(3,2)) + A(2,4)*(A(6,3)^2 - A(2,3)*A(3,3)) + A(3,4)*(A(6,4)^2 - A(2,4)*A(3,4)) - A(4,4)*(A(2,2)*A(3,3) + A(2,3)*A(3,2) - 2*A(6,2)*A(6,3)) - A(5,4)*(A(2,2)*A(3,4) + A(2,4)*A(3,2) - 2*A(6,2)*A(6,4)) - A(6,4)*(A(2,3)*A(3,4) + A(2,4)*A(3,3) - 2*A(6,3)*A(6,4)) - A(2,1)*A(3,4) - A(2,4)*A(3,1) + 2*A(6,1)*A(6,4), 2*A(6,4)*A(6,5) - A(2,5)*A(3,4) - A(2,4)*A(3,5), A(1,1)*(A(6,2)^2 - A(2,2)*A(3,2)) + A(2,1)*(A(6,3)^2 - A(2,3)*A(3,3)) + A(3,1)*(A(6,4)^2 - A(2,4)*A(3,4)) + A(6,1)^2 - A(4,1)*(A(2,2)*A(3,3) + A(2,3)*A(3,2) - 2*A(6,2)*A(6,3)) - A(5,1)*(A(2,2)*A(3,4) + A(2,4)*A(3,2) - 2*A(6,2)*A(6,4)) - A(6,1)*(A(2,3)*A(3,4) + A(2,4)*A(3,3) - 2*A(6,3)*A(6,4)) - A(2,1)*A(3,1), A(1,5)*(A(6,2)^2 - A(2,2)*A(3,2)) + A(2,5)*(A(6,3)^2 - A(2,3)*A(3,3)) + A(3,5)*(A(6,4)^2 - A(2,4)*A(3,4)) - A(4,5)*(A(2,2)*A(3,3) + A(2,3)*A(3,2) - 2*A(6,2)*A(6,3)) - A(5,5)*(A(2,2)*A(3,4) + A(2,4)*A(3,2) - 2*A(6,2)*A(6,4)) - A(6,5)*(A(2,3)*A(3,4) + A(2,4)*A(3,3) - 2*A(6,3)*A(6,4)) - A(2,1)*A(3,5) - A(2,5)*A(3,1) + 2*A(6,1)*A(6,5), A(6,5)^2 - A(2,5)*A(3,5);
 A(4,1)*A(5,2) - A(5,2)*(A(1,2)*A(6,4) + A(1,4)*A(6,2) - A(4,2)*A(5,4) - A(4,4)*A(5,2)) - A(6,2)*(A(1,3)*A(6,4) + A(1,4)*A(6,3) - A(4,3)*A(5,4) - A(4,4)*A(5,3)) - A(1,2)*(A(1,2)*A(6,2) - A(4,2)*A(5,2)) - A(2,2)*(A(1,3)*A(6,3) - A(4,3)*A(5,3)) - A(3,2)*(A(1,4)*A(6,4) - A(4,4)*A(5,4)) - A(1,1)*A(6,2) - A(1,2)*A(6,1) - A(4,2)*(A(1,2)*A(6,3) + A(1,3)*A(6,2) - A(4,2)*A(5,3) - A(4,3)*A(5,2)) + A(4,2)*A(5,1), A(4,2)*A(5,5) - A(1,5)*A(6,2) - A(1,2)*A(6,5) + A(4,5)*A(5,2), A(4,1)*A(5,3) - A(5,3)*(A(1,2)*A(6,4) + A(1,4)*A(6,2) - A(4,2)*A(5,4) - A(4,4)*A(5,2)) - A(6,3)*(A(1,3)*A(6,4) + A(1,4)*A(6,3) - A(4,3)*A(5,4) - A(4,4)*A(5,3)) - A(1,3)*(A(1,2)*A(6,2) - A(4,2)*A(5,2)) - A(2,3)*(A(1,3)*A(6,3) - A(4,3)*A(5,3)) - A(3,3)*(A(1,4)*A(6,4) - A(4,4)*A(5,4)) - A(1,1)*A(6,3) - A(1,3)*A(6,1) - A(4,3)*(A(1,2)*A(6,3) + A(1,3)*A(6,2) - A(4,2)*A(5,3) - A(4,3)*A(5,2)) + A(4,3)*A(5,1), A(4,3)*A(5,5) - A(1,5)*A(6,3) - A(1,3)*A(6,5) + A(4,5)*A(5,3), A(4,1)*A(5,4) - A(5,4)*(A(1,2)*A(6,4) + A(1,4)*A(6,2) - A(4,2)*A(5,4) - A(4,4)*A(5,2)) - A(6,4)*(A(1,3)*A(6,4) + A(1,4)*A(6,3) - A(4,3)*A(5,4) - A(4,4)*A(5,3)) - A(1,4)*(A(1,2)*A(6,2) - A(4,2)*A(5,2)) - A(2,4)*(A(1,3)*A(6,3) - A(4,3)*A(5,3)) - A(3,4)*(A(1,4)*A(6,4) - A(4,4)*A(5,4)) - A(1,1)*A(6,4) - A(1,4)*A(6,1) - A(4,4)*(A(1,2)*A(6,3) + A(1,3)*A(6,2) - A(4,2)*A(5,3) - A(4,3)*A(5,2)) + A(4,4)*A(5,1), A(4,4)*A(5,5) - A(1,5)*A(6,4) - A(1,4)*A(6,5) + A(4,5)*A(5,4), A(4,1)*A(5,1) - A(5,1)*(A(1,2)*A(6,4) + A(1,4)*A(6,2) - A(4,2)*A(5,4) - A(4,4)*A(5,2)) - A(6,1)*(A(1,3)*A(6,4) + A(1,4)*A(6,3) - A(4,3)*A(5,4) - A(4,4)*A(5,3)) - A(1,1)*(A(1,2)*A(6,2) - A(4,2)*A(5,2)) - A(2,1)*(A(1,3)*A(6,3) - A(4,3)*A(5,3)) - A(3,1)*(A(1,4)*A(6,4) - A(4,4)*A(5,4)) - A(1,1)*A(6,1) - A(4,1)*(A(1,2)*A(6,3) + A(1,3)*A(6,2) - A(4,2)*A(5,3) - A(4,3)*A(5,2)), A(4,1)*A(5,5) - A(5,5)*(A(1,2)*A(6,4) + A(1,4)*A(6,2) - A(4,2)*A(5,4) - A(4,4)*A(5,2)) - A(6,5)*(A(1,3)*A(6,4) + A(1,4)*A(6,3) - A(4,3)*A(5,4) - A(4,4)*A(5,3)) - A(1,5)*(A(1,2)*A(6,2) - A(4,2)*A(5,2)) - A(2,5)*(A(1,3)*A(6,3) - A(4,3)*A(5,3)) - A(3,5)*(A(1,4)*A(6,4) - A(4,4)*A(5,4)) - A(1,1)*A(6,5) - A(1,5)*A(6,1) - A(4,5)*(A(1,2)*A(6,3) + A(1,3)*A(6,2) - A(4,2)*A(5,3) - A(4,3)*A(5,2)) + A(4,5)*A(5,1), A(4,5)*A(5,5) - A(1,5)*A(6,5);
 A(4,1)*A(6,2) - A(5,2)*(A(2,2)*A(5,4) + A(2,4)*A(5,2) - A(4,2)*A(6,4) - A(4,4)*A(6,2)) - A(6,2)*(A(2,3)*A(5,4) + A(2,4)*A(5,3) - A(4,3)*A(6,4) - A(4,4)*A(6,3)) - A(1,2)*(A(2,2)*A(5,2) - A(4,2)*A(6,2)) - A(2,2)*(A(2,3)*A(5,3) - A(4,3)*A(6,3)) - A(3,2)*(A(2,4)*A(5,4) - A(4,4)*A(6,4)) - A(2,1)*A(5,2) - A(2,2)*A(5,1) - A(4,2)*(A(2,2)*A(5,3) + A(2,3)*A(5,2) - A(4,2)*A(6,3) - A(4,3)*A(6,2)) + A(4,2)*A(6,1), A(4,2)*A(6,5) - A(2,5)*A(5,2) - A(2,2)*A(5,5) + A(4,5)*A(6,2), A(4,1)*A(6,3) - A(5,3)*(A(2,2)*A(5,4) + A(2,4)*A(5,2) - A(4,2)*A(6,4) - A(4,4)*A(6,2)) - A(6,3)*(A(2,3)*A(5,4) + A(2,4)*A(5,3) - A(4,3)*A(6,4) - A(4,4)*A(6,3)) - A(1,3)*(A(2,2)*A(5,2) - A(4,2)*A(6,2)) - A(2,3)*(A(2,3)*A(5,3) - A(4,3)*A(6,3)) - A(3,3)*(A(2,4)*A(5,4) - A(4,4)*A(6,4)) - A(2,1)*A(5,3) - A(2,3)*A(5,1) - A(4,3)*(A(2,2)*A(5,3) + A(2,3)*A(5,2) - A(4,2)*A(6,3) - A(4,3)*A(6,2)) + A(4,3)*A(6,1), A(4,3)*A(6,5) - A(2,5)*A(5,3) - A(2,3)*A(5,5) + A(4,5)*A(6,3), A(4,1)*A(6,4) - A(5,4)*(A(2,2)*A(5,4) + A(2,4)*A(5,2) - A(4,2)*A(6,4) - A(4,4)*A(6,2)) - A(6,4)*(A(2,3)*A(5,4) + A(2,4)*A(5,3) - A(4,3)*A(6,4) - A(4,4)*A(6,3)) - A(1,4)*(A(2,2)*A(5,2) - A(4,2)*A(6,2)) - A(2,4)*(A(2,3)*A(5,3) - A(4,3)*A(6,3)) - A(3,4)*(A(2,4)*A(5,4) - A(4,4)*A(6,4)) - A(2,1)*A(5,4) - A(2,4)*A(5,1) - A(4,4)*(A(2,2)*A(5,3) + A(2,3)*A(5,2) - A(4,2)*A(6,3) - A(4,3)*A(6,2)) + A(4,4)*A(6,1), A(4,4)*A(6,5) - A(2,5)*A(5,4) - A(2,4)*A(5,5) + A(4,5)*A(6,4), A(4,1)*A(6,1) - A(5,1)*(A(2,2)*A(5,4) + A(2,4)*A(5,2) - A(4,2)*A(6,4) - A(4,4)*A(6,2)) - A(6,1)*(A(2,3)*A(5,4) + A(2,4)*A(5,3) - A(4,3)*A(6,4) - A(4,4)*A(6,3)) - A(1,1)*(A(2,2)*A(5,2) - A(4,2)*A(6,2)) - A(2,1)*(A(2,3)*A(5,3) - A(4,3)*A(6,3)) - A(3,1)*(A(2,4)*A(5,4) - A(4,4)*A(6,4)) - A(2,1)*A(5,1) - A(4,1)*(A(2,2)*A(5,3) + A(2,3)*A(5,2) - A(4,2)*A(6,3) - A(4,3)*A(6,2)), A(4,1)*A(6,5) - A(5,5)*(A(2,2)*A(5,4) + A(2,4)*A(5,2) - A(4,2)*A(6,4) - A(4,4)*A(6,2)) - A(6,5)*(A(2,3)*A(5,4) + A(2,4)*A(5,3) - A(4,3)*A(6,4) - A(4,4)*A(6,3)) - A(1,5)*(A(2,2)*A(5,2) - A(4,2)*A(6,2)) - A(2,5)*(A(2,3)*A(5,3) - A(4,3)*A(6,3)) - A(3,5)*(A(2,4)*A(5,4) - A(4,4)*A(6,4)) - A(2,1)*A(5,5) - A(2,5)*A(5,1) - A(4,5)*(A(2,2)*A(5,3) + A(2,3)*A(5,2) - A(4,2)*A(6,3) - A(4,3)*A(6,2)) + A(4,5)*A(6,1), A(4,5)*A(6,5) - A(2,5)*A(5,5);
 A(5,1)*A(6,2) - A(5,2)*(A(3,2)*A(4,4) + A(3,4)*A(4,2) - A(5,2)*A(6,4) - A(5,4)*A(6,2)) - A(6,2)*(A(3,3)*A(4,4) + A(3,4)*A(4,3) - A(5,3)*A(6,4) - A(5,4)*A(6,3)) - A(1,2)*(A(3,2)*A(4,2) - A(5,2)*A(6,2)) - A(2,2)*(A(3,3)*A(4,3) - A(5,3)*A(6,3)) - A(3,2)*(A(3,4)*A(4,4) - A(5,4)*A(6,4)) - A(3,1)*A(4,2) - A(3,2)*A(4,1) - A(4,2)*(A(3,2)*A(4,3) + A(3,3)*A(4,2) - A(5,2)*A(6,3) - A(5,3)*A(6,2)) + A(5,2)*A(6,1), A(5,2)*A(6,5) - A(3,5)*A(4,2) - A(3,2)*A(4,5) + A(5,5)*A(6,2), A(5,1)*A(6,3) - A(5,3)*(A(3,2)*A(4,4) + A(3,4)*A(4,2) - A(5,2)*A(6,4) - A(5,4)*A(6,2)) - A(6,3)*(A(3,3)*A(4,4) + A(3,4)*A(4,3) - A(5,3)*A(6,4) - A(5,4)*A(6,3)) - A(1,3)*(A(3,2)*A(4,2) - A(5,2)*A(6,2)) - A(2,3)*(A(3,3)*A(4,3) - A(5,3)*A(6,3)) - A(3,3)*(A(3,4)*A(4,4) - A(5,4)*A(6,4)) - A(3,1)*A(4,3) - A(3,3)*A(4,1) - A(4,3)*(A(3,2)*A(4,3) + A(3,3)*A(4,2) - A(5,2)*A(6,3) - A(5,3)*A(6,2)) + A(5,3)*A(6,1), A(5,3)*A(6,5) - A(3,5)*A(4,3) - A(3,3)*A(4,5) + A(5,5)*A(6,3), A(5,1)*A(6,4) - A(5,4)*(A(3,2)*A(4,4) + A(3,4)*A(4,2) - A(5,2)*A(6,4) - A(5,4)*A(6,2)) - A(6,4)*(A(3,3)*A(4,4) + A(3,4)*A(4,3) - A(5,3)*A(6,4) - A(5,4)*A(6,3)) - A(1,4)*(A(3,2)*A(4,2) - A(5,2)*A(6,2)) - A(2,4)*(A(3,3)*A(4,3) - A(5,3)*A(6,3)) - A(3,4)*(A(3,4)*A(4,4) - A(5,4)*A(6,4)) - A(3,1)*A(4,4) - A(3,4)*A(4,1) - A(4,4)*(A(3,2)*A(4,3) + A(3,3)*A(4,2) - A(5,2)*A(6,3) - A(5,3)*A(6,2)) + A(5,4)*A(6,1), A(5,4)*A(6,5) - A(3,5)*A(4,4) - A(3,4)*A(4,5) + A(5,5)*A(6,4), A(5,1)*A(6,1) - A(5,1)*(A(3,2)*A(4,4) + A(3,4)*A(4,2) - A(5,2)*A(6,4) - A(5,4)*A(6,2)) - A(6,1)*(A(3,3)*A(4,4) + A(3,4)*A(4,3) - A(5,3)*A(6,4) - A(5,4)*A(6,3)) - A(1,1)*(A(3,2)*A(4,2) - A(5,2)*A(6,2)) - A(2,1)*(A(3,3)*A(4,3) - A(5,3)*A(6,3)) - A(3,1)*(A(3,4)*A(4,4) - A(5,4)*A(6,4)) - A(3,1)*A(4,1) - A(4,1)*(A(3,2)*A(4,3) + A(3,3)*A(4,2) - A(5,2)*A(6,3) - A(5,3)*A(6,2)), A(5,1)*A(6,5) - A(5,5)*(A(3,2)*A(4,4) + A(3,4)*A(4,2) - A(5,2)*A(6,4) - A(5,4)*A(6,2)) - A(6,5)*(A(3,3)*A(4,4) + A(3,4)*A(4,3) - A(5,3)*A(6,4) - A(5,4)*A(6,3)) - A(1,5)*(A(3,2)*A(4,2) - A(5,2)*A(6,2)) - A(2,5)*(A(3,3)*A(4,3) - A(5,3)*A(6,3)) - A(3,5)*(A(3,4)*A(4,4) - A(5,4)*A(6,4)) - A(3,1)*A(4,5) - A(3,5)*A(4,1) - A(4,5)*(A(3,2)*A(4,3) + A(3,3)*A(4,2) - A(5,2)*A(6,3) - A(5,3)*A(6,2)) + A(5,5)*A(6,1), A(5,5)*A(6,5) - A(3,5)*A(4,5)];
end