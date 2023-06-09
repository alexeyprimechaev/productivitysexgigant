//
//  PortfolioPoint.swift
//  Portfolio (iOS)
//
//  Created by Alexey Primechaev on 10/9/21.
//

import Foundation
import CoreData

class TaskEntry: NSManagedObject, Identifiable {
    
    @NSManaged private var titleStored: String?
    
    @NSManaged private var timeStartedStored: Date?
    @NSManaged private var timeFinishedStored: Date?
    @NSManaged private var timeStored: NSNumber?
    @NSManaged private var isInProgressStored: NSNumber?
    @NSManaged private var isSuccessfulStored: NSNumber?
    
    
    
}

extension TaskEntry {
    var title: String {
        get {
            titleStored ?? ""
        }
        set {
            titleStored = newValue
        }
        
    }
    
    var timeStarted: Date {
        get { timeStartedStored ?? Date() }
        set { timeStartedStored = newValue }
    }
    
    var timeFinished: Date {
        get { timeFinishedStored ?? Date() }
        set { timeFinishedStored = newValue }
    }
    
    var time: Int {
        get { timeStored?.intValue ?? 0 }
        set { timeStored = NSNumber(value: Int32(newValue)) }
    }
    
    var isInProgredd: Bool {
        get { isInProgressStored?.boolValue ?? true }
        set { isInProgressStored = newValue as NSNumber }
    }
    
    var isSuccessful: Bool {
        get { isSuccessfulStored?.boolValue ?? true }
        set { isSuccessfulStored = newValue as NSNumber }
    }
    
}


extension TaskEntry {
    static func getAllTaskEntries() -> NSFetchRequest<TaskEntry> {
        let request: NSFetchRequest<TaskEntry> = TaskEntry.fetchRequest() as! NSFetchRequest<TaskEntry>
        
        let sortDescriptor = NSSortDescriptor(keyPath: \TaskEntry.timeStartedStored, ascending: true)
        
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }
}
