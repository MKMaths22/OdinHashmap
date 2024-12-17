require './hashmap'
require './linkedlist'
require 'minitest/autorun'

class HashMapTest < Minitest::Test
    def test_creating_simple_hash
        hash = HashMap.new
        hash.set('name', 'Peter')
        assert(hash.has?('name'), 'Failed to find key')
    end
end