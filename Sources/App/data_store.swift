import Vapor 

class ContactDataStore {
    var contacts: [Contact]
    
    private init() {
        contacts = [
            Contact(name: "John", email: "jd@gmail.com"),
            Contact(name: "Clara", email: "cd@gmail.com"),
        ]
    }

    static let sharedInstance = ContactDataStore()

    func add(_ contact: Contact) {
        contacts.append(contact)
    }
}


