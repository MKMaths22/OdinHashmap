require './hashmap'
require './linkedlist'
require 'minitest/autorun'

class HashMapTest < Minitest::Test
  def setup
    @hash_of_twelve = HashMap.new
    @hash_of_thirteen = HashMap.new
    @keys_array = %w[apple banana carrot dog elephant frog grape hat ice\ cream jacket kite lion]
    @values_array = %w[red yellow orange brown grey green purple black white blue pink golden]
    @keys_array.each_with_index do |key, index|
        @hash_of_twelve.set(key, @values_array[index])
        @hash_of_thirteen.set(key, @values_array[index])
    end
    @hash_of_thirteen.set('moon', 'silver')
  end
    
  def test_get_with_present_key 
    assert_equal(@hash_of_twelve.get(@keys_array[6]), @values_array[6], 'Failed to retrieve correct value')
    assert_equal(@hash_of_thirteen.get('moon'), 'silver', 'Failed to retrieve correct value')
  end

  def test_get_with_absent_key
    assert_nil(@hash_of_twelve.get('moon'), 'Did not give nil value when getting absent key')
  end
  
  def test_capacity
    assert_equal(@hash_of_twelve.capacity, 16, 'Capacity not 16 with length 12')
    assert_equal(@hash_of_thirteen.capacity, 32, 'Capacity not 32 with length 13')
  end
  
  def test_has_present_key
    assert(@hash_of_twelve.has?(@keys_array[0]), 'Failed to find key')
    assert(@hash_of_thirteen.has?('moon'), 'Failed to find key after capacity doubled')
  end

  def test_has_absent_key
    assert_equal(@hash_of_twelve.has?('moon'), false, 'Found absent key')
    assert_equal(@hash_of_thirteen.has?('Peter'), false, 'Found absent key')
  end

  def remove_present_key

  end

  def remove_absent_key

  end

  def test_length
    assert_equal(@hash_of_twelve.length, 12, 'Length not correct')
  end

  def test_clear

  end

  def test_keys

  end

  def test_values

  end

  def test_entries

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