//
//  CPQueueStack.swift
//  CP-Data-Algorithms
//
//  Created by Mariana Samardzic on 10/25/19.
//  Copyright © 2019 Crystal Pigeon. All rights reserved.
//

import Foundation

public struct CPQueueStack<T> : CPQueue {
    private var leftStack : [T] = []
    private var rightStack : [T] = []
    public init() {}
    
    public var isEmpty: Bool {
        return leftStack.isEmpty && rightStack.isEmpty
    }
    public var peek: T? {
        return !leftStack.isEmpty ? leftStack.last : rightStack.first
    }
    @discardableResult
    public mutating func enqueue(_ element: T) -> Bool {
        rightStack.append(element)
        return true
    }
    @discardableResult
    public mutating func dequeue() -> T? {
        if leftStack.isEmpty {
            leftStack = rightStack.reversed()
            rightStack.removeAll()
        }
        return leftStack.popLast()
    }
}
extension CPQueueStack: CustomStringConvertible {
    public var description: String {
        let printList = leftStack.reversed() + rightStack
        return String(describing: printList)
    }
}

