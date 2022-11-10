function MA=myreshape(MB)
MC = permute(MB,[3,2,1]);
MA = reshape(MC, numel(MC), 1);
end