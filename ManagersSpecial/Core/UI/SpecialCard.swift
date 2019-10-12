//
//  Card.swift
//  ManagersSpecial
//
//  Created by Alejandro Orozco Builes on 9/10/19.
//  Copyright © 2019 Alejandro Orozco Builes. All rights reserved.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

struct SpecialCard: View {
    var special: Grocery.ViewModel.ManagerSpecial
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(UIColor.systemBackground))
                .cornerRadius(8)
                .shadow(radius: 3)

            VStack {
                VStack {
                    HStack() {
                        WebImage(url: special.imageURL, placeholder: .init(systemName: "j.circle.fill"))
                            .resizable()
                            .scaledToFit()
                            .frame(minWidth: 10, maxWidth: 50, minHeight: 10, maxHeight: 50)
                            .layoutPriority(0)
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text(special.originalPrice)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                                .strikethrough()
                                .lineLimit(1)
                            Text(special.currentPrice)
                                .foregroundColor(.green)
                                .fontWeight(.bold)
                                .lineLimit(1)
                        }.minimumScaleFactor(0.1)
                         .layoutPriority(1)
                    }.layoutPriority(0)
                     .fixedSize(horizontal: false, vertical: false)
                    EmptyView().frame(width: 0, height: 10)
                    VStack {
                        Text(special.name)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .minimumScaleFactor(0.1)
                            .layoutPriority(2)
                    }.layoutPriority(2)
                }.padding()
            }
            .frame(width: special.size.width, height: special.size.height)
            .accessibilityElement(children: .combine)
            .accessibility(label: Text(special.accessibilityLabel))
        }
    }
}

struct Card_Previews: PreviewProvider {    
    static var previews: some View {
        ScrollView {
            VStack {
                HStack {
                    SpecialCard(special: .init(name: "Noodle Dish with Roasted Black Bean Sauce",
                    imageURL: URL(string: "https://raw.githubusercontent.com/Swiftly-Systems/code-exercise-ios/master/images/L.png"),
                    size: .init(width: 355, height: 135),
                    originalPrice: "$2.00",
                    currentPrice: "$1.00"))
                }
            }.padding(.horizontal)
            .frame(width: UIScreen.main.bounds.width)
        }
    }
}
