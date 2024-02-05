import Vapor

func routes(_ app: Application) throws {
    app.get { req throws in
        req.view.render("index", [
            "contacts": ContactDataStore.sharedInstance.contacts
        ])
    }

    app.post("contacts") { req async throws -> View in
        let contact = try req.content.decode(Contact.self)
        ContactDataStore.sharedInstance.add(contact)

        return try await req.view.render("index", [
            "contacts": ContactDataStore.sharedInstance.contacts
        ])
    }
}
