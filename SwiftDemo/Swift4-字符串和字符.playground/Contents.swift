import UIKit

18-10-08
"No.3 字符串和字符"
"https://www.cnswift.org/strings-and-characters"

var str = "Hello, playground"

//字符串字面量:
//多行字符串 """ XXX """
//要让多行字符串开头或结束带换行,需要在第一行或最后一行写一空行
let string =
"""

    This string starts with a line feed.
    It also end with a line feed.

"""
print(string)
//字符串拼接
str.append(string)
print(str)

//访问和修改字符串:
//字符串索引
let greeting = "Guten Tag!"
print(greeting[greeting.startIndex]) // G
print(greeting[greeting.index(before: greeting.endIndex)]) // !
print(greeting[greeting.index(greeting.startIndex, offsetBy: 7)]) // a 从开始数,索引为7的位置
//indices 访问字符串中每个字符的索引
////terminator:  G1 u1 t1 e1 n1  1 T1 a1 g1 !1
for index in greeting.indices {
    print("\(greeting[index])",terminator:"1 ")
}

//插入和删除:
//插入
//insert(_:at:)  特定索引位置插入'字符'
var welcome = "\nhello"
welcome.insert("!", at: welcome.endIndex)
print(welcome)
//insert(contentsOf:at:)  插入'字符串'到指定位置
welcome.insert(contentsOf: " there", at: welcome.index(before: welcome.endIndex))
print(welcome) // hello there!
//删除
//remove(_:at:) 移除指定位置上的"字符"
welcome.remove(at: welcome.index(before: welcome.endIndex))
print(welcome)
//remove(contentsOf:at:) 移除指定范围内的"字符串"
let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
welcome.removeSubrange(range)
print(welcome) //hello

//子字符串 Substring:
//子字符串可以重用一部分内存区域用来保存原字符串的内存,或者用来保存其他子字符串的内存
//子字符串不适合长期保存,重用了原字符串的内存,只要这个字符串有子字符串在使用中,那么这个字符串就必须保存在内存中
let greeting2 = "hello,world!"
let index = greeting2.firstIndex(of: ",") ?? greeting2.endIndex
let beginning = greeting2[..<index]
print(beginning) //hello   String.SubSequence
let ending = greeting2[index...]
print(ending)   //,world!  String.SubSequence
//将 短期子字符串 转换成 长期字符串
let newString = String(beginning+ending)
print(newString)

//前缀和后缀:
//前缀
let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]
var act1SceneCount = 0
for scene in romeoAndJuliet {
    if scene.hasPrefix("Act 1") {
        act1SceneCount += 1
    }
}
print("There are \(act1SceneCount) scenes in Act 1")
//后缀
var mansionCount = 0
var cellCount = 0
for scene in romeoAndJuliet {
    if scene.hasSuffix("Capulet's mansion") {
        mansionCount += 1
    }else if scene.hasSuffix("Friar Lawrence's cell"){
        cellCount += 1
    }
}
print("\(mansionCount) Mansion scenes; \(cellCount) Cell scenes.")





