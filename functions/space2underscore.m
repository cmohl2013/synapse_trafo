%function [outstr]=space2underscore(str)
%transforms spaces in strings to underscores

function [outstr]=space2underscore(str)

str(isspace(str))='_';
outstr=str;
end

