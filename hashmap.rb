class HashMap
    def hash(key)
        hash_code = 0
        prime_number = 31
        key.each_char { |char| hash_code = (prime_number * hash_code) + char.ord }
        hash_code
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