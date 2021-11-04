function []=Ojeras(x1, x2, m, b, h, L, N)
programinception=fopen("inception2.m", "w");
fprintf(programinception, "t=0:%.4f:10-%.4f;\n", h, h);
fprintf(programinception, "y=pi/2+pi/8*sin(pi*t);\n");
fprintf(programinception, "x0=zeros(1, %d);\n", (N-1)*3);
fprintf(programinception, "b=%.4f;\nm=%.4f;\nx1=%.4f;\nx2=%.4f;\nh=%.4f;\nL=%.4f;\ng=%.4f;\n", b, m, x1, x2, h, L, 9.81);
fprintf(programinception, "f=@(x)");
for i=1:N-1
    fprintf(programinception, "(y(%d)-x(%d))^2+", i, i);
end
fprintf(programinception, "0;\nnonlcon=@inception;\nAeq=[];\nbeq=[];\nA=[];\nb=[];\n");
fprintf(programinception, "lbx1=-180*ones(1, %d);\nlbx2=-180*ones(1, %d);\nlbT=-15*ones(1, %d);\n", N-1, N-1, N-1);
fprintf(programinception, "lb=[lbx1, lbx2, lbT];\nub=-lb;\n");
fprintf(programinception, "[x, fval, exitflag, output, lambda, grad, hessian]=fmincon(f, x0, A, b, Aeq, beq, lb, ub, nonlcon);\n");
fprintf(programinception, "x11=[x1, ");
for i=1:N-1
    fprintf(programinception, "x(%d), ", i);
end
fprintf(programinception, "0];\nx11=x11(1:length(x11)-1);\n");
fprintf(programinception, "x22=[x2, ");
for i=N:N*2-2
    fprintf(programinception, "x(%d), ", i);
end
fprintf(programinception, "0];\nx22=x22(1:length(x22)-1);\n");
fprintf(programinception, "T=[");
for i=N*2:N*3-3
    fprintf(programinception, "x(%d), ", i);
end
fprintf(programinception, "0, 0, 0];\nT=T(1:length(T)-1);\n");
fclose(programinception);