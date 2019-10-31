//
//  CPStack.swift
//  CP-Data-Algorithms
//
//  Created by Mariana Samardzic on 10/22/19.
//  Copyright © 2019 Crystal Pigeon. All rights reserved.
//

import Foundation
/**
 Stack is a data structure in which you can only add or remove elements from one side of the structure. Elements that are pushed in last are the first ones to be popped out
 */
public struct CPStack<Element> {
    private var storage: [Element] = []
    public init() {}
    public init(_ elements: [Element]) {
        storage = elements
    }
    public var isEmpty: Bool {
        return peek() == nil
    }
    
    /**
     Function that adds a value to the stack
     - parameter element: The value that should be added to the stack
     - Complexity: O(1)
     */
    public mutating func push(_ element: Element) {
        storage.append(element)
    }
    /**
     Function that removes a value from the stack
     - Complexity: O(1)
     - returns: the removed value
     */
    public mutating func pop() -> Element? {
        return storage.popLast()
    }
    /**
     Function returns the value that is at the top of the stack
     - Complexity: O(1)
     - returns: the last value of the stack
     */
    public func peek() -> Element? {
        return storage.last
    }
    
}

extension CPStack: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        storage = elements
    }
}

extension CPStack: CustomStringConvertible {
    public var description: String {
        let topDivider = "---top---\n"
        let bottomDivider = "\n-----------"
        
        let stackElements = storage
            .map {"\($0)"}
            .reversed()
            .joined(separator: "\n")
        return topDivider + stackElements + bottomDivider
    }
}
