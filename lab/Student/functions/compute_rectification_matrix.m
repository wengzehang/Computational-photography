% H = compute_rectification_matrix(points1, points2)
%
% Method: Determines the mapping H * points1 = points2
% 
% Input: points1, points2 of the form (4,n) 
%        n has to be at least 5
%
% Output:  H (4,4) matrix 
% 

function H = compute_rectification_matrix( points1, points2 )

%------------------------------
% TODO: FILL IN THIS PART
    h = zeros(1,16)';
    
    % initialize Q, check valid paris, like in compute_homography.m
    pairnum = 0;
    for i=1:size(points2,2)
        if ~isnan(points2(1,i))
            pairnum = pairnum + 1;
        end
    end
%     Q = zeros(16,3*pairnum);
    W = [];
    
    % find all the pairs (using nan infor) and construct alpha, beta
    % matrices
    for i=1:size(points2,2)
        if ~isnan(points2(1,i))
%             p2 = points2(:,i);
%             x= p2(1); y=p2(2); z=p2(3); w=p2(4);
%             pcorrect = points1(:,i);
%             xcorrect = pcorrect(1);
%             ycorrect = pcorrect(2);
%             zcorrect = pcorrect(3);
%             wcorrect = pcorrect(4);
            pwrong = points1(:,i);
            pcorrect = points2(:,i);
            x= pwrong(1); y=pwrong(2); z=pwrong(3); w=pwrong(4);
            xcorrect = pcorrect(1);
            ycorrect = pcorrect(2);
            zcorrect = pcorrect(3);
            wcorrect = pcorrect(4);
            
            w1 = [x,y,z,w,0,0,0,0,0,0,0,0,-x*xcorrect,-y*xcorrect,-z*xcorrect,-w*xcorrect];
            w2 = [0,0,0,0,x,y,z,w,0,0,0,0,-x*ycorrect,-y*ycorrect,-z*ycorrect,-w*ycorrect];
            w3 = [0,0,0,0,0,0,0,0,x,y,z,w,-x*zcorrect,-y*zcorrect,-z*zcorrect,-w*zcorrect];
            W = [W;w1;w2;w3];
        end
    end
    
    [U, S, V] = svd(W);
    % pick the eigenvector correspond to the minimum eigenvalue
    h = V(:, end);
    
    % reshape the h to H and return
    H = reshape(h,4,4)';
    
end