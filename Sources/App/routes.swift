import Vapor
import Authentication

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }

    let minecraftPlayerLinkController = MinecraftPlayerLinkController()
    router.post("authenticate/minecraft", use: minecraftPlayerLinkController.index)

    // Example of configuring a controller
//    let todoController = TodoController()
//    router.get("todos", use: todoController.index)
//    router.post("todos", use: todoController.create)
//    router.delete("todos", Todo.parameter, use: todoController.delete)

    let authMiddleware = Account.basicAuthMiddleware(using: BCryptDigest())

//    router.grouped(authMiddleware) { router in
//        
//    }
}
