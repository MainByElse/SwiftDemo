import UIKit

18-12-07
"No.11 方法"
"https://www.cnswift.org/methods"

var str = "Hello, playground"

//方法是关联了特定类型的函数
//类,结构体和枚举都能定义实例方法
//方法封装了给定类型特定的任务和功能
//OC中,类是唯一能定义方法的类型
//Swift中,类,结构体和枚举都能在创建的类型中定义方法

//实例方法
//属于特定类实例,结构体实例和枚举实例的方法
//实例方法默认可以访问同类下所有其他实例方法和属性
//实例方法只能在类型的具体实例中被调用,不能独立于实例而被调用
class Counter {
    var count = 0
    func increment() {
        count += 1
//        self.count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}

let counter = Counter()
counter.increment()
print(counter.count)//1
counter.increment(by: 2)
print(counter.count)//3
counter.reset()
print(counter.count)//0

//self属性
struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }
}
let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOf(x: 1.0) {
    print("This point is to the right of the line where x == 1.0")
}

//在实例方法中修改值类型
//结构体和枚举是值类型,默认情况下,值类型属性是不能被自身的实例方法修改
//异变: 任何改变在方法结束的时候都会写入到原始的结构体中
struct Point1 {
    var x = 0.0, y = 0.0
    //异步方法: mutating 允许修改自身的属性
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}

var somePoint1 = Point1(x: 1.0, y: 1.0)
somePoint1.moveBy(x: 2.0, y: 3.0)
print("this point is now at \(somePoint1.x),\(somePoint1.y)")

//在异变方法里指定自身
//异变方法可以指定整个实例给隐含的self属性
struct Point2 {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = Point2(x: x+deltaX, y: y+deltaY)
    }
}

//枚举的异变方法可以设置隐含的self属性为相同枚举里的不同成员
enum TriStateSwitch {
    case off,low,high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .low
        }
    }
}
var ovenLight = TriStateSwitch.low
ovenLight.next()
print(ovenLight)//high
ovenLight.next()
print(ovenLight)//low

//类型方法
//定义在类型本身调用的方法
//func前加 static来明确一个类型方法
//类同样可以使用class来允许子类重写父类对类型方法的实现
class SomeClass {
    class func someTypeMethod() {
        
    }
}
SomeClass.someTypeMethod()
//在类型方法的函数体中,隐含的self属性指向了类本身而不是这个类的实例

struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    
    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }
    
    static func isUnlock(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    
    @discardableResult//特性: 忽略返回值
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlock(level) {
            currentLevel = level
            return true
        }else {
            return false
        }
    }
}

class Player {
    var tracker = LevelTracker()
    let playerName: String
    func complete(level: Int) {
        LevelTracker.unlock(level+1)
        tracker.advance(to: level+1)
    }
    init(name: String) {
        playerName = name
    }
}

var player = Player(name: "Ara")
player.complete(level: 1)
print(LevelTracker.highestUnlockedLevel)//2

player = Player(name: "Bcb")
if player.tracker.advance(to: 5) {
    print("5")
}else {
    print("not 5")
}

