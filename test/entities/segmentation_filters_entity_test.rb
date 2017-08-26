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

class FinishWithFilterEntityTests < ActionView::TestCase
    test "Operator name should be FinishWith" do
        filter = FinishWithFilterEntity.new
        assert_equal 'FinishWith', filter.get_operator_name
    end

    test "Get subquery value" do
        filter = FinishWithFilterEntity.new
        field = '__field__'
        value = '__value__'
        assert_equal '__field__ like "%__value__"', filter.get_query(field, value)
    end
end

class LowerThanFilterEntityTests < ActionView::TestCase
    test "Operator name should be LowerThan" do
        filter = LowerThanFilterEntity.new
        assert_equal 'LowerThan', filter.get_operator_name
    end

    test "Get subquery value" do
        filter = LowerThanFilterEntity.new
        field = '__field__'
        value = '__value__'
        assert_equal '__field__ < __value__', filter.get_query(field, value)
    end
end


class LowerOrEqualThanFilterEntityTests < ActionView::TestCase
    test "Operator name should be LowerOrEqualThan" do
        filter = LowerOrEqualThanFilterEntity.new
        assert_equal 'LowerOrEqualThan', filter.get_operator_name
    end

    test "Get subquery value" do
        filter = LowerOrEqualThanFilterEntity.new
        field = '__field__'
        value = '__value__'
        assert_equal '__field__ <= __value__', filter.get_query(field, value)
    end
end
