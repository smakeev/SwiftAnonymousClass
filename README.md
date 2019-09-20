# SwiftAnonymousClass

Analog of anonymous class in Swift.

SwiftAnonymousClass adds function ```_new``` in your project.
```swift
func _new<Type>(_ objectCreator:()->Type) -> Type {
    return objectCreator()
}
```
Let's say you have a protocol:
```swift
protocol Greeting {
    func sayHello() -> String
}
```
You need a class wich says hello.

```swift
let object: Greeting = _new {
  class NoName: Greeting {
    func sayHello() -> String {
      return "hello from no name class"
    }
  }
  return NoName()
}

object.sayHello()
```
More real example:

```swift
        let configuration = URLSessionConfiguration.default
        var downloadsSession = URLSession(configuration: configuration,
                                          delegate: _new {
                                            class NoName: NSObject, URLSessionDownloadDelegate {
                                                func urlSession(_ session: URLSession,
                                                                downloadTask: URLSessionDownloadTask,
                                                                didFinishDownloadingTo location: URL) {
                                                    print("Finished downloading to \(location).")
                                                }
                                            }
                                            return NoName()
                                          },
                                          delegateQueue: nil)
```                                          
Note URLSession stores it's delegate strongly but, usually delegates are stored weekly. So you will get nil if just use ```some.delegate = _new {...}```.
Firstly you need to store it strongly.
