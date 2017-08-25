require_relative '../entities/segmentation_filters_entity'

class SegmentsController < ApplicationController
    def index
        @segments = Segmentation.all
    end

    def new
        @segment = Segmentation.new
        @string_filters = [
            EqualFilterEntity.new.get_operator_name,
            ContainsFilterEntity.new.get_operator_name,
            StartsWithFilterEntity.new.get_operator_name,
            FinishWithFilterEntity.new.get_operator_name
        ]
        @integer_filters = [
            EqualFilterEntity.new.get_operator_name,
            GreaterThanFilterEntity.new.get_operator_name,
            LowerThanFilterEntity.new.get_operator_name,
            GreaterOrEqualThanFilterEntity.new.get_operator_name,
            LowerOrEqualThanFilterEntity.new.get_operator_name
        ]
        @fields = [
            {
                'name': 'name',
                'filters': @string_filters
            },
            {
                'name': 'email',
                'filters': @string_filters
            },
            {
                'name': 'age',
                'filters': @integer_filters
            },
            {
                'name': 'state',
                'filters': @string_filters
            },
            {
                'name': 'occupation',
                'filters': @string_filters
            }
        ]
    end
    
    def create
        @segmentation = Segmentation.new(segment_params)
        @segmentation.save
        @filters = segment_filters_params

        @filters.each do |filter|
            filter['segmentation'] = @segmentation
            @segmentation_filter = SegmentationFilter.new(filter)
            @segmentation_filter.save
        end

        redirect_to segments_path
    end

    private
        def segment_params
            params.require(:segment).permit(:name)
        end

        def segment_filters_params
            @filtersToSave = []
            @fields = params[:'filter-field']
            @filters = params[:'filter-filter']
            @values = params[:'filter-value']

            @fields.each do |group, fs|
                fs.each do |fieldKey, fieldName|
                    @filtersToSave += [{
                        'group': group.to_i,
                        'field': fieldName,
                        'operation': @filters[group][fieldKey],
                        'value': @values[group][fieldKey]
                    }]
                end
            end

            return @filtersToSave
        end
end
