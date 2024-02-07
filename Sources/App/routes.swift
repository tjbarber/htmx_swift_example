import Vapor

func routes(_ app: Application) throws {
    app.get { req throws in
        req.view.render("index", [
            "contacts": ContactDataStore.sharedInstance.contacts
        ])
    }

    app.post("contacts") { req async throws -> Response in
        var contact = try req.content.decode(Contact.self)

        do {
            // this is bad code but heck it
            contact = try ContactDataStore.sharedInstance.add(contact)!
        } catch {
            return try await req.view
                .render("form", FormViewContext(contact: contact, errorMessage: error.localizedDescription))
              .encodeResponse(status: .unprocessableEntity, for: req)
        }

        return try await req.view.render("oob-contact", ["contact": contact]).encodeResponse(for: req)
    }

    app.delete("contacts", ":id") { req async throws -> Response in
        guard let idStr = req.parameters.get("id"), let id = Int(idStr) else {
            throw Abort(.notAcceptable)
        }

        ContactDataStore.sharedInstance.deleteContact(by: id)
        return Response()
    }
}
