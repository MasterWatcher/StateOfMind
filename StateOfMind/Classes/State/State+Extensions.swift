//
//  State+Extensions.swift
//  Nimble
//
//  Created by goncharov on 19/10/2018.
//

public extension State {

    func map<U>(_ transform: (T) -> U) -> State<U> {
        switch self {
        case .loading: return State<U>.loading
        case let .content(value): return State<U>.content(transform(value))
        case .empty: return State<U>.empty
        case let .error(value): return State<U>.error(value)
        }
    }

    func mapContentToNil<U>() -> State<U>? {
        switch self {
        case .loading: return State<U>.loading
        case .content: return nil
        case .empty: return State<U>.empty
        case let .error(value): return State<U>.error(value)
        }
    }

    func flatMap<U>(none: State<U> = .empty, _ transform: (T) -> U?) -> State<U> {
        switch self {
        case .loading: return State<U>.loading
        case let .content(value):
            guard let result = transform(value) else { return none }
            return State<U>.content(result)
        case .empty: return State<U>.empty
        case let .error(value): return State<U>.error(value)
        }
    }

    init(_ value: T?, none: State<T> = .empty) {
        guard let value = value else {
            self = none
            return
        }
        self = .content(value)
    }
}

extension State where T: Collection {
    init(_ value: T) {
        guard !value.isEmpty else {
            self = .empty
            return
        }
        self = .content(value)
    }
}
