class PolyTreeNode
  attr_reader :children, :value, :parent
  def initialize(value)
    @value = value
    @children = []
    @parent = nil
  end 

  def parent=(assigned_parent)
    original_parent = @parent
     #@parent.children.select! { |child| child != self } if @parent != nil
        #if current_parent != passed_node/future parent
    if @parent != assigned_parent 
        @parent = assigned_parent
        if !@parent.nil? && !@parent.children.include?(self)
            @parent.children << self
            original_parent.children.select! { |node| node != self } if !original_parent.nil?
           # @parent.add_child(self)
           # original_parent.remove_child(self) unless original_parent.nil?
        end 
    end 
  end

  def add_child(child)
    self.children << child
    child.parent = self
  end

  def remove_child(child)
    #self.children.select! { |node| node != child } if !self.nil?
    raise "node is not a child" if child.parent != self
    child.parent = nil
  end

  def dfs(value)
   # stack = []
   # stack.unshift(self)
    
     return self if self.value == value
#
     self.children.each do |child|
        search_result = child.dfs(value)
        return search_result unless search_result.nil?
     end
   #  
   #  nil
    # self.children.each {|child| stack.unshift(child)}
   # until stack.empty?
   #     cur = stack.shift
   #     cur.children.each {|child| stack.unshift(child)}
   #     return cur if cur.value == value
   # end 

    nil
  end

  def bfs(target)
    queue = [self]
                                     # node 1

    until queue.empty?
        cur = queue.shift                             # n3, [n4, n5, n6, n7]
        return cur if cur.value == value              # false
        queue.concat(cur.children)
        #cur.children.each {|child| queue.push(child)} # [n4, n5, n6, n7, n8, n9]
    end 
    nil
  end 
end


         #       1
         #    2 3 4 5   
         #   6 7 8 9 10
#
#
#
# 2.dfs(9)      | [6, 7, 8, 9, 10]   | node 6 | -
# 1.dfs(9)      | [2, 3, 4, 5]       | node 2 | -
# ---------------------------------------------------------
# function call | stack              | cur    | return value

# base case : self.value == value
#
# stack = [2, 3, 4, 5, 6, 7, 8, 9, 10]
#  
# if self.children.empty? 
# look at the next child = 2 -> self.children[0]
# if nil -> we didn't find the value
#   
# 
#
#node_1.dfs => stack [2,3,4,5]
#node_2.dfs => stack [3,4,5]
#node_3.dfd => stach [7,4,5]
         #       1
         #    2 3 4 5   
         #   6 7 8 9 10





#('a'..'g').map { |value| PolyTreeNode.new(value) }


#node_1 = PolyTreeNode.new(1) #child 
#
#node_2 = PolyTreeNode.new(2) #parent #node_2 is node_1's parent 
#
#node_3 = PolyTreeNode.new(3)
#
#node_1.parent = node_3 # node.parent = node_3, node_3.children = [node_1]
#node_1.parent = node_2 # node_1 = self  # node_2 = node = @parent
#remove node_1 from node_3's children 
#node.children = [] << self


# node_1.parent == node_3

