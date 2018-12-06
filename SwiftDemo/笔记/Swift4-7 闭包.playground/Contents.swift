import UIKit

18-11-05
"No.7 闭包"
"https://www.cnswift.org/closures"

var str = "Hello, playground"

//闭包是可以在代码中被传递和引用的功能性独立模块
//闭包能够捕获和存储定义在其上下文中的任何常量和变量的引用

//闭合形式:
//全局函数是一个有名字但不会捕获任何值的闭包
//内嵌函数是一个有名字且能从其上层函数捕获值的闭包
//闭包表达式是一个轻量级语法所写的可以捕获其上下文中变量和常量值的没有名字的闭包

//常见优化:
//利用上下文推断形式参数和返回值的类型
//单表达式的闭包可以隐式返回
//简写实际参数名
//尾随闭包语法

//闭包表达式:在简短行内就能写完闭包的语法
//sorted方法
//根据排序闭包将已知类型的数组的值进行排序,一旦排序完成,sorted(by:)会返回与原数组类型大小完全相同的新数组,该数组的元素是已排序好的
//原始数组不会被修改
let names = ["Chris","Alex","Ewa","Barry","Daniella"]
func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reserveNames = names.sorted(by: backward)
print(reserveNames)

//闭包表达式语法
/**
 { (parameters) -> (return type) in
    statements
 }
*/
//可以使用常量形式参数,变量形式参数,输入输出形式参数
//不能提供默认值
//可变形式参数也能使用,但要在形式参数列表的最后边
//元组也可用作形式参数和返回类型
//形式参数类型和返回类型都应写在大括号内
//in 表示闭包的形式参数类型和返回类型已经完成,并且闭包的函数体即将开始
reserveNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})

//从语境中推断类型
//当把闭包作为行内闭包表达式传递给函数,形式参数类型和返回类型都能推断出来
//所以当闭包作为函数的实际参数时不需要用完整形式来书写行内闭包
reserveNames = names.sorted(by: { s1, s2 in return s1 > s2 })

//从单表达式闭包隐式返回
//单表达式能通过从他们的声明中删除return来隐式返回他们单个表达式的结果
reserveNames = names.sorted(by: { s1, s2 in s1 > s2 })
//第二个实际参数的函数类型已经明确必须通过闭包返回一个bool值

//简写的实际参数名
//Swift自动对行内闭包提供简写实际参数名, 通过$0,$1,$2等名字来引用闭包的实际参数值
//如果再闭包表达式中使用简写实际参数名,那么可以在闭包的实际参数列表中忽略对其定义,并且简写实际参数名的数字和类型将会从期望的函数类型中推断出来
//in 也能被省略,因为闭包表达式完全由他的函数体组成
reserveNames = names.sorted(by: { $0 > $1 })
//$0,$1 分别是闭包的第一个和第二个 string 实际参数

//运算符参数
reserveNames = names.sorted(by: >)
//> 作为有两个string类型形式参数的函数并返回bool类型的值

//尾随闭包:
//被书写在形式参数的括号外边(后面)的闭包表达式
func someFunctionThatTakesAClosure(closure: () -> Void){
    
}

someFunctionThatTakesAClosure {
    
}
//如果闭包表达式被作为函数唯一的实际参数并把闭包表达式用作尾随闭包,那么调用这个函数时就不需要在函数名字的后边写()
reserveNames = names.sorted(){ $0 > $1 }
reserveNames = names.sorted { $0 > $1 }

let digitNames = [
    0: "Zero",1: "One",2: "Two",  3: "Three",4: "Four",
    5: "Five",6: "Six",7: "Seven",8: "Eight",9: "Nine"
]
let numbers = [16,58,510]

let strings = numbers.map { (number) -> String in
    var number = number
    var output = ""
    repeat{
        output = digitNames[number % 10]! + output//取余
        number /= 10
    }while number > 0
    return output
}
print(strings)
//map(_:) 方法在数组中为每个元素调用了一次函数表达式

//捕获值:
//一个闭包能从上下文捕获已被定义的常量和变量
//即使定义这些常量和变量的原作用域已经不存在了,闭包仍能在其函数体内引用和修改这些值
//一个能够捕获值的闭包最简单的模型是内嵌函数,即被书写在另一个函数内部
//一个内嵌函数能够捕获外部函数的实际参数,并能捕获任何在外部函数的内部定义了的常量和变量
func makeIncrement(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func increment() -> Int {
        //runningTotal和amount来自内敛函数外部
        runningTotal += amount
        return runningTotal
    }
    return increment
}
let incrementByTen = makeIncrement(forIncrement: 10)
print(incrementByTen())//10
print(incrementByTen())//20
print(incrementByTen())//30
//如果分配了一个闭包给类实例的属性,并且闭包通过引用该实例或者他的成员来捕获实例,你将在闭包和实例间建立一个强引用环

//闭包是引用类型
//函数和闭包都是引用类型
//无论什么时候赋值一个函数或闭包给常量和变量,实际上都是将常量和变量设置为对函数和闭包的引用
//赋值一个闭包到两个不同的常量和变量中,这两个常量或变量都将指向相同的闭包
let anotherIncrementByTen = incrementByTen
print(anotherIncrementByTen())//40

//逃逸闭包
//当闭包作为一个实际参数传递给一个函数时,这个闭包逃逸了 --- 因为它在函数返回之后被调用
//当声明一个接受闭包作为形式参数的函数时,可以在形式参数前写@escaping 来明确闭包允许逃逸
//闭包可以逃逸的一种方法是被存储在定义于函数之外的变量里
//eg: 很多函数接收闭包实际参数来作为启动异步任务的回调,函数在启动任务后返回,但是闭包要直到任务完成 -- 闭包需要逃逸,以便于稍后调用
var completionHandlers : [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void){
    completionHandlers.append(completionHandler)
}
//函数someFunctionWithEscapingClosure接收一个闭包作为实际参数并且添加它到声明在函数外部的数组里,如果不标记函数的形式参数为 @escaping,就会遇到编译错误
//让闭包escaping 意味着你必须在闭包中显示的引用self
func someFunctionWithNoescapingClosure(closure: () -> Void){
    closure()
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure {
            self.x = 100
        }
        someFunctionWithNoescapingClosure {
            x = 200
        }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)//200

completionHandlers.first?()
print(instance.x)//100

//自动闭包
//自动创建的用来把作为实际参数传递给函数的表达式打包的闭包
//自动闭包不接受任何实际参数,,并且当他被调用时,会返回内部打包的表达式的值













