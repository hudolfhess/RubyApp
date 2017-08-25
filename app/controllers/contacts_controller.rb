require_relative '../gateways/contact_gateway'
require_relative '../entities/segmentation_filters_entity'

class ContactsController < ApplicationController
    def initialize
        @contact_gateway = ContactGateway.new
    end

    def index
        @segmentation_id = params[:segmentation_id]

        if @segmentation_id
            @segmentation_filters = SegmentationFilter.where('segmentation_id = ?', @segmentation_id)
            @segmentation_query_builder = SegmentationFilterQueryBuilder.new(@segmentation_filters)
            @queryWhere = @segmentation_query_builder.get_query

            @contacts = Contact.where(@queryWhere)
        else
            @contacts = @contact_gateway.get_all_contacts
        end
    end

    def new
        @contact = Contact.new
    end

    def edit
        @contact = Contact.find(params[:id])
    end

    def create
        @contact = @contact_gateway.add_new_contact(contact_params)
        if @contact.errors.any? == false
            redirect_to @contact
        else
            render 'new'
        end
    end

    def update
        @contact = @contact_gateway.update_contact(params[:id], contact_params)
        if @contact.errors.any? == false
            redirect_to @contact
        else
            render 'edit'
        end
    end

    def show
        @contact = @contact_gateway.find_contact_by_id(params[:id])
    end

    private
        def contact_params
            params.require(:contact).permit(:name, :email, :age, :state, :occupation)
        end
end
