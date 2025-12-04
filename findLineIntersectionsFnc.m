function [intersections] = findLineIntersectionsFnc(vec1,vec2)
% findLineInersectionsFnc finds every intersect of the lines defined by two
% 2xn&k vectors of points, points must be ordered along lines
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% by Vitex Lucens, vitexLucens.org
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input
%   - vec1 = { 2xn vector of points defining a line in 2D }
%   - vec2 = { 2xk vector of points defining a line in 2D }
%
% Output
%   - intersections = { 2xp vector containing every intersection of the lines defined by vec1 and vec2}
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
intersections = [];
tol = 1e-12;

for id1 = 1:1:size(vec1,2)-1
    minDistance1 = norm(vec1(:,id1) - vec1(:,id1+1));

    for id2 = 1:1:size(vec2,2)-1
        minDistance2 = norm(vec2(:,id2) - vec2(:,id2+1));

        % Points in 2D
        pt1 = vec1(:,id1);
        pt2 = vec1(:,id1+1);
        pt3 = vec2(:,id2);
        pt4 = vec2(:,id2+1);
        
        % Move to 3D plane
        p1 = [pt1; 1];
        p2 = [pt2; 1];
        p3 = [pt3; 1];
        p4 = [pt4; 1];

        % Take cross products, move to 2D, and normalise
        L1 = cross(p1,p2);
        L2 = cross(p3,p4);
        P  = cross(L1,L2);
        if abs(P(3)) < 1e-12
            continue;
        end
        Pf = [P(1);P(2)]./P(3);

        % Check if its a true intersection (with tolerance for boundary cases)
        d1 = norm(pt1 - Pf);
        d2 = norm(pt2 - Pf);
        d3 = norm(pt3 - Pf);
        d4 = norm(pt4 - Pf);

        if max(d1, d2) <= minDistance1 + tol && max(d3, d4) <= minDistance2 + tol
            intersections = [intersections, Pf];
        end
            
    end
end

end