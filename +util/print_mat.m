function print_mat(A)
    for i = 1:size(A, 1)
        for j = 1:size(A,2)
            fprintf('%f,', A(i,j));
        end
        fprintf('\n');
    end
end