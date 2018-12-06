import UIKit

18-11-29
"No.10 属性"
"https://www.cnswift.org/properties"

var str = "Hello, playground"

//属性可以将值与特定的类,结构体或者是枚举联系起来
//存储属性会存储常量或变量作为实例的一部分,反之计算属性会计算(不是存储)值
//计算属性可以有类,结构体或枚举定义
//存储属性只能有类,结构体定义
//类型属性: 属性与类型本身相关联

//存储属性:
//存储属性是一个作为特定类或结构体实例的一部分变量或常量
//存储属性要么是变量存储属性(var),要么是常量存储属性(let)
//可以为存储属性提供一个默认值作为定义的一部分
//在初始化的过程中设置和修改存储属性的初始值
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
rangeOfThreeItems.firstValue = 6
print(rangeOfThreeItems)
//常量length 创建时赋初始值不能再修改

//常量结构体实例的存储属性
//创建一个结构体的实例并赋值给常量,不能修改这个实例的属性,即使这个结构体实例的属性是变量
let rangeOfFourItems = FixedLengthRange(firstValue: 2, length: 3)
//rangeOfFourItems.firstValue = 3
//因为结构体是值类型,当一个值类型的实例被标记为常量时,该实例的其他属性也为常量
///类是引用类型,给常量赋值引用类型实例,仍可修改常量实例的变量属性

//延迟存储属性
//延迟存储属性的初始值在其第一次使用时才进行计算
//加 lazy
//延迟存储属性必须声明为 var(变量)
//初始值可能在实例初始化完成之前无法取得
//常量必须在实例初始化完成之前有值
class DataImporter {
    var fileName = "data.txt"
}
class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
}
let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")

//只有第一次访问importer时才会创建
print(manager.importer.fileName)
//如果被lazy修饰的属性同时被多个线程访问并且属性还没有被初始化,无法保证属性只被初始化一次

//计算属性
//除了存储属性,类、结构体、枚举也能定义计算属性,实际并不存储值
//提供一个读取器和一个可选的设置器来间接得到和设置其他的属性和值
struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    //center为计算属性
    var center: Point {
        get {
            let centerX = origin.x + (size.width*0.5)
            let centerY = origin.y + (size.height*0.5)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width*0.5)
            origin.y = newCenter.y - (size.height*0.5)
        }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0), size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("now square.origin: \(square.origin.x) , \(square.origin.y)")

//简写设置器(setter)声明
//如果一个计算属性的设置器没有为将要被设置的值定义一个名字,默认命名为newValue
struct AlertnativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width*0.5)
            let centerY = origin.y + (size.height*0.5)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width*0.5)
            origin.y = newValue.y - (size.height*0.5)
        }
    }
}

//只读计算属性
//只有读取器没有设置器的计算属性
//只读计算属性返回一个值,也可通过点语法访问,但是不能被修改为另一个值
//必须用var定义计算属性
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4, height: 5, depth: 2)
print(fourByFiveByTwo.volume)
//去掉get和大括号简化只读计算属性的声明

//属性观察值
//属性观察者会观察并对属性值的变化做出回应
//每当一个属性的值被设置时,属性观察者都会被调用,即使这个值与该属性当前的值相同
//可以为定义的任意存储属性添加属性观察者,除了延迟存储属性
//也可以通过在子类中重写属性来为任何继承属性(存储属性和计算属性)添加属性观察者
//不需要为非重写的计算属性定义属性观察者,可以在计算属性的设置器里直接观察和响应他们值的改变

//观察者:
///willSet: 该值被存储之前调用
//新的属性值会以常量形式参数传递
//可以在 willSet 实现中为这个参数定义名字,默认使用newValue
///didSet:  在一个新值被存储后调用
//一个包含旧属性值的常量形式参数将会被传递
//可以命名,也可使用默认名 oldValue
//如果在属性自己的观察者didSet 里给自己赋值,赋值的新值会取代刚刚设置的值

//PS: 父类属性的willSet和didSet观察者会在子类初始化器设置时被调用,不会在类的父类初始化器调用中设置其自身属性时被调用
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
stepCounter.totalSteps = 360

//全局和局部变量
//全局变量是定义在任何函数、方法、闭包或类型环境之外的变量
//局部变量是定义在函数、方法或者闭包环境之中的变量
///全局常量和变量永远是延迟计算的,与延迟存储属性(lazy)有着相同的行为,只是全局常量和变量不需要使用lazy修饰

//类型属性
//实例属性是属于特定类型实例的属性,每次创建这个类型的新实例,就拥有一堆属性值,与其他实例不同
//存储类型属性可以是变量或常量,计算类型属性总是变量,与计算实例属性一致
//不同于存储实例属性,存储类型属性必须有一个默认值 -- 类型本身不能拥有在初始化时给存储类型属性赋值的初始化器
///存储类型属性是在第一次访问时延迟初始化的,就算被多个线程同时访问,也只会初始化一次,且不需要lazy修饰

//类型属性语法
//类型属性是写在类型的定义之中的,在类型的花括号里,并且每一个类型属性都显示的放在它支持的类型范围内
//使用static来开一类型属性
//对于类类型的计算类型属性,可以使用class来允许子类重写父类的实现
struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}

//查询和设置类型属性
//类型属性使用点语法来查询和设置,与实例属性一致
//类型在类里查询和设置,而不是这个类型的实例
print(SomeStructure.storedTypeProperty)//Some value.
SomeStructure.storedTypeProperty = "Another value."
print(SomeStructure.storedTypeProperty)//Another value.
print(SomeEnumeration.computedTypeProperty)//6
print(SomeClass.computedTypeProperty)//27

struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannel = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                currentLevel = AudioChannel.thresholdLevel//限制最大不超过10
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannel {
                AudioChannel.maxInputLevelForAllChannel = currentLevel
            }
        }
    }
}

var leftChannel = AudioChannel()
var rightChannel = AudioChannel()

leftChannel.currentLevel = 7
print(leftChannel.currentLevel)//7
print(AudioChannel.maxInputLevelForAllChannel)//7

rightChannel.currentLevel = 11
print(rightChannel.currentLevel)//10
print(AudioChannel.maxInputLevelForAllChannel)//10




