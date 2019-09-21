# SwiftAnonymousClass

Analog of anonymous class in Swift.

SwiftAnonymousClass adds function ```_new``` in your project.
```swift
public func _new<Type>(owner: AnyObject? = nil, _ objectCreator:()->Type) -> Type
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
To do this you may use ```owner``` parameter of ```_new``` function.
This parameter will bind lifetime of ```_new``` object and ```owner```
new anonimous object will be removed on deinit owner call.

example:
```swift

protocol ADelegate: class {
	func `do`()
 }
 
 class A {
	weak var delegate: ADelegate?
	
	deinit {
		delegate?.do()
	}
}

...

let a = A()
a.delegate = _new(owner: a) {			
			class ADelegateInstance: ADelegate {
			
				func `do`() {
					print("DO from delegate")
				}
			}
      }
```

If you set new anonymous delegate the first will be deallocated.
If you set new delegate (not from _new) your anonymous delegate will stay untill owner deallocated.
To make it be removed forced you may first set _new with nil. Example:

Let's say you have Some class with week delegate SomeDelegate. 
You have some class SOmeDelegateInstance and it's instance stored strongly somewhere.
Firstly you set Some instance delegate as an anonymous object.
But after you change it to not anonymous class your anonymous class will be unawailable but alive.
To make it be destoyed before some instance be released you may do the follow

```swift

some.delegate = _new(owner:some) {
    class NoName: SomeDelegate {
        func `do`() {
            print("DO")
        }
    }
    return NoName()
}

some.delegate = _new(owner:some) { nil }
some.delegate = someDelegateInstance
```

## How to use:
You may copy SwiftAnonymousClass.swift directly to your project,
or use cocoa pods:
```
pod "SwiftAnonymousClass"
```
you will need to add 
```swift
import SwiftAnonymousClass
```



