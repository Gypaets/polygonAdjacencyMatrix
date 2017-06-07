function pAM = polygonAdjacencyMatrix(cL)
%% Definition
% polygonAdjacencyMatrix calculates the adjacency matrix of the polygons
%  defined with a connectivity list cL. All polygons should have the same
%  number of edges. Fast and fully vectorized approach.
%
%% Usage
% Input:
%   cL: (n x m) connectivity list of the triangulation (n polygons with m
%   edges each).
% 
% Output:
%   pAM: (n x n) polygon adjacency matrix.
%
%% Examples
% % Create triangulation from 100000 random points
% pointsC=rand(100000,2);
% X=pointsC(:,1);
% Y=pointsC(:,2);
% tri=delaunayTriangulation(X,Y);
% % Extract connectivity list
% cL=tri.ConnectivityList;
% % Calculate polygon adjacency matrix
% tic
% pAM = polygonAdjacencyMatrix(cL);
% toc
%
%% Author
% Gypaets
%
%% Function
%
% Triangulation size
nV = max(cL(:)); % Number of vertex in triangulation
nP = size(cL,1); % Number of polygons in triangulation
pS = size(cL,2); % Polygon size

% Vertex adjacency matrix
[lr, lc] = find(sparse(reshape(cL(:,1:pS).',[],1),reshape(cL(:,[2:pS, 1]).',[],1),1,nV,nV));
vertexAM = spfun(@(x) x>0, sparse(lr,lc,1,nV,nV) + sparse(lr,lc,1,nV,nV)');
clear lr lc

% Polygon to vertex adjacency matrix (nP x nV)
polygonVertexAM = sparse(cL(:),repmat(1:nP,[1 pS]),1,nV,nP)';

% Matrix with all edges (nE x 2)
[lr lc] = find(triu(vertexAM));
edges = [lr lc];
clear lr lc

% Number of edges in triangulation
nE = length(edges);

% Polygons to edges adjacency matrix (nP x nE)
weightedVertexEdgeAM = sparse(edges(:),[1:nE 1:nE],1,nV,nE);
edgePolygonAM = spfun(@(x) x-1, polygonVertexAM*weightedVertexEdgeAM);

% Edges connected to two different polygons
indic = find(sum(edgePolygonAM)==2);

% Index of polygons connected to innerEdges
[pI, ~] = find(edgePolygonAM(:,indic));

% Indices to create polygon adjacency matrix
l = reshape(pI, [2, length(pI)/2])';
l1 = l(:,1);
l2 = l(:,2);

% Polygon adjacency matrix
pAM = sparse([l1 l2],[l2 l1],1,nP,nP);

end