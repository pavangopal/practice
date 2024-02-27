//
//  OpenClose.swift
//  Practice
//
//  Created by Pavangopal on 28/02/24.
//

import Foundation

enum Color {
    case red,blue,green
}

enum Size {
    case small, medium, large
}

class Product {
    let color: Color
    let size: Size
    init(color: Color, size: Size) {
        self.color = color
        self.size = size
    }
}

protocol Specification {
    associatedtype T
    func isSatify(item: T) -> Bool
}

protocol Filter {
    associatedtype T
    func filter<Spec:Specification>(items: [T], specification: Spec) -> [T] where Spec.T == T
}

class ColorSpecification: Specification {
    let color: Color
    
    init(color: Color) {
        self.color = color
    }
    
    func isSatify(item: Product) -> Bool {
        return item.color == self.color
    }
}

class SizeSpecification: Specification {
    let size: Size
    
    init(size: Size) {
        self.size = size
    }
    
    func isSatify(item: Product) -> Bool {
        return item.size == self.size
    }
}

class AndSpecification: Specification {
    let size: Size
    let color: Color
    
    init(size: Size, color: Color) {
        self.size = size
        self.color = color
    }
    
    func isSatify(item: Product) -> Bool {
        return item.size == self.size && item.color == self.color
    }
}

class FilterProduct: Filter {
    func filter<Spec>(items: [Product], specification: Spec) -> [Product] where Spec : Specification, Product == Spec.T {
        return items.filter { product in
            specification.isSatify(item: product)
        }
    }
}

class OpenClose {
    func main() {
        let productList = [Product(color: .red, size: .small),
                           Product(color: .red, size: .large),
                           Product(color: .red, size: .small)]
        
        let smallProductList = FilterProduct().filter(items: productList, specification: SizeSpecification(size: .small))
        let largeProductList = FilterProduct().filter(items: productList, specification: SizeSpecification(size: .large))
        let smallRedProductList = FilterProduct().filter(items: productList, specification: AndSpecification(size: .small, color: .red))
        
        smallProductList.forEach({print($0.size)})
        largeProductList.forEach({print($0.size)})
        smallRedProductList.forEach({print($0.size, "\t", $0.color)})
        
    }
    
}
