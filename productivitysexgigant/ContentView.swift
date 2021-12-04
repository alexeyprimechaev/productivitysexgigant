//
//  ContentView.swift
//  productivitysexgigant
//
//  Created by Игорь Дячук on 04.12.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @FetchRequest(fetchRequest: TaskEntry.getAllTaskEntries()) var taskEntries: FetchedResults<TaskEntry>
    @Environment(\.managedObjectContext) var context

    
    var body: some View {
        
        
        
        VStack {
            Knopka(buttonText: "haha  r") {
                var taskEntry = TaskEntry(context: context)
                taskEntry.title = "Panis"
            }
            List(taskEntries) { entry in
                Text(entry.title)
            }
        Text("Hello, world!")
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "TaskData")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
