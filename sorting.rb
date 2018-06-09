n = gets.chomp.to_i
n_arr = gets.chomp.split(' ').map(&:to_i)

# start_index and end_index are are the indices of the elements to be swapped or reversed
start_index = end_index = -1

# mark array sortable as default
is_sortable = true
prev_diff = 0
negative_diff_count = 0

(0..(n - 2)).each do |i|
  diff = n_arr[i + 1] - n_arr[i] # Get diff value between current index and next index

  # Break loop if
  # - Value of next index is bigger than current index's one.
  # - Next index is last item in array
  # - Value Next index is bigger than value of start_index
  break if (diff > 0) && (i == n - 2) && n_arr[start_index] < n_arr[i + 1]

  # Break loop and mark as NOT Sortable if matched one of followings:
  # - Value of next index is smaller than current index's one.
  # - Previous Diff value is positive
  # - Have at least one negative diff
  # OR
  # - Value of next index is bigger than current index's one.
  # - Next index is last item in array
  # - Value Next index is smaller than value of start_index
  if (diff < 0 && prev_diff > 0 && negative_diff_count > 0) ||
     (diff > 0 && (i == n - 2) && n_arr[start_index] > n_arr[i + 1])
    is_sortable = false
    break

  # Count negative diff and set start_index and end_index
  elsif diff < 0
    start_index = i if start_index == -1
    end_index = i + 1
    negative_diff_count += 1
  end

  prev_diff = diff
end

if !is_sortable
  puts 'no'
elsif negative_diff_count == 1
  puts 'yes'
  puts "swap #{start_index + 1} #{end_index + 1}"
elsif negative_diff_count.zero? && is_sortable
  puts 'Array is already sorted'
elsif negative_diff_count > 0 && is_sortable
  puts "yes reverse #{start_index + 1} #{end_index + 1}"
end
