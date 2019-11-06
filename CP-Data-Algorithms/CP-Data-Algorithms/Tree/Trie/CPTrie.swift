//
//  CPTrie.swift
//  CP-Data-Algorithms
//
//  Created by Mariana Samardzic on 11/6/19.
//  Copyright © 2019 Crystal Pigeon. All rights reserved.
//

import Foundation

/**
 A trie is a tree data structures that stores data that can be represented as a collection. It is often used for storing words because it can quickly find all the words that begin with some prefix. It is also relatively memory efficient since individual nodes can be shared between many different values.
 */
public class CPTrie<CollectionType: Collection> where CollectionType.Element: Hashable {
    public typealias CPNode = CPTrieNode<CollectionType.Element>
    private let root = CPNode(key: nil, parent: nil)
    
    public init(){}
    /**
     Function that inserts a collection in a trie
     - parameter collection: A collection that should be inserted in the trie
     - Complexity: O(k), k = number of elements in the collection
     */
    public func insert(_ collection: CollectionType) {
        //keeps track of traversal progress, starts at root
        var current = root
        //each element in collection is stored in separate nodes
        for element in collection {
            //check if it exists, if doesn't, crete new node
            if current.children[element] == nil {
                current.children[element] = CPNode(key: element, parent: current)
            }
            //move current to the next node
            current = current.children[element]!
        }
        //after loop, last node should be terminating
        current.isTerminating = true
    }
    /**
     Function that searches for collection in a trie
     - parameter collection: A collection that should be found in the trie
     - Complexity: O(k), k = number of elements in the collection
     - returns: A boolean value indicating if the collection is found
     */
    public func contains(_ collection: CollectionType) -> Bool {
        //keeps track of traversal progress, starts at root
        var current = root
        //go through each element of the collection
        for element in collection {
            //if one element is missing return
            guard let child = current.children[element] else {
                return false
            }
            current = child
        }
        //if the last element is terminating return true
        return current.isTerminating
    }
    /**
     Function that removes a collection from a trie
     - parameter collection: A collection that should be removed from the trie
     - Complexity: O(k), k = number of elements in the collection
     */
    public func remove(_ collection: CollectionType) {
        //check if the collection exists and come to the last element
        var current = root
        for element in collection {
            guard let child = current.children[element] else { return }
            current = child
        }
        guard current.isTerminating else {return}
        
        //the last element is no longer terminating
        current.isTerminating = false
        //conditions to remove a node
        //1-it has a parent(stop at the root node)
        //2-it doesn't have children(if it has children, it is part of a different collection)
        //3-it is not terminating(if it is terminating it is part of a different collection)
        while let parent = current.parent, current.children.isEmpty && !current.isTerminating {
            parent.children[current.key!] = nil
            current = parent
        }
    }
}

public extension CPTrie where CollectionType: RangeReplaceableCollection {
    /**
     Function that finds all collections from a trie that contain a certain prefix
     - parameter prefix: A collection that represents a prefix
     - Complexity: O(k*m), k = longest collection matching the prefix, m = number of collections that match the prefix
     - returns: an array of collections that match the prefix
     */
    func collections(startingWith prefix: CollectionType) -> [CollectionType] {
        //check if the collection exists and come to the last element
        var current = root
        for element in prefix {
            guard let child = current.children[element] else { return [] }
            current = child
        }
        return collections(startingWith: prefix, after: current)
    }
    
    private func collections(startingWith prefix: CollectionType, after node: CPNode) -> [CollectionType] {
        //creating an array for all the collections that conatin the prefix
        var results: [CollectionType] = []
        
        //if it's the termonating node add to the array
        if node.isTerminating {
            results.append(prefix)
        }
        //go through each child of the node
        for child in node.children.values {
            //add an element to the prefix and call the same function
            var prefix = prefix
            prefix.append(child.key!)
            results.append(contentsOf: collections(startingWith: prefix, after: child))
        }
        return results
    }
    
}
