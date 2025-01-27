class HashMap
    
    require './linkedlist'

    attr_reader :length, :capacity, :load_factor, :buckets

    def initialize(load_factor = 0.75, capacity = 16)
        @capacity = capacity
        @buckets = Array.new(capacity) { LinkedList.new }
        @load_factor = load_factor
        @length = 0
    end
    
    def hash(key)
        hash_code = 0
        prime_number = 31
        key.each_char { |char| hash_code = (prime_number * hash_code) + char.ord }
        hash_code
    end

    def set(key, value)
        linked_list = linked_list_from_key(key)
        unless linked_list.prepend_or_update(key, value) == 'updated'
            increment_length
            grow_buckets if need_to_grow_buckets?
        end
    end

    def grow_buckets
        new_capacity = 2 * @capacity
        new_buckets = Array.new(new_capacity) { LinkedList.new }
        @buckets.each do |list|
            # we can prepend each node onto its new LinkedList without checking for duplicate keys, because they are already unique
            list.list_each_with_index do |node|
                bucket_number = hash(node.key) % new_capacity
                new_list = new_buckets[bucket_number]
                new_list.prepend_node(Node.new(node.key, node.value))
                # we need to make a copy to prepend the node to the new list, otherwise 
                # the behaviour of list_each_with_index is affected because the node.next_node changes.
            end
        end
        @buckets = new_buckets
        @capacity = new_capacity
    end
    # PROBLEM here, want to tell linked list to increment it's size but that is a private method.
            # If I use the insert_at, or prepend methods to add to the end of the list, the list is
            # being traversed for a second time. How to avoid this?
            # SOLUTION: I have already changed the Node class to include keys and values, so modify the LinkedList methods
            # to only allow unique keys. Redundant methods from the old LinkedList class can be removed later. In the
            # meantime, give the LinkedList a #append_or_update method which accepts (key, value) and either updates or appends as 
            # necessary. Because it is a LinkedList method, it can use the private #increment_size method. Similarly for
            # deleting from the Hashmap and decrement_size.

    def get(key)
      linked_list_from_key(key).get_value(key)
    end

    def has?(key)
      linked_list_from_key(key).contains?(key)
    end

    def remove(key)
      output = linked_list_from_key(key).remove_key(key)
      decrement_length if output
      output
    end

    def clear
      initialize
    end
    
    def entries
      output_array = []
      @buckets.each do |list|
        list.output_entries.each do |entry|
          output_array.push(entry)
        end
      end
      output_array
    end

    def get_data(data)
      output_array = []
      @buckets.each do |list|
        list.output_data(data).each do |datum|
          output_array.push(datum)
        end
      end
      output_array
    end

    def values
      get_data(:value)
    end

    def keys
      get_data(:key)
    end

    def no_of_buckets_used
      output = 0
      @buckets.each do |list|
        output = output + 1 if list.head
      end
      output
    end

    private

    def linked_list_from_key(key)
      # returns the linked_list object associated with a key
      bucket_number = hash(key) % @capacity
      @buckets[bucket_number]
    end
    
    def need_to_grow_buckets?
        @length > (@load_factor * @capacity)
    end
    
    def increment_length
        @length = length + 1
    end

    def decrement_length
        @length = length - 1
    end
end

# list = LinkedList.new(['first_key'], ['first_value'])
# puts "created list has length #{list.size}"
# list.remove_key(list.head.key)
# puts "list now has length #{list.size}"
# Above lines confirmed that remove_current_node works with no previous node (i.e. removing the head).