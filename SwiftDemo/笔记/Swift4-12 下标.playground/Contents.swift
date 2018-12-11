import UIKit

18-12-07
"No.12 下标"
"https://www.cnswift.org/subscripts"

var str = "Hello, playground"

//下标
//类,结构体和枚举可以定义下标,作为访问集合,列表或序列成员元素的快捷方式
//使用下标通过索引值来设置或检索值而不需要为设置和检索分别使用实例方法
//一个类型可以定义多个下标,并且下标会基于传入的索引值的类型选择合适的下标重载使用
//下标没有限制单个维度,可使用多个输入形参来定义下标以满足自定义类型的需求

//下标的语法
//下标脚本允许通过实例名后面的方括号内写一个或多个值对该类的实例进行查询
//subscript 指定一个或多个输入形式参数和返回类型
//下标可以是读写也可以是只读的
struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")//18

//下标选项
//下标可以接收任意数量的输入形式参数,且这些输入形式参数是任意类型
//下标也可以返回任意类型
//下标可以使用变量形式参数和可变形式参数,但不能使用输入输出形式参数或提供默认形式参数值
//下标重载: 类或结构体可以根据自身需要提供多个下标实现,合适被使用的下标会基于值类型或使用下标时下标方括号里包含的值来推断

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns//判断下标是否越界
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column),"Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        } 
    }
}

var matrix = Matrix(rows: 2, columns: 2)
matrix[0,1] = 1.5
matrix[1,0] = 3.2





