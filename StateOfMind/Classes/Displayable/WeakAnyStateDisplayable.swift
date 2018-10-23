//
//  WeakAnyStateDisplayable.swift
//  StateOfMind
//
//  Created by goncharov on 19/10/2018.
//

class WeakAnyStateDisplayable<T>: StateDisplayable {

    private let _showLoading: () -> Void
    private let _hideLoading: () -> Void
    private let _showEmpty: () -> Void
    private let _hideEmpty: () -> Void
    private let _showError: (Error) -> Void
    private let _hideError: () -> Void
    private let _showContent: (T) -> Void
    private let _hideContent: () -> Void

    init<U: StateDisplayable>(_ statable: U) where U.ContentType == T {
        _showLoading = { [weak statable] in return statable?.showLoading() }
        _hideLoading = { [weak statable] in return statable?.hideLoading() }
        _showEmpty = { [weak statable] in return statable?.showEmpty() }
        _hideEmpty = { [weak statable] in return statable?.hideEmpty() }
        _showError = { [weak statable] error in return statable?.showError(error) }
        _hideError = { [weak statable] in return statable?.hideError() }
        _showContent = { [weak statable] content in return statable?.showContent(content) }
        _hideContent = { [weak statable] in return statable?.hideContent() }
    }

    func showLoading() {
        _showLoading()
    }

    func hideLoading() {
        _hideLoading()
    }

    func showEmpty() {
        _showEmpty()
    }

    func hideEmpty() {
        _hideEmpty()
    }

    func showError(_ error: Error) {
        _showError(error)
    }

    func hideError() {
        _hideError()
    }

    func showContent(_ content: T) {
        _showContent(content)
    }

    func hideContent() {
        _hideContent()
    }
}

