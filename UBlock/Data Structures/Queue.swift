//
//  Queue.swift
//  UBlock
//
//  Created by Yida Zhang on 2021-04-01.
//

import Foundation

class Node<T> {
    
    var next: Node?
    var value: T
    
    init(_ value: T) {
        self.value = value
    }
}

class LinkedList<T> {
    private var head: Node<T>?
    private var tail: Node<T>?
    
    var isEmpty: Bool { return head == nil }
    var first: Node<T>? { return head }
    var last: Node<T>? { return tail }
    
    func append(_ value: T) {
        let node = Node(value)
        if tail != nil {
            tail!.next = node
            tail = tail!.next
        } else {
            head = node
            tail = head
        }
    }
    
    func removeFirst() -> T? {
        var result: T?
        if head != nil {
            result = head!.value
            if tail === head {
                tail = head!.next
            }
            head = head!.next
        }
        return result
    }
}

struct Queue<T> {
    
    var list: LinkedList<T>
    var isEmpty: Bool { return list.isEmpty }
    
    init(_ list: LinkedList<T> = LinkedList<T>()) {
        self.list = list
    }
    
    func enqueue(_ value: T) {
        list.append(value)
    }
    
    func enqueue(_ values: [T]) {
        for value in values {
            list.append(value)
        }
    }
    
    func dequeue() -> T? {
        return list.removeFirst()
    }
}
