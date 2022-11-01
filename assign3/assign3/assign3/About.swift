//
//  About.swift
//  assign3
//
//  Created by Fay Liu on 4/15/21.
//

import SwiftUI

struct About: View {
    @State private var degrees = 0.0
    
    var animation: Animation {
        Animation.linear
            .repeatForever()
    }
    
    var body: some View {
        VStack{
            Button("CLILK ME") {
                withAnimation {
                    self.degrees += 360
                }
            }.padding(20)
            .foregroundColor(Color.pink)
            .rotation3DEffect(.degrees(degrees), axis: (x: 1, y: 1, z: 1))
                         
             
            Text("CMSC436").rotation3DEffect(.degrees(degrees), axis: (x: 1, y: 1, z: 1))
                .animation(animation).font(.title)
        }
        
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        About().environmentObject(Triples())
    }
}
