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
    @State var statusText = "Status Text"

    
    var body: some View {
        
        
        
        VStack {
            Spacer()
            Text(statusText).font(.largeTitle.bold())
            Spacer()
            AddingView(statusText: $statusText)
           
            
        
    }
    }
}

enum AddingState {
    case normal, adding
}


struct AddingView: View {
    
    @FetchRequest(fetchRequest: TaskEntry.getAllTaskEntries()) var taskEntries: FetchedResults<TaskEntry>
    @Environment(\.managedObjectContext) var context
    
    @State var addingState: AddingState = .normal
    
    
    @State var title = String()
    
    @State var time = Int(0)
    
    @Binding var statusText: String
        
    @FocusState var isFocused: Bool
    
    var body: some View {
        VStack {
            if addingState == .normal {
                HStack(spacing: 12) {
                    AddButton(buttonText: "5m") {
                        let taskEntry = TaskEntry(context: context)
                        time = 5
                        addingState = .adding
                        statusText = "New 5m Timer"
                        isFocused = true
                    }
                    AddButton(buttonText: "20m") {
                        let taskEntry = TaskEntry(context: context)
                        time = 20
                        addingState = .adding
                        statusText = "New 20m Timer"
                        isFocused = true
                    }
                    AddButton(buttonText: "40m") {
                        let taskEntry = TaskEntry(context: context)
                        time = 40
                        addingState = .adding
                        statusText = "New 40m Timer"
                        isFocused = true
                        
                    }
                }.padding(.horizontal)
            } else {
                TextField("Enter Task Title", text: $title) {
                    
                    taskEntries.last?.title = title
                    taskEntries.last?.time = time
                    addingState = .normal
                    
                    title = ""
                    time = 0
                    statusText = "Timer Running"
                }.textFieldStyle(RoundedRectTextFieldStyle()).padding()
                
                    .focused($isFocused)
                

            }
        }
    }
}

struct RoundedRectTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(RoundedRectangle(cornerRadius: 12, style: .continuous).foregroundColor(Color(.systemGray6)))
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
