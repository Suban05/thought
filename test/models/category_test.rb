# frozen_string_literal: true

require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  setup do
    @category = categories(:one)
  end
  test 'name should not be empty' do
    @category.name = nil
    assert_not @category.valid?
  end

  test 'name should be filled' do
    @category.name = 'category'
    assert @category.valid?
  end
end
