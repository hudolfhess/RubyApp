class SegmentationFilterEntity
    @operator_name = nil
    @query_string = ''

    def get_query(field, value)
        @query = @query_string.clone
        @query.gsub! '{field}', field
        @query.gsub! '{value}', value
        return @query
    end

    def get_operator_name
        return @operator_name
    end
end

class EqualFilterEntity < SegmentationFilterEntity
    def initialize
        @operator_name = 'Equal'
        @query_string = '{field} = \'{value}\''
    end
end

class ContainsFilterEntity < SegmentationFilterEntity
    def initialize
        @operator_name = 'Contains'
        @query_string = '{field} like \'%{value}%\''
    end
end

class StartsWithFilterEntity < SegmentationFilterEntity
    def initialize
        @operator_name = 'StartsWith'
        @query_string = '{field} like \'{value}%\''
    end
end

class FinishWithFilterEntity < SegmentationFilterEntity
    def initialize
        @operator_name = 'FinishWith'
        @query_string = '{field} like \'%{value}\''
    end
end

class LowerThanFilterEntity < SegmentationFilterEntity
    def initialize
        @operator_name = 'LowerThan'
        @query_string = '{field} < {value}'
    end
end

class LowerOrEqualThanFilterEntity < SegmentationFilterEntity
    def initialize
        @operator_name = 'LowerOrEqualThan'
        @query_string = '{field} <= {value}'
    end
end

class GreaterThanFilterEntity < SegmentationFilterEntity
    def initialize
        @operator_name = 'GreaterThan'
        @query_string = '{field} > {value}'
    end
end

class GreaterOrEqualThanFilterEntity < SegmentationFilterEntity
    def initialize
        @operator_name = 'GreaterOrEqualThan'
        @query_string = '{field} >= {value}'
    end
end

class SegmentationFilterEntityFactory
    def initialize
        @filters_objects = [
            EqualFilterEntity.new,
            ContainsFilterEntity.new,
            StartsWithFilterEntity.new,
            FinishWithFilterEntity.new,
            GreaterThanFilterEntity.new,
            LowerThanFilterEntity.new,
            GreaterOrEqualThanFilterEntity.new,
            LowerOrEqualThanFilterEntity.new
        ]
    end

    def make(segmentation_filter)
        @filters_objects.each do |filter_object|
            if filter_object.get_operator_name == segmentation_filter.operation
                return filter_object
            end
        end
    end
end

class SegmentationFilterQueryBuilder
    def initialize(segmentation_filters)
        @segmentation_filters = segmentation_filters
    end

    def get_query
        @segmentation_factory = SegmentationFilterEntityFactory.new
        @groups = get_segmentation_groups
        @query = []

        @groups.each do |_,filters|
            @subqueries = []
            filters.each do |filter|
                @entity = @segmentation_factory.make(filter)
                @subqueries += [@entity.get_query(filter.field, filter.value)]
            end
            @query += ['(' + @subqueries.join(' AND ') + ')']
        end

        return @query.join(' OR ')
    end

    private
        def get_segmentation_groups
            @segmentation_groups = {}

            @segmentation_filters.each do |filter|
                if !@segmentation_groups[filter.group]
                    @segmentation_groups[filter.group] = []
                end

                @segmentation_groups[filter.group] += [filter]
            end

            return @segmentation_groups
        end
end
