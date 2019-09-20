# SwiftAnonymousClass

Add function ```new``` in your project.
```swift
func new<Type>(_ objectCreator:()->Type) -> Type {
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
let object: Greeting = new {
  class NoName: Greeting {
    func sayHello() -> String {
      return "hello from no name class"
    }
  }
  return NoName()
}
```
