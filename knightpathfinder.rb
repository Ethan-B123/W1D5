require_relative 'skeleton/lib/00_tree_node.rb'

class KnightPathFinder
  attr_reader :move_tree
  def initialize(position = [0,0])
    @move_tree = PolyTreeNode.new(position)
    @position = position
    @visited_positions = [position]
  end

  def self.valid_moves(pos)  # array of possible moves
    changes = [[1,2],[2,1], [-1,2],[-2,1], [1,-2],[2,-1], [-1,-2],[-2,-1]]
    changes.map! {|xy| [ xy[0]+pos[0], xy[1]+pos[1] ]}
    changes.select do |xy|
      xy.all? {|coordinate| coordinate >= 0 && coordinate < 8}
    end
  end

  def new_move_positions(pos)  # calls the ::valid_moves class method and
    # filters out any positions that are already in @visited_positions;
    # It should then add the remaining new positions to @visited_positions
    #  and return these new positions.
    possible = KnightPathFinder.valid_moves(pos)
    possible.reject! {|xy| @visited_positions.include?(xy)}
    @visited_positions.concat(possible)
    possible
  end

  def build_move_tree
    @move_tree
    queue = [@move_tree]
    until queue.empty?
      grow_from = queue.shift
      moves_possible = new_move_positions(grow_from.value)
      moves_possible.each do |new_spot|
        working_node = PolyTreeNode.new(new_spot)
        working_node.parent = grow_from
        queue << working_node
      end
    end
  end

  def find_node(pos)
    @move_tree.bfs(pos)
  end

  def find_path(pos)
    target_node = find_node(pos)
    trace_path_back(target_node)
  end

  def trace_path_back(node)
    parent, ret_val = node.parent, [node.value]
    while parent
      ret_val << parent.value
      parent = parent.parent
    end
    ret_val.reverse
  end

  def get_depth_board
    build_move_tree
    depth = Array.new(8){ Array.new(8){ [] } }
    (0..7).each do |x|
      (0..7).each do |y|
        depth[x][y] = find_node([x,y]).depth
      end
    end
    depth
  end

  def render_board
    depth = get_depth_board
    depth.each do |row|
      p row
    end
  end

end
