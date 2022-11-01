//
//  ContentView.swift
//  Triples
//
//  Created by Fay Liu on 3/14/21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var triples : Triples
    @State var isRand = true
    @State var isMove = true
    
    var body: some View {
        VStack {
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            
            Text("Score: \(triples.score)")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            
            ForEach (0..<4) {i in
                HStack{
                    ForEach (0..<4) {j in
                        ZStack{
                            if triples.board[i][j] == 1 {
                                Rectangle().foregroundColor(Color(red: 0.5, green: 0.8, blue: 1, opacity: 1.0)).frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            } else if triples.board[i][j] == 2 {
                                Rectangle().foregroundColor(Color(red: 0.5, green: 0.8, blue: 0.5, opacity: 1.0)).frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            } else {
                                Rectangle().foregroundColor(Color(red: 1, green: 0.5, blue: 0.5, opacity: 1.0)).frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            }
                           
                            Text(String(triples.board[i][j]))
                        }
                        
                    }
                }
            }
            
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            
            Button("Up"){
                isMove = !triples.collapse(dir: .up)
                triples.spawn()
            }.alert(isPresented: $isMove){
                Alert(title: Text("This is an alert!"),
                      message: Text("Score: \(triples.score)"))
            }.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/).colorMultiply(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).frame(width: 100, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            
            HStack{
                Spacer()
                Button("Left"){
                    isMove = !triples.collapse(dir: .left)
                    triples.spawn()
                }.alert(isPresented: $isMove){
                    Alert(title: Text("This is an alert!"),
                          message: Text("Score: \(triples.score)"))
                }.border(Color.black).colorMultiply(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Spacer()
                Button("Right"){
                    isMove = !triples.collapse(dir: .right)
                    triples.spawn()
                }.alert(isPresented: $isMove){
                    Alert(title: Text("This is an alert!"),
                          message: Text("Score: \(triples.score)"))
                }.border(Color.black).colorMultiply(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Spacer()
            }
           
            
            Button("Down"){
                isMove = !triples.collapse(dir: .down)
                triples.spawn()
            }.alert(isPresented: $isMove){
                Alert(title: Text("This is an alert!"),
                      message: Text("Score: \(triples.score)"))
            }.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/).colorMultiply(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).frame(width: 100, height: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            
            Button("New Game"){
                triples.newgame(rand: isRand)
                triples.spawn()
                triples.spawn()
                triples.spawn()
                triples.spawn()
            }.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/).colorMultiply(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).frame(width: 200, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            

            
            VStack {
                Picker(selection: $isRand, label: /*@START_MENU_TOKEN@*/Text("Picker")/*@END_MENU_TOKEN@*/, content: {
                    Text("Random").tag(true)
                    Text("Determ").tag(false)
                }).pickerStyle(SegmentedPickerStyle()).padding()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Triples())
    }
}
