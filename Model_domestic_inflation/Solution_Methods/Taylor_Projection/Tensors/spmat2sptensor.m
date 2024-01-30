function [ A ] = spmat2sptensor( spmat )
%convert sparse matrix to sparse tensor
%can be improved by mexing (its basically a transpose)
%
% © Copyright, Oren Levintal, June 13, 2016.
% bug fixed on January 20, 2017 (a row vector produced an error)
[i,j,vals]=find(spmat);
[l,m]=size(spmat);
A=sptensor(i(:),j(:),vals(:)',l,m);

end

