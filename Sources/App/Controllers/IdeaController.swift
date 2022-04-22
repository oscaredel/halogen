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
        ideas.put(use: update)
        ideas.group(":ideaID") { idea in
            idea.delete(use: delete)
        }
    }
    
    // GET Request /ideas
    func index(req: Request) throws -> EventLoopFuture <[Idea]> {
        return Idea.query(on: req.db).all()
    }
    
    // POST Request /ideas route
    func create(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let idea = try req.content.decode(Idea.self)
        return idea.save(on: req.db).transform(to: .ok)
    }
    
    // PUT Request /ideas route
    func update(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let idea = try req.content.decode(Idea.self)
        
        return Idea.find(idea.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {
                $0.title = idea.title
                return $0.update(on: req.db).transform(to: .ok)
            }
    }
    
    // DELETE Request /ideas/id route
    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        Idea.find(req.parameters.get("ideaID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}
