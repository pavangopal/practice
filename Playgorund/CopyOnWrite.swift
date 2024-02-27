//
//  CopyOnWrite.swift
//  Practice
//
//  Created by Pavangopal on 28/02/24.
//

import Foundation

final class Ref<T> {
    var val: T
    init(_ v: T) { val = v }
}

struct Box<T> {
    var ref: Ref<T>
    
    init(_ x: T) {
        ref = Ref(x)
    }
    
    var value: T {
        get { return ref.val }
        set {
            if !isKnownUniquelyReferenced(&ref) {
                ref = Ref(newValue)
                return
            }
            ref.val = newValue
        }
    }
}

class CopyOnWrite {
    func main() {
        var box = Box(10)
        var boxCopy = box
        boxCopy.value = 20
        print(boxCopy.value)
    }
}
