require_relative  "00_tree_node.rb"
require "byebug"

class KnightPathFinder
    attr_reader :start_pos, :move_tree

    def self.valid_moves(pos)
        #
      row, col = pos.value
      valid_moves = []
      #move_tree << move_right_up(start_pos) if move_right_up(start_pos)

      if col + 2 <= 7
        if row + 1 <= 7
            valid_moves << PolyTreeNode.new([row + 1, col + 2])
        end
        if row - 1 >= 0
            valid_moves << PolyTreeNode.new([row - 1, col + 2])
        end
      end

      if row + 2 <= 7
        if col + 1 <= 7
            valid_moves << PolyTreeNode.new([row + 2, col + 1])
        end
        if col - 1 >= 0
            valid_moves << PolyTreeNode.new([row +2, col - 1])
        end
      end

      if row - 2 >= 0
        if col + 1 <= 7
            valid_moves << PolyTreeNode.new([row - 2, col + 1])
        end
        if col - 1 >= 0
            valid_moves << PolyTreeNode.new([row - 2, col - 1])
        end
      end

      if col - 2 >= 0
        if row + 1 <= 7
            valid_moves << PolyTreeNode.new([row + 1, col - 2])
        end
        if row - 1 >= 0
            valid_moves << PolyTreeNode.new([row - 1, col - 2])
        end
      end

      valid_moves
    end 

    def initialize(start_pos = [0,0])
      @start_pos = PolyTreeNode.new(start_pos)
      #@move_tree = self.build_move_tree(start_pos)
      @considered_positions = [@start_pos.value]
    end

    def new_move_pos(pos)
       # 
        possible_moves = KnightPathFinder.valid_moves(pos).select { |node| !@considered_positions.include?(node.value) }
        possible_moves.each { |node| node.parent = pos  }
        possible_moves.each { |node| @considered_positions << node.value }
        possible_moves
    end

    def build_move_tree
        queue = [@start_pos]
        move_tree = [@start_pos]

        
        until queue.empty?
            current_position = queue.shift
            next_moves = new_move_pos(current_position)
            next_moves.each { |node| queue << node }
            next_moves.each { |node| move_tree << node }
        end

        

        move_tree
    end

    def find_path(end_pos)
        #
        move_tree = build_move_tree

        until move_tree.empty?
          current_position = move_tree.shift
  
          if current_position.value == end_pos
            puts "hello"
            return parent_finder(current_position)
          end
        end
    end

    def parent_finder(node)
        return node.value if node.parent.nil?
        path = [node.value]

        cur_parent = node.parent
        path.unshift(cur_parent.value)
        return parent_finder(cur_parent) + path

        path
    end

    # def build_move_tree(start_pos)
    #   row, col = start_pos
    #   move_tree = []
    #   #move_tree << move_right_up(start_pos) if move_right_up(start_pos)

    #   if col + 2 <= 7
    #     if row + 1 <= 7
    #         move_tree << PolyTreeNode.new([row + 1, col + 2])
    #     end
    #     if row - 1 >= 0
    #         move_tree << PolyTreeNode.new([row - 1, col + 2])
    #     end
    #   end

    #   if row + 2 <= 7
    #     if col + 1 <= 7
    #         move_tree << PolyTreeNode.new([row + 2, col + 1])
    #     end
    #     if col - 1 >= 0
    #         move_tree << PolyTreeNode.new([row +2, col - 1])
    #     end
    #   end

    #   if row - 2 >= 0
    #     if col + 1 <= 7
    #         move_tree << PolyTreeNode.new([row - 2, col + 1])
    #     end
    #     if col - 1 >= 0
    #         move_tree << PolyTreeNode.new([row - 2, col - 1])
    #     end
    #   end

    #   if col - 2 >= 0
    #     if row + 1 <= 7
    #         move_tree << PolyTreeNode.new([row + 1, col - 2])
    #     end
    #     if row - 1 >= 0
    #         move_tree << PolyTreeNode.new([row - 1, col - 2])
    #     end
    #   end
    #   move_tree
    # end

  #  def move_right_up(start_pos)
  #      if col + 2 <= 7
  #          if row + 1 <= 7
  #              return PolyTreeNode.new([row + 1, col + 2])
  #          end
  #      end
  #      nil
  #  end

   # def move_left_up(start_pos)
   #     if col + 2 <= 7
   #         if row - 1 >= 0
   #             move_tree << PolyTreeNode.new([row - 1, col + 2])
   #         end
   #     end
   # end 
#
   # def move_left_down(start_pos)
   #     if col - 2 >= 0
   #         if row - 1 >= 0
   #             move_tree << PolyTreeNode.new([row - 1, col - 2])
   #         end
   #   end
   # end


    
end 

knight = KnightPathFinder.new([4, 4])
knight.build_move_tree
p knight.find_path([2, 3])