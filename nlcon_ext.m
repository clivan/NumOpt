function [c,ceq] = nlcon_ext(z)
A=[z(1) z(2) z(3) z(4)];
c = [2*(max(A)+min(A))-(z(1)+z(2)+z(3)+z(4));
    z(10)-z(11);
    z(11)-z(12);
    z(12)-z(13);
    z(13)-z(14);
    z(14)-z(15)
    ];
ceq=[z(2)*cos(z(10))+z(3)*cos(z(16))-z(1)*cos(z(7))-z(4)*cos(z(22));
    z(2)*cos(z(11))+z(3)*cos(z(17))-z(1)*cos(z(7))-z(4)*cos(z(23));
    z(2)*cos(z(12))+z(3)*cos(z(18))-z(1)*cos(z(7))-z(4)*cos(z(24));
    z(2)*cos(z(13))+z(3)*cos(z(19))-z(1)*cos(z(7))-z(4)*cos(z(25));
    z(2)*cos(z(14))+z(3)*cos(z(20))-z(1)*cos(z(7))-z(4)*cos(z(26));
    z(2)*cos(z(15))+z(3)*cos(z(21))-z(1)*cos(z(7))-z(4)*cos(z(27));
    z(2)*sin(z(10))+z(3)*sin(z(16))-z(1)*sin(z(7))-z(4)*sin(z(22));
    z(2)*sin(z(11))+z(3)*sin(z(17))-z(1)*sin(z(7))-z(4)*sin(z(23));
    z(2)*sin(z(12))+z(3)*sin(z(18))-z(1)*sin(z(7))-z(4)*sin(z(24));
    z(2)*sin(z(13))+z(3)*sin(z(19))-z(1)*sin(z(7))-z(4)*sin(z(25));
    z(2)*sin(z(14))+z(3)*sin(z(20))-z(1)*sin(z(7))-z(4)*sin(z(26));
    z(2)*sin(z(15))+z(3)*sin(z(21))-z(1)*sin(z(7))-z(4)*sin(z(27))
    ];
