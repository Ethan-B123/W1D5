require_relative 'skeleton/lib/00_tree_node.rb'

class KnightPathFinder
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

  end


end

knight = KnightPathFinder.new

p knight.new_move_positions([1,1])

#
# if __file__ == $PROGRAM_NAME
#
# end
