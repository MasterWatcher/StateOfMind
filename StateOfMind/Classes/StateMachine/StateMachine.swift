//
//  StateMachine.swift
//  Nimble
//
//  Created by goncharov on 19/10/2018.
//

public class StateMachine<T> {

    let displayable: WeakAnyStateDisplayable<T>

    var condition: Condition
    var loadingCondition: Condition
    var contentCondition: Condition
    var emptyCondition: Condition
    var errorCondition: Condition

    var currentStatePresentationTime: TimeInterval {
        return Date().timeIntervalSince(stateSetupTime)
    }

    private var dispatchWorkItem: DispatchWorkItem?
    private var stateSetupTime = Date()

    public init<U: StateDisplayable>(displayable: U,
                              loadingCondition: Condition = LoadingCondition(minPresentationTime: TimeConstants.loadingDefaultMinPresentationTime),
                              contentCondition: Condition = ContentCondition(delay: TimeConstants.loadingDefaultDelay),
                              emptyCondition: Condition = EmptyCondition(delay: TimeConstants.loadingDefaultDelay),
                              errorCondition: Condition = ErrorCondition(delay: TimeConstants.loadingDefaultDelay)
        ) where U.ContentType == T {
        self.displayable = WeakAnyStateDisplayable(displayable)
        self.loadingCondition = loadingCondition
        self.contentCondition = contentCondition
        self.emptyCondition = emptyCondition
        self.errorCondition = errorCondition
        condition = contentCondition
    }

    public func setState(_ state: State<T>) {
        stateSetupTime = Date()
        condition.setState(state, with: self)
    }
}
