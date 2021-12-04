//
//  Knopka.swift
//  productivitysexgigant
//
//  Created by Игорь Дячук on 04.12.2021.
//

import SwiftUI

struct Knopka: View {
    var body: some View {
        ZStack {
            
            Text("20 mins").background(RoundedRectangle(cornerRadius: 10.0).foregroundColor(Color("BrandGray")))
        }
        
        
    }
}

struct Knopka_Previews: PreviewProvider {
    static var previews: some View {
        Knopka()
    }
}
