//
//  CPTrieNode.swift
//  CP-Data-Algorithms
//
//  Created by Mariana Samardzic on 11/6/19.
//  Copyright © 2019 Crystal Pigeon. All rights reserved.
//

import Foundation

public class CPTrieNode<Key: Hashable> {
    //holds the data. Root node has no data therefore no key
    public var key: Key?
    //keeping track of the parent node makes remove operation easier
    public weak var parent: CPTrieNode?
    //can have multiple children
    public var children: [Key: CPTrieNode] = [:]
    //end of a collection
    public var isTerminating = false
    
    public init(key: Key?, parent: CPTrieNode?) {
        self.key = key
        self.parent = parent
    }
}
