class HashMap
    
    require './linkedlist'

    def initialize(load_factor = 0.75, capacity = 16)
        @capacity = capacity
        @buckets = Array.new(capacity) { LinkedList.new }
        @load_factor = load_factor
        @entries_counter = 0
    end
    
    def hash(key)
        hash_code = 0
        prime_number = 31
        key.each_char { |char| hash_code = (prime_number * hash_code) + char.ord }
        hash_code
    end

    def need_to_grow_buckets?
        @entries_counter > (@load_factor * @capacity)
        # will be private in final version
    end

    def set(key, value)
        bucket_number = hash(key) % @capacity
        linked_list = @buckets[bucket_number]
        linked_list.list_each_with_index do |node|
            if node.key == key
                node.value == value
                return
            end
            next if node.next_node
            new_node = Node.new(key, value, nil)
            node.next_node = new_node
            # PROBLEM here, want to tell linked list to increment it's size but that is a private method.
            # If I use the insert_at, or prepend methods to add to the end of the list, the list is
            # being traversed for a second time. How to avoid this?
            # SOLUTION: I have already changed the Node class to include keys and values, so modify the LinkedList methods
            # to only allow unique keys. Redundant methods from the old LinkedList class can be removed later. In the
            # meantime, give the LinkedList a #appendorupdate method which accepts (key, value) and either updates or appends as 
            # necessary. Because it is a LinkedList method, it can use the private #increment_size method. Similarly for
            # deleting from the Hashmap and decrement_size.
        end

    end

    def get(key)

    end

    def has?(key)

    end

    def remove(key)

    end

    def length

    end

    def keys

    end

    def values

    end

    def entries

    end
end

# hash = HashMap.new
# list = LinkedList.new(['a', 'b'], ['1'])
# puts "List head is #{list.head}, with key #{list.head.key} and value #{list.head.value} \n The next key is #{list.head.next_node.key} with value #{list.head.next_node.value}"
