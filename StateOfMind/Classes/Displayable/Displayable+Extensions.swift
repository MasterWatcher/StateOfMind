//
//  Displayable+Extensions.swift
//  StateOfMind
//
//  Created by goncharov on 19/10/2018.
//

public extension LoadingDisplayable {
    func showLoading() {}
    func hideLoading() {}
}

public extension ContentDispayable {
    func showContent(_: ContentType) {}
    func hideContent() {}
}

public extension EmptyDisplayable {
    func showEmpty() {}
    func hideEmpty() {}
}

public extension ErrorDispayable {
    func showError(_: Error) {}
    func hideError() {}
}
