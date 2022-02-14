import UIKit

/*
 Ранее мы с вами уже решали данное задание:
 Напишите функцию, которая принимает на вход массив с элементами типа Int, а возвращает целое число – сумму всех положительных элементов переданного массива.
 К примеру для массива [1,-2,3,4,-5] должно быть возвращено 1+3+4 = 8
 В данном случае вам потребуется использовать изученные в этой главе методы для того, чтобы найти наиболее оптимальное решение


let someArray = [1,-2,3,4,-5]
func funcName (array arr: [Int]) -> Int {
    let positiveArray = arr.filter{$0 > 0}
    return positiveArray.reduce(0, +)
}

funcName(array: someArray)
*/


/*
 Напишите функция, которая принимает на вход массив типа [Int] и возвращает так же массив, но в котором все элементы исходного массива возведены в квадрат.
 */

func multiFunc (_ arr: [Int]) -> [Int] {
    return arr.map{$0 * $0}
}
multiFunc([1,2,3])

/*
 Повтор задания из главы 15. В этот раз используйте изученные в данном разделе методы
 Напишите функцию, которая принимает на вход массив типа [Int] и, в случае, если количество элементов > 0, то возвращает целое число – произведение всех элементов переданной коллекции. Если количество элементов = 0, то возвращается 0.


func funcName (arr: [Int]) -> Int {
    guard arr.count != 0 else {
        return 0
    }
    return arr.reduce(1, *)
}

funcName(arr: [1,2,3,4])

*/

/*
 Напишите функцию, которая принимает на вход строку и заменяет в ней все цифры на соответсвующие имя слова (например 1 на “один”, 8 на “восемь”)
 */
var someArray = [1, 2, 3]
someArray.append(contentsOf: [4])
func numChange (someString: String) -> String {
    var resultString = ""
    let numDict: [Character: String] = ["1" : "один", "2" : "два"]
    for char in someString {
        guard Int(String(char)) != nil else {
            resultString.append(contentsOf: String(char))
            continue
        }
        resultString.append(contentsOf: numDict[char]!)
    }
    return resultString
}
numChange(someString: "1 два ноль 2")


