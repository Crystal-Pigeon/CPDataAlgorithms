//
//  DoublyLinkedList.swift
//  CP-Data-Algorithms
//
//  Created by Mariana Samardzic on 10/25/19.
//  Copyright © 2019 Crystal Pigeon. All rights reserved.
//

import Foundation

public class CPNodeDoublyLinked<T> {
    
    public var value: T
    public var next: CPNodeDoublyLinked<T>?
    public var previous: CPNodeDoublyLinked<T>?
    
    public init(value: T) {
        self.value = value
    }
}

extension CPNodeDoublyLinked: CustomStringConvertible {
    
    public var description: String {
        return String(describing: value)
    }
}

public class CPDoublyLinkedList<T> {
    
    private var head: CPNodeDoublyLinked<T>?
    private var tail: CPNodeDoublyLinked<T>?
    
    public init() { }
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var first: CPNodeDoublyLinked<T>? {
        return head
    }
    
    public func append(_ value: T) {
        let newNode = CPNodeDoublyLinked(value: value)
        
        guard let tailNode = tail else {
            head = newNode
            tail = newNode
            return
        }
        
        newNode.previous = tailNode
        tailNode.next = newNode
        tail = newNode
    }
    
    public func remove(_ CPNodeDoublyLinked: CPNodeDoublyLinked<T>) -> T {
        let prev = CPNodeDoublyLinked.previous
        let next = CPNodeDoublyLinked.next
        
        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        
        next?.previous = prev
        
        if next == nil {
            tail = prev
        }
        
        CPNodeDoublyLinked.previous = nil
        CPNodeDoublyLinked.next = nil
        
        return CPNodeDoublyLinked.value
    }
}

extension CPDoublyLinkedList: CustomStringConvertible {
    
    public var description: String {
        var string = ""
        var current = head
        while let CPNodeDoublyLinked = current {
            string.append("\(CPNodeDoublyLinked.value) -> ")
            current = CPNodeDoublyLinked.next
        }
        return string + "end"
    }
}

public class LinkedListIterator<T>: IteratorProtocol {
    
    private var current: CPNodeDoublyLinked<T>?
    
    init(CPNodeDoublyLinked: CPNodeDoublyLinked<T>?) {
        current = CPNodeDoublyLinked
    }
    
    public func next() -> CPNodeDoublyLinked<T>? {
        defer { current = current?.next }
        return current
    }
}

extension CPDoublyLinkedList: Sequence {
    
    public func makeIterator() -> LinkedListIterator<T> {
        return LinkedListIterator(CPNodeDoublyLinked: head)
    }
}
