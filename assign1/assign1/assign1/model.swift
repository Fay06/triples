//
//  model.swift
//  assign1
//
//  Created by Fay Liu on 2/20/21.
//

import Foundation

class Triples{
    var board: [[Int]]
    
    init() {
        board = [[Int]](repeating: [Int](repeating: 0, count: 4), count: 4)
    }

    func newgame() {
        for i in 0...3 {
            for j in 0...3 {
                board[i][j] = 0
            }
        }
    }                   // re-inits 'board', and any other state you define

    func rotate() {
        board = rotate2DInts(input: board)
    }                    // rotate a square 2D Int array clockwise

    func shift() {
        var temp = board
        var change = false
        
        for i in 0..<4 {
            for j in 0..<3 {
                if(!change){
                    if (board[i][j] == 0){
                        for z in j..<3{
                            temp[i][z] = board[i][z+1]
                        }
                        temp[i][3] = 0
                        change = true
                    }
                }
            }
            
            for j in 0..<3 {
                if(!change){
                    if (board[i][j] == 1) {
                        if (board[i][j+1] == 2){
                            temp[i][j] = board[i][j] + board[i][j+1]
                            for z in j+1..<3{
                                temp[i][z] = board[i][z+1]
                            }
                            temp[i][3] = 0
                            change = true
                        }
                    }else if (board[i][j] == 2){
                        if (board[i][j+1] == 1){
                            temp[i][j] += board[i][j] + board[i][j+1]
                            for z in j+1..<3{
                                temp[i][z] = board[i][z+1]
                            }
                            temp[i][3] = 0
                            change = true
                        }
                    }else if (board[i][j] == board[i][j+1]){
                        temp[i][j] = board[i][j] + board[i][j+1]
                        for z in j+1..<3{
                            temp[i][z] = board[i][z+1]
                        }
                        temp[i][3] = 0
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

    func collapse(dir: Direction) {
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
    }      // collapse in specified direction using shift() and rotate()
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
