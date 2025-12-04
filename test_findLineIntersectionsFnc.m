%% Unit Test for findLineIntersectionsFnc

%% Create test data
letterSpacing = 1.2;
scale = 0.8;

% L
L = [0 0; 0 1; 0 0; 0.5 0]' * scale;
% u
u = [0.7 1; 0.7 0.1; 0.8 0; 1 0; 1.1 0.1; 1.1 1]' * scale;
u(1,:) = u(1,:) + 0.6;
% c
c = [1.1 0.8; 0.9 1; 0.7 0.8; 0.7 0.2; 0.9 0; 1.1 0.2]' * scale;
c(1,:) = c(1,:) + 1.5;
% e
e = [1.1 0.5; 0.7 0.5; 0.7 0.8; 0.9 1; 1.1 0.8; 1.1 0.5; 0.7 0.5; 0.7 0.2; 0.9 0; 1.1 0.2]' * scale;
e(1,:) = e(1,:) + 2.4;
% n
n = [0.7 0; 0.7 1; 0.8 1; 0.9 0.9; 1.1 0.9; 1.1 0]' * scale;
n(1,:) = n(1,:) + 3.3;
% s
s = [1.1 0.8; 0.9 1; 0.7 0.8; 0.7 0.6; 1.1 0.4; 1.1 0.2; 0.9 0; 0.7 0.2]' * scale;
s(1,:) = s(1,:) + 4.2;

% Combine all letters into one polyline
lucens = [L, u, c, e, n, s];
% Center it
lucens(1,:) = lucens(1,:) - mean(lucens(1,:));
lucens(2,:) = lucens(2,:) - mean(lucens(2,:));
% Scale up for visibility
lucens = lucens * 3;

% Line 2: A wavy string passing through the text
nStringPoints = 100;
stringX = linspace(-8, 8, nStringPoints);
stringY = 2 * sin(stringX * 0.8) + 0.5 * cos(stringX * 2.5);
string = [stringX; stringY];

%% Find intersections
intersections = findLineIntersectionsFnc(lucens, string);

%% Plot
figure('Name', 'findLineIntersectionsFnc Test', 'Position', [100 100 600 600]);
hold on;
axis equal;
grid on;

% Plot "Lucens"
plot(lucens(1,:), lucens(2,:), 'b-', 'LineWidth', 3, 'DisplayName', '"Lucens"');

% Plot the string
plot(string(1,:), string(2,:), 'm-', 'LineWidth', 1.5, 'DisplayName', 'String');

% Plot intersections
scatter(intersections(1,:), intersections(2,:), 50, 'black', 'filled', ...
    'MarkerEdgeColor', 'k', 'LineWidth', 1, 'DisplayName', 'Intersections');

title(sprintf('%d Intersections Found', size(intersections, 2)));
xlabel('X');
ylabel('Y');
legend('Location', 'northeast');

fprintf('\n=== Test Complete ===\n');
