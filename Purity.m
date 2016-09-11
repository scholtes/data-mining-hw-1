function [ max_purity, max_class ] = Purity( matrix, class_col )
%Compute purity of a decision tree leaf node
    
    max_purity = 0;
    class_mode = 0;
    
    classes = matrix(:,class_col);
    unique_classes = unique(classes);
    num_entries = size(matrix,1);
    
    for class_ = unique_classes'
        total = sum(classes == class_);
        if total > class_mode 
            max_purity = total / num_entries;
            max_class = class_;
            class_mode = total;
        end            
    end

end

