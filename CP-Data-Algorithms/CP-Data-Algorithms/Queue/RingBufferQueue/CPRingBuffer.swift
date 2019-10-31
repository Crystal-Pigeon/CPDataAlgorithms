//
//  CPRingBuffer.swift
//  CP-Data-Algorithms
//
//  Created by Mariana Samardzic on 10/25/19.
//  Copyright © 2019 Crystal Pigeon. All rights reserved.
//

import Foundation

public struct CPRingBuffer<T> {
    
    private var array: [T?]
    private var readIndex = 0
    private var writeIndex = 0
    
    public init(count: Int) {
        array = Array<T?>(repeating: nil, count: count)
    }
    
    private var availableSpaceForReading: Int {
        return writeIndex - readIndex
    }
    private var availableSpaceForWriting: Int {
        return array.count - availableSpaceForReading
    }
    
    public var first: T? {
        return array[readIndex]
    }
    public var isFull: Bool {
        return availableSpaceForWriting == 0
    }
    public var isEmpty: Bool {
        return availableSpaceForReading == 0
    }
    
    public mutating func write(_ element: T) -> Bool{
        if !isFull {
            array[writeIndex % array.count] = element
            writeIndex += 1
            return true
        } else {
            return false
        }
    }
    public mutating func read() -> T? {
        if !isEmpty {
            let element = array[readIndex % array.count]
            readIndex += 1
            return element
        } else {
            return nil
        }
    }
    
}
extension CPRingBuffer: CustomStringConvertible {
    public var description: String {
        let values = (0..<availableSpaceForReading).map {
            String(describing: array[($0 + readIndex) % array.count]!)
        }
        return "[" + values.joined(separator: ", ") + "]"
    }
}
