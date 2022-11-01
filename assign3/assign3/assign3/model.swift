//
//  model.swift
//  assign3
//
//  Created by Fay Liu on 4/12/21.
//

import Foundation

class Triples : ObservableObject{
    @Published var board: [[Tile?]]
    @Published var score: Int
    @Published var global_id = 1
    @Published var list: [Score?]
    @Published var date: Date
    var seededGenerator: SeededGenerator
    
    struct Tile : Equatable{
        var val : Int
        var id : Int
    }
    
    struct Score: Hashable {
        var score: Int
        var time: Date
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(score)
        }
        
        init(score: Int, time: Date) {
            self.score = score
            self.time = time
        }
        
        func toString() -> String{
            let str = "score: \(score)     time:\(time)"
            return str
        }
    }


    init() {
        board = [[Tile?]](repeating: [Tile?](repeating: nil, count: 4), count: 4)
        score = 0
        seededGenerator = SeededGenerator()
        list = [Score]()
        date = NSDate() as Date
        list.append(Score(score: 300, time: date))
        list.append(Score(score: 400, time: date))
        newgame(rand: true)
        spawn()
        spawn()
        spawn()
        spawn()
    }

    func newgame(rand: Bool) {
        if (rand) {
            seededGenerator = SeededGenerator(seed: UInt64(Int.random(in:1...1000)))
        } else {
            seededGenerator = SeededGenerator(seed: 14)
        }
        for x in 0..<4 {
            for y in 0..<4 {
                board[x][y] = nil
            }
        }
        score = 0
    }                   // re-inits 'board', and any other state you define

    func rotate() {
        board = rotate2D(input: board)
    }                    // rotate a square 2D Int array clockwise

    func shift() {
        var temp = board
        var change = false
        
        for i in 0..<4 {
            for j in 0..<3 {
                if(!change){
                    if (board[i][j] == nil){
                        if (board[i][j+1] != nil){
                            for z in j..<3{
                                temp[i][z] = board[i][z+1]
                            }
                            temp[i][3] = nil
                            change = true
                        }
                    }
                }
            }
            
            for j in 0..<3 {
                if(!change){
                    if (board[i][j]?.val == 1) {
                        if (board[i][j+1]?.val == 2){
                            temp[i][j]?.val = board[i][j]!.val + board[i][j+1]!.val
                            temp[i][j]?.id = board[i][j+1]!.id
                            score += temp[i][j]?.val ?? 0
                            for z in j+1..<3{
                                temp[i][z] = board[i][z+1]
                            }
                            temp[i][3] = nil
                            change = true
                        }
                    }else if (board[i][j]?.val == 2){
                        if (board[i][j+1]?.val == 1){
                            temp[i][j]?.val = board[i][j]!.val + board[i][j+1]!.val
                            temp[i][j]?.id = board[i][j+1]!.id
                            score += temp[i][j]?.val ?? 0
                            for z in j+1..<3{
                                temp[i][z] = board[i][z+1]
                            }
                            temp[i][3] = nil
                            change = true
                        }
                    }else if (board[i][j]?.val == board[i][j+1]?.val){
                        temp[i][j]?.val = board[i][j]!.val + board[i][j+1]!.val
                        temp[i][j]?.id = board[i][j+1]!.id
                        score += temp[i][j]?.val ?? 0
                        for z in j+1..<3{
                            temp[i][z] = board[i][z+1]
                        }
                        temp[i][3] = nil
                        change = true
                    }
                }
            }
            change = false
        }
        
        board = temp
    }                     // collapse to the left
    
    enum Direction {
        case up, down, right, left
    }

    func collapse(dir: Direction) -> Bool{
        let comp = board
        if case .left = dir {
            shift()
        } else if case.down = dir {
            rotate()
            shift()
            rotate()
            rotate()
            rotate()
        } else if case.right = dir {
            rotate()
            rotate()
            shift()
            rotate()
            rotate()
        } else if case.up = dir {
            rotate()
            rotate()
            rotate()
            shift()
            rotate()
        }
        
        if (comp == board){
            return false
        } else {
            return true
        }
    }      // collapse in specified direction using shift() and rotate()
    
    func isGameDone() -> Bool{
        var num = 0
        for x in 0..<4 {
            for y in 0..<4 {
                if (board[x][y] == nil) {
                    num += 1;
                }
            }
        }
        if num == 0 {
            return true
        } else {
            return false
        }
    }
        
    func spawn() {
        var num = 0
        for x in 0..<4 {
            for y in 0..<4 {
                if (board[x][y] == nil) {
                    num += 1;
                }
            }
        }
        let value = Int.random(in: 1...2, using: &seededGenerator)
        var index = Int.random(in: 0..<num, using: &seededGenerator)
        var finish = false
        for x in 0..<4 {
            for y in 0..<4 {
                if (board[x][y] == nil) {
                    if (index == 0) {
                        board[x][y] = Tile(val: value, id: global_id)
                        global_id += 1
                        score += value
                        finish = true
                        break
                    } else {
                        index -= 1;
                    }
                }
            }
            if (finish) {
                break
            }
        }
    }
}

// class-less function that will return of any square 2D Int array rotated clockwise
public func rotate2DInts(input: [[Int]]) -> [[Int]] {
    var rota = input
    let n: Int = input.count
    
    for i in 0..<n {
        for j in 0..<n {
            rota[i][j] = input[n - j - 1][i]
        }
    }
    
    return rota
}

// class-less function that will return of any square 2D array rotated clockwise
public func rotate2D<T>(input: [[T]]) -> [[T]] {
    var rota = input
    let n: Int = input.count
    
    for i in 0..<n {
        for j in 0..<n {
            rota[i][j] = input[n - j - 1][i]
        }
    }
    
    return rota
}
