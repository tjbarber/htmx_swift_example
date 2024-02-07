import Vapor 

enum ContactDataStoreErrors: Error {
    case emailNotUnique
}

extension ContactDataStoreErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .emailNotUnique:
                return NSLocalizedString(
                    "Email is not unique",
                    comment: ""
                )
        }
    }
}

class ContactDataStore {
    var contacts: [Contact]
    var nextPrimaryKey: Int {
        return contacts.count + 1
    }
    
    private init() {
        contacts = [
            Contact(id: 1, name: "John", email: "jd@gmail.com"),
            Contact(id: 2, name: "Clara", email: "cd@gmail.com"),
        ]
    }

    static let sharedInstance = ContactDataStore()

    func add(_ passedContact: Contact) throws -> Contact? {
        for contact in contacts {
            if contact.email == passedContact.email {
                throw ContactDataStoreErrors.emailNotUnique
            }
        } 

        // this is bad code and I hate it but it is what it is so I can mock a
        // primary key
        let contact = Contact(id: nextPrimaryKey, name: passedContact.name, email: passedContact.email)
        contacts.append(contact)
        return contact
    }

    func deleteContact(by id: Int) {
        guard let index = contacts.firstIndex(where: { $0.id == id }) else { return }
        contacts.remove(at: index)
    }
}


