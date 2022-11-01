//
//  assign3App.swift
//  assign3
//
//  Created by Fay Liu on 4/12/21.
//

import SwiftUI

@main
struct assign3App: App {
    @StateObject private var triples = Triples()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(triples)
        }
    }
}
