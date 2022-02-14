import UIKit

/*
 Измените сабскрипт таким образом, чтобы он корректно обрабатывал удаление фигуры с шахматной доски. Не забывайте, что у класса Chessman есть метод kill(). То есть должно происходить не просто удаление фигуры с поля, но и изменение свойства coordinates на nil у самой фигуры.
 2) Реализуйте метод printDesk() в классе gameDesk, выполняющий вывод на консоль изображения шахматной доски с помощью символов в следующем виде:
 // 1 _ _ _ _ _ _ _ _
 // 2 _ _ _ _ _ _ _ _
 // 3 _ _ _ _ _ _ _ _
 // 4 _ _ _ _ _ _ _ _
 // 5 _ _ _ _ _ _ _ _
 // 6 _ _ _ _ _ _ _ _
 // 7 _ _ _ _ _ _ _ _
 // 8 _ _ _ _ _ _ _ _
 //   A B C D E F G H
 При этом там, где располагаются созданные фигуры должны выводиться их графически отображения (значение свойства symbol класса Chessman).

 3) Доработайте классы таким образом, чтобы убитые фигуры (убранные с поля, значение координат изменено на nil) при использовании метода printDesk() появлялись над и под шахматной доской (над шахматной – черные фигуры), под шахматной – белые).
 4) Доработайте классы таким образом, чтобы появилась возможность изменить координаты фигуры на поле.
 Например:
 game.move(from:to:)
 5) Если вы чувствуете в себе силы, то реализуйте следующий функционал:
 – при попытке передвижения фигуры должна производиться проверка возможности ее перемещения. Попытайтесь реализовать хотя бы для одного типа фигур (к примеру пешка). При этом должны учитываться: особенности первого хода, будет ли съедена в результате хода фигура противника и т.д.
 ♝♜
 1 _ _ _ _ _ _ _ _
 2 _ _ _ ♚ _ _ _ _
 3 _ _ _ _ _ ♛ _ _
 4 _ _ _ _ _ _ _ _
 5 _ _ _ _ _ _ _ _
 6 _ _ _ _ _ _ _ _
 7 _ _ _ ♔ _ _ _ _
 8 _ _ _ _ _ _ _ _
   A B C D E F G H
 ♙♘♕♖♗
 
*/


class Chessman {
    enum ChessmanColor {
        case black, white
    }
    
    enum ChessmanType {
        case king, queen, bishop, knight, castle, pawn
    }
    
    let color: ChessmanColor
    let type: ChessmanType
    var coordinates: (String, Int)?
    let figureSymbol: Character
    
    init(color: ChessmanColor, type: ChessmanType){
        self.type = type
        self.color = color
        self.coordinates = nil
        if color == .black {
            switch type {
                case .queen:
                figureSymbol = "\u{265A}"
                case .king:
                figureSymbol = "\u{265B}"
                case .castle:
                figureSymbol = "\u{265C}"
                case .bishop:
                figureSymbol = "\u{265D}"
                case .knight:
                figureSymbol = "\u{265E}"
                case .pawn:
                figureSymbol = "\u{265F}"
            }
        } else {
            switch type {
                case .queen:
                figureSymbol = "\u{2654}"
                case .king:
                figureSymbol = "\u{2655}"
                case .castle:
                figureSymbol = "\u{2656}"
                case .bishop:
                figureSymbol = "\u{2657}"
                case .knight:
                figureSymbol = "\u{2658}"
                case .pawn:
                figureSymbol = "\u{2659}"
            }
        }
    }
    
    func setCoordinates(char c: String, num n: Int) -> Void {
        coordinates = (c, n)
    }
    
    func kill() {
        coordinates = nil
    }
}



class GameDesk {
    var desk: [Int:[String:Chessman?]] = [:]
    var whiteFigure: [Chessman] = []
    var blackFigure: [Chessman] = []
    init() {
        for i in 0...10 {
            desk[i] = [:]
        }
    }
    
    
    subscript(alpha: String, number: Int) -> Chessman? {
        get {
            if desk[number]![alpha] != nil {
                return desk[number]![alpha]!
            } else {
                return nil
            }
        }
        
        set {
            if let chessman = newValue{
                self.setChessman(chess: chessman, coordinates: (alpha,number))
                newValue!.setCoordinates(char: alpha, num: number)
                if self.desk[number]![alpha]!!.color == .white {
                    whiteFigure.append(self.desk[number]![alpha]!!)
                } else {
                    blackFigure.append(self.desk[number]![alpha]!!)
                }
            } else {
                guard self.desk[number]![alpha] != nil else {
                    return
                }
                self.desk[number]![alpha]!!.kill()
                self.desk[number]![alpha] = nil
            }
            
        }
    }
    
    func setChessman(chess: Chessman, coordinates: (String,Int)) -> Void {
        let rowRange = 1...8
        let colRange = "A"..."H"
        if (rowRange.contains(coordinates.1) && colRange.contains(coordinates.0)) {
            desk[coordinates.1]![coordinates.0] = chess
        } else {
            print("Coordinates out of range")
        }
    
    }
    
    func printDesk() {
        let colRange = ["A", "B", "C", "D", "E", "F", "G", "H"]
        var printResult = ""
        for chessman in blackFigure {
            guard chessman.coordinates != nil else {
                printResult += String(chessman.figureSymbol)
                continue
            }
        }
        print(printResult)
        for num in 1...8 {
            printResult = ""
            printResult += "\(String(num)) "
            for char in colRange {
                if desk[num]![char] != nil {
                    printResult += "\(String(desk[num]![char]!!.figureSymbol)) "
                } else {
                    printResult += "_ "
                }
            }
            print(printResult)
        }
        printResult = "  "
        for char in colRange {
            printResult += "\(char) "
        }
        print(printResult)
        printResult = ""
        for chessman in whiteFigure {
            guard chessman.coordinates != nil else {
                printResult += String(chessman.figureSymbol)
                continue
            }
        }
        print(printResult)
    }
    
    func move(from: (String, Int), to: (String,Int)) {
        guard desk[from.1]![from.0] != nil else {
            print("В клетке (\(from.0)\(from.1)) нет фигуры")
            return
        }
        
        guard desk[to.1]![to.0] != nil else {
            desk[from.1]![from.0]!!.setCoordinates(char: to.0, num: to.1)
            desk[to.1]![to.0] = desk[from.1]![from.0]!
            desk[from.1]![from.0] = nil
            return
        }
        desk[to.1]![to.0]!?.kill()
        desk[from.1]![from.0]!!.setCoordinates(char: to.0, num: to.1)
        desk[to.1]![to.0] = desk[from.1]![from.0]!
        desk[from.1]![from.0] = nil
    
        
//        if let chessman = desk[from.1]![from.0] {
//            if desk[to.1]![from.0] != nil {
//                desk[to.1]![to.0]!!.kill()
//            } else {
//            chessman!.setCoordinates(char: to.0, num: to.1)
//            desk[to.1]![to.0] = chessman!
//                desk[from.1]![from.0] = nil
//
//            }
//        } else {
//            print("Empty cell")
//        }
    }
}

var game = GameDesk()
var kingWhite = Chessman (color: .white, type: .king)
var queenBlack = Chessman(color: .black, type: .queen)
var blackPawns1 = Chessman(color: .black, type: .pawn)
var blackPawns2 = Chessman(color: .black, type: .pawn)
var blackPawns3 = Chessman(color: .black, type: .pawn)
var blackPawns4 = Chessman(color: .black, type: .pawn)
var whiteQueen = Chessman(color: .white, type: .queen)
game["A", 3] = whiteQueen
game["B", 7] = queenBlack
game["A", 2] = blackPawns1
game["B", 2] = blackPawns2
game["C", 2] = blackPawns3
game["D", 2] = blackPawns4
game["B", 8] = kingWhite
game.printDesk()
game.move(from: ("A", 3), to: ("A", 2))
game.printDesk()
game.move(from: ("A", 2), to: ("B", 2))
game.printDesk()
blackPawns1.coordinates
game.move(from: ("B", 7), to: ("C", 7))
game.printDesk()
game["A", 8]
game.move(from: ("B", 8), to: ("A", 8))
game.printDesk()
game.move(from: ("B", 2), to: ("B", 7))
game.printDesk()
game.move(from: ("A", 8), to: ("B", 7))
game.printDesk()
game.move(from: ("C", 2), to: ("C", 4))
game.printDesk()
game.printDesk()
game.whiteFigure
game.blackFigure
game["A", 6]
game.printDesk()
game["A", 6] = kingWhite
game.printDesk()
game["A", 6] = nil
game.printDesk()
game["A", 6] = nil
