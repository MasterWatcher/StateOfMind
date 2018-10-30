//
//  ContentDispayable.swift
//  StateOfMind
//
//  Created by goncharov on 19/10/2018.
//

public protocol ContentDispayable {
    associatedtype ContentType
    func showContent(_: ContentType)
    func hideContent()
}
