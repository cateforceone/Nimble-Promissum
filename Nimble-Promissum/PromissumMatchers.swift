import Promissum
import Nimble

public func beResolved<T, U>() -> NonNilMatcherFunc<Promise<T, U>> {
    return promiseMatcher(postfixMessage: "be resolved", checker: { result in
        switch result {
        case .Value?: return true
        default: return false
        }
    })
}

public func beRejected<T, U>() -> NonNilMatcherFunc<Promise<T, U>> {
    return promiseMatcher(postfixMessage: "be rejected", checker: { result in
        switch result {
        case .Error?: return true
        default: return false
        }
    })
}

public func bePending<T, U>() -> NonNilMatcherFunc<Promise<T, U>> {
    return promiseMatcher(postfixMessage: "be pending", checker: { result in
        switch result {
        case nil: return true
        default: return false
        }
    })
}


private func stringifyPromise<T, U>(promise: Promise<T, U>) -> String {
    switch promise.result {
    case nil: return "<pending>"
    case let .Value(value)?: return "<resolved: \(value)>"
    case let .Error(error)?: return "<rejected: \(error)>"
    }
}

private func promiseMatcher<T, U>(
    postfixMessage postfixMessage: String,
    checker: Result<T, U>? -> Bool) -> NonNilMatcherFunc<Promise<T, U>> {
        return NonNilMatcherFunc { actualExpression, failureMessage in
            failureMessage.postfixMessage = postfixMessage

            if let actualValue = try actualExpression.evaluate() {
                failureMessage.actualValue = stringifyPromise(actualValue)
                return checker(actualValue.result)
            }

            return false
        }
}
