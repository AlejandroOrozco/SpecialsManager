//
//  GroceryView.swift
//  ManagersSpecial
//
//  Created by Alejandro Orozco Builes on 9/10/19.
//  Copyright © 2019 Alejandro Orozco Builes. All rights reserved.
//

import SwiftUI

struct GroceryView: View {
    @ObservedObject var controller = GroceryController()

    var body: some View {
        ScrollView {
            VStack {
                Text("Manager's Special")
                ForEach(controller.managersSpecials.indices, id: \.self) { row in
                    HStack(alignment: .center) {
                        ForEach(self.controller.managersSpecials[row].indices, id: \.self) { colum in
                            SpecialCard(special: self.controller.managersSpecials[row][colum])
                        }
                    }.padding(.horizontal)
                }
            }.frame(width: UIScreen.main.bounds.width)
             .padding(.vertical)
        }.background(Color("Background"))
            .alert(isPresented: $controller.showAlertMessage) { () -> Alert in
                Alert(title: Text("\(controller.alertMessage?.title ?? String())"),
                      message: Text("\(controller.alertMessage?.message ?? String())"),
                      dismissButton: .cancel())
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        GroceryView()
    }
}
