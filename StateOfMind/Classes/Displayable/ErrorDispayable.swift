//
//  ErrorDispayable.swift
//  StateOfMind
//
//  Created by goncharov on 19/10/2018.
//

public protocol ErrorDispayable {
    func showError(_: Error)
    func hideError()
}
