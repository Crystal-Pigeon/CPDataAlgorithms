//
//  CPBinarySearchTree.swift
//  CP-Data-Algorithms
//
//  Created by Mariana Samardzic on 10/30/19.
//  Copyright © 2019 Crystal Pigeon. All rights reserved.
//

import Foundation

public struct CPBinarySearchTree<Element: Comparable> {
    public private(set) var root: CPBinaryNode<Element>?
    public init(){}
    
    public mutating func insert(value: Element) {
        root = insert(from: root, value: value)
    }
    private func insert(from node: CPBinaryNode<Element>?, value: Element) -> CPBinaryNode<Element> {
        guard let node = node else { return CPBinaryNode(value) }
        
        if value < node.value {
            node.leftChild = insert(from: node.leftChild, value: value)
        } else {
            node.rightChild = insert(from: node.rightChild, value: value)
        }
        return node
    }
    
    public func contains(_ value: Element) -> Bool {
        var current = root
        while  let node = current {
            if node.value == value { return true }
            if value < node.value { current = node.leftChild }
            else { current = node.rightChild }
        }
        return false
    }
    public mutating func remove(_ value: Element) {
        root = remove(node: root, value: value)
    }
    private func remove(node: CPBinaryNode<Element>?, value: Element) -> CPBinaryNode<Element>? {
        
        guard let node = node else { return nil }
        
        if value == node.value {
            //if the node is a leaf
            if node.leftChild == nil && node.rightChild == nil { return nil }
            
            //if the node has only one child
            if node.leftChild == nil { return node.rightChild }
            if node.rightChild == nil {return node.leftChild}
            
            //if the node has two children
            node.value = node.rightChild!.min.value
            node.rightChild = remove(node: node.rightChild, value: node.value)
            
        }
        else if value < node.value {
            node.leftChild = remove(node: node.leftChild, value: value)
        } else {
            node.rightChild = remove(node: node.rightChild, value: value)
        }
        return node
        
    }
}
extension CPBinarySearchTree: CustomStringConvertible {
    public var description: String {
        guard let root = root else { return "empty tree" }
        return String(describing: root)
    }
}
