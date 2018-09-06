//
//  Task.swift
//  TasksOnFire
//
//  Created by Soon Yin Jie on 5/9/18.
//  Copyright © 2018 Tinkertanker. All rights reserved.
//

import Foundation
import Firebase

struct Task {
    
    var name: String
    var completed: Bool
    var addedByUser: String
    var ref: DatabaseReference?
    
    func toDictionary() -> Any {
        return [
            "name": name,
            "completed": completed,
            "addedByUser": addedByUser
        ]
    }
    
}
