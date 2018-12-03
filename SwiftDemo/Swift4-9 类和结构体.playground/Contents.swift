import UIKit

18-11-27
"No.9 类和结构体"
"https://www.cnswift.org/classes-and-structures"

var str = "Hello, playground"

//不需要为自定义类和结构体创建独立的接口和实现文件,系统会自动生成面向其他代码的外部接口

//类和结构体的对比
//共同:
//  1.定义属性用来存储值
//  2.定义方法用来提供功能
//  3.定义下标脚本用来允许使用下标语法访问值
//  4.定义初始化器用于初始化状态
//  5.可以被扩展来默认所没有的功能
//  6.遵循协议来针对特定类型提供标准功能

//类有结构体没有的额外功能:
//  1.允许一个类继承另一个类的特征
//  2.类型转换允许你在运行检查和解释一个类实例的类型
//  3.反初始化器允许一个类实例释放任何其所被分配的资源
//  4.引用计数允许不止一个对类实例的引用

//定义语法
struct Resolution {
    var width = 0
    var height = 0
    
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}
    
//类与结构体实例
let someResolution = Resolution()
let someVideoMode = VideoMode()

//访问属性
print("\(someResolution.width)")
print("\(someVideoMode.resolution.height)")

someVideoMode.resolution.width = 200
print("\(someVideoMode.resolution.width)")
//swift允许直接设置结构体属性中的子属性

//结构体类型的成员初始化器
//所有的结构体都有一个自动生成的成员初始化器
let vga = Resolution(width: 10, height: 20)
///与结构体不同,类实例不会接收默认的成员初始化器

//结构体和枚举是值类型
//值类型是一种当他被指定到常量或者变量,或者被传递给函数时会被拷贝的类型
//Swift中所有的基本类型(整数,浮点数,布尔值,字符串,数组,字典)都是值类型,并以结构体的形式在后台实现
//Swift中所有的结构体和枚举都是值类型,在代码传递中总是被拷贝
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
cinema.width = 2048
print("\(hd.width) -- \(cinema.width)")

//类是引用类型
//不同于值类型,引用类型被赋值到一个常量或变量,或本身被传递到一个函数的时候是不会被拷贝的
//相对于拷贝,这里使用的是对同一个现存实例的引用

let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
//常量alsoTenEighty的参数在改变 ,并不是常量alsoTenEighty本身在改变

print("\(tenEighty.frameRate) -- \(alsoTenEighty.frameRate)")
//引用和被引用一起被改变

//特征运算符
//相同于  (===) 两个类型常量或变量引用自相同的实例
//不相同于 (!==)
//检查两个常量或变量是否引用相同
if tenEighty === alsoTenEighty {
    print("引用相同")
}

//类和结构体之间的选择
//类和结构体都可以用来定义自定义的数据类型
//结构体实例总是通过值来传递
//类实例总是通过引用来传递

//使用结构体标准:
//  1.结构体的主要目的是为了封装一些相关的简单数据值
//  2.当你在赋予或者传递一些结构实例时,有理由需要封装的数据值被拷贝而不是引用
//  3.任何存储在结构体中的属性是值类型,也将被拷贝而不是引用
//  4.结构体不需要从一个已存在类型继承属性或者行为

//字符串,数组,字典的赋值和拷贝行为
//Swift的String,Array,Dictionary类型是作为结构体来实现的,意味着被赋值到一个常量或变量,或被传递到一个函数或方法中时,其实是传递了拷贝
//NSString,NSArray,NSDictionary是作为类实现的,实例作为一个已存在实例的引用而不是拷贝来赋值和传递








