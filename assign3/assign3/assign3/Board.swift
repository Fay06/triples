//
//  Board.swift
//  assign3
//
//  Created by Fay Liu on 4/15/21.
//

import SwiftUI

func abs(_ ip: CGFloat) -> CGFloat {
    if ip > 0 {
        return ip
    } else {
        return -ip
    }
}

struct Board: View {
    @EnvironmentObject var triples : Triples
    @State var isRand = true
    @State var isMove = true
    @State var isDone = false
    @State var date = Date()
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        if verticalSizeClass == .regular {
            ZStack {
                VStack {
                    Text("Score: \(triples.score)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    ForEach (0..<4) {i in
                        HStack{
                            ForEach (0..<4) {j in
                                TileView(tile: triples.board[i][j] ?? Triples.Tile(val: 0, id: -1)).animation(.easeInOut(duration: 1))
                            }
                        }
                    }
                    

                    Button("Up"){
                        withAnimation(.easeInOut(duration: 1)){
                            isMove = !triples.collapse(dir: .up)
                            triples.spawn()
                        }
                        isDone = triples.isGameDone()
                    }.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/).colorMultiply(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).frame(width: 100, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    
                    HStack{
                        Spacer()
                        Button("Left"){
                            withAnimation(.easeInOut(duration: 1)){
                                isMove = !triples.collapse(dir: .left)
                                triples.spawn()
                            }
                            isDone = triples.isGameDone()
                        }.border(Color.black).colorMultiply(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        Spacer()
                        Button("Right"){
                            withAnimation(.easeInOut(duration: 1)){
                                isMove = !triples.collapse(dir: .right)
                                triples.spawn()
                            }
                            isDone = triples.isGameDone()
                        }.border(Color.black).colorMultiply(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        Spacer()
                    }
                   
                    
                    Button("Down"){
                        withAnimation(.easeInOut(duration: 1)){
                            isMove = !triples.collapse(dir: .down)
                            triples.spawn()
                        }
                        isDone = triples.isGameDone()
                    }.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/).colorMultiply(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).frame(width: 100, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    
                    Button("New Game"){
                        isDone = true
                    }.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/).colorMultiply(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).frame(width: 200, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

                    
                    VStack {
                        Picker(selection: $isRand, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/, content: {
                            Text("Random").tag(true)
                            Text("Determ").tag(false)
                        }).pickerStyle(SegmentedPickerStyle()).padding()
                    }
                    
                }
                
                if $isDone.wrappedValue {
                    ZStack {
                        Color.white
                        VStack {
                            Spacer()
                            Text("Your Score: \(triples.score)").bold().font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            Spacer()
                            Button("Close"){
                                isDone = false
                                date = NSDate() as Date
                                triples.list.append(Triples.Score(score:triples.score, time:date))
                                triples.newgame(rand: isRand)
                                triples.spawn()
                                triples.spawn()
                                triples.spawn()
                                triples.spawn()
                            }.accentColor(Color.red)
                            Spacer()
                        }
                    }.frame(width: 300, height: 150).cornerRadius(20).shadow(radius: 20)
                }
                
            }.gesture(
                DragGesture().onEnded({position in
                    let direction = position.translation
                    if abs(direction.width) < abs(direction.height) {
                        if direction.height < 0 {
                            withAnimation(.easeInOut(duration: 1)){
                                isMove = !triples.collapse(dir: .up)
                                triples.spawn()
                            }
                            isDone = triples.isGameDone()
                        } else {
                            withAnimation(.easeInOut(duration: 1)){
                                isMove = !triples.collapse(dir: .down)
                                triples.spawn()
                            }
                            isDone = triples.isGameDone()
                        }
                    } else {
                        if direction.width < 0 {
                            withAnimation(.easeInOut(duration: 1)){
                                isMove = !triples.collapse(dir: .left)
                                triples.spawn()
                            }
                            isDone = triples.isGameDone()
                        } else {
                            withAnimation(.easeInOut(duration: 1)){
                                isMove = !triples.collapse(dir: .right)
                                triples.spawn()
                            }
                            isDone = triples.isGameDone()
                        }
                    }
                })
            )
        } else {
            ZStack {
                HStack {
                    VStack {
                        Text("Score: \(triples.score)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        ForEach (0..<4) {i in
                            HStack{
                                ForEach (0..<4) {j in
                                    TileView(tile: triples.board[i][j] ?? Triples.Tile(val: 0, id: -1)).animation(.easeInOut(duration: 1))
                                }
                            }
                        }
                    }
                    
                    VStack{
                        Button("Up"){
                            withAnimation(.easeInOut(duration: 1)){
                                isMove = !triples.collapse(dir: .up)
                                triples.spawn()
                            }
                            isDone = triples.isGameDone()
                        }.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/).colorMultiply(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).frame(width: 100, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        
                        HStack{
                            Spacer()
                            Button("Left"){
                                withAnimation(.easeInOut(duration: 1)){
                                    isMove = !triples.collapse(dir: .left)
                                    triples.spawn()
                                }
                                isDone = triples.isGameDone()
                            }.border(Color.black).colorMultiply(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            Spacer()
                            Button("Right"){
                                withAnimation(.easeInOut(duration: 1)){
                                    isMove = !triples.collapse(dir: .right)
                                    triples.spawn()
                                }
                                isDone = triples.isGameDone()
                            }.border(Color.black).colorMultiply(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            Spacer()
                        }
                       
                        
                        Button("Down"){
                            withAnimation(.easeInOut(duration: 1)){
                                isMove = !triples.collapse(dir: .down)
                                triples.spawn()
                            }
                            isDone = triples.isGameDone()
                        }.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/).colorMultiply(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).frame(width: 100, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        
                        Button("New Game"){
                            isDone = true
                        }.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/).colorMultiply(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).frame(width: 200, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                        VStack {
                            Picker(selection: $isRand, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/, content: {
                                Text("Random").tag(true)
                                Text("Determ").tag(false)
                            }).pickerStyle(SegmentedPickerStyle()).padding()
                        }
                    }
        
                }
                
                if $isDone.wrappedValue {
                    ZStack {
                        Color.white
                        VStack {
                            Spacer()
                            Text("Your Score: \(triples.score)").bold().font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            Spacer()
                            Button("Close"){
                                isDone = false
                                date = NSDate() as Date
                                triples.list.append(Triples.Score(score:triples.score, time:date))
                                triples.newgame(rand: isRand)
                                triples.spawn()
                                triples.spawn()
                                triples.spawn()
                                triples.spawn()
                            }.accentColor(Color.red)
                            Spacer()
                        }
                    }.frame(width: 300, height: 150).cornerRadius(20).shadow(radius: 20)
                }
                
            }.gesture(
                DragGesture().onEnded({position in
                    let direction = position.translation
                    if abs(direction.width) < abs(direction.height) {
                        if direction.height < 0 {
                            withAnimation(.easeInOut(duration: 1)){
                                isMove = !triples.collapse(dir: .up)
                                triples.spawn()
                            }
                            isDone = triples.isGameDone()
                        } else {
                            withAnimation(.easeInOut(duration: 1)){
                                isMove = !triples.collapse(dir: .down)
                                triples.spawn()
                            }
                            isDone = triples.isGameDone()
                        }
                    } else {
                        if direction.width < 0 {
                            withAnimation(.easeInOut(duration: 1)){
                                isMove = !triples.collapse(dir: .left)
                                triples.spawn()
                            }
                            isDone = triples.isGameDone()
                        } else {
                            withAnimation(.easeInOut(duration: 1)){
                                isMove = !triples.collapse(dir: .right)
                                triples.spawn()
                            }
                            isDone = triples.isGameDone()
                        }
                    }
                })
            )
        }
        
    }
}


struct Board_Previews: PreviewProvider {
    static var previews: some View {
        Board().environmentObject(Triples())
    }
}
