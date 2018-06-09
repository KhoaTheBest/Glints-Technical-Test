matrix_info = gets.chomp.split(' ').map(&:to_i)
M = matrix_info[0]
N = matrix_info[1]
R = matrix_info[2]

A = [].freeze
(1..M).each do
  A.push gets.chomp.split(' ').map(&:to_i)
end

puts '=============================='

def swap(item_one, item_two)
  temp = A[item_one[:row]][item_one[:col]]
  A[item_one[:row]][item_one[:col]] = A[item_two[:row]][item_two[:col]]
  A[item_two[:row]][item_two[:col]] = temp
end

def print_array
  (0..(M - 1)).each do |i|
    row = ''
    (0..(N - 1)).each do |j|
      row += "_#{(A[i][j])}"
    end
    puts row
  end
end

(1..R).each do
  start_index = 0

  while start_index < ([M, N].min / 2)
    # Shift all items in top row to left
    temp_row = A[start_index][start_index + 1]
    ((start_index + 1)..(N - start_index - 2)).each do |j|
      swap({ row: start_index, col: j }, row: start_index, col: j + 1)
    end

    # Move all items in most left col down to bottom
    temp_col = A[M - start_index - 1][start_index]
    (start_index..(M - start_index - 2)).reverse_each do |i|
      swap({ row: i, col: start_index }, row: i + 1, col: start_index)
    end
    A[start_index][start_index] = temp_row

    # Shift all items in bottom row to right
    temp_row = A[M - start_index - 1][N - start_index - 1]
    ((start_index + 1)..(N - start_index - 2)).reverse_each do |j|
      swap({ row: M - start_index - 1, col: j }, row: M - start_index - 1, col: j + 1)
    end
    A[M - start_index - 1][start_index + 1] = temp_col

    # Move all items in most right col up to top
    (start_index..(M - start_index - 2)).each do |i|
      swap({ row: i, col: N - start_index - 1 }, row: i + 1, col: N - start_index - 1)
    end
    A[M - start_index - 1][N - start_index - 1] = temp_row

    swap({ row: M - start_index - 1, col: N - start_index - 1 },
         row: M - start_index - 2, col: N - start_index - 1)

    # Continue with next inner ring.
    start_index += 1
  end
end
print_array
