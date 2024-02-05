import Vapor

struct FormViewContext: Encodable {
    var contact: Contact?
    var errorMessage: String?
}
