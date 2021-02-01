class Node
  attr_accessor :value, :ref

  def initialize(value, ref=nil)
    @value = value
    @ref = ref
  end

  def to_s
    "Value: #{@value}"
  end
end

class LinkedList
  attr_accessor :tail, :head

  def initialize
    @head = nil
  end

  def prepend(value)
    previous_head = @head
    @head = Node.new(value, previous_head)
  end
  
  def append(value)
    if @head
      find_tail.ref = Node.new(value)
    else
      @head = Node.new(value)
    end
  end

  def append_after(target, value)
    node = find(target)
    
    return unless node

    old_ref = node.ref

    node.ref= Node.new(value)
    node.ref.ref = old_ref
  end

  def find(value)
    node = @head

    return node if node.value == value

    while node = node.ref
      return node if node.value == value
    end
  end
  
  def delete(value)
    if @head.value == value
      @head = @head.ref
      return
    end

    node = find_before(value)
    node.ref = node.ref.ref
  end

  def find_before(value)
    node = @head
    
    return if !node.ref
    return node if node.ref.value == value
    
    while node = node.ref
      return node if node.ref && node.ref.value == value
    end
  end

  def print
    node = @head
    puts node

    while node = node.ref
      puts node
    end
  end

  private

  def find_tail  
    node = @head

    while node.ref
      node = node.ref
    end
    
    node
  end
end
