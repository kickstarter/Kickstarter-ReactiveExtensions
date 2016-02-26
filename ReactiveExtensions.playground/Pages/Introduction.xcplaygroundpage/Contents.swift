import XCPlayground
import ReactiveExtensions
import ReactiveCocoa
import Result

/*:
# Reactive Extensions

A collection of tools for use with Reactive Cocoa.

---

## Getting started

* Open `ReactiveExtensions.xcworkspace` instead of the playground file directly.
* Build the `ReactiveExtensions` framework (`cmd+B`).
* Render the markdown by going to Editor > Show Rendered Markup.

---

## Functional Reactive Programming

We use [functional reactive programming (FRP)](https://en.wikipedia.org/wiki/Functional_reactive_programming) 
extensively in our work on iOS and Android. The implementation of FRP that we have 
decided to use for iOS is [Reactive Cocoa (RAC)](https://github.com/ReactiveCocoa/ReactiveCocoa),
but it should be known that [RxSwift](https://github.com/ReactiveX/RxSwift) is another
popular FRP library. We want to emphasize foundational ideas that can be applied regardless 
of library.

FRP is the idea that by lifting values into a streams that vary over time we can recover
many nice composability properties that we would not have seen otherwise. These streams
go through a few stages: items are emitted over time and possibly at some point a completion
or error state is emitted, at which point the stream will never emit again. For example,
a network request is a stream that remains silent while the work is being done (downloading,
parsing, etc...), and then emits a single value of the payload and completes, or errors
if something went wrong. Similarly, a tap event on a button is a stream that emits every
time a button is tapped, but it never completes or errors.

## Reactive Cocoa

TODO: Talk about:

* Parameterizations over values and errors
* Signals and signal producers
* Memory management

## Custom operators

Since FRP is at the core of everything we do we have defined some custom operators that model
problems that we face often but that are not apart of the core RAC library. Most of these
operators are quite simple and implemented in terms of other core operators. We introduce
a new operator when we want to have a way to describe something that comes up often. For example,
there are many times that we perform a `map` operator that can result in a stream of
optional values, and then immediately follow it with an `ignoreNil` in order to filter out
all `nil` values:

`user.map { u in u.location }.ignoreNil()`

We decided to make these two chained operators into a single one, simply called `flatMap`:

`user.flatMap { u in u.location }`

Now the resulting stream of locations can be used without worrying about optionals.

What follows is some of our custom operators and situations you may want to use them.
*/

/*:
### `mapConst`

Many times we do a `map` to a constant value, e.g. `clicks.map { _ in 1 }`. We call this
operation `mapConst` and it can be used simply as `clicks.mapConst(1)`. This can be
useful for transforming user input into a stream of actions, e.g.:
*/

let incrementClicks = SignalProducer<(), NoError>(values: [(), (), (), ()])
incrementClicks
  .mapConst(1)
  .allValues()

/*:
This stream could be merged with a corresponding decrementing stream:
*/

let decrementClicks = SignalProducer<(), NoError>(values: [(), (), ()])
incrementClicks.mapConst(1)
  .mergeWith(decrementClicks.mapConst(-1))
  .allValues()

/*:
Now we have a stream of `+1` values followed by `-1` values corresponding to clicks on
a incrementing and decrementing button. We could then use the `scan` operator to acummulate
the summation of these values:
*/

let clicksTotal = incrementClicks.mapConst(1)
  .mergeWith(decrementClicks.mapConst(-1))
  .scan(0, +)

clicksTotal.allValues()

/*:
Now we have a stream that counts up as the increment button is clicked and goes back down
when the decrement button is clicked.
*/

/*:
### `demoteErrors`

There's an operator in core RAC called `promoteErrors` that promotes a signal that is
parameterized by the `NoError` type into one that is parameterized by some error. The signal
won’t actually error, but at least its type can now align with some other signal in order to
make `flatMap`, `combineLatest`, etc. with other signals work. E.g.
*/

// Returns a signal of `x` when `x` is odd, and errors otherwise.
func fetchDataThatCouldError(x: Int) -> SignalProducer<Int, NSError> {
  if (x % 2 == 1) {
    return SignalProducer(value: x)
  }
  return SignalProducer(error: NSError(domain: "", code: 1, userInfo: nil))
}

clicksTotal.promoteErrors(NSError.self)
  .flatMap(fetchDataThatCouldError)
  .allValues()

/*:
The above emits only one value because the second emission of `clicksTotal` caused
`fetchDataThatCouldError` to error, and so ended the whole stream.

We sometimes come across the opposite situation of error promotion. We want to “demote”
the errors of a signal to one that will never error, essentially preventing the signal
from ever erroring. This can be useful for “fire and forget” network requests, and for
composition with UI events, which typically never error.
*/

clicksTotal
  .flatMap { x in fetchDataThatCouldError(x).demoteErrors() }
  .allValues()

/*:
Now all the errors of `fetchDataThatCouldError` are ignored, and we only get emissions
for which `clicksTotal` emits an odd number.
*/

/*:
### `uncollect`

This operator is the opposite of the `collect` operator in RAC core. It transforms a stream 
of sequences into a stream of the values contained in the sequeneces. That is, when 
the original stream emits a sequence, all of the values in that sequences are individually 
emitted in the `uncollect`ed stream. This can be useful for dealing with results from an 
API request that returns an array of objects.
*/

let response = SignalProducer<[Int], NoError>(value: [1, 2, 3, 4, 5, 6, 7])
response
  .uncollect()
  .filter { x in x % 2 == 0 }
  .collect()
  .allValues()

/*:
## `concatMap`, `mergeMap`, `switchMap`

RAC has the concept of “merge strategies” when it comes to `flatMap`. To understand these concepts
we must create a signal that emits values over time and not all at once. The following function
produces a signal that emits its input 3 times, but each emission is staggered from the previous
by .01 seconds.
*/

let scheduler = QueueScheduler(queue: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0))

// Returns a signal that emits `x` three times, but each staggered by .01 seconds.
func staggeredTriple(x: Int) -> SignalProducer<Int, NoError> {
  return SignalProducer(value: x).delay(0.01, onScheduler: scheduler)
    .mergeWith(SignalProducer(value: x).delay(0.02, onScheduler: scheduler))
    .mergeWith(SignalProducer(value: x).delay(0.03, onScheduler: scheduler))
}

/*:
With this function we can describe each of the `flatMap` operations. The first is the simplest:
*/

SignalProducer<Int, NoError>(values: [1, 2, 3])
  .flatMap(.Concat, transform: staggeredTriple)
  .allValues()

/*:
For every emission of the base signal (1, 2, 3), `flatMap(.Concat)` concatenated all of the
emissions of `staggeredTriple` in a serial fashion. Hence, when `1` emitted, the `flatMap`
emitted `(1, 1, 1)`, and then when `2` emitted, `(2, 2, 2)`, and so on.

The next simplest is `flatMap(.Merge)`:
*/

SignalProducer<Int, NoError>(values: [1, 2, 3])
  .flatMap(.Merge, transform: staggeredTriple)
  .allValues()

/*:
In this case each emission of the base signal spawns a new signal of triples, and those resulting
signals are merged. Since the triples are stagged, the first emissions of each triple emit version, 
and then the second and third, hence the overall emission is (1, 2, 3, 1, 2, 3, 1, 2, 3).

Finally, perhaps the most complicated, but also most useful, is `flatMap(.Latest)`:
*/

SignalProducer<Int, NoError>(values: [1, 2, 3])
  .flatMap(.Latest, transform: staggeredTriple)
  .allValues()

/*:
In this case each emission of the base signal spawns a new signal of triples, but if the triples
have not finish emitting by the time the base gets a new emission it is canceled. Hence, the only
values that are emitted are the last triple (3, 3, 3).
*/

/*:
All of these operators are useful, but we prefer to give each of them their own operator with
more descriptive names:
*/

SignalProducer<Int, NoError>(values: [1, 2, 3])
  .mergeMap(staggeredTriple)
  .allValues()

SignalProducer<Int, NoError>(values: [1, 2, 3])
  .concatMap(staggeredTriple)
  .allValues()

SignalProducer<Int, NoError>(values: [1, 2, 3])
  .switchMap(staggeredTriple)
  .allValues()





// Playground configuration
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

