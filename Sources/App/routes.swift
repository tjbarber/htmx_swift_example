import Vapor

func routes(_ app: Application) throws {
    app.get { req throws in
        req.view.render("index", [
            "contacts": ContactDataStore.sharedInstance.contacts
        ])
    }

    app.post("contacts") { req async throws -> Response in
        let contact = try req.content.decode(Contact.self)

        do {
            _ = try ContactDataStore.sharedInstance.add(contact)
        } catch {
            return try await req.view
                .render("form", FormViewContext(contact: contact, errorMessage: error.localizedDescription))
              .encodeResponse(status: .unprocessableEntity, for: req)
        }

        return try await req.view.render("oob-contact", ["contact": contact]).encodeResponse(for: req)
    }
}
