import Vapor

/// Register your application's routes here.
public func routes(_ app: Application) throws {
    // Basic "It works" example
    app.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    app.get("hello") { req in
        return "Hello, world!"
    }

//    let minecraftPlayerLinkController = MinecraftPlayerLinkController()
//    app.post("authenticate/minecraft", use: minecraftPlayerLinkController.index))

    try app.register(collection: PlayerAuthenticateController())

    // Example of configuring a controller
//    let todoController = TodoController()
//    router.get("todos", use: todoController.index)
//    router.post("todos", use: todoController.create)
//    router.delete("todos", Todo.parameter, use: todoController.delete)

//    let authMiddleware = Account.basicAuthMiddleware(using: BCryptDigest())

//    router.grouped(authMiddleware) { router in
//        
//    }
}
