% Demo routine for LAMBDA
%
% An example data file will be used with:
%
% a       float ambiguity vector (n x 1)
% Q       variance matrix of float ambiguities (n x n)
%
% OUTPUT
%
% a_ILS   ILS solution (n x 2) (best and second-best candidate vector)
% a_B     Bootstrapping solution (n x 1)
% a_R     Rounding solution (n x 1)
% a_PAR   PAR solution (n x 1) with min.required success rate of 0.995
% a_RT    Solution of ILS with fixed failure rate Ratio Test
% sqnorm  Squared norms of ambiguity residuals (1 x 2) of best and
%         second-best ILS solution
% Ps      Bootstrapping success rate
% PsPAR   Bootstrapping success rate with PAR
% Qzhat   Variance matrix of decorrelated float ambiguities
% Z       Transformation matrix
% nPAR    Number of fixed ambiguities with PAR
% nRT     Number of fixed ambiguities with Ratio Test 
%         (0 if rejected, n if accepted)
% mu      Threshold value used for Ratio Test
%
% Below the 'return' command, more useful examples can be found on how to 
% use the main LAMBDA routine with the different options
%
%------------------------------------------------------------------
% DATE    : 04-MAY-2012                                          
% Author  : Sandra VERHAGEN                                             
%           GNSS Research Centre, Curtin University
%           Mathematical Geodesy and Positioning, Delft University of
%           Technology 
%------------------------------------------------------------------
% Modifiziert für Satellitennavigation Übung 1
% 27.4.2021 D.Becker INS
%------------------------------------------------------------------
addpath(genpath(pwd));
% Specify the file which contains the float solution: a and Q
load amb10

%   method: 1: ILS method based on search-and-shrink [DEFAULT]
%           2: ILS method based enumeration in search
%           3: integer rounding method
%           4: integer bootstrapping method

[a_ILS,sqnorm]                    = LAMBDA(a,Q,1,'ncands',2);
[a_ILS2,sqnorm2]                  = LAMBDA(a,Q,2,'ncands',2);
[a_R]                             = LAMBDA(a,Q,3);
[a_B]                             = LAMBDA(a,Q,4);

