# frozen_string_literal: true

# The Linked List class contains methods for linked lists
class LinkedList
    attr_reader :size, :head
  
    # size and head methods taken care of by attr_reader
  
    def initialize(keys_array = [], values_array = [])
      # only works if the keys are unique. Could write code that checks this, but this is
      # not relevant for the Hashmap project.
      @head = nil
      @size = keys_array.size
      keys_array.each_with_index do |key, index|
        current_node = Node.new(key, values_array[index], @head)
        change_head(current_node)
        # if values array is too short for keys array nil values will be used. If too many values in values array, excess values are ignored
      end
    end
  
    def valid_index?(index, num)
      (0..num).include?(index) && index.integer?
      # checks if index = 0, 1, .... or num
    end
  
    # def at(index)
    #  return nil unless valid_index?(index, size - 1)
  
      # makes sure the index supplied is valid, return nil otherwise
  
    #  current_node = @head
    #  index.times { current_node = current_node.next_node }
      # head has index zero, so we need to move to the next node index times
    #  current_node
    # end
  
    # def tail
    #  at(size - 1)
      # at method already has guard clause in case size = 0
    # end
  
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

    def get_value(key)
      list_each_with_index(nil) { |node, index| return node.value if node.key == key }
      nil
      # returns nil if list is empty or if no node has the required key
    end

    def find(key)
        list_each_with_index(nil) { |node, index| return index if node.key == key }
        nil
    end

    def remove_key(key)
        list_each_with_index do |current_node, index|
          previous_node = previous_node.next_node if previous_node
          previous_node = @head if index == 1
          if current_node.key == key
            remove_current_node(current_node, previous_node)
            return current_node.value
          end
        end
        nil
    end
  
    # def to_s
    #   output_string = ''
    #   list_each_with_index { |node| output_string += " Key: #{node.key}, Value: #{node.value} -> " }
    #   output_string + 'nil'
    # end

    def output_entries
      output_array = []
      list_each_with_index { |node| output_array.push([node.key, node.value]) }
      output_array
    end

    def output_data(data)
      # uses send method so data should be (:key) or (:value) as required
      output_array = []
      list_each_with_index { |node| output_array.push(node.send(data)) }
      output_array
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

    def append(key, value)
      insert_at(key, value, size)
    end
  
    def pop
      remove_at(size - 1)
    end

    # Many methods in this class will be redundant for the Hashmap, I will delete them later as necessary
    def prepend_or_update(key, value)
        update(key, value) ? 'updated' : prepend(key, value)
    end

    def update(key, value)
        # returns the node updated, or nil if key was not present
        list_each_with_index do |node|
            if node.key == key
                node.value = value
                return node
            end
        end
        nil
    end

    def prepend(key, value)
        change_head(Node.new(key, value, @head))
        increment_size
    end

    def prepend_node(node)
        node.next_node = @head
        change_head(node)
        increment_size
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

    def remove_current_node(current_node, previous_node = nil)
      previous_node ? previous_node.next_node = current_node.next_node : change_head(current_node.next_node)
      decrement_size
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
  
  # my_list = LinkedList.new(['name', 'age'], ['Peter', '43'])
  # puts "my_list keys are #{my_list.output_data(:key)}"
  # puts "the values are #{my_list.output_data(:value)}"
  # my_list.prepend('new_key', 'new_value')
  # puts "my_list entries are now #{my_list}"
  
  # my_list.remove_at(0)
  # puts my_list.find(4)
  # p my_list.remove_at(0)
  # p my_list.remove_at(0)
  # p my_list.remove_at(2)
  # p my_list.remove_at(1)
  # my_list.append(10)
  # puts my_list