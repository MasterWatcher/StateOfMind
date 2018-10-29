//
//  EmptyCondition.swift
//  StateOfMind
//
//  Created by goncharov on 19/10/2018.
//

open class EmptyCondition: Condition {

    public var delayedTransition: DelayedTransition?

    private let delay: TimeInterval

    public init(delay: TimeInterval) {
        self.delay = delay
    }

    public func setState<T>(_ state: State<T>, with stateMachine: StateMachine<T>) {
        switch state {
        case .loading:
            delayedTransition?.cancel()
            performDelayedTransition(delay: delay) {
                stateMachine.displayable.hideEmpty()
                stateMachine.displayable.showLoading()
                stateMachine.condition = stateMachine.loadingCondition
            }
        case let .content(value):
            guard let delayedTransition = delayedTransition else { return }
            delayedTransition.cancel()
            stateMachine.displayable.hideEmpty()
            stateMachine.displayable.showContent(value)
            stateMachine.condition = stateMachine.contentCondition
        case .empty:
            guard let delayedTransition = delayedTransition else { return }
            delayedTransition.cancel()
            stateMachine.displayable.hideEmpty()
            stateMachine.displayable.showEmpty()
        case let .error(value):
            guard let delayedTransition = delayedTransition else { return }
            delayedTransition.cancel()
            stateMachine.displayable.hideEmpty()
            stateMachine.displayable.showError(value)
            stateMachine.condition = stateMachine.errorCondition
        }
    }
}
