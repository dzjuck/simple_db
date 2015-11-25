require 'simple_db'

class FinderCache
  def initialize(data_path)
    @data_path = data_path
    @dbs = {}
  end

  def data
    @data ||= DataLoader.new(@data_path).load
  end

  def all_indexes
    @all_indexes ||= hash_indexes.merge(tree_indexes)
  end

  def hash_indexes
    @hash_indexes ||= IndexBuilder::Hash.new(data).build

    {hash: @hash_indexes}
  end

  def rb_tree_indexes
    @rb_tree_indexes ||= IndexBuilder::RedBlackTree.new(data).build

    {tree: @rb_tree_indexes}
  end

  def b_plus_tree_indexes
    @b_plus_tree_indexes ||= IndexBuilder::BPlusTree.new(data).build

    {tree: @b_plus_tree_indexes}
  end
  
  def dbs(finder_class)
    if !@dbs.empty? && @dbs[finder_class.to_s].nil?
      @dbs = {}
    end
    indexes = case finder_class.to_s
      when 'Finder::FullScan'
        nil
      when 'Finder::Hash', 'Finder::Hash2'
        hash_indexes
      when 'Finder::RedBlackTree', 'Finder::RedBlackTree2'
        rb_tree_indexes
      when 'Finder::BPlusTree', 'Finder::BPlusTreeSimple'
        b_plus_tree_indexes
      else
        all_indexes
      end

    @dbs[finder_class.to_s] ||= 
      SimpleDb.new(@data_path, finder_class, data, indexes)
  end
end

