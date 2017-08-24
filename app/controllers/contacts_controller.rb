require_relative '../gateways/contact_gateway'

class ContactsController < ApplicationController
    def initialize
        @contact_gateway = ContactGateway.new
    end

    def index
        @segmentation_id = params[:segmentation_id]
        # get segmentation filters
        # make groups
        # filter by groups
        ### select * from contacts where (group 0) or (group 1) or (group 2)
        # @contacts = Contact.where('(name like ? and age >= ? and state = ?) or (name like ? and age >= ? and state = ?)', '%h%', 15, 'SC', '%h%', 10, 'SP')

        if @segmentation_id
            @contacts = []
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
