//
//  State.swift
//  Nimble
//
//  Created by goncharov on 19/10/2018.
//

public enum State<T> {
    case loading(String)
    case content(T)
    case error(Error)
    case empty(String)
}
