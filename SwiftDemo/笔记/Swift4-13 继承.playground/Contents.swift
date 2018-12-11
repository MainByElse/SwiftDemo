import UIKit

18-12-10
"No.13 继承"
"https://www.cnswift.org/inheritance"

var str = "Hello, playground"

//一个类可以从另一个类继承方法、属性和其他的特性
//当一个类从另一个类继承的时候,继承的类就是所谓的子类,而这个类继承的类称为父类
//在Swift中类可以调用和访问属于他们父类的方法、属性和下标脚本,并且可以提供它们自己重写的方法,属性和下标脚本来定义或修改他们的行为
//类也可以向继承的属性添加属性观察器,以便在属性值改变时得到通知,可以添加任何属性监视到属性中,不管是被定义为存储还是计算属性

//定义一个基类
//任何不从另一个类继承的类都是所谓的基类
//类不会从一个通用基类继承, 没有指定特定父类的类都会以基类的形式创建

class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        
    }
}

let someVehicle = Vehicle()
print(someVehicle.description)

//子类
//子类是基于现有类创建新类的行为
//子类从现有的类继承了一些特征,可以重新定义,也可以为子类添加新的特征
//为了表明子类有父类,要把子类写在父类的前面,用冒号分隔
class Bicycle: Vehicle {
    var hasBasket = false
}
let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 15.0
print(bicycle.description)

//子类本身也可被继承
class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}
let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
print(tandem.description)

//重写
//子类可以提供它自己的实例方法、类型方法、实例属性、类型属性或下标脚本的自定义实现,否则将从父类继承
//override 会执行Swift编译器检查重写的类的父类(父类的父类)是否有与之匹配的声明来供你重写

//访问父类的方法,属性和下标脚本
//super

//重写方法
//在子类中重写一个继承的实例或类型方法来提供定制的或替代的方法实现
class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo")
    }
}
let train = Train()
train.makeNoise()

//重写属性的getter和setter
//继承的属性是存储还是计算属性对子类不透明
//子类仅仅知道继承的属性有个特定名字和类型,必须声明重写的属性名称和类型,以确保编译器可以检查重写是否匹配了父类中有相同名称和类型的属性

//可以通过在子类重写里为继承而来的只读属性添加getter和setter来把它用作可读写属性
//不能把一个继承来的可读写属性表示为只读属性
//如果提供了一个setter作为属性重写的一部分,必须为重写提供一个getter
class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + "in gear \(gear)"
    }
}
let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print(car.description)

//重写属性观察器
//使用属性重写来为继承的属性添加属性观察器
//在继承属性的值改变时得到通知,无论这个属性最初如何实现
//不能给继承而来的常量存储属性或只读的计算属性添加属性观察器
//不能为同一个属性同时提供重写的setter和重写的属性观察器
//如果要监听属性值的改变,并已为属性提供了一个自定义的setter,那么从自定义的setter里就可以监听任意值的改变
class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}
let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print(automatic.description)

//阻止重写
//通过 final标记为终点来阻止一个方法、属性或下标脚本被重写
//可以在类定义时的class前写final来标记一整个类为终点


