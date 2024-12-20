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
    assert_equal(@hash_of_twelve.get(@keys_array[6]), @values_array[6], 'Failed to retrieve correct value.')
    assert_equal(@hash_of_thirteen.get('moon'), 'silver', 'Failed to retrieve correct value.')
  end

  def test_get_with_absent_key
    assert_nil(@hash_of_twelve.get('moon'), 'Did not give nil value when getting absent key.')
    assert_nil(@hash_of_thirteen.get('Peter'), 'Did not give nil value when getting absent key.')
  end
  
  def test_capacity
    assert_equal(@hash_of_twelve.capacity, 16, 'Capacity not 16 with length 12.')
    assert_equal(@hash_of_thirteen.capacity, 32, 'Capacity not 32 with length 13.')
  end
  
  def test_has_present_key
    assert(@hash_of_twelve.has?(@keys_array[0]), 'Failed to find key.')
    assert(@hash_of_thirteen.has?('moon'), 'Failed to find key after capacity doubled.')
  end

  def test_has_absent_key
    assert_equal(@hash_of_twelve.has?('moon'), false, 'Found absent key.')
    assert_equal(@hash_of_thirteen.has?('Peter'), false, 'Found absent key.')
  end

  def test_return_value_when_remove_present_key
    assert_equal(@hash_of_twelve.remove(@keys_array[0]), @values_array[0], 'Did not return value of removed key.')
    assert_equal(@hash_of_thirteen.remove(@keys_array[6]), @values_array[6], 'Did not return value of removed key.')
  end

  def test_return_value_when_remove_absent_key
    assert_nil(@hash_of_twelve.remove('moon'), 'Failed to return nil when removing absent key.')
    assert_nil(@hash_of_thirteen.remove('Peter'), 'Failed to return nil when removing absent key.' )
  end

  def test_hash_state_after_removing_present_key
    @hash_of_twelve.remove(@keys_array[0])
    assert_nil(@hash_of_twelve.get(@keys_array[0]), 'Gave a value for a removed key.')
    assert_equal(@hash_of_twelve.length, 11, 'Removing key failed to reduce hash length.')
    @hash_of_thirteen.remove(@keys_array[8])
    assert_nil(@hash_of_thirteen.get(@keys_array[8]), 'Gave a value for a removed key.')
    assert_equal(@hash_of_thirteen.length, 12, 'Removing a key failed to reduce hash length.')
  end

  def test_length
    assert_equal(@hash_of_twelve.length, 12, 'Length not correct.')
    assert_equal(@hash_of_thirteen.length, 13, 'Length not correct.')
  end

  def test_clear
    @hash_of_twelve.clear
    assert_equal(@hash_of_twelve.length, 0, 'Clear method failed to make length zero.')
    assert_nil(@hash_of_twelve.get(@keys_array[9]), 'Clear method did not remove every key.')
  end

  def test_keys
    assert_equal(@hash_of_twelve.keys.sort, @keys_array.sort, 'Keys method did not return the supplied keys.')
    assert_equal(@hash_of_thirteen.keys.sort, @keys_array.push('moon').sort, 'Keys method did not return the supplied keys.')
    # these tests work because the @keys_array, followed by 'moon' are alphabetically comparable, otherwise
    # the sort method is not necessarily stable.
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