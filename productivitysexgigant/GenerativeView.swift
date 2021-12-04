////
////  GenerativeView.swift
////  100 (iOS)
////
////  Created by Игорь Дячук on 04.11.2021.
////
//
////добавить блюр
//
//// сделать четкие lanes чтобы не было пересечений
//
//
//// отключить движение и проверить явное положение тачей на разных устройствыах
//
import Foundation
import SwiftUI
//
struct GenerativeViewContainer: View {
    var body: some View {
        TimelineView(.periodic(from: .now, by: 0.01)) { timeline in
            ZStack {
                
                GenerativeView(date: timeline.date, opacity: 0.16, fontSize: 36.0)
                GenerativeView(date: timeline.date, opacity: 1.0, fontSize: 48.0)
            }
            
        }
    }
    
}

struct GenerativeView: View {
    
    
    @StateObject var shapes = Shapes()
    let date: Date
    
    let opacity: Double
    
    let fontSize: Double
    
    @State var tapCooldown = false
    
    


    
    var body: some View {
        GeometryReader { proxy in
            Canvas { context, size in
                

                for shape in shapes.shapes {
                    let textTime = context.resolve(Text(shape.iconName).font(.system(size: self.fontSize + shape.tapState)))
                    
//                    var deltaX = -100
//
//                    var deltaY = -100
//
//
//
//                    var x0 = (Double(shape.xPos)*1.2/Double(shape.xPosMax) - 0.1) * size.width
//                    var y0 = shape.coord.y * size.height
//
//                    let rectSize = 5.0
//                    context.fill(Path {
//                        path in
//
//                    while (deltaY <= 100) {
//                        deltaX = -100
//                        while (deltaX <= 100 ) {
//                            if dist(x1: x0 + Double(deltaX), y1: y0 + Double(deltaY), x2: x0, y2: y0) < 30 {
//                                path.addRect(CGRect(x: (Double(shape.xPos)*1.2/Double(shape.xPosMax) - 0.1) * size.width + CGFloat(deltaX), y: shape.coord.y * size.height + CGFloat(deltaY), width: rectSize, height: rectSize))
//                            }
//                            deltaX += 5
//                        }
//                        deltaY += 5
//                    }
//                    }, with: .color(.red))
                    

                   
                    context.draw(textTime, at: CGPoint(x: (Double(shape.xPos)*1.2/Double(shape.xPosMax) - 0.1) * size.width, y: shape.coord.y * size.height))
                    
                    
                }

            }.edgesIgnoringSafeArea(.all).statusBar(hidden: true).onChange(of: date) { _ in
                shapes.update()
            }.onAppear(perform: {
                for i in 0..<6 {
                    shapes.shapes.append(Shape())
                }
                
                
            }).opacity(self.opacity)
         }.edgesIgnoringSafeArea(.all)
    }
    
    init(date: Date, opacity: Double, fontSize: Double) {
        
        self.date = date
        self.opacity = opacity
        self.fontSize = fontSize
    }
    
 
    
    func dist(shape: Shape, tapValue: DragGesture.Value, screenSize: CGSize) -> Double {
        var x1 = tapValue.location.x
        var y1 = tapValue.location.y
        
        var x2 = (Double(shape.xPos)*1.2/Double(shape.xPosMax) - 0.1) * screenSize.width
        var y2 = shape.coord.y * screenSize.height

                         
        return sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2))

    }
    
    func dist(x1: Double, y1: Double, x2: Double,  y2: Double) -> Double {

        return sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2))

    }
//
    

}

class Shapes: ObservableObject {
    var shapes = [Shape]()
    
    func update() {
        for index in shapes.indices {
            shapes[index].update()
        }
    }
    
}

class Shape: ObservableObject {
    var iconName: String
    var coord: CGPoint
    var velocity: Double
    var delta: Double
    var xPos: Int
    var xPosMax = 20
    
    var takts = 0
    var changeTakts = 8
    
    // 1 c 12 переходов
    //1 с 100 раз вызовется
    //
    
    var tapState = 0.0
    var isTapped = false
    var isTappedIncrease = true
    var tapStateMax = 6.0*2.0
    
    

    
    init() {
        self.iconName = EmojiPicker().setEmoji()
        self.coord = CGPoint(x: Double.random(in:-0.1 ..< 1.1), y: Double.random(in: 1.1 ..< 2.5))
        self.delta = 1.0 * Double(sin(self.coord.y))
        self.velocity = Double.random(in: -0.002 ..< -0.001)
        self.xPos = Int.random(in: 0 ..< xPosMax)
    }

    func update() {
        self.coord.y += self.velocity
        
        if self.coord.y < -0.1 {
            self.iconName = EmojiPicker().setEmoji()
            self.coord = CGPoint(x: Double.random(in:-0.1 ..< 1.1), y: Double.random(in: 1.3 ..< 2.5))
            self.xPos = Int.random(in: 0 ..< 16)
        }
        
     
        takts += 1
        if takts >= changeTakts {
            takts = 0
            
         
            
  
            
            
            self.iconName = EmojiPicker().nextEmoji(currentEmoji: iconName)
            

        }
        
        
        
     }
    
    
}


struct EmojiPicker {
    let emojis = "🕐🕑🕒🕓🕔🕕🕖🕗🕘🕙🕚🕛"
    

    func setEmoji() -> String {
        let startInt = Int.random(in: 0..<emojis.count)
        
        let start = emojis.index(emojis.startIndex, offsetBy: startInt)
        let end = emojis.index(emojis.startIndex, offsetBy: startInt + 1)
        let range = start..<end

        return String(emojis[range])
    }
    
    func nextEmoji(currentEmoji: String) -> String {
        let startIntKal = emojis.firstIndex(of: currentEmoji[currentEmoji.startIndex])
        let startInt = emojis.distance(from: emojis.startIndex, to: startIntKal ?? emojis.startIndex)
        if startInt != emojis.count - 1 {
            let start = emojis.index(emojis.startIndex, offsetBy: startInt+1)
            let end = emojis.index(emojis.startIndex, offsetBy: startInt + 2)
            let range = start..<end
            return String(emojis[range])
            
        } else {
            let start = emojis.index(emojis.startIndex, offsetBy: 0)
            let end = emojis.index(emojis.startIndex, offsetBy: 1)
            let range = start..<end
            return String(emojis[range])
        }
    
        
    }
}




extension Int {
    var f: CGFloat { return CGFloat(self) }
}

extension Float {
    var f: CGFloat { return CGFloat(self) }
}

extension Double {
    var f: CGFloat { return CGFloat(self) }
}

extension CGFloat {
    var swf: Float { return Float(self) }
}

extension String
{
    func characterAtIndex(index:Int) -> unichar
    {
        return self.utf16[String.UTF16View.Index(encodedOffset: index)]
    }

    // Allows us to use String[index] notation
    subscript(index:Int) -> unichar
    {
        return characterAtIndex(index: index)
    }
}
