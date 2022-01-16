import UIKit

let name = "Taylor"

for letter in name {
  print("Give me a \(letter)")
}

extension String {
  subscript(i: Int) -> String {
    return String(self[index(startIndex, offsetBy: i)])
  }
}

let indexName = name.index(name.startIndex, offsetBy: 2)
let indexBefore = name.index(before: name.endIndex)
name[indexName]
name[indexBefore]
name[2]

let password = "12345"
password.hasPrefix("123")
password.hasSuffix("345")

extension String {
    // remove a prefix if it exists
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }

    // remove a suffix if it exists
    func deletingSuffix(_ suffix: String) -> String {
        guard self.hasSuffix(suffix) else { return self }
        return String(self.dropLast(suffix.count))
    }
}

let weather = "it's going to rain"
print(weather.capitalized)

extension String {
    var capitalizedFirst: String {
        guard let firstLetter = self.first else { return "" }
        return firstLetter.uppercased() + self.dropFirst()
    }
}

weather.capitalizedFirst

let string = "This is a test string"
let attributes: [NSAttributedString.Key: Any] = [
    .foregroundColor: UIColor.white,
    .backgroundColor: UIColor.red,
    .font: UIFont.boldSystemFont(ofSize: 36)
]

let attributedString1 = NSAttributedString(string: string, attributes: attributes)

let attributedString = NSMutableAttributedString(string: string)
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 8), range: NSRange(location: 0, length: 4))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: NSRange(location: 5, length: 2))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 24), range: NSRange(location: 8, length: 1))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 32), range: NSRange(location: 10, length: 4))
attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 40), range: NSRange(location: 15, length: 6))


//Create a String extension that adds a withPrefix() method. If the string already contains the prefix it should return itself; if it doesn’t contain the prefix, it should return itself with the prefix added. For example: "pet".withPrefix("car") should return “carpet”.

extension String {
  func withPrefix(_ prefix: String) -> String {
    guard self.hasPrefix(prefix) else {
      return prefix + self
    }
    return self
  }
}

let pet = "pet"
pet.withPrefix("car")
pet.withPrefix("pet")


//Create a String extension that adds an isNumeric property that returns true if the string holds any sort of number. Tip: creating a Double from a String is a failable initializer.

extension String {
  func isNumeric() -> Bool {
    for i in Array(self) {
      if let _ = Int(String(i)) {
        return true
      }
    }
    return false
  }
}

let nuuuum = "2 pac"

pet.isNumeric()
nuuuum.isNumeric()

//Create a String extension that adds a lines property that returns an array of all the lines in a string. So, “this\nis\na\ntest” should return an array with four elements.

extension String {
  func arrayFromEveryLine() -> Array<String> {
    return self.components(separatedBy: "\n")
  }
}


let testString = "this\nis\na\ntest"

let array = testString.arrayFromEveryLine()
array[2]
print(testString.arrayFromEveryLine())

extension UIView {
  func bounceOut(duration: TimeInterval) {
    UIView.animate(withDuration: duration) { [unowned self] in
      self.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
    }
    
  }
}

let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
view.backgroundColor = .red
view.bounceOut(duration: 3)

extension Int {
  func times(completion: @escaping() -> (Void)) {
    var count = UInt(self)
    while count != 0 {
      completion()
      count -= 1
    }
  }
}

5.times {
  print("Hello world")
}

extension Array where Element: Comparable {
  mutating func remove(item: Element) {
    if let index = self.firstIndex(of: item) {
      self.remove(at: index)
    }
  }
}

var arrayInt = [5, 5, 3 ,2]
arrayInt.remove(item: 5)
