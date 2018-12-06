import UIKit

18-10-11
"No.6 函数"
"https://www.cnswift.org/functions"

var str = "Hello, playground"

//函数是一个独立的代码块,用来执行特定的任务
//Swift中的函数都有类型, 形式参数类型(输入)和返回类型(输出)
func greet(name: String) -> String {
    return "hello \(name)!"
}
let string = greet(name: "Else")
print(string)
//多返回值函数 -- 使用元组
func minMax(array:[Int]) -> (min:Int,max:Int)? {
    //可选元组 -- 函数不会对传入的数组进行安全性检查,数组可能为nil
    if array.isEmpty {
        return nil
    }
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        }else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin,currentMax)
}
let bounds = [1,3,5,6,8,9]
print("min:\(String(describing: bounds.min())) , max:\(String(describing: bounds.max()))")

//形式参数: 实际参数标签和形式参数名
//实际参数标签: 用在调用函数的时候. 调用函数时,每个实际参数前都要写实际参数标签
//形式参数名: 用在函数实现中.
//默认情况下,形式参数使用形式参数名作为实际参数标签

//指定实际参数标签: 在形式参数名之前写实际参数标签,用空格分隔
func someFunction(argumentLabel paramterName: Int) {
    // In the function body, parameterName refers to the argument value
    // for that parameter.
}
//PS: 如果为形式参数提供了实际参数标签,那么这个实际参数在调用函数时必须使用实际参数标签
someFunction(argumentLabel: 1)
//eg:
func greet(name: String,from hometown: String) -> String {
    //形式参数名(hometown)在实现中使用
    return "hello \(name), glad you counld visit from \(hometown)."
}
//实际参数标签(from)在调用时使用
print(greet(name: "Else", from: "QingDao"))

//省略实际参数标签
func someFunction(_ firstParamterName: Int, secondParamterName: Int) {
    
}
//调用时第一个形式参数不显示实际参数标签,也不显示形式参数名
someFunction(1, secondParamterName: 1)

//默认形式参数值
func someFunction(paramterWithDefault: Int = 12) {
    print(paramterWithDefault)
}
someFunction(paramterWithDefault: 6)
someFunction() // 不传参,函数使用默认值

//可变形式参数
//可以接受零或多个特定类型的值
//只能在函数的内部改变
func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for value in numbers {
        total += value
    }
    return total / Double(numbers.count)
}
print(arithmeticMean(1.21211111,1.21211111,1.21211111))
//PS: 一个函数最多只能有一个可变形式参数

//输入输出形式参数
//函数能够修改一个形式参数的值,,并且在函数结束后修改仍然生效
//在形式参数定义开始的时候在前边添加一个 'inout' 关键字,可以定义一个输入输出形式参数
//输入输出形式参数有一个能输入给函数的值,函数能对其进行修改,还能输出到函数外替换原来的值
//只能把变量作为输入输出形式参数的实际参数,因为变量和字面量不能修改
//将变量作为输入输出形式参数的实际参数,直接在它之前添加一个 '&' 符号来表示可以被函数修改
//PS: 输入输出形式参数不能有默认值,可变形式参数不能标记为 inout ,如果一个形式参数标记为 inout ,那么就不能标记为 var/let
func swapTwoInts(_ a: inout Int,_ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt) //& 表示可被修改
print("someInt is now \(someInt), anotherInt is now \(anotherInt)")

//函数类型:
//每个函数都有一个特定的函数类型,由形式参数,返回类型组成
func addTwoInts(_ a: Int, _ b: Int) -> Int{
    return a + b
}
func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}
//以上两个函数的类型为: (Int, Int) -> Int
//即: 有两个形式参数的函数类型, 都是Int类型, 并返回Int类型的值

func printHelloWorld() {
    print("hello world")
}
//无形式参数和返回值的函数, 函数类型为: () -> void

//使用函数类型:
var mathFunction: (Int, Int) -> Int = addTwoInts(_:_:)
print("add result: \(mathFunction(2,3))")

//不同的函数有相同的匹配类型,可以指定相同的变量
mathFunction = multiplyTwoInts(_:_:)
print("multiply result: \(mathFunction(2,3))")

//函数类型作为形式参数类型:
func printMathFunction(_ mathFunction: (Int, Int) -> Int,_ a: Int,_ b: Int) {
    print("mathFunction: \(mathFunction(a,b))")
}
printMathFunction(addTwoInts(_:_:), 1, 2)

//函数类型作为返回类型:
func stepForward(_ input: Int) -> Int {
    return input + 1
}
func stepBackward(_ input: Int) -> Int {
    return input - 1
}
func chooseStepFunction(backwards: Bool) -> (Int)->Int {
    return backwards ? stepBackward(_:) : stepForward(_:)
}

var currentValue = 3
let moveNearerToZero = chooseStepFunction(backwards: currentValue > 0)

print("\nCounting to Zero :")
while currentValue != 0 {
    print("\(currentValue)...")
    currentValue = moveNearerToZero(currentValue)
}
print("Zero")

//内嵌函数:
//在函数内部定义另一个函数
//内嵌函数(stepForward,stepBackward)默认情况下在外部是被隐藏的,但仍可通过包裹它的函数(chooseStepFunction1)来调用
//包裹的函数也可返回内部的内嵌函数在另外的范围里使用
func chooseStepFunction1(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input + 1 }
    return backward ? stepForward(input:) : stepBackward(input:)
}
var currentValue1 = -4
let moveNearerToZero1 = chooseStepFunction1(backward: currentValue > 0)
while currentValue1 != 0 {
    print("\(currentValue1)....")
    currentValue1 = moveNearerToZero1(currentValue1)
}
print("Zero!")



