require './hashmap'
require './linkedlist'
require 'minitest/autorun'

class HashMapTest < Minitest::Test
  def setup
    @hash_of_twelve = HashMap.new
    @keys_array = %w[apple banana carrot dog elephant frog grape hat ice\ cream jacket kite lion]
    @values_array = %w[red yellow orange brown grey green purple black white blue pink golden]
    @keys_array.each_with_index do |key, index|
        @hash_of_twelve.set(key, @values_array[index])
    end
  end
    
  def test_default_capacity
    assert_equal(@hash_of_twelve.capacity, 16)
  end
  
  def test_has_key
    assert(@hash_of_twelve.has?('apple'), 'Failed to find key')
  end

  def test_length
    assert_equal(@hash_of_twelve.length, 12, 'Length not correct')
  end

  def test_overwrite_maintains_length
    @hash_of_twelve.set(@keys_array[3], 'white')
    assert_equal(@hash_of_twelve.length, 12, 'Length not maintained when overwriting value')
  end

  def test_overwrite_changes_value
    @hash_of_twelve.set(@keys_array[3], 'white')
    value = @hash_of_twelve.get(@keys_array[3])
    assert_equal(value, 'white', 'Overwritten value not correct')
  end

  def test_overwrite_maintains_capacity
    old_capacity = @hash_of_twelve.capacity
    @hash_of_twelve.set(@keys_array[3], 'white')
    assert_equal(@hash_of_twelve.capacity, old_capacity, 'Capacity not maintained when overwriting value')
  end
end