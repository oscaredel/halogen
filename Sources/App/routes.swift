import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return req.view.render("index", ["title": "Hello Vapor!"])
    }

    app.get("hello", ":name") { req -> String in
        let name = req.parameters.get("name")
        return "Hello, \(name ?? "world")!"
    }
    app.get("foo") { req -> String in
        return "bar"
    }
    
    try app.register(collection: IdeaController())
}
