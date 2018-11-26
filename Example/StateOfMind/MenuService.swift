//
//  MenuService.swift
//  
//
//  Created by Anton Goncharov on 11/22/18.
//

import Foundation

class MenuService {
    
    var delay = 1.0
    var resultType: ResultType = .content
    
    private static let content = [
        MenuItem(name: "Pizza Margarita", price: 12.22),
        MenuItem(name: "Pizza Marinara", price: 10.27),
        MenuItem(name: "Pasta Carbonara", price: 15.65),
        MenuItem(name: "Pasta Bolognese", price: 18.95),
        MenuItem(name: "Lasagne", price: 17.40),
        MenuItem(name: "Coffee", price: 10.00),
        MenuItem(name: "Tea", price: 5.00)
    ]
    
    func loadMenu(callback:@escaping ([MenuItem]?, Error?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
            switch self.resultType {
            case .content: callback(MenuService.content, nil)
            case .empty: callback([], nil)
            case .error: callback(nil, Errors.someError)
            }
        })
    }
}

enum ResultType {
    case content
    case empty
    case error
}

enum Errors: Error {
    case someError
}
