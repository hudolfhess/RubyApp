class ContactGateway
    def get_all_contacts()
        return Contact.all
    end

    def find_contact_by_id(id)
        return Contact.find(id)
    end

    def add_new_contact(contact)
        @contact = Contact.new(contact)
        @contact.save
        return @contact
    end

    def update_contact(id, contact)
        @contact = find_contact_by_id(id)
        @contact.update(contact)
        return @contact
    end
end
