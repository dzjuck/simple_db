module BPlusTree
  def self.version_string
    "BPlusTree version #{VERSION}"
  end
end

require_relative "b_plus_tree/version"
require_relative "b_plus_tree/linked_list"
require_relative "b_plus_tree/tree"
require_relative "b_plus_tree/page"
require_relative "b_plus_tree/page/internal"
require_relative "b_plus_tree/page/leaf"
