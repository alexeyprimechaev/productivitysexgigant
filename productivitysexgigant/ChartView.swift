//
//  ChartView.swift
//  productivitysexgigant
//
//  Created by Alexey Primechaev on 12/4/21.
//

import SwiftUI

struct ChartView: View {
    @FetchRequest(fetchRequest: TaskEntry.getAllTaskEntries()) var taskEntries: FetchedResults<TaskEntry>
    @Environment(\.managedObjectContext) var context
    
    let daysInChart = 7
    
    @State var statDays = [(daysOffset: Int, succ: Int, fail: Int)]()

    var body: some View {

               
        HStack{
            
            
            
        }.onChange(of: taskEntries.filter {_ in return true}) { newValue in
            updateChartData()
        }
        .onAppear {
        updateChartData()
        }.frame(height: 200)


    }
    
    func updateChartData() {
        for i in 0..<daysInChart {
        
            var succ = 0
        
            var fail = 0
        
            for item in taskEntries {
                if item.timeStarted.isInSameDay(date: Calendar.current.date(byAdding: .day, value: -1*i, to: Date()) ?? Date()) {
                    if item.isSuccessful {
                        succ += 1
                    } else {
                        fail += 1
                    }
                }
            }
        
            statDays.append((daysOffset: i, succ: succ, fail: fail))
        }
    }
}





struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}



extension Date {
    static func hoursDifference(end: Date, start: Date) -> Double {
        let diff = Int(end.timeIntervalSince1970 - start.timeIntervalSince1970)

        let hours = Double(diff) / 3600.0
        //   let minutes = (Double(diff) - hours * 3600) / 60.0
        return hours
    }
    
    static func minutesDifference(end: Date, start: Date) -> Double {
        let diff = Int(end.timeIntervalSince1970 - start.timeIntervalSince1970)

      let hours = Double(diff) / 3600.0
        let minutes = hours * 60.0

        return minutes
    }
    
    static func secondsDifference(end: Date, start: Date) -> Double {
        let diff = Int(end.timeIntervalSince1970 - start.timeIntervalSince1970)

      let hours = Double(diff) / 3600.0
        let minutes = hours * 60.0
        let seconds = minutes * 60.0
        return seconds
    }

    func isEqual(to date: Date, toGranularity component: Calendar.Component, in calendar: Calendar = .current) -> Bool {
        calendar.isDate(self, equalTo: date, toGranularity: component)
    }

    func isInSameYear(date: Date) -> Bool { isEqual(to: date, toGranularity: .year) }
    func isInSameMonth(date: Date) -> Bool { isEqual(to: date, toGranularity: .month) }
    func isInSameDay(date: Date) -> Bool { isEqual(to: date, toGranularity: .day) }
    func isInSameWeek(date: Date) -> Bool { isEqual(to: date, toGranularity: .weekOfYear) }

    var isInThisYear: Bool { isInSameYear(date: Date()) }
    var isInThisMonth: Bool { isInSameMonth(date: Date()) }
    var isInThisWeek: Bool { isInSameWeek(date: Date()) }

    var isInYesterday: Bool { Calendar.current.isDateInYesterday(self) }
    var isInToday: Bool { Calendar.current.isDateInToday(self) }
    var isInTomorrow: Bool { Calendar.current.isDateInTomorrow(self) }

    var isInTheFuture: Bool { self > Date() }
    var isInThePast: Bool { self < Date() }
}





//ZStack {
//    GeometryReader { reader in
//
//Path { p in
//
//    let chartWidth = reader.size.width
//    let chartHeight = reader.size.height
//
//    var x = CGFloat(0.0)
//    var y = CGFloat(0.0)
//
//
//
//    for i in 0..<5 {
//        x = 0.0
//        y = chartHeight*(1-CGFloat(i)/4.0)
//
//        p.move(to: CGPoint(x: x, y: y))
//
//        x = chartWidth
//
//        p.addLine(to: CGPoint(x: x, y: y))
//
//
//    }
//
//}
//
//    }.onChange(of: taskEntries) { newValue in
//
//}
//.onAppear {
//for i in 0..<daysInChart {
//
//    var succ = 0
//
//    var fail = 0
//
//    for item in taskEntries {
//        if item.isSuccessful {
//            succ += 1
//        } else {
//            fail += 1
//        }
//    }
//
//    statDays.append((daysOffset: i, succ: succ, fail: fail))
//}
//}.frame(height: 200)
//
//
//}







//
//
//struct TodayChartView: View {
//
//    @Environment(\.managedObjectContext) var context
//    @FetchRequest(fetchRequest: MoodEntry.getTodayMoodEntries()) var moodEntries: FetchedResults<MoodEntry>
//
//    @State var time1 = "2"
//    @State var time2 = "1"
//    @State var time3 = "0"
//
//    @State private var end = CGFloat.zero
//
//    var body: some View {
//
//
//            VStack {
//                ZStack {
//                    GeometryReader { reader in
//
//                Path { p in
//
//                    let chartWidth = reader.size.width
//                    let chartHeight = reader.size.height
//
//                    var x = CGFloat(0.0)
//                    var y = CGFloat(0.0)
//
//                    for i in 0..<5 {
//                        x = 0.0
//                        y = chartHeight*(1-CGFloat(i)/4.0)
//
//                        p.move(to: CGPoint(x: x, y: y))
//
//                        x = chartWidth
//
//                        p.addLine(to: CGPoint(x: x, y: y))
//
//
//                    }
//
//                }.stroke(Color("TextColorGrey"), style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round)).animation(.default)
//
//
//
//                Path { p in
//
//
//                    let pointsNormalized = getPoints()
//                    var points = [CGPoint]()
//
//                    let chartWidth = reader.size.width
//                    let chartHeight = reader.size.height
//
//                    for item in pointsNormalized {
//                        points.append(CGPoint(x: item.x*chartWidth, y: item.y*chartHeight))
//                    }
//
//                    if points.count > 1 {
//                        for i in 1..<points.count {
//
//                            p.move(to: CGPoint(x: points[i-1].x, y: points[i-1].y))
//                            p.addLine(to: CGPoint(x: points[i].x, y: points[i].y))
//
//
//                        }
//                    }
//
//                }.trim(from: 0, to: end).stroke(Color.blue, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round)).animation(.default)
//
//
//
//                Path { p in
//
//                    let pointsNormalized = getPoints()
//                    var points = [CGPoint]()
//
//                    let chartWidth = reader.size.width
//                    let chartHeight = reader.size.height
//
//                    for item in pointsNormalized {
//                        points.append(CGPoint(x: item.x*chartWidth, y: item.y*chartHeight))
//                    }
//
//                    if points.count > 0 {
//                        for i in 0..<points.count {
//
//                            p.addEllipse(in: CGRect(x: points[i].x-4, y: points[i].y-4, width: 8, height: 8))
//
//                        }
//                    }
//
//                }.trim(from: 0, to: end).stroke(Color.blue, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round)).animation(.default)
//
//
//
//                Path { p in
//
//                    let pointsNormalized = getPoints()
//                    var points = [CGPoint]()
//
//                    let chartWidth = reader.size.width
//                    let chartHeight = reader.size.height
//
//                    for item in pointsNormalized {
//                        points.append(CGPoint(x: item.x*chartWidth, y: item.y*chartHeight))
//                    }
//
//                    if points.count > 0 {
//                        for i in 0..<points.count {
//
//                            p.addEllipse(in: CGRect(x: points[i].x-2.5, y: points[i].y-2.5, width: 5, height: 5))
//
//                        }
//                    }
//
//
//                }.trim(from: 0, to: end).fill(Color("BackgroundColorAlt")).animation(.easeInOut).animation(.default)
//                    }
//                }.padding(.vertical, 10)
//                .padding(.horizontal, 6)
//                HStack {
//                    Text(time1).fontWeight(.bold).modifier(LegendTextModifier())
//                    Spacer()
//                    Text(time2).fontWeight(.bold).modifier(LegendTextModifier())
//                    Spacer()
//                    Text(time3).fontWeight(.bold).modifier(LegendTextModifier())
//
//                }.animation(.default)
//            }.padding(.vertical, cardInsideVerticalPadding).animation(.easeInOut)
//            .onAppear {
//                self.end = 1
//                var time1Date = Date()
//                var time3Date = Date()
//
//                var time2Date = Date()
//
//                var time1String = ""
//                var time2String = ""
//                var time3String = ""
//
//
//                let dateFormatter : DateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "h:mm a"
//
//                for entry in moodEntries {
//                    if entry.date.isInToday {
//                        if (time1String == "") {
//                            time1Date = entry.date
//                            time1String = dateFormatter.string(from: time1Date)
//                        }
//                        time3Date = entry.date
//
//                        time2Date = Date(timeIntervalSince1970: (time1Date.timeIntervalSince1970 + time3Date.timeIntervalSince1970)/2.0)
//                        time2String = dateFormatter.string(from: time2Date)
//                        time3String = dateFormatter.string(from: time3Date)
//
//
//                    }
//                }
//
//                if (time3String == time1String) {
//                    time1 = time1String
//                    time2 = ""
//                    time3 = ""
//                } else {
//                    time1 = time1String
//                    time2 = time2String
//                    time3 = time3String
//                }
//
//
//
//
//            }
//            .padding(.horizontal, cardInsideHorizontalPadding)
//            .frame(height: chartCardHeight)
//            .modifier(CardViewModifierAlt())
//            .onChange(of: moodEntries.filter {_ in return true}) { newValue in
//                var time1Date = Date()
//                var time3Date = Date()
//
//                var time2Date = Date()
//
//                var time1String = ""
//                var time2String = ""
//                var time3String = ""
//
//
//                let dateFormatter : DateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "h:mm a"
//
//                for entry in moodEntries {
//                        if (time1String == "") {
//                            time1Date = entry.date
//                            time1String = dateFormatter.string(from: time1Date)
//                        }
//                        time3Date = entry.date
//
//                        time2Date = Date(timeIntervalSince1970: (time1Date.timeIntervalSince1970 + time3Date.timeIntervalSince1970)/2.0)
//                        time2String = dateFormatter.string(from: time2Date)
//                        time3String = dateFormatter.string(from: time3Date)
//                }
//                if (time3String == time1String) {
//                    time1 = time1String
//                    time2 = ""
//                    time3 = ""
//                } else {
//                    time1 = time1String
//                    time2 = time2String
//                    time3 = time3String
//                }
//
//            }
//
//    }
//
//    func getPoints() -> [CGPoint] {
//        var points = [CGPoint]()
//
//        var mins = 0
//        var minsMin = 24*60
//        var minsMax = 0
//        var minsGap = CGFloat(0)
//
//        minsGap = CGFloat(minsMax - minsMin)
//
//        var x = CGFloat(0.0)
//        var y = CGFloat(0.0)
//
//        for entry in moodEntries {
//                mins = Int(Calendar.current.component(.hour, from: entry.date))*60 + Int(Calendar.current.component(.minute, from: entry.date))
//                if mins < minsMin {
//                    minsMin = mins
//                }
//                if mins > minsMax {
//                    minsMax = mins
//                }
//
//        }
//
//        minsGap = CGFloat(minsMax - minsMin)
//
//        if minsGap == CGFloat(0) {
//            minsGap = CGFloat(1)
//        }
//
//
//
//
//        if moodEntries.count > 0 {
//            for i in 0..<moodEntries.count {
//
//
//                mins = Int(Calendar.current.component(.hour, from: moodEntries[i].date))*60 + Int(Calendar.current.component(.minute, from: moodEntries[i].date))
//
//                x = CGFloat(mins-minsMin)/minsGap
//                y = (1-CGFloat(moodEntries[i].value)/4.0)
//
//                points.append(CGPoint(x: x, y: y))
//
//            }
//        }
//
//
//        return points
//    }
//}
