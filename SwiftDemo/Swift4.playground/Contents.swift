import UIKit

18-09-29
"No.1 基础内容"

"https://www.cnswift.org/the-basics"

var str = "Hello, playground"

//常量和变量:
//1 命名不能以数字开头

//浮点数:
//1 推断浮点数的时候始终选择 Double 类型

//数值型字面量:
//1 二进制 0b
//2 八进制 0o
//3 十六进制 0x
//4 浮点型字面量:小数点两边必须有至少一个数字
//    十进制有一个可选的指数 -- E/e 等于基数乘以10eexp
//    十六进制必须有指数 -- P/p 等于基数乘以2exp
//5 整数和浮点数都可以添加额外的0或下划线_增加代码的可读性,不影响字面量的值

//类型别名:
//typealias

//※ 元组:
//把多个值合并成单一的复合型的值 --- 可以是任何类型且不必是相同的类型
let http404Error = (404," Not Found")
let (statusCode,statusMessage) = http404Error
print(String(statusCode)+statusMessage)

//用不到的数据使用 _ 替换
let (justCode,_) = http404Error
print(justCode)

//使用索引获取值
print(http404Error.0)
print(http404Error.1)

//定义时给单个元素命名
let http200Status = (statusCode:200,statusMessage:"Success")
print(http200Status.statusCode)
print(http200Status.statusMessage)

//※ 可选值:
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber) //Int? 类型 表示可能为nil
print(convertedNumber ?? 404)   //Optional(123)

//如果定义可选变量时没有提供默认值,默认设置为nil
var surveyAnswer : String?  //survey 调查/勘测
print(surveyAnswer ?? "surveyAnswer为nil")

//if语句/强制展开
if convertedNumber != nil {
    print("ConvertedNumber contains some integer value of \(convertedNumber!)")
    //convertedNumber! 强制展开 判断convertedNumber不为nil时, 可强制展开
}

//可选项绑定
if let actualNumber = Int(possibleNumber) {
    print("possibleNumber \(possibleNumber) has a integer value actualNumber \(actualNumber)")
}

//可以在同一个if语句中包含多个可选项绑定, 用逗号分隔, 如果任一可选绑定结果为nil 或 布尔值为false, 则整个if会被判定为false
if let firstNumber = Int("4"),let secondNumber = Int("42"),firstNumber < secondNumber && secondNumber < 100 {
    print("\(firstNumber) < \(secondNumber) < 100")
}
//等价于
if let firstNumber = Int("4") {
    if let secondNumber = Int("42") {
        if firstNumber < secondNumber && secondNumber < 100 {
            print("\(firstNumber) < \(secondNumber) < 100")
        }
    }
}

//注意: 使用 if 语句创建的常量和变量只在if语句的函数体内有效
//     在 guard 语句中创建的常量和变量在guard语句后的代码中也可用

//隐式展开可选项
//可选项一旦被设定值后,就会一直拥有值
//在声明的类型后边加 ! 来书写隐式展开可选项
let possibleString : String? = "An optional string."
let forcedString : String = possibleString!

let assumedString : String! = "An implicitly unwrapped optional string."
let implicitString = assumedString // implicitly 含蓄地 暗中地 unwrapp 打开

//错误处理:
func canThrowAnError() throws {
    
}

do {
    try canThrowAnError()
} catch  {
    //错误抛出时执行
}

//断言和先决条件:
//断言
let age = -3
//assert(age >= 0, "A person's age cannot be less than zero")//停止应用

//强制先决条件
//条件可能潜在为假,但是必须肯定为真才能执行的地方使用先决条件
let index = -2
//precondition(index > 0, "Index must be greater than zero.")










