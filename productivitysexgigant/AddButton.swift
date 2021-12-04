
import SwiftUI

struct AddButton: View {
    
    @State var buttonText: String
    var onTapped: () -> Void
    
    var body: some View {
        Button(action: onTapped) {
            HStack {
                Spacer()
                Text(buttonText).font(.headline)
                Spacer()
            }
            .padding(20)
            .background(RoundedRectangle(cornerRadius: 20.0).foregroundColor(Color(.systemGray6)))
        }
     
    
        
        
    }
}

struct Knopka_Previews: PreviewProvider {
    static var previews: some View {
        AddButton(buttonText: "4\nmins", onTapped: {})
    }
}
