import UIKit

//:  [Сылка на тесты](https://docs.google.com/forms/d/e/1FAIpQLSeNUvNsLIHjKJluYyK7DvCuHRCbp7N4kYR9vDMw0ILdWeF1HQ/viewform)

//: # Home Work 7


 
/*:
 ## Задание 1
 1.1 Создайте класс `Shape` (родительский класс) со следующими свойствами:
 
 - `height: Float`
 
 - `width: Float`
 
 - `radius: Float`
 
 - `square: Float`
 
 - `perimeter: Float`
 
 Oбъявите в классе методы `squareOfShape` и `perimeterOfShape` для расчетов площади и периметра (длины) фигуры соответственно. Методы должены возвращать `Float`. Создайте инициализатор для сторон прямоугольника и отдельный инициализатор для радиуса.
 */

class Shape {
    var height: Float = 0
    var width: Float = 0
    var radius: Float = 0
    var sqare: Float = 0
    var perimetr: Float = 0
    
    init(height: Float, width: Float) {
        self.height = height
        self.width = width
    }
    
    init(radius: Float) {
        self.radius = radius
    }
    
    func squareOfShape() -> Float {
        return 0
    }
    
    func perimetrOfShape() -> Float {
        return 0
    }
    
    func description() {
    }
}


/*:
 1.2. Создайте классы `Circle`, `Rectangle` и `Ellipse`, унаследовав их от `Shape`. Переопределите методы `squareOfShape` и `perimeterOfShape` для каждого класса в соответствии с правилом расчета площади или периметра (длины) конкретной фигуры

 1.3 В каждом классе создайте метод `description`, который выводит на консоль сообщение следующего вида: «Площадь фигуры <тип фигуры> равна <... >, периметр (длина) равна <...>»
 */

class Circle: Shape {
    
    override func squareOfShape() -> Float {
        return 3.14 * radius * radius
    }
    
    override func perimetrOfShape() -> Float {
        return 2 * 3.14 * radius
    }
    
    override func description() {
        print("Площадь фигуры треугольник равна \(squareOfShape()), длина равна \(perimetrOfShape())")
    }
}

class Rectangle: Shape {
    
    override func squareOfShape() -> Float {
        return height * width
    }
    
    override func perimetrOfShape() -> Float {
        return height * 2 + width * 2
    }
    
    override func description() {
        print("Площадь фигуры квадрат равна \(squareOfShape()), периметр равен \(perimetrOfShape())")
    }
}



//: 1.4 Создайте по экземпляру каждого класса, кроме `Shape`, проинициализируйте свойства `height` и `width` или `radius` для каждого класса в любые значения и вызовите у каждого экземпляра класса метод `description`

let krug = Circle(radius: 5)
let kvadrat = Rectangle(height: 10, width: 10)

//krug.description()
//kvadrat.description()


/*:
## Задание 2

 2.1.
 
 Спроектировать проигрыватель(класс `AudioPlayer`), в него можно добавить одну или несколько композиций (метод `addCompositions(compositions: [AudioFile])`):
 - композиция (класс или структура `AudioFile`) имеет название, альбом, автора и длительность.
 
 Проигрыватель может:
 - перемешивать композиции(метод `shuffleCompositions()`)
 - выводить количество песен (свойство `numberOfCompositions`)
 - проигрывать следующую песню (метод `playNext()`), предыдущую (метод `playPrevious()`)
 - при проигрывании  песни выводить в консоль: "Играет композиция с именем <название>(<альбом>). Автор: <автор>",
 - если была  последняя композиция(песня), то при проигрывании следующей(`playNext()`) будет играться первая.
 - если песен нет, то при попытке проигрывания следующей песни или предыдущей выводить: "Композиции не найдены",
 */

class AudioPlayer {
    var compositions: [AudioFile] = []
    var numberOfCompositions: Int { compositions.count }
    var currentComposition = -1
    var connectedDevice: AudioSpeakerProtocol? = nil
    
    func addCompositons(composition: AudioFile) {
        compositions.append(composition)
    }
    
    func shuffleComposition() {
        compositions.shuffle()
    }
    
//    func numberOfCompositions() {
//        print("Количество композиций в плейлисте \(compositions.count)")
//    }
    
    func playNext() {
        if compositions.isEmpty {
            print("Композиции не найдены")
        } else {
            currentComposition += 1
            
            guard currentComposition != compositions.count else {
                currentComposition = 0
                connectedDevice?.playingSomething(lenght: compositions[currentComposition].time)
                print("Играет композиция с именем \(compositions[currentComposition].name)(\(compositions[currentComposition].album)). Автор: \(compositions[currentComposition].author)")
                return
            }
            
            connectedDevice?.playingSomething(lenght: compositions[currentComposition].time)
            print("Играет композиция с именем \(compositions[currentComposition].name)(\(compositions[currentComposition].album)). Автор: \(compositions[currentComposition].author)")

        }
    }
    
    func playPrevious() {
        if compositions.isEmpty {
            print("Композиции не найдены")
        } else {
            
            currentComposition -= 1
            
            guard currentComposition > -1 else {
                currentComposition = compositions.count - 1
                connectedDevice?.playingSomething(lenght: compositions[currentComposition].time)
                print("Играет композиция с именем \(compositions[currentComposition].name)(\(compositions[currentComposition].album)). Автор: \(compositions[currentComposition].author)")
                return
            }

            connectedDevice?.playingSomething(lenght: compositions[currentComposition].time)
            print("Играет композиция с именем \(compositions[currentComposition].name)(\(compositions[currentComposition].album)). Автор: \(compositions[currentComposition].author)")
        }
    }
}

class AudioFile {
    var name: String
    var album: String
    var author: String
    var time: UInt
    
    init(album: String, author: String, name: String, time: UInt) {
        self.album = album
        self.author = author
        self.name = name
        self.time = time
    }
}

protocol AudioSpeakerProtocol {
    func playingSomething(lenght: UInt) -> Void
}

class Loudspeakers: AudioSpeakerProtocol {
    func playingSomething(lenght: UInt) {
        print("На колонках проигрывается неизвестный звук длительностью \(lenght)")
    }
}

class Headphones: AudioSpeakerProtocol {
    func playingSomething(lenght: UInt) {
        print("В наушниках проигрывается неизвестный звук длительностью \(lenght)")
    }
}

let audioPlayer = AudioPlayer()
audioPlayer.addCompositons(composition: AudioFile(album: "Fear of a Blank Planet", author: "Procupine", name: "Anastezia", time: 1063))
audioPlayer.addCompositons(composition: AudioFile(album: "aaat", author: "Samson", name: "Anton", time: 1000))
audioPlayer.addCompositons(composition: AudioFile(album: "KKK", author: "ZZZ", name: "MMM", time: 1099))
//audioPlayer.playNext()
audioPlayer.currentComposition
audioPlayer.connectedDevice = Loudspeakers()
audioPlayer.shuffleComposition()
audioPlayer.compositions
audioPlayer.playNext()
audioPlayer.currentComposition
audioPlayer.playNext()
audioPlayer.currentComposition
audioPlayer.playNext()
audioPlayer.currentComposition
audioPlayer.playNext()
audioPlayer.currentComposition
audioPlayer.playNext()
audioPlayer.currentComposition
audioPlayer.connectedDevice = Headphones()
audioPlayer.playPrevious()
audioPlayer.currentComposition
audioPlayer.playPrevious()
audioPlayer.currentComposition
audioPlayer.playPrevious()
audioPlayer.currentComposition
audioPlayer.playPrevious()
audioPlayer.currentComposition
audioPlayer.playPrevious()
audioPlayer.currentComposition


/*
 2.2.
 
 К проигрывателю через USB может быть подключено одно из выходных устройств: Наушники(класс `Headphones`), Колонки(класс `Loudspeakers`).
 
 Колонки при начале проигрывания композиции в проигрывателе(если подключены) выводят в консоль "На колонках проигрывается неизвестный звук длительностью <длительность>"
 
 Наушники при начале проигрывания композиции в проигрывателе(если подключены) выводят в консоль "В наушниках проигрывается неизвестный звук длительностью <длительность>", где <длительность> - это длительность композиции.
 
 > Если интерфейс подключения один (USB), то может стоит подключать выходное устройство через протокол?
 
 2.3.
 Время послушать музыку! Для этого нужно последовательно выполнить действия:
 
 - Создать объект класса проигрыватель(`AudioPlayer`),
 - Добавить в него 3 любые песни `addCompositions`, пример песни: `AudioFile(title: "Anesthetize", album: "Fear of a Blank Planet", author: "Porcupine Tree", lengthSeconds: 1063)`
 - Проиграть 1 песню (и вспомнить, что выходное устройство не подключено :-))
 - Подключить к проигрывателю колонки `Loudspeakers`.
 - Перемешать песни (метод `shuffleCompositions()`)
 - Проиграть 5 песен через метод `playNext()`.
 - Вместо колонок подключить наушники `Headphones`
 - Проиграть 2 песни.

*/


