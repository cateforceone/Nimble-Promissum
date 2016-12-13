import Promissum
import Nimble

/// Nimble matcher for checking whether a promise has been resolved with a value
/// or not. This is often paired with `toEventually` in situations where the
/// promise may be resolved at some point in the future.
public func beResolved<T, U>() -> NonNilMatcherFunc<Promise<T, U>> {
    return promiseMatcher(postfixMessage: "be resolved", checker: { result in
        switch result {
        case .Value?: return true
        default: return false
        }
    })
}

/// Nimble matcher for checking whether a promise has been rejected with an error
/// or not. This is often paired with `toEventually` in situations where the
/// promise may be rejected at some point in the future.
public func beRejected<T, U>() -> NonNilMatcherFunc<Promise<T, U>> {
    return promiseMatcher(postfixMessage: "be rejected", checker: { result in
        switch result {
        case .Error?: return true
        default: return false
        }
    })
}

/// Nimble matcher for checking whether a promise has neither been resolved
/// nor rejected.
public func bePending<T, U>() -> NonNilMatcherFunc<Promise<T, U>> {
    return promiseMatcher(postfixMessage: "be pending", checker: { result in
        switch result {
        case nil: return true
        default: return false
        }
    })
}


private func stringifyPromise<T, U>(_ promise: Promise<T, U>) -> String {
    switch promise.result {
    case nil: return "<pending>"
    case let .Value(value)?: return "<resolved: \(value)>"
    case let .Error(error)?: return "<rejected: \(error)>"
    }
}

private func promiseMatcher<T, U>(
    postfixMessage: String,
    checker: (Result<T, U>?) -> Bool) -> NonNilMatcherFunc<Promise<T, U>> {
        return NonNilMatcherFunc { actualExpression, failureMessage in
            failureMessage.postfixMessage = postfixMessage

            if let actualValue = try actualExpression.evaluate() {
                failureMessage.actualValue = stringifyPromise(actualValue)
                return checker(actualValue.result)
            }

            return false
        }
}
