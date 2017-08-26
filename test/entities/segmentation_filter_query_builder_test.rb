require 'test_helper'
require_relative '../../app/entities/segmentation_filters_entity'

class SegmentationFilterQueryBuilderTests < ActiveSupport::TestCase
    test "Should be empty when QueryBuilder initialized with empty list" do
        query_builder = SegmentationFilterQueryBuilder.new([])
        assert_equal '', query_builder.get_query
    end

    test "When passed filter Equal" do
        filter = get_segmentantion_filter('_field_', EqualFilterEntity.new.get_operator_name, '_value_')
        query_builder = SegmentationFilterQueryBuilder.new([filter])
        assert_equal '(_field_ = \'_value_\')', query_builder.get_query
    end

    test "When passed filter Contains" do
        filter = get_segmentantion_filter('_field_', ContainsFilterEntity.new.get_operator_name, '_value_')
        query_builder = SegmentationFilterQueryBuilder.new([filter])
        assert_equal '(_field_ like \'%_value_%\')', query_builder.get_query
    end

    test "When passed filter StartsWith" do
        filter = get_segmentantion_filter('_field_', StartsWithFilterEntity.new.get_operator_name, '_value_')
        query_builder = SegmentationFilterQueryBuilder.new([filter])
        assert_equal '(_field_ like \'_value_%\')', query_builder.get_query
    end

    test "When passed filter FinishWith" do
        filter = get_segmentantion_filter('_field_', FinishWithFilterEntity.new.get_operator_name, '_value_')
        query_builder = SegmentationFilterQueryBuilder.new([filter])
        assert_equal '(_field_ like \'%_value_\')', query_builder.get_query
    end

    test "When passed filter GreaterThan" do
        filter = get_segmentantion_filter('_field_', GreaterThanFilterEntity.new.get_operator_name, '_value_')
        query_builder = SegmentationFilterQueryBuilder.new([filter])
        assert_equal '(_field_ > _value_)', query_builder.get_query
    end

    test "When passed filter LowerThan" do
        filter = get_segmentantion_filter('_field_', LowerThanFilterEntity.new.get_operator_name, '_value_')
        query_builder = SegmentationFilterQueryBuilder.new([filter])
        assert_equal '(_field_ < _value_)', query_builder.get_query
    end

    test "When passed filter GreaterOrEqualThan" do
        filter = get_segmentantion_filter('_field_', GreaterOrEqualThanFilterEntity.new.get_operator_name, '_value_')
        query_builder = SegmentationFilterQueryBuilder.new([filter])
        assert_equal '(_field_ >= _value_)', query_builder.get_query
    end

    test "When passed filter LowerOrEqualThan" do
        filter = get_segmentantion_filter('_field_', LowerOrEqualThanFilterEntity.new.get_operator_name, '_value_')
        query_builder = SegmentationFilterQueryBuilder.new([filter])
        assert_equal '(_field_ <= _value_)', query_builder.get_query
    end

    test "Should separate by AND operator when has two or more filters in the same group" do
        filter_1 = get_segmentantion_filter('_field_', LowerOrEqualThanFilterEntity.new.get_operator_name, '_value_', 0)
        filter_2 = get_segmentantion_filter('_field_', EqualFilterEntity.new.get_operator_name, '_value_', 0)
        query_builder = SegmentationFilterQueryBuilder.new([filter_1, filter_2])
        assert_equal '(_field_ <= _value_ AND _field_ = \'_value_\')', query_builder.get_query
    end

    test "Should separate different groups with OR operator" do
        filter_1 = get_segmentantion_filter('_field_', EqualFilterEntity.new.get_operator_name, '_value_', 0)
        filter_2 = get_segmentantion_filter('_field_', LowerOrEqualThanFilterEntity.new.get_operator_name, '_value_', 0)
        filter_3 = get_segmentantion_filter('_field_', EqualFilterEntity.new.get_operator_name, '_value_', 1)
        filter_4 = get_segmentantion_filter('_field_', LowerOrEqualThanFilterEntity.new.get_operator_name, '_value_', 1)
        query_builder = SegmentationFilterQueryBuilder.new([filter_1, filter_2, filter_3, filter_4])
        assert_equal '(_field_ = \'_value_\' AND _field_ <= _value_) OR (_field_ = \'_value_\' AND _field_ <= _value_)', query_builder.get_query
    end

    def get_segmentantion_filter(field, operation, value, group = 0)
        return SegmentationFilter.new({
            'group': group,
            'field': field,
            'operation': operation,
            'value': value
        })
    end
end
