//
//  ListRowItemView.swift
//  Priority
//
//  Created by Victor Zerefos on 06/07/21.
//

import SwiftUI

struct ListRowItemView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var item: Item
    
    var body: some View {
        Toggle(isOn: $item.completion, label: {
            Text(item.task ?? "")
                .font(.system(.title3, design: .rounded))
                .fontWeight(.bold)
                .foregroundColor(item.completion ? Color.red : Color.primary)
                .padding(12)
                .animation(.default)
        }) //: - TOGGLE
        .toggleStyle(CheckBoxStyle())
        .onReceive(item.objectWillChange, perform: { _ in
            if self.viewContext.hasChanges {
                try? self.viewContext.save()
            }
        })
    }
}
