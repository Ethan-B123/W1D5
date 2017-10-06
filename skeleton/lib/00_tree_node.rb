class PolyTreeNode
  def initialize(value)  # method that sets the value, and starts parent as nil, and children to an empty array
    @parent = nil
    @children = []
    @value = value
  end

  def parent  # method that returns the node's partent
    @parent
  end

  def children  # method that returns an array of children of a node
    @children
  end

  def value  # method that returns the value stored at the node
    @value
  end

  def parent=(new_parent)  # method which (1) sets the parent property and (2) adds
    # the node to their parent's array of children (unless we're setting parent to nil).

    if @parent
      @parent.children.delete(self)
    end

    @parent = new_parent
    return @parent if !@parent #needed to be back
    @parent.children.push(self) unless @parent.children.include?(self)
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "Not a child" if !children.include?(child_node) #added for 2nd spec
    child_node.parent = nil
  end


#   Write a #dfs(target_value) method which takes a value to search for
  # and performs the search. Write this recursively.
  # First, check the value at this node. If a node's value matches the
  # target value, return the node.
  # If not, iterate through the #children and repeat.

  def dfs(target)
    return self if value == target
    return nil if children.empty?
    children.each do |child|
      child_found = child.dfs(target)
      return child_found if child_found
    end
    nil
  end

  def bfs(target)


    queue = [self]

    until queue.empty?
      node = queue.shift
      return node if node.value == target

      queue.concat(node.children)
    end

    nil
  end
end
