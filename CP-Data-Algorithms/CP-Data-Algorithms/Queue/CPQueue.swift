//
//  CPQueue.swift
//  CP-Data-Algorithms
//
//  Created by Mariana Samardzic on 10/25/19.
//  Copyright © 2019 Crystal Pigeon. All rights reserved.
//

import Foundation

public protocol CPQueue {
    associatedtype Element
    mutating func enqueue(_ element: Element) -> Bool
    mutating func dequeue() -> Element?
    var isEmpty: Bool { get }
    var peek: Element? { get }
}
