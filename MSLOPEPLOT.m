clear
distance = 0:1:10000;

for i = 1:length(distance)
    Pl(i) = getPathLoss(0, distance(i), 0.0114);
end

plot(log(distance), Pl, 'k');
hold on
kk = 0:2:95;
plot(log(500).*ones(1, length(kk)), kk, ':r' )


set(findobj(gca, 'Type', 'Line', 'Linestyle', '-'), 'LineWidth', 2);

xlabel('Log ( Distance) ');
ylabel('Path Loss (dB)');

set(gca,'XTick',log(500))  
set(gca,'XTickLabel','Rc')