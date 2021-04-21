/*:
 [Previous](@previous)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[Next](@next)
 
 # Observer
 - - - - - - - - - -
 ![Observer Diagram](Observer_Diagram.png)
 
 The observer pattern lets one object observe changes on another object. It involves three types:
 
 (1) The **subscriber** is the "observer" object and receives updates.
 
 (2) The **publisher** is the "observable" object and sends updates.
 
 (3) The **value** is the underlying object that's changed.
 
 ## Code Example
 */
// 1
import Combine

// 2
public class User {
    
    // 3
    @Published var name: String
    
    // 4
    public init(name: String) {
        self.name = name
    }
}

// 1
let user = User(name: "Ray")

// 2
let publisher = user.$name

// 3
var subscriber: AnyCancellable? = publisher.sink() {
    print("User's name is \($0)")
}

// 4
user.name = "Vicki"
subscriber = nil
user.name = "Ray has left the building"
