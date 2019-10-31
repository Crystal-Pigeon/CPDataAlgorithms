//
//  CPQueueLinkedList.swift
//  CP-Data-Algorithms
//
//  Created by Mariana Samardzic on 10/25/19.
//  Copyright © 2019 Crystal Pigeon. All rights reserved.
//

import Foundation

public class CPQueueLinkedList<T>: CPQueue {
    private var list = CPDoublyLinkedList<T>()
    public init() {}
    
    public var peek: T? {
        return list.first?.value
    }
    public var isEmpty: Bool {
        return list.isEmpty
    }
    
    /**
     Function that adds the element at the end of the queue
     - parameter element: The element that should be added
     - Complexity: O(1)
     - returns: true if the element is added
     */
    public func enqueue(_ element: T) -> Bool {
        list.append(element)
        return true
    }
    
    /**
     Function that removes the element at the front of the queue
     - Complexity: O(1)
     - returns: true removed element
     */
    public func dequeue() -> T? {
        guard !list.isEmpty, let element = list.first else {
            return nil
        }
        return list.remove(element)
    }
}

extension CPQueueLinkedList: CustomStringConvertible {
    public var description: String {
        return String(describing: list)
    }
}

