import UIKit

18-10-10
"No.5 控制流2"
"https://www.cnswift.org/control-flow"

var str = "Hello, playground"

//switch:
//没有隐式贯穿 -- 没有break时,不会从一个case执行到下一个case
//匹配到第一个case执行结束即退出
//case中匹配多值可使用 ',' 间隔,并可写成多行
//使用贯穿行为,使用 'fallthrough'
let someCharactor: Character = "z"
switch someCharactor {
case "a","b":
    print("The first letters of the alphabet")
//    fallthrough
case "z":
    print("The last letter of the alphabet")
    fallthrough
default:
    print("Some other charactor")
}

//区间匹配
let approximateCount = 62
let countedThings = "moons orbiting Saturn"
var naturalCount = String()
//var naturalCount: String //报错 初始化需要赋值
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}
print(naturalCount)

//元组
//使用下滑线_ 来表明匹配所有可能的值
let somePoint = (value0:1, value1:1)
switch somePoint {
case (0,0):
    print("(0, 0) is at the origin")
case (_,0):
    print(String(somePoint.value0) + ", 0 is on the x-axis")
    print(111)
case (0,_):
    print("(0, \(String(somePoint.value1))) is on the y-axis")
//    print(222)
case (-2...2,-2...2):
    print(String(somePoint.value0) + ", " + String(somePoint.value1) + " is inside the box")
    print(333)
default:
    print(String(somePoint.value0) + ", "  + String(somePoint.value1) + " is outside of the box")
    print(444)
}
print(String(somePoint.value0) + String(somePoint.value1))

//值绑定
//case可以将匹配到的值 '临时' 绑定为一个常量或变量,case的函数体中可用
//变量的改变只在函数体内部有效
let anotherPoint = (2,0)
switch anotherPoint {
case (let x,0):
    print("on the x-axis with an x value of " + String(x))
case (0, let y):
    print("on the y-axis with a y value of " + String(y))
case let (x, y)://声明了带有两个占位符常量的元组,可以匹配所有值,所以不需要default分支
    print("somewhere else at (" + String(x) + ", " + String(y) + ")")
}

//where
//switch可以使用 where检查额外的情况
let yetAnotherPoint = (1,-1)
switch yetAnotherPoint {
case let (x,y) where x == y:
    print("(" + String(x) + ", " + String(y) + ")" + " is on the line x == y")
case let (x, y) where x == -y:
    print("(" + String(x) + ", " + String(y) + ")" + " is on the line x == -y")
case let (x, y):
    print("(" + String(x) + ", " + String(y) + ")" + " is just some arbitrary point")
}

//复合情况
let someCharacter: Character = "e"
switch someCharacter {
case "a", "e", "i", "o", "u":
    print("\(someCharacter) is a vowel")
case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
     "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    print("\(someCharacter) is a consonant")
default:
    print("\(someCharacter) is not a vowel or a consonant")
}

//控制转移语句:
//continue break fallthrough return throw
//Continue:
//循环停止正在进行的操作并重新开始下一次循环
let puzzleInput = "great minds think alike"
var puzzleOutput = ""
let charactorsToRemove: [Character] = ["a","e","i","o","u"," "]
for charactor in puzzleInput {
    if charactorsToRemove.contains(charactor) {
        continue
    }else{
        puzzleOutput.append(charactor)
    }
}
print(puzzleOutput)

//break:
//立即结束整个控制流语句

//fallthrough:
//Swift中的switch不会从每个case的结尾贯穿到下一个case,如果想贯穿,使用fallthrough
let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13, 17, 19:
    description += " a prime number, and also"
    fallthrough
default:
    description += " an integer."
}
print(description)

//给语句打标签
let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
var square = 0
var diceRoll = 0
//标签: gameLoop
gameLoop: while square != finalSquare {
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    switch square + diceRoll {
    case finalSquare:
        // diceRoll will move us to the final square, so the game is over
        break gameLoop // 中断 gameLoop 循环,而不是中断 switch
    case let newSquare where newSquare > finalSquare:
        // diceRoll will move us beyond the final square, so roll again
        continue gameLoop // 继续循环 gameLoop ,而不是继续判断 switch
    default:
        // this is a valid move, so find out its effect
        square += diceRoll
        square += board[square]
    }
}
print("square: \(square). Game over!")

//提前退出 - guard:
//条件必须为真才能执行guard之后的语句
//guard语句总是得有else分支,用来执行条件为假时的情况
func greet(person: [String:String])
{
    guard let name = person["name"] else {
        print("There is no Name.")
        return
    }
    print("hello \(name)")
    
    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }
    print("I hope the weather is nice in \(location)")
}
//name 满足条件 / location 不满足条件
/**
 hello John
 I hope the weather is nice near you.
 */
greet(person: ["name":"John"])
//name 满足条件 / location 满足条件
/**
 hello Jane
 I hope the weather is nice in Qingdao
 */
greet(person: ["name":"Jane","location":"Qingdao"])

//检查API的可用性: - 可用性条件
if #available(iOS 10,macOS 10.14, *) {
    // Use iOS 10 APIs on iOS, and use macOS 10.14 APIs on macOS
    print("Use iOS 10 APIs on iOS, and use macOS 10.14 APIs on macOS")
} else {
    // Fall back to earlier iOS and macOS APIs
    print("Fall back to earlier iOS and macOS APIs")
}
