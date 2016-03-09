import XCTest
import Nimble
import Promissum
import Nimble_Promissum

class Nimble_PromissumTests: XCTestCase {
    let resolvedPromise: Promise<Int, ErrorType> = Promise(value: 42)
    let rejectedPromise: Promise<Int, ErrorType> = Promise(error: NSError(domain: "", code: 0, userInfo: nil))
    let pendingPromise:  Promise<Int, ErrorType> = PromiseSource().promise

    func testPositiveMatches() {
        expect(self.resolvedPromise).to(beResolved())
        expect(self.rejectedPromise).to(beRejected())
        expect(self.pendingPromise).to(bePending())
    }

    func testNegativeMatches() {
        expect(self.rejectedPromise).toNot(beResolved())
        expect(self.pendingPromise).toNot(beResolved())

        expect(self.resolvedPromise).toNot(beRejected())
        expect(self.pendingPromise).toNot(beRejected())

        expect(self.resolvedPromise).toNot(bePending())
        expect(self.rejectedPromise).toNot(bePending())
    }

    func testAsynchronousResolution() {
        let source = PromiseSource<Int, NoError>()
        dispatch_async(dispatch_get_main_queue()) { source.resolve(123) }

        expect(source.promise).toEventually(beResolved())
        expect(source.promise.value).to(equal(123))
    }

    func testAsynchronousRejection() {
        let source = PromiseSource<Int, NSError>()
        dispatch_async(dispatch_get_main_queue()) { source.reject(NSError(domain: "nmb", code: 0, userInfo: nil)) }

        expect(source.promise).toEventually(beRejected())
        expect(source.promise.error?.domain).to(equal("nmb"))
    }
}
