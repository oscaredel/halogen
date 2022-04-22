//
//  Idea.swift
//  
//
//  Created by Oscar Edel on 22/04/2022.
//

import Fluent
import Vapor

final class Idea: Model, Content {
    static let schema = "ideas"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    init() {}
    
    init(id: UUID? = nil, title: String) {
        self.id = id
        self.title = title
    }
}
