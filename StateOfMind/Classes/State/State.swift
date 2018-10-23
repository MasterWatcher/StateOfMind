//
//  State.swift
//  Nimble
//
//  Created by goncharov on 19/10/2018.
//

//TODO: implement different types of loading
public enum State<T> {
    case loading
    case content(T)
    case error(Error)
    case empty
}
