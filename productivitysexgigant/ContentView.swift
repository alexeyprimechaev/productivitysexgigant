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
    
    @EnvironmentObject var appState: AppState
    @State var generativeView = GenerativeViewContainer()
    
    var body: some View {
        
        ZStack {
            generativeView.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
               
                Text(appState.statusText).font(.largeTitle.bold())
                
                if appState.isRunning {
                    ForEach(taskEntries.filter{$0.isInProgredd}) { taskEntry in
                        TimerView(taskEntry: taskEntry)
                    }
                    
                } else {
                    ChartView()
                }
                Spacer()
                if appState.isRunning {
                    ForEach([taskEntries.last ?? TaskEntry()]) { taskEntry in
                        TaskControls(taskEntry: taskEntry)
                    }
                    
                } else {
                AddingView(statusText: $statusText)
                
                }
                
                
            }
        }
        
        
    }
}

enum AddingState {
    case normal, adding
}

struct TaskControls: View {
    
    @EnvironmentObject var appState: AppState
    
    @ObservedObject var taskEntry: TaskEntry
    
    var body: some View {
        HStack {
            Text(taskEntry.title)
        if taskEntry.isInProgredd {
            AddButton(buttonText: "Done") {
                appState.isRunning = false
                taskEntry.isSuccessful = true
            }
        } else {
            AddButton(buttonText: "Done") {
                appState.isRunning = false
                taskEntry.isSuccessful = true
            }
            AddButton(buttonText: "Ne uspel(((") {
                appState.isRunning = false
                taskEntry.isSuccessful = false
            }
        }
        }
    }
}

struct AddingView: View {
    
    @FetchRequest(fetchRequest: TaskEntry.getAllTaskEntries()) var taskEntries: FetchedResults<TaskEntry>
    @Environment(\.managedObjectContext) var context
    
    @State var addingState: AddingState = .normal
    
    
    @State var title = String()
    
    @State var time = Int(0)
    
    @Binding var statusText: String
    
    @FocusState var isFocused: Bool
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack {
            if addingState == .normal {
                HStack(spacing: 12) {
                        
                    
                    AddButton(buttonText: "test") {
                        for i in 0...100 {
                            let taskEntry = TaskEntry(context: context)
                            
                            appState.newTaskItem = taskEntry
                            
                            taskEntry.title = "krasivo"
                            
                            taskEntry.timeStarted = Calendar.current.date(byAdding: .day, value: -1*(Int.random(in: 0..<20)), to: Date()) ?? Date()
                            
                            taskEntry.isSuccessful = Int.random(in: 0..<100) > 30 ? true : false
                    
                        
                        }
                        
                        
                        
                    }
                    AddButton(buttonText: "5m") {
                        let taskEntry = TaskEntry(context: context)
                        appState.newTaskItem = taskEntry
                        time = 5
                        addingState = .adding
                        statusText = "New 5m Timer"
                        isFocused = true
                    }
                    AddButton(buttonText: "20m") {
                        let taskEntry = TaskEntry(context: context)
                        appState.newTaskItem = taskEntry
                        time = 20
                        addingState = .adding
                        statusText = "New 20m Timer"
                        isFocused = true
                    }
                    AddButton(buttonText: "40m") {
                        let taskEntry = TaskEntry(context: context)
                        appState.newTaskItem = taskEntry
                        time = 40
                        addingState = .adding
                        statusText = "New 40m Timer"
                        isFocused = true
                        
                    }
                }.padding(.horizontal)
            } else {
                TextField("Enter Task Title", text: $title) {
                    
                    appState.newTaskItem.title = title
                    appState.newTaskItem.time = time
                    appState.newTaskItem.timeStarted = Date()
                    appState.newTaskItem.timeFinished = taskEntries.first?.timeStarted.addingTimeInterval(Double(time)) ?? Date()
                    appState.newTaskItem.isInProgredd = true
                    addingState = .normal
                    
                    appState.isRunning = true
                    
                    
                    title = ""
                    time = 0
                    statusText = "Timer Running"
                    
                    do {
                        try context.save()
                    } catch {
                        print(error)
                    }
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
