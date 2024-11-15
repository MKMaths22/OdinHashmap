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
    def initialize
        @bucket_state = 'empty'
        # bucket_state will be 'empty', 'onenode' or 'linkedlist' for 0,1, or 2 or more entries respectively
    end
end

hash = HashMap.new