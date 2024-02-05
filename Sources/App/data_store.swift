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
    
    private init() {
        contacts = [
            Contact(name: "John", email: "jd@gmail.com"),
            Contact(name: "Clara", email: "cd@gmail.com"),
        ]
    }

    static let sharedInstance = ContactDataStore()

    func add(_ newContact: Contact) throws -> Contact? {
        for contact in contacts {
            if contact.email == newContact.email {
                throw ContactDataStoreErrors.emailNotUnique
            }
        } 

        contacts.append(newContact)
        return newContact
    }
}


