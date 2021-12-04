//
//  AppState.swift
//  TimePiece (iOS)
//
//  Created by Alexey Primechaev on 12/21/20.
//  Copyright © 2020 Alexey Primechaev. All rights reserved.
//

import Foundation
import SwiftUI

public let defaultsStored = UserDefaults(suiteName: "group.timepiece") ?? UserDefaults.standard


public class AppState: ObservableObject {
    
    @Published var newTaskItem = TaskEntry()
    @Published var statusText = "дéфолт"
    @Published var isRunning = ((defaultsStored.value(forKey: "isRunning") ?? false) as! Bool) {
        willSet {
            defaultsStored.set(newValue, forKey: "askToMakeReusable")
        }
    }
    
}
