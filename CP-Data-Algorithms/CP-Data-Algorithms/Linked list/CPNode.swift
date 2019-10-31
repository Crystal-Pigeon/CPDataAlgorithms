//
//  CPNode.swift
//  CP-Data-Algorithms
//
//  Created by Mariana Samardzic on 10/22/19.
//  Copyright © 2019 Crystal Pigeon. All rights reserved.
//

import Foundation
/**
 A node is a class that is used in linked lists.It holds a value of a certain type and it holds a reference to the next node in a list
 */
public class CPNode<Value> {
    
    public var value: Value
    public var next: CPNode?
    
    /**
     Creating a new node
     - parameter value: The value that the node contains
     - parameter next: The node that should be after this node in a linked list
     */
    public init(value: Value, next: CPNode? = nil) {
        self.value = value
        self.next = next
    }
}

extension CPNode: CustomStringConvertible {
    public var description: String {
        guard let next = next else {
            return "\(value)"
        }
        return "\(value) -> " + String(describing: next) + " "
    }
}
