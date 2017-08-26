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
        assert_equal '(_field_ = "_value_")', query_builder.get_query
    end

    test "When passed filter Contains" do
        filter = get_segmentantion_filter('_field_', ContainsFilterEntity.new.get_operator_name, '_value_')
        query_builder = SegmentationFilterQueryBuilder.new([filter])
        assert_equal '(_field_ like "%_value_%")', query_builder.get_query
    end

    test "When passed filter StartsWith" do
        filter = get_segmentantion_filter('_field_', StartsWithFilterEntity.new.get_operator_name, '_value_')
        query_builder = SegmentationFilterQueryBuilder.new([filter])
        assert_equal '(_field_ like "_value_%")', query_builder.get_query
    end

    test "When passed filter FinishWith" do
        filter = get_segmentantion_filter('_field_', FinishWithFilterEntity.new.get_operator_name, '_value_')
        query_builder = SegmentationFilterQueryBuilder.new([filter])
        assert_equal '(_field_ like "%_value_")', query_builder.get_query
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

    def get_segmentantion_filter(field, operation, value)
        return SegmentationFilter.new({
            'group': 0,
            'field': field,
            'operation': operation,
            'value': value
        })
    end
end
