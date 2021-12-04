//
//  productivitysexgigantApp.swift
//  productivitysexgigant
//
//  Created by Игорь Дячук on 04.12.2021.
//

import SwiftUI

@main
struct productivitysexgigantApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
