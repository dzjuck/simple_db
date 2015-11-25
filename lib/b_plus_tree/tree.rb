class BPlusTree::Tree
  def initialize(size)
    @root = BPlusTree::Page::Internal.new(size)
    leaf  = BPlusTree::Page::Leaf.new(size)
    @root.insert(0, leaf)
  end

  def insert(key, value)
    leaf, path = @root.search_leaf(key) # path = [(internal1, internal2, ...) root]
    result = nil
    if leaf.can_insert?(key, value)
      result = leaf.insert(key, value)
    else
      pivot, new_leaf = split_page(key, leaf, path)
      if key < pivot
        result = leaf.insert(key, value)
      else
        result = new_leaf.insert(key, value)
      end
    end
    return true unless result.nil?
    nil
  end

  def delete(key)
    leaf, path = @root.search_leaf(key)
    leaf.delete(key)
  end

  def search(key)
    leaf, path = @root.search_leaf(key)
    leaf.search(key)
  end

  # Added by Ilya Lavrov, 22.11.2015
  # Returns the leaf
  def search_leaf(key)
    @root.search_leaf(key)
  end

  # Added by Ilya Lavrov, 22.11.2015
  # Returns the node with the smallest key that is >= the given key.
  def search_lower_bound(key)
    leaf, path = @root.search_leaf(key)
    leaf.search_lower_bound(key)
  end

  def keys
    @root.keys
  end

  private

  def split_page(key, page, path)
    pivot, new_page = page.split(key)
    parent = path.shift

    if parent.nil? # split root
      new_root = BPlusTree::Page::Internal.new(@root.max_size)
      new_root.insert(0, page)
      new_root.insert(pivot, new_page)
      @root = new_root
    elsif parent.can_insert?(pivot, new_page)
      parent.insert(pivot, new_page)
    else
      p_pivot, p_new_page = split_page(pivot, parent, path)
      if pivot < p_pivot
        parent.insert(pivot, new_page)
      else
        p_new_page.insert(pivot, new_page)
      end
    end

    return pivot, new_page
  end
end
