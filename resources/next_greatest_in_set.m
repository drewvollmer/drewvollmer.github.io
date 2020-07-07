% next_greatest_in_set.m
% Recursive binary search returning the index of the search_set array entry that is greater than or
% equal to, and closest to, the input value.  Useful when rounding in discrete state spaces.
% Drew Vollmer 02-28-2017


function index = next_greatest_in_set(value, search_set)

    % Make sure that the input set is sorted. Attach boolean to descending order
    is_descending = issorted( search_set(length(search_set):-1:1) );

    if is_descending;
        search_set = search_set(length(search_set):-1:1);
    elseif ~issorted(search_set);
        error('Error: input search_set not sorted.')
    end;

    % Take some middle value to check (will be 1 in a two-element vector)
    middle_index = ceil(length(search_set) / 2);

    % Base cases: value is greater than everything in the search set
    % (error); one element is left in the search set and is greater than
    % the value
    if (value > search_set(end));
        error('Error: no weakly greater value found.');

    elseif (length(search_set) == 1);
        index = 1;

    elseif (value <= search_set(middle_index + 1)) && (value > search_set(middle_index));
        index = middle_index + 1;

    elseif value > search_set(middle_index + 1);
        index = middle_index + 1 + next_greatest_in_set(value, search_set( (middle_index + 2):end));

    elseif value <= search_set(middle_index);
        index = next_greatest_in_set(value, search_set( 1:middle_index ));
    end;

    % Account for descending-order
    if is_descending;
        index = length(search_set) + 1 - index;
    end;

end
