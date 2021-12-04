//
//  TimerView.swift
//  productivitysexgigant
//
//  Created by Alexey Primechaev on 12/4/21.
//

import SwiftUI

struct TimerView: View {
    
    
    
    @ObservedObject var taskEntry: TaskEntry
    
    @State var height = CGFloat.zero
    
    @State var currentDate = Date()
    
    @EnvironmentObject var appState: AppState
    
    
    var body: some View {
        VStack {
                
            

            VStack(spacing: 0) {
                Spacer()
                Rectangle().foregroundColor(.primary).frame(height: height * (
                    taskEntry.timeFinished.timeIntervalSince(currentDate))/Double(taskEntry.time))
            }.background(Color(.systemGray6)).frame(height: 440).clipShape(RoundedRectangle(cornerRadius: 40, style: .continuous))
                
                

        }.frame(width: 160).overlay(
            GeometryReader { geometry in
                Spacer()
                    .onAppear {
                        height = geometry.size.height
                    }

            })
            .overlay(
                Group {
                if taskEntry.isInProgredd {
                    Text(taskEntry.timeFinished, style: .timer).font(.title.bold()).foregroundColor(.white).blendMode(.difference)
                } else {
                    Text("done").font(.title.bold()).foregroundColor(.white).blendMode(.difference)
                }
                }
                   )
               
        
            .onReceive(Timer.publish(every: 0.007, on: .main, in: .common).autoconnect()) { time in
                currentDate = Date()
                if currentDate > taskEntry.timeFinished {
                    taskEntry.isInProgredd = false
                    appState.statusText = "timer done btw"
                }
        }
    }
}
