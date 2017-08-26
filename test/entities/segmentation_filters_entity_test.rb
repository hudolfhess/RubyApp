require 'test_helper'
require_relative '../../app/entities/segmentation_filters_entity'

class EqualFilterEntityTests < ActionView::TestCase
    test "Operator name should be Equal" do
        filter = EqualFilterEntity.new
        assert_equal 'Equal', filter.get_operator_name
    end

    test "Get subquery value" do
        filter = EqualFilterEntity.new
        field = '__field__'
        value = '__value__'
        assert_equal '__field__ = "__value__"', filter.get_query(field, value)
    end
end

class ContainsFilterEntityTests < ActionView::TestCase
    test "Operator name should be Contains" do
        filter = ContainsFilterEntity.new
        assert_equal 'Contains', filter.get_operator_name
    end

    test "Get subquery value" do
        filter = ContainsFilterEntity.new
        field = '__field__'
        value = '__value__'
        assert_equal '__field__ like "%__value__%"', filter.get_query(field, value)
    end
end

class StartsWithFilterEntityTests < ActionView::TestCase
    test "Operator name should be StartsWith" do
        filter = StartsWithFilterEntity.new
        assert_equal 'StartsWith', filter.get_operator_name
    end

    test "Get subquery value" do
        filter = StartsWithFilterEntity.new
        field = '__field__'
        value = '__value__'
        assert_equal '__field__ like "__value__%"', filter.get_query(field, value)
    end
end
