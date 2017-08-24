class SegmentsController < ApplicationController
    def index
        @segments = Segmentation.all
    end

    def new
        @segment = Segmentation.new
    end
end
