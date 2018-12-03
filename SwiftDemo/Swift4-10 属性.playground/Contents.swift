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









