//
//  CPQueueArray.swift
//  CP-Data-Algorithms
//
//  Created by Mariana Samardzic on 10/25/19.
//  Copyright © 2019 Crystal Pigeon. All rights reserved.
//

import Foundation

public struct CPQueueArray<T>: CPQueue {
    private var array: [T] = []
    public init() {}
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    public var peek: T? {
        return array.first
    }
    /**
     Function that adds the element at the end of the queue
     - parameter element: The element that should be added
     - Complexity: O(1)
     - returns: true if the element is added
     */
    public mutating func enqueue(_ element: T) -> Bool {
        array.append(element)
        return true
    }
    /**
     Function that removes the element from the front of the queue
     - Complexity: O(n)
     - returns: the removed element
     */
    public mutating func dequeue() -> T? {
        return isEmpty ? nil: array.removeFirst()
    }
}
extension CPQueueArray: CustomStringConvertible {
    public var description: String {
        return String(describing: array)
    }
}
