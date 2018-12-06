import UIKit

18-10-09
"No.4 集合类型"
"https://www.cnswift.org/collection-types"

var str = "Hello, playground"

//数组: 有序值的集合
//合集: 唯一值的无序集合
//字典:无序的键值对集合

//数组:
//数组以有序的方式来存储相同类型的值. 相同类型的值可以在数组的不同地方多次出现
var someInts = [Int]()
print("someInts is of type [Int] with \(someInts.count) items.")
someInts.append(3)
print(someInts)
someInts = []
print(someInts)
//使用默认值创建数组
var threeDoubles = Array(repeating: 0.0, count: 3)
print(threeDoubles)
//通过连接两个数组来创建数组
var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
var sixDoubles = threeDoubles + anotherThreeDoubles
print(sixDoubles) //[0.0, 0.0, 0.0, 2.5, 2.5, 2.5]
//使用数组字面量创建数组
var shoppingList : [String] = ["Eggs","Milk"]
//var shoppingList = ["Eggs","Milk"] 使用相同类型的数组字面量创建数组,不需要写明数组的类型
print(shoppingList)
//访问和修改数组
if shoppingList.isEmpty {
    print("Empty.")
}else{
    print("Not Empty.")
}
shoppingList.append("Flour")
print(shoppingList)
shoppingList += ["Baking Powder"]
print(shoppingList)
shoppingList[0] = "Six eggs"
print(shoppingList)
shoppingList[2...3] = ["Bananas","Apples"]
print(shoppingList)
//插入
shoppingList.insert("Oranges", at: 0)
print(shoppingList)
//删除
shoppingList.remove(at: 0)
print(shoppingList)
shoppingList.removeLast()
print(shoppingList)

//遍历
for item in shoppingList {
    print(item)
}
for (index,value) in shoppingList.enumerated() {
    print("index: \(index) is value: \(value)")
}

//合集:
//'同一类型' 且 '不重复' 的值 '无序' 的存储到一个集合中
var letters = Set<Character>()
print("letters is of type Set<Character> with \(letters.count) items.")
letters.insert("a")
print(letters)
letters = []
print(letters)

//使用数组字面量创建合集
//※: 合集类型不能从数组字面量推断出来,所以 'Set类型' 必须显示声明
var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
print(favoriteGenres)
//使用包含相同类型值(String)的数组字面量初始化合集,String类型可省略
//var favoriteGenres: Set = ["Rock", "Classical", "Hip hop"]

//访问和修改合集
if favoriteGenres.isEmpty {
    print("As far as music goes, I'm not picky.")
} else {
    print("I have particular music preferences.")
}
//插入
favoriteGenres.insert("Jazz")
print(favoriteGenres)
//删除
//如果元素是合集中的成员就移除并返回移除的元素,如果合集中没有改元素返回nil
if let removedGenre = favoriteGenres.remove("Jazz") {
    print("\(removedGenre)? I'm over it.")
    print(favoriteGenres)
} else {
    print("I never much cared for that.")
}
//合集可一次移除所有
//favoriteGenres.removeAll()
//print(favoriteGenres)
if favoriteGenres.contains("Funk") {
    print("I get up on the good foot.")
} else {
    print("It's too funky in here.")
}
//遍历
for genre in favoriteGenres {
    print("\(genre)")
}
//按特定顺序遍历 -- 按首字母排序 从小到大
for genre in favoriteGenres.sorted() {
    print("\(genre)")
}

//基本合集操作
//intersection(_:) 创建一个只包含两个合集共有值的新合集
//symmetricDefference(_:) 创建一个只包含两个合集自有的非共有值的新合集(除共有值之外的所有值)
//union(_:) 创建一个包含两个合集的所有值的新合集
//subtracting(_:) 创建一个两个合集中不包含某一合集的新合集(两合集所有值去掉其中一个合集的所有值剩下的)
let oddDigits: Set = [1,3,5,7,9]
let evenDigits: Set = [0,2,4,6,8]
let singleDigitPrimeNumbers = [2,3,5,7]

print(oddDigits.union(evenDigits).sorted()) //[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
print(oddDigits.intersection(evenDigits).sorted())//[]
print(oddDigits.subtracting(singleDigitPrimeNumbers).sorted())//[1, 9]
print(oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted())//[1, 2, 9]

//合集成员关系及相等性
// == 判断两个合集是否包含相同的值
// isSubSet(of:) 确定一个合集的所有值是否被某集合包含
// isSuperSet(of:) 确定一个合集是否包含某个合集的所有值
// isStrictSubSet(of:) / isStrictSuperSet(of:) 判断一个合集是否为某个合集的子集或超集,但并不相等
// isDisJoint(with:) 判断两个合集是否拥有完全不同的值
let houseAnimals: Set = ["?","?"]
let farmAnimals: Set = ["?","?","?","?","?"]
let cityAnimals: Set = ["?","?"]

print(cityAnimals == houseAnimals) //true
print(houseAnimals.isSubset(of: farmAnimals)) //true
print(farmAnimals.isSuperset(of: houseAnimals)) //true
print(farmAnimals.isDisjoint(with: cityAnimals)) //false

//字典:
//无序的互相关联的同一类型的键和同一类型的值的集合
//每一个值都与唯一的键相关联
var nameOfIntegers = [Int:String]()
nameOfIntegers[16] = "sixteen"
print(nameOfIntegers)
nameOfIntegers = [:]
print(nameOfIntegers)
//字面量创建
var airports: [String:String] = ["YYZ":"Toronto","DUB":"Dublin"]
print(airports) //["DUB": "Dublin", "YYZ": "Toronto"] 无序
//使用相同类型的字典字面量初始化字典,可省略类型
//var airports = ["YYZ":"Toronto","DUB":"Dublin"]

//访问和修改字典
airports["LHR"] = "London" //添加新元素 / 赋值
print(airports)

//updateValue(_:forKey:)
//键没值时新建值,键有值时更新键对应的值
//※: 执行更新后返回旧的值(可选值)
if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
    print("The old value for DUB was \(oldValue)")
}
//下标脚本取值时 返回可选值
if let airportName = airports["DUB"] {
    print("The name of the airport is \(airportName).")
} else {
    print("That airport is not in the airports dictionary.")
}
//使用下标脚本给一个键赋值为nil,以移除该键值对
airports["APL"] = "Apple International"
airports["APL"] = nil
print(airports)
//删除
//该键对应的值存在时移除并返回移除的值,该键对应的值不存在时,返回nil
if let removedValue = airports.removeValue(forKey: "YYZ") {
    print("The removed airport's name is \(removedValue).")
} else {
    print("The airports dictionary does not contain a value for DUB.")
}

//遍历
for (airportCode,airportValue) in airports {
    print("\(airportCode) : \(airportValue)")
}
for airCode in airports.keys {
    print("code:\(airCode)")
}
for airValue in airports.values {
    print("value:\(airValue)")
}

let airportCodes = [String](airports.keys)
print(airportCodes)
let airportValues = [String](airports.values)
print(airportValues)


