//
//  productivitysexgigantApp.swift
//  productivitysexgigant
//
//  Created by Игорь Дячук on 04.12.2021.
//

import SwiftUI

@main
struct productivitysexgigantApp: App {
    
    var jsonData = JsonData()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(jsonData)
        }
    }
}
