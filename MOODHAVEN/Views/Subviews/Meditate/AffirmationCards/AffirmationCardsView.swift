//
//  AffirmationCardsView.swift
//  MOODHAVEN
//
//  Created by Berkay Disli on 8.04.2023.
//

import SwiftUI

struct AffirmationCardsView: View {
    @Environment(\.dismiss) var dismiss
    
    let fgColor: Color
    let bgColor: Color
    @State var cards: [Card] = []
    
    @State var isRotationEnabled: Bool = true
    
    var body: some View {
        NavigationView {
            VStack {
                BoomerangCard(isRotationEnabled: isRotationEnabled, fgColor: fgColor, cards: $cards)
                    .frame(height: 220)
                    .padding(.horizontal)
            }
            .padding(15)
            .preferredColorScheme(.dark)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(content: {
                bgColor
                    .overlay {
                        Image("affirmationCardViewBg")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .blendMode(.overlay)
                            .opacity(0.3)
                    }
                    .ignoresSafeArea()
            })
            .onAppear(perform: setupCards)
            .navigationTitle("Affirmation Cards")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(fgColor)
                    }

                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Toggle (isRotationEnabled ? "Rotation Enabled":"Rotation Disabled", isOn: $isRotationEnabled)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    } label: {
                        Image(systemName: "gearshape")
                            .foregroundColor(fgColor)

                    }
                }
            }
        }
    }
    
    
    func setupCards() {
        cards = [.init(imageName: "lineArtHeart", message: "I am surrounded by love and choose to let it fill my heart every day.", color: Color(hex: "#ff5f5f") ?? fgColor),
                 .init(imageName: "lineArtMeditation", message: "I find inner peace and clarity through meditation and always carry it with me.", color: Color(hex: "#a8d8ea") ?? fgColor),
                 .init(imageName: "lineArtFlower", message: "I embrace growth and change, knowing that they are part of my journey towards a beautiful life.", color: Color(hex: "#ffc1c1") ?? fgColor),
                 .init(imageName: "lineArtTree", message: "I am grounded, strong, and resilient like a tree, and can weather any storm.", color: Color(hex: "#72a98f") ?? fgColor),
                 .init(imageName: "lineArtButterfly", message: "I am constantly transforming and becoming the best version of myself, just like a butterfly.", color: Color(hex: "#fcdab7") ?? fgColor),
                 .init(imageName: "lineArtSun", message:  "I radiate positivity and warmth to those around me, and bring light to even the darkest of days.", color: Color(hex: "#ffbe0b") ?? fgColor),
                 .init(imageName: "lineArtWaves", message: "I am like the waves of the ocean, constantly ebbing and flowing, finding my own rhythm and harmony.", color: Color(hex: "#0077be") ?? fgColor),
                 .init(imageName: "lineArtMountains", message: "I am strong and steadfast, like a mountain, and can overcome any obstacle in my path.", color: Color(hex: "#9e9e9e") ?? fgColor),
                 .init(imageName: "lineArtLotus", message: "I embrace the beauty that arises from difficult experiences, just as a lotus flower blooms from muddy waters.", color: Color(hex: "#ffc300") ?? fgColor)]

        
        if var first = cards.first {
            first.id = UUID().uuidString
            cards.append(first)
        }
        
    }
     
}

struct AffirmationCardsView_Previews: PreviewProvider {
    static var previews: some View {
        AffirmationCardsView(fgColor: .fg8, bgColor: .set8)
            .preferredColorScheme(.dark)
    }
}

// MARK: Card Model
struct Card: Identifiable{
    var id: String = UUID().uuidString
    var imageName: String
    var message: String
    var color: Color
    var isRotated: Bool = false
    var extraOffset: CGFloat = 0
    var scale: CGFloat = 1
    var zIndex: Double = 0
    
}

// MARK: Boomerang Card View
struct BoomerangCard: View{
    var isRotationEnabled: Bool = false
    let fgColor: Color
    @Binding var cards: [Card]
    
    // MARK: Gesture Properties
    @State var offset: CGFloat = 0
    @State var currentIndex: Int = 0
    
    var body: some View{
        GeometryReader{
            let size = $0.size
            ZStack{
                ForEach(cards.reversed()) { card in
                    CardView(card: card, size: size, fgColor: fgColor)
                        .offset(y: currentIndex == indexOf(card: card) ? offset : 0)
                }
            }
            .animation(.spring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: offset == .zero)
            .frame(width: size.width, height: size.height)
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 2)
                    .onChanged(onChanged(value:))
                    .onEnded(onEnded(value:))
            )
        }
    }
    
    func onChanged(value: DragGesture.Value) {
        offset = currentIndex == (cards.count - 1) ? 0 : value.translation.height
    }
    
    func onEnded(value: DragGesture.Value) {
        var translation = value.translation.height
        // Since We Only Need Negative
        translation = (translation < 0 ? -translation : 0)
        translation = (currentIndex == (cards.count - 1) ? 0:translation)
        
        // Half of the height of the card
        if translation > 110 {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                cards[currentIndex].isRotated = true
                // Slightly bigger than card height
                cards[currentIndex].extraOffset = -350
                cards[currentIndex].scale = 0.7
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.6)) {
                    cards[currentIndex].zIndex = -100
                    for index in cards.indices {
                        cards[index].extraOffset = 0
                    }
                    
                    if currentIndex != (cards.count - 1) {
                        currentIndex += 1
                    }
                    
                    offset = .zero
                }
            }
            
            DispatchQueue.main.asyncAfter (deadline: .now() + 0.5) {
                for index in cards.indices{
                    if index == currentIndex {
                        if cards.indices.contains(currentIndex - 1) {
                            cards[currentIndex - 1].zIndex = ZIndex(card: cards[currentIndex - 1])
                        }
                    } else {
                        cards[index].isRotated = false
                        withAnimation(.linear) {
                            cards[index].scale = 1
                        }
                    }
                }
                
                if currentIndex == (cards.count - 1) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        for index in cards.indices {
                            cards[index].zIndex = 0
                        }
                        
                        currentIndex = 0
                    }
                }
            }
        } else {
            offset = .zero
        }
    }
    
    func ZIndex(card: Card) -> Double {
        let index = indexOf(card: card)
        let totalCount = cards.count
        return currentIndex > index ? Double(index - totalCount) : cards[index].zIndex
    }
    
    
    
    @ViewBuilder
    func CardView(card: Card, size: CGSize, fgColor: Color)->some View{
        let index = indexOf(card: card)
        Image("affirmationCardBg")
            .resizable()
            .blendMode(.colorDodge)
            .aspectRatio(contentMode: .fill)
            .frame(width: size.width, height: size.height)
            .background(Color.set8)
            .overlay(alignment: .top, content: {
                RoundedRectangle(cornerRadius: 8).stroke(LinearGradient(colors: [card.color, fgColor.opacity(0.1), fgColor.opacity(0.1)], startPoint: .top, endPoint: .bottom), lineWidth: 1.5)
                    .padding(1)
            })
            .overlay {
                HStack {
                    Text(card.message)
                        .fontWeight(.semibold)
                        
                    
                    Spacer()
                    Image(card.imageName)
                        .resizable()
                        .colorInvert()
                        .aspectRatio(contentMode: .fit)
                        .contrast(100)
                        .scaleEffect(1.1)
                        
                        
                }
                .padding()
                .hAlign(.center)
                .vAlign(.center)
                .backgroundBlur(radius: 1) // Optional?
                 
            }
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .scaleEffect(card.scale, anchor: card.isRotated ? .center:.top)
            .rotation3DEffect(.init(degrees: isRotationEnabled && card.isRotated ? 180:0), axis: (x: 0, y: 0, z: 1))
            .offset(y: -offsetFor(index: index))
            .offset(y: card.extraOffset)
            .scaleEffect(scaleFor(index: index), anchor: .top)
            .zIndex(card.zIndex)
    }
    
    // MARK: Scale And Offset Values For Each Card
    func scaleFor(index value: Int) -> Double {
        let index = Double(value - currentIndex)
        
        if index >= 0 {
            if index > 3 {
                return 0.8
            }
            
            return 1 - (index / 15)
        } else {
            if -index > 3 {
                return 0.8
            }
            
            return 1 + (index / 15)
        }
    }
    
    func offsetFor(index value: Int) -> Double {
        let index = Double(value - currentIndex)
        
        if index >= 0 {
            if index > 3 {
                return 30
            }
            
            return (index * 10)
        } else {
            if -index > 3 {
                return 30
            }
            
            return (-index * 10)
        }
    }
    
    func indexOf(card: Card) -> Int {
        if let index = cards.firstIndex (where: { CCard in
            CCard.id == card.id
        }){
            return index
        }
        
        return 0
    }
}
        
