//
//  State+Extensions.swift
//  Nimble
//
//  Created by goncharov on 19/10/2018.
//

public extension State {

    static var loading: State {
        return .loading("")
    }

    static var empty: State {
        return .empty("")
    }

    func setEmpty(_ type: String) -> State {
        guard case .empty = self else { return self }
        return .empty(type)
    }

    func map<U>(_ transform: (T) -> U) -> State<U> {
        switch self {
        case let .loading(type): return State<U>.loading(type)
        case let .content(value): return State<U>.content(transform(value))
        case let .empty(type): return State<U>.empty(type)
        case let .error(value): return State<U>.error(value)
        }
    }

    func mapContentToNil<U>() -> State<U>? {
        switch self {
        case let .loading(type): return State<U>.loading(type)
        case .content: return nil
        case let .empty(type): return State<U>.empty(type)
        case let .error(value): return State<U>.error(value)
        }
    }

    func flatMap<U>(none: State<U> = .empty, _ transform: (T) -> U?) -> State<U> {
        switch self {
        case let .loading(value): return State<U>.loading(value)
        case let .content(value):
            guard let result = transform(value) else { return none }
            return State<U>.content(result)
        case let .empty(value): return State<U>.empty(value)
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
