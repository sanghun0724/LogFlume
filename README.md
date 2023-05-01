# LogFlume

LogFlume is a lightweight, scalable, and useful logging library for iOS apps, written in Swift. It provides an easy-to-use interface for logging messages at various log levels, including verbose, debug, info, warning, and error. 

## Features

- Lightweight: LogFlume is designed to be lightweight and non-intrusive, ensuring that it has a minimal impact on your app's performance.
- Scalable: LogFlume is built with scalability in mind, allowing you to easily customize and extend its functionality to meet your app's specific logging needs.
- Useful: LogFlume provides a variety of log levels and log formatting options, making it easy to quickly diagnose and fix issues in your app.
- Fast: LogFlume is optimized for speed, ensuring that it can log messages quickly and efficiently, without impacting your app's performance.

## Requirements

- iOS 13.0+
- Xcode 10.2+
- Swift 5.0+

## Installation

### Pod
You can install LogFlume using [CocoaPods](https://cocoapods.org/) by adding the following line to your `Podfile`:

```ruby
pod 'LogFlume'
```

### Swift Package Manager

To install LogFlume using Swift Package Manager, add the package dependency to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/sanghun0724/LogFlume.git", from: "0.1.0")
]
```

Alternatively, you can manually add the LogFlume files to your project.

## Usage

To use LogFlume in whole project, simply import the `LogFlume` module and create an type of the `LogFlume` class in near the top of your `AppDelegate.swift` or `SceneDelegate.swift` 

```swift
import LogFlume

let log = LogFlume.self
```

You can add the LogFlume log channel (xcodeChannel) to your AppDelegate:didFinishLaunchingWithOptions() or scene(_:willConnectTo:options:) at the start.

```Swift
// if you want configure global setting, there is three options.
log.formatType = .simple // 1 
log.dateFormat = "HH:mm" // 2
log.printerType = .dump // 3

let xcode = XcodeLoggingChannel()  // log to Xcode Console
log.addChannels(xcode) // add channel


// start logging anything
log.verbose("SHLEE is Pulple")
log.verbose(123)

log.info(-100000000000)
log.info(NSNull())

log.error(Void())
log.error(1.0)

// also you can log with target value 
log.verbose("SHLEE is Pulple",printerType: .dump, value: [2,2,2,2,23,3,4])
log.verbose(123, value: "Char")

struct TestStruct { let val = 1 }
log.info(-100000000000, value: TestStruct())
log.info(NSNull(), value: [[[2]]])

log.error(Void(), value: Void())
log.error(1.0, value: 1.0)

```
## License

LogFlume is released under the [MIT License](https://opensource.org/licenses/MIT). See `LICENSE` for details.

## Acknowledgments

LogFlume was inspired by the ([SwiftyBeaver](https://github.com/SwiftyBeaver/SwiftyBeaver), [EPLogger](https://github.com/ElonPark/EPLogger)) logging library.





