import Vapor

struct Contact: Content {
    var id: Int?
    let name: String
    let email: String
}

