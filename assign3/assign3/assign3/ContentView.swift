//
//  ContentView.swift
//  assign3
//
//  Created by Fay Liu on 4/12/21.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        TabView {
            Board().tabItem {
                Label("Board", systemImage: "gamecontroller")
            }
//            Scores().tabItem {
//                Label("Scores", systemImage: "list.dash")
//            }
            About().tabItem {
                Label("About", systemImage: "info.circle")
            }
        }
        
    }
}

struct TileView: View {
    var tile = Triples.Tile(val: 0, id: 0)

    init(tile: Triples.Tile) {
        self.tile = tile
    }

    var body: some View {
        if tile.id == -1 {
            Rectangle().foregroundColor(Color.white).frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).border(Color.black)
        } else {
            ZStack{
                if tile.val == 1 {
                    Rectangle().foregroundColor(Color(red: 0.5, green: 0.8, blue: 1, opacity: 1.0)).frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).border(Color.black)
                } else if tile.val == 2 {
                    Rectangle().foregroundColor(Color(red: 0.5, green: 0.8, blue: 0.5, opacity: 1.0)).frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).border(Color.black)
                } else {
                    Rectangle().foregroundColor(Color(red: 1, green: 0.5, blue: 0.5, opacity: 1.0)).frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).border(Color.black)
                }

                Text(tile.val.description)
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Triples())
    }
}

