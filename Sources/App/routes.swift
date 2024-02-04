import Vapor

class Count {
    var count = 0
    
    private init() {}

    static let sharedInstance = Count()
}

func routes(_ app: Application) throws {
    app.get { req throws in
        try req.view.render("index", ["count": Count.sharedInstance.count])
    }

    app.post("count") { req async throws -> View in
       Count.sharedInstance.count += 1
       return try await req.view.render("count", ["count": Count.sharedInstance.count])
    }
}
