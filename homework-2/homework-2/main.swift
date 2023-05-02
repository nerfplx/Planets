//
//  main.swift
//  homework-2
//
//  Created by Александр Платонов on 20.04.2023.
//

import Foundation

class ThreadSafeArray <T> {
    
    private var safeArray = [T]()
    private let semaphore = DispatchSemaphore(value: 1)
    
    func append(_ item: T) {
        semaphore.wait()
        safeArray.append(item)
        semaphore.signal()
    }
    
    func remove(at index: Int) {
        semaphore.wait()
        if index < safeArray.count {
            safeArray.remove(at: index)
        }
        semaphore.signal()
    }
    
    subscript(index: Int) -> T? {
        guard index < safeArray.count - 1 else {return nil}
        semaphore.wait()
        let sub = safeArray[index]
        semaphore.signal()
        return sub
    }
    
    func contains(_ element: T) -> Bool where T: Equatable  {
        semaphore.wait()
        let arrayContains = safeArray.contains(element)
        semaphore.signal()
        return arrayContains
    }
    
    var isEmpty: Bool {
        semaphore.wait()
        let arrayIsEmpty = safeArray.isEmpty
        semaphore.signal()
        return arrayIsEmpty
    }
    
    var count: Int {
        semaphore.wait()
        let arrayCount = safeArray.count
        semaphore.signal()
        return arrayCount
    }
}

var safeArray = ThreadSafeArray<Int>()

let queue = DispatchQueue(label: "array", attributes: .concurrent)

let group = DispatchGroup()

group.enter()
queue.async {
    for number in 0...1000 {
        safeArray.append(number)
    }
    group.leave()
}

group.enter()
queue.async {
    for number in 0...1000 {
        safeArray.append(number)
    }
    group.leave()
}
group.wait()

print("Количество элементов в массиве: \(safeArray.count)")
