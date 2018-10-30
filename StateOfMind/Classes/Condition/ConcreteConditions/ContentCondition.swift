open class ContentCondition: Condition {

    public var delayedTransition: DelayedTransition?

    private let delay: TimeInterval

    public init(delay: TimeInterval) {
        self.delay = delay
    }

    public func setState<T>(_ state: State<T>, with stateMachine: StateMachine<T>) {
        switch state {
        case let .loading(type):
            delayedTransition?.cancel()
            performDelayedTransition(delay: delay) {
                stateMachine.displayable.hideContent()
                stateMachine.displayable.showLoading(type)
                stateMachine.condition = stateMachine.loadingCondition
            }
        case let .content(value):
            delayedTransition?.cancel()
            stateMachine.displayable.hideContent()
            stateMachine.displayable.showContent(value)
        case let .empty(type):
            guard let delayedTransition = delayedTransition else { return }
            delayedTransition.cancel()
            stateMachine.displayable.hideContent()
            stateMachine.displayable.showEmpty(type)
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
