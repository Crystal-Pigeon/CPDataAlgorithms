//
//  CPTreeNode.swift
//  CP-Data-Algorithms
//
//  Created by Mariana Samardzic on 10/30/19.
//  Copyright © 2019 Crystal Pigeon. All rights reserved.
//

import Foundation

public class CPTreeNode<T> {
    public var value: T
    public var children: [CPTreeNode] = []
    public init(_ value: T){
        self.value = value
    }
    /**
     Function that adds a child node
     - parameter child: The node that should be a new child node
     */
    public func add(_ child: CPTreeNode) {
        self.children.append(child)
    }
    /**
     Function that iterates through a tree. It visits each depth first
     - parameter visit: A function that should be executed with each node
     */
    public func forEachDepthFirst(visit: (CPTreeNode) -> Void) {
        visit(self)
        children.forEach {
            $0.forEachDepthFirst(visit: visit)
        }
    }
    /**
     Function that iterates through a tree. It visits each level first
     - parameter visit: A function that should be executed with each node
     */
    public func forEachLevelOrder(visit: (CPTreeNode) -> Void) {
        visit(self)
        var queue = CPQueueStack<CPTreeNode>()
        children.forEach { queue.enqueue($0) }
        while let node = queue.dequeue() {
            visit(node)
            node.children.forEach { queue.enqueue($0) }
        }
    }
}

extension CPTreeNode where T: Equatable {
    /**
     Function that searches a value in a tree. It uses depth-first traversal
     - parameter value: A value that is searched for
     - returns: a node that hold the searched value if it exists
     */
    public func search(_ value: T) -> CPTreeNode? {
        var result: CPTreeNode?
        forEachDepthFirst { node in
            if value == node.value {
                result = node
            }
        }
        return result
    }
}
