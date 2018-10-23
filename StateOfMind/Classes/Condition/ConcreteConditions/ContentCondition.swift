//
//  ContentCondition.swift
//  StateOfMind
//
//  Created by goncharov on 19/10/2018.
//

open class ContentCondition: Condition {

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
                stateMachine.displayable.hideContent()
                stateMachine.displayable.showLoading()
                stateMachine.condition = stateMachine.loadingCondition
            }
        case let .content(value):
            delayedTransition?.cancel()
            stateMachine.displayable.hideContent()
            stateMachine.displayable.showContent(value)
        case .empty:
            guard let delayedTransition = delayedTransition else { return }
            delayedTransition.cancel()
            stateMachine.displayable.hideContent()
            stateMachine.displayable.showEmpty()
            stateMachine.condition = stateMachine.emptyCondition
        case let .error(value):
            guard let delayedTransition = delayedTransition else { return }
            delayedTransition.cancel()
            stateMachine.displayable.hideContent()
            stateMachine.displayable.showError(value)
            stateMachine.condition = stateMachine.errorCondition
        }
    }
}
