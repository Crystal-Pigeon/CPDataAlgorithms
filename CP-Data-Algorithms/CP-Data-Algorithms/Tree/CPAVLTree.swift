//
//  CPAVLTree.swift
//  CP-Data-Algorithms
//
//  Created by Mariana Samardzic on 11/1/19.
//  Copyright © 2019 Crystal Pigeon. All rights reserved.
//

import Foundation

public struct CPAVLTree<Element: Comparable> {
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
        
        let balancedNode = balanced(node)
        balancedNode.height = max(balancedNode.leftHeight, balancedNode.rightHeight) + 1
        return balancedNode
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
        let balancedNode = balanced(node)
        balancedNode.height = max(balancedNode.leftHeight, balancedNode.rightHeight) + 1
        return balancedNode
    }
    private func leftRotate(_ node: CPBinaryNode<Element>) -> CPBinaryNode<Element> {
        let pivot = node.rightChild!
        node.rightChild = pivot.leftChild
        pivot.leftChild = node
        node.height = max(node.leftHeight, node.rightHeight) + 1
        pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1
        return pivot
        
    }
    private func rightRotate(_ node: CPBinaryNode<Element>) -> CPBinaryNode<Element> {
        let pivot = node.leftChild!
        node.leftChild = pivot.rightChild
        pivot.rightChild = node
        node.height = max(node.leftHeight, node.rightHeight) + 1
        pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1
        return pivot
    }
    
    private func rightLeftRotate(_ node: CPBinaryNode<Element>) -> CPBinaryNode<Element> {
        guard let rightChild = node.rightChild else { return node }
        node.rightChild = rightRotate(rightChild)
        return leftRotate(node)
    }
    private func leftRightRotate(_ node: CPBinaryNode<Element>) -> CPBinaryNode<Element> {
        guard let leftChild = node.leftChild else { return node }
        node.leftChild = leftRotate(leftChild)
        return rightRotate(node)
    }
    private func balanced(_ node: CPBinaryNode<Element>) -> CPBinaryNode<Element> {
        switch node.balanceFactor {
        case 2:
            if let leftChild = node.leftChild, leftChild.balanceFactor == -1 {
                return leftRightRotate(node)
            } else {
                return rightRotate(node)
            }
        case -2:
            if let rightChild = node.rightChild, rightChild.balanceFactor == 1 {
                return rightLeftRotate(node)
            } else {
                return leftRotate(node)
            }
        default:
            return node
        }
    }
}
extension CPAVLTree: CustomStringConvertible {
    public var description: String {
        guard let root = root else { return "empty tree" }
        return String(describing: root)
    }
}

