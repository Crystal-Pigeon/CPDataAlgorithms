//
//  CPQueueRingBuffer.swift
//  CP-Data-Algorithms
//
//  Created by Mariana Samardzic on 10/25/19.
//  Copyright © 2019 Crystal Pigeon. All rights reserved.
//

import Foundation

public struct CPQueueRingBuffer<T>: CPQueue {
    private var ringBuffer: CPRingBuffer<T>
    public init(count: Int){
        ringBuffer = CPRingBuffer<T>(count: count)
    }
    public var isEmpty: Bool{
        return ringBuffer.isEmpty
    }
    public var peek: T? {
        return ringBuffer.first
    }
    public mutating func enqueue(_ element: T) -> Bool {
        return ringBuffer.write(element)
    }
    public mutating func dequeue() -> T? {
        return isEmpty ? nil : ringBuffer.read()
    }
}
extension CPQueueRingBuffer: CustomStringConvertible {
    public var description: String {
        return String(describing: ringBuffer)
    }
}
