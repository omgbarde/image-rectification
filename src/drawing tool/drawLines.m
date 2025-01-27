%% not used anymore
function A = drawLines(numPairs)
fprintf('Draw pairs of parallel lines along X, Y and Z\n');

count = 1;
A = zeros(6,numPairs);

while (count <=numPairs)
    figure(gcf);
    title(['Draw ', num2str(numPairs),' pairs of parallel segments: step ',num2str(count) ]);
    col = 'rgb';

    segment1 = drawline('Color',col(count));
    segment2 = drawline('Color',col(count));
    
    l = segToLineDenorm(segment1.Position);
    m = segToLineDenorm(segment2.Position);

    % fprintf(num2str(count));
    % fprintf(':\n');
    % disp(l);
    % disp(m);

    % store the paris in a matrix A (each column = one pair)
    A(:,count) = [l(1),l(2),l(3),m(1),m(2),m(3)];
    count = count + 1;
end
% disp(A)
end