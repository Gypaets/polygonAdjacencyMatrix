# polygonAdjacencyMatrix
Polygon adjacency matrix calculation for triangulations using MATLAB.

## Definition
polygonAdjacencyMatrix calculates the adjacency matrix of the polygons defined with a connectivity list cL. All polygons should have the same number of sides. Fast and fully vectorized approach.

## Usage
pAM = polygonAdjacencyMatrix(cL)

* Input:

 cL: (n x m) connectivity list of the triangulation (n polygons with m sides each).

* Output:

 pAM: (n x n) polygon adjacency matrix.
