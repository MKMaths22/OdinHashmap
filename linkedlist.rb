# frozen_string_literal: true

# The Linked List class contains methods for linked lists
class LinkedList
    attr_reader :size, :head
  
    # size and head methods taken care of by attr_reader
  
    def initialize(keys_array = [], values_array = [])
      previous_node = nil
      @head = nil
      @size = keys_array.size
      keys_array.each_with_index do |key, index|
        current_node = Node.new(key, values_array[index])
        # if values array is too short for keys array nil values will be used. If too many values in values array, excess values are ignored
        index.zero? ? change_head(current_node) : previous_node.next_node = current_node
        # either we are dealing with the head node or there is a previous node, but not both
        previous_node = current_node
      end
    end
  
    def valid_index?(index, num)
      (0..num).include?(index) && index.integer?
      # checks if index = 0, 1, .... or num
    end
  
    def at(index)
      return nil unless valid_index?(index, size - 1)
  
      # makes sure the index supplied is valid, return nil otherwise
  
      current_node = @head
      index.times { current_node = current_node.next_node }
      # head has index zero, so we need to move to the next node index times
      current_node
    end
  
    def tail
      at(size - 1)
      # at method already has guard clause in case size = 0
    end
  
    def list_each_with_index(default_output = nil)
      return default_output if size.zero?
  
      current_node = head
      current_index = 0
      size.times do
        yield current_node, current_index
        current_node = current_node.next_node
        current_index += 1
      end
    end
  
    def contains?(value)
      list_each_with_index(false) { |node| return true if node.value == value }
      false
      # returns false only if none of the nodes had the required value
    end

    def contains?(key)
      list_each_with_index(false) { |node| return true if node.key == key }
      false
    end
  
    def find(value)
      list_each_with_index(nil) { |node, index| return index if node.value == value }
      nil
      # returns nil if list is empty or if no node had the required value
    end

    def find(key)
        list_each_with_index(nil) { |node, index| return index if node.key == key }
        nil
    end
  
    def to_s
      output_string = ''
      list_each_with_index { |node| output_string += "( Key: #{node.key} ), Value: #{node.value} -> " }
      output_string + 'nil'
    end
  
    def insert_at(key, value, index)
      return 'Error, index not valid' unless valid_index?(index, size)
  
      # checks index provided will fit in the given list
  
      node_to_add = Node.new(key, value, at(index))
      # if index = size, at(index) returns nil which is correct
  
      index.zero? ? change_head(node_to_add) : at(index - 1).next_node = node_to_add
      # either we insert a new head or previous node has link changed but not both
      increment_size
    end
  
    def remove_at(index)
      return unless valid_index?(index, size - 1)
  
      # checks index provided appears in the given list
  
      removed_node = at(index)
      index.zero? ? change_head(at(1)) : at(index - 1).next_node = removed_node.next_node
      # if list had only one node, at(1) is nil so head becomes nil.
      # similarly if index = size - 1 the removed node had next_node = nil so this
      # property transfers to the previous node
      decrement_size
      removed_node
    end
  
    def prepend(key, value)
      insert_at(key, value, 0)
    end
  
    def append(key, value)
      insert_at(key, value, size)
    end
  
    def pop
      remove_at(size - 1)
    end

    # Many methods in this class will be redundant for the Hashmap, I will delete them later as necessary
    def append_or_update(key, value)
        if @size.zero?
            @head = Node.new(key, value, nil)
            increment size
            return
        end
        list_each_with_index do |node|
            if node.key == key
                node.value = value
                return
            end
            next if node.next_node
            node.next_node = Node.new(key, value, nil)
            increment_size
        end
    end
  
    private
  
    def change_head(node)
      @head = node
    end
  
    def increment_size
      @size = size + 1
    end
  
    def decrement_size
      @size = size - 1
    end
  end
  
  # The Node class contains methods for nodes of a linked list
  class Node
    attr_accessor :key, :value, :next_node
  
    def initialize(key = nil, value = nil, next_node = nil)
      @key = key
      @value = value
      @next_node = next_node
    end
  end
  
  # my_list = LinkedList.new([1, 2, 4, 5])
  # my_list.remove_at(0)
  # puts my_list.find(4)
  # p my_list.remove_at(0)
  # p my_list.remove_at(0)
  # p my_list.remove_at(2)
  # p my_list.remove_at(1)
  # my_list.append(10)
  # puts my_list