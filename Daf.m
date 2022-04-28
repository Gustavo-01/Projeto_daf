%%
clear all
close all
clc

alpha_0 = 1;
beta = 1;
gama = 1;
v = 0.5;
dT = 0.1;
Tc1 = 120;
Tc2 = 100;
Tf = 140;

%%

alpha_1 = @ (T) alpha_0 * (T-Tc1);
alpha_2 = @ (T) alpha_0 * (T-Tc2);

psi_1_coup = zeros(Tc1/dT-1,1);
psi_2_coup = zeros(Tc1/dT-1,1);
psi_1 = zeros(Tc1/dT-1,1);
psi_2 = zeros(Tc1/dT-1,1);


i = 0;
T = 0:dT:Tf;
PsiMax = 11;
PsiMin = 0;
for t = T
    i=i+1;
    "T: " + i + " - " + length(T)
    out = solve_F(alpha_0,beta,gama,v,Tc1,Tc2,t,PsiMax,PsiMin);
    psi_1_coup(i) = out(1);
    psi_2_coup(i) = out(2);
    PsiMax = max([psi_1_coup(i),psi_2_coup(i)]) * (1.05);
    PsiMin = min([psi_1_coup(i),psi_2_coup(i)]) * (0.95);
    
    %No coupling
    out = solve_F_noCoup(alpha_0,beta,gama,Tc1,Tc2,t,PsiMax,PsiMin);
    psi_1(i) = out(1);
    psi_2(i) = out(2);
    PsiMax = max([psi_1(i),psi_2(i)]) * (1.05);
    PsiMin = min([psi_1(i),psi_2(i)]) * (0.95);
end
%%
figure(1)
plot(T(1:length(psi_1)),psi_1,'r--')
hold on
plot(T(1:length(psi_1)),psi_2,'b--')

figure(2)
plot(T(1:length(psi_1_coup)),psi_1_coup,'r')
hold on
plot(T(1:length(psi_1_coup)),psi_2_coup,'b')

