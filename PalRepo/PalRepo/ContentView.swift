//
//  ContentView.swift
//  PalRepo
//
//  Created by Adin Donlagic on 3/5/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    private var pals : [PalCharacter] = PalCharacter.allPals
    
    var body: some View {
        Text("Hello!")
    }
}

#Preview {
    ContentView()
}
