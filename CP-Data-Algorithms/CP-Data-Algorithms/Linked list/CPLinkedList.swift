//
//  CPNode.swift
//  CP-Data-Algorithms
//
//  Created by Mariana Samardzic on 10/22/19.
//  Copyright © 2019 Crystal Pigeon. All rights reserved.
//

import Foundation


/**
 Linked list is a collection of values arranged in a linear unidirectional sequence. The advantages of using a linked list over an array
 are constant time insertion and removal from the front of the list and reliable performance characteristics. A linked list is a chain of nodes, where a head is the first node in the list and a tail is the last node in the list
 */
public struct CPLinkedList<Value> {
    
    public var head: CPNode<Value>?
    public var tail: CPNode<Value>?
    public var isEmpty: Bool {
        return head == nil
    }
    
    public init(){}
    
    /**
     Function that adds a value at the beginning of the linked list
     - parameter value: The value that should be added at the beginning of the linked list
     - Complexity: O(1)
     */
    public mutating func push(_ value: Value) {
        copyNodes()
        head = CPNode(value: value, next: head)
        if tail == nil {
            tail = head
        }
    }
    
    /**
     Function that adds a value at the end of the linked list
     - parameter value: The value that should be added at the end of the linked list
     - Complexity: O(1)
     */
    public mutating func append(_ value: Value) {
        copyNodes()
        guard !isEmpty else {
            push(value)
            return
        }
        tail!.next = CPNode(value: value)
        tail = tail!.next
    }
    
    /**
     Function that finds the node in the linked list at the given position
     - parameter index: The position of the node in the linked list
     - Complexity: O(i), where i is the given index
     - returns: the node at the given position
     */
    public func node(at index: Int) -> CPNode<Value>? {
        var currentNode = head
        var currentIndex = 0
        
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode!.next
            currentIndex += 1
        }
        
        return currentNode
    }
    
    /**
     Function that inserts a value in the linked list after a ceratin node
     - parameter value: The value that should be inserted
     - parameter node: The node in the linked list after which a new value should be inserted
     - Complexity: O(1)
     - returns: the inserted node
     */
    public mutating func insert(_ value: Value, after node: CPNode<Value>) -> CPNode<Value> {
        copyNodes()
        guard tail !== node else {
            append(value)
            return tail!
        }
        node.next = CPNode(value: value, next: node.next)
        return node.next!
    }
    
    
    /**
     Function that removes the first value in the linked list
     - Complexity: O(1)
     - returns: the removed value
     */
    public mutating func pop() -> Value? {
        copyNodes()
        defer {
            head = head?.next
            if isEmpty {
                tail = nil
            }
        }
        return head?.value
    }
    
    /**
     Function that removes the last value in the linked list
     - Complexity: O(n)
     - returns: the removed value
     */
    public mutating func removeLast() -> Value? {
        copyNodes()
        guard let head = head else {
            return nil
        }
        guard head.next != nil else {
            return pop()
        }
        
        var prev = head
        var current = head
        while let next = current.next {
            prev = current
            current = next
        }
        prev.next = nil
        tail = prev
        
        return current.value
    }
    
    /**
     Function that removes the value after a ceratin node in the linked list
     - parameter node: The node in the linked list that is placed before the value that should be removed
     - Complexity: O(1)
     - returns: the removed value
     */
    public mutating func remove(after node: CPNode<Value>) -> Value? {
        copyNodes()
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
        }
        return node.next?.value
    }
}
extension CPLinkedList: Collection {
    
    public struct Index: Comparable {
        
        public var node: CPNode<Value>?
        
        static public func ==(lhs: Index, rhs: Index) -> Bool {
            switch (lhs.node, rhs.node) {
            case let (left?, right?):
                return left.next === right.next
            case (nil, nil):
                return true
            default:
                return false
            }
        }
        
        static public func <(lhs: Index, rhs: Index) -> Bool {
            guard lhs != rhs else {
                return false
            }
            let nodes = sequence(first: lhs.node) { $0?.next }
            return nodes.contains { $0 === rhs.node }
        }
    }
    
    public var startIndex: Index {
        return Index(node: head)
    }
    
    public var endIndex: Index {
        return Index(node: tail?.next)
    }
    
    public func index(after i: Index) -> Index {
        return Index(node: i.node?.next)
    }
    
    public subscript(position: Index) -> Value {
        return position.node!.value
    }
}


extension CPLinkedList {
    private mutating func copyNodes() {
        guard !isKnownUniquelyReferenced(&head) else {
            return
        }
        guard var oldNode = head else {
            return
        }
        head = CPNode(value: oldNode.value)
        var newNode = head
        
        while let nextOldNode = oldNode.next {
            newNode!.next = CPNode(value: nextOldNode.value)
            newNode = newNode!.next
            oldNode = nextOldNode
        }
        tail = newNode
    }
}

extension CPLinkedList: CustomStringConvertible {
    public var description: String {
        guard let head = head else {
            return "Empty List"
        }
        return String(describing: head)
    }
}
