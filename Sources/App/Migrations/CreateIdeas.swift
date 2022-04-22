//
//  CreateIdeas.swift
//  
//
//  Created by Oscar Edel on 22/04/2022.
//

import Fluent

struct CreateIdeas: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("ideas")
            .id()
            .field("title", .string, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("ideas").delete()
    }
    
    
}
