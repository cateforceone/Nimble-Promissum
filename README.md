# Nimble-Promissum

[Nimble](https://github.com/Quick/Nimble) matchers for [Promissum](https://github.com/tomlokhorst/Promissum) promises. These allow you to easily write expressive tests that produce useful failure messages when working with promises.

## Usage

```swift
let promise = computeTheMeaningOfLife()

expect(promise).to(bePending())
expect(promise).toEventually(beResolved())
expect(promise).toNot(beRejected())

expect(promise.value).to(equal(42))
```

## Installation

Nimble-Promissum is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Nimble-Promissum"
```

## Author

Brian Croom, brian.s.croom@gmail.com

## License

Nimble-Promissum is available under the MIT license. See the LICENSE file for more info.
