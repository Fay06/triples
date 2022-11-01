//
//  Scores.swift
//  assign3
//
//  Created by Fay Liu on 4/15/21.
//

import SwiftUI

func sort(list: [Triples.Score?]) -> [Triples.Score?] {
    return list.sorted {
        $0!.score > $1!.score
    }
}

struct Scores: View {
    @EnvironmentObject var triples : Triples
    
    var body: some View {
        
        VStack {
            Text("Scores: ").font(.title).bold()
            
            List(0..<sort(list: triples.list).count) { i in
                Text(sort(list: triples.list)[i]!.toString())
            }
        }
        
    }
}

struct Scores_Previews: PreviewProvider {
    static var previews: some View {
        Scores().environmentObject(Triples())
    }
}
