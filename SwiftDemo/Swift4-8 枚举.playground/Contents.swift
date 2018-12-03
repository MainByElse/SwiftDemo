import UIKit

18-11-26
"No.8 枚举"
"https://www.cnswift.org/enumerations"

var str = "Hello, playground"

//枚举为一组相关值定义了一个通用类型
//Swift中不需给枚举中每个成员提供值
//提供的值可以是: 字符串,字符,任意的整数值,浮点类型
//枚举类型可以指定任意类型的值与不同的成员值关联存储
//Swift中的枚举是具有自己权限的一类类型,使用了许多一般只被类所支持的特性

//Swift中 枚举成员在被创建时不会分配一个默认的整数值
//不同的枚举成员在自己的权限中都是完全合格的值,并且是在CompassPoint中被显示定义的类型
enum CompassPoint {
    case north
    case south
    case east
    case west
}

//多个成员值可以出现在同一行中,用逗号分隔
enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}

var directionToHead = CompassPoint.west//类型推断为CompassPoint
directionToHead = .east//可使用点语法

//使用Switch语句来匹配枚举值
directionToHead = .south
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}
//不能将所有枚举值列举出一个case时,需要提供default

//遍历枚举情况(case)
//在枚举名字后边写CaseIterable来允许枚举被遍历
enum Beverage: CaseIterable {
    case coffee,tea,juice
}
let numberOfChoices = Beverage.allCases.count
print(numberOfChoices)

for beverage in Beverage.allCases {
    print(beverage)
}

//关联值
///可以存储任意给定类型的关联值,不同枚举成员关联值的类型可以不同
//定义一个叫做 Barcode的枚举类型，它要么用 (Int, Int, Int, Int)类型的关联值获取 upc 值，要么用 String 类型的关联值获取一个 qrCode的值
enum Barcode {
    case upc(Int,Int,Int,Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(8, 85909, 51226, 3)
//可以分配不同类型的值 -- 只能存储其中之一
productBarcode = Barcode.qrCode("ABCDEFG")

switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem),\(manufacturer),\(product),\(check)")
case .qrCode(let productCode):
    print("QR Code: \(productCode)")
}
//如果一个枚举成员的所有关联值都被提取为常量或变量
productBarcode = Barcode.upc(8, 85909, 51226, 3)
switch productBarcode {
case let .upc(numberSystem,manufacturer,product,check):
    print("UPC: \(numberSystem),\(manufacturer),\(product),\(check)")
case let .qrCode(productCode):
    print("QR Code: \(productCode)")
}

//原始值
//枚举成员可以用相同类型的默认值预先填充(原始值)
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}
///原始值与关联值不同.
//原始值是第一次定义枚举时,用来预先填充的值
//特定枚举成员的原始值是始终相同的
//关联值是基于枚举成员的其中之一创建新的常量和变量时设定,并且每次这些关联值是可以不同的

//隐式指定原始值
//当在操作存储整数或字符串原始值枚举时,不必显式给每个枚举成员分配原始值
//没有分配时,Swift会自动分配原始值
//当整数值作为原始值时,每成员的隐式值都比前一个大一.
//如果第一个成员没有值,那么他的值是0
enum PlanetInt: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

//如果字符串作为原始值时,每个成员的隐式原始值是那个成员的名称
enum CompassPointString: String {
    case north, south, east, west
}

//使用rawValue来访问枚举成员的原始值
let earthOrder = PlanetInt.earth.rawValue
print(earthOrder)
let sunsetDirection = CompassPointString.south.rawValue
print(sunsetDirection)

//从原始值初始化
//如果用原始值类型来定义一个枚举,枚举会自动收到一个可以接受原始值类型的值的初始化器(rawValue的形式参数),然后返回一个枚举类型或者nil
let possiblePlanet = PlanetInt(rawValue: 7)
print(possiblePlanet ?? "没有对应的planet")
//不是所有的Int值都会对应一个planet,因此原始值的初始化器总是返回可选的枚举成员
//原始值初始化器是可失败初始化器
let positionToFind = 11
if let somePlanet = PlanetInt(rawValue: positionToFind) {
    switch somePlanet {
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for human")
    }
}else{
    print("There isn't a planet at position \(positionToFind)")
}

//递归枚举 -- 内嵌
//拥有另一个枚举作为枚举成员关联值的枚举
//当编译器操作递归枚举时必须插入间接寻址层
//在声明枚举成员之前使用 indirect 来明确是递归枚举
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression,ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression,ArithmeticExpression)
}
//同样可以在枚举之前写 indirect ,让整个枚举成员在需要时可以递归
let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

//递归函数是一种操作递归结构数据的简单方法
func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left,right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left,right):
        return evaluate(left) * evaluate(right)
    }
}
print(evaluate(product))
//通过直接返回关联值来判断普通数字

