//
//  TriplesApp.swift
//  Triples
//
//  Created by Fay Liu on 3/14/21.
//

import SwiftUI

@main
struct TriplesApp: App {
    @StateObject private var triples = Triples()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(triples)
        }
    }
}
