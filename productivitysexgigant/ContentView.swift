//
//  ContentView.swift
//  productivitysexgigant
//
//  Created by Игорь Дячук on 04.12.2021.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var jsonDara: JsonData
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
