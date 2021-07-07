//
//  Constant.swift
//  Priority
//
//  Created by Victor Zerefos on 06/07/21.
//

import SwiftUI

//: - Formatter

let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

//: - UI

var backgroundGradient: LinearGradient {
    return LinearGradient(gradient: Gradient(colors: [Color.orange, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
}

//: - UX
let feedback = UINotificationFeedbackGenerator()
