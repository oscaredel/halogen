//
//  IdeaController.swift
//  
//
//  Created by Oscar Edel on 22/04/2022.
//

import Fluent
import Vapor

struct IdeaController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let ideas = routes.grouped("ideas")
        ideas.get(use: index)
        ideas.post(use: create)
    }
    
    // /ideas route
    func index(req: Request) throws -> EventLoopFuture <[Idea]> {
        return Idea.query(on: req.db).all()
    }
    
    func create(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let idea = try req.content.decode(Idea.self)
        return idea.save(on: req.db).transform(to: .ok)
    }
}
