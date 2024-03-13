//
//  ContentView.swift
//  Flashcard
//
//  Created by Emily Park on 3/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var deckId: Int = 0
    @State private var createCardViewPresented = false
    @State private var cards: [Card] = Card.mockedCards
    @State private var cardsToPractice: [Card] = []
    @State private var cardsMemorized: [Card] = []
       
    var body: some View {
        ZStack {
            VStack {
                Button("Reset!") {
                cards = cardsToPractice + cardsMemorized
                cardsToPractice = []
                cardsMemorized = []
                }
                .disabled(cardsToPractice.isEmpty && cardsMemorized.isEmpty)
                   
                   Button("More Practice") {
                       cards = cardsToPractice
                       cardsToPractice = []
                   }
                   .disabled(cardsToPractice.isEmpty)
               }
               
               ForEach(0..<cards.count, id: \.self) { index in
                   CardView(card: cards[index],
                       onSwipedLeft: {
                           let removedCard = cards.remove(at: index)
                           cardsToPractice.append(removedCard)
                       },
                       onSwipedRight: {
                           let removedCard = cards.remove(at: index)
                        cardsMemorized.append(removedCard)
                       }
                   )
                       .rotationEffect(.degrees(Double(cards.count - 1 - index) * -5))
               }
           }
           .id(deckId)
           .sheet(isPresented: $createCardViewPresented, content: {
               CreateFlashcardView { card in
                   cards.append(card)
               }
           })
           .frame(maxWidth: .infinity, maxHeight: .infinity)
           .overlay(alignment: .topTrailing) {
               Button("Add Flashcard") {
                   createCardViewPresented.toggle()
               }
               .padding()
           }
       }
   }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
