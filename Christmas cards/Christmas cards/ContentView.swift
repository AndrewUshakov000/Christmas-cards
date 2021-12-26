//
//  ContentView.swift
//  Christmas cards
//
//  Created by Andrew Ushakov on 12/16/21.
//

import SwiftUI

struct ContentView: View {
    @State private var createCard = false

    var body: some View {
        ZStack {
            Color.init(red: 128 / 255, green: 0, blue: 32 / 255)
                .ignoresSafeArea()
            VStack {
                Image("santa")
                    .resizable()
                    .frame(width: 700, height: 400)
                    .ignoresSafeArea()
                VStack(alignment: .leading) {
                    Text("Merry Christmas!")
                        .foregroundColor(.white)
                        .font(.custom("Chalkboard SE", size: 39))
                        .offset(y: -40)
                    Text("It is cold outside and everybody prepares \nfor a Chistmas. So, let's wish everybody \na Merry Christmas!")
                        .foregroundColor(.white)
                        .font(.custom("Chalkboard SE", size: 19))
                }
                Spacer()
                Button {
                    self.createCard.toggle()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 9)
                            .frame(width: 300, height: 70)
                            .foregroundColor(.white)
                        Text("Create a Christmas card")
                            .foregroundColor(.black)
                            .font(Font.custom("American Typewriter", size: 22))
                    }
                }
            }.fullScreenCover(isPresented: $createCard) {
                DetailView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
