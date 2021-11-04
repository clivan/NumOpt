function []=Insomnio(x1, x2, TT, h, m, b, L, n)
    programinception=fopen("inception.m", "w");
    fprintf(programinception, "function [c,ceq]=inception(x)\n");
    fprintf(programinception, "\tc=[];\nx1=%.4f;\nx2=%.4f;\nTT=%.4f;\nh=%.4f;\nm=%.4f;\nb=%.4f;\nL=%.4f;\ng=%.4f;\n", x1, x2, TT,  h, m, b, L, 9.81);
    fprintf(programinception, "ceq=[");
    fprintf(programinception, "x(1)-x1-h*x2;\n\t");
     for i=1:n-2
        fprintf(programinception, "x(%d)-x(%d)-h*x(%d);\n\t", i+1, i, i+n-1);
    end
    fprintf(programinception, "x(%d)-x2-h*((1/(m*L*L))*(TT-m*g*L*sin(x1)-b*x2));\n", 2*n+1);
    for i=n:2*n-4
        fprintf(programinception, "x(%d)-x(%d)-h*((1/(m*L*L))*(x(%d)-m*g*L*sin(x(%d))-b*x(%d)));\n", 2*n+1, i, n+i+1, i+1-n, i);
    end
    fprintf(programinception, "];");
    fprintf(programinception, "x=[x, 0];");
    fclose(programinception);