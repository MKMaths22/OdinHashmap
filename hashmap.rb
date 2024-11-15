class HashMap
    
    require './linkedlist'

    def initialize(load_factor = 0.75, capacity = 16)
        @capacity = capacity
        @buckets = Array.new(capacity) { Bucket.new }
        @load_factor = load_factor
        @entries = 0
    end
    
    def hash(key)
        hash_code = 0
        prime_number = 31
        key.each_char { |char| hash_code = (prime_number * hash_code) + char.ord }
        hash_code
    end

    def need_to_grow_buckets?
        @entries > (@load_factor * @capacity)
        # will be private in final version
    end

    def set(key, value)

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

class Bucket
    def initialize(keys_array = [], values_array = [])
        @keys_array = keys_array
        @values_array = values_array
        @bucket_list = nil
        @bucket_one_node = nil
        populate_bucket
    end

    def populate_bucket
        
    end
end

# hash = HashMap.new
# list = LinkedList.new(['a', 'b'], ['1'])
# puts "List head is #{list.head}, with key #{list.head.key} and value #{list.head.value} \n The next key is #{list.head.next_node.key} with value #{list.head.next_node.value}"
