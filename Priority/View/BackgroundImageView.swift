//
//  BackgroundImageView.swift
//  Priority
//
//  Created by Victor Zerefos on 06/07/21.
//

import SwiftUI

struct BackgroundImageView: View {
    var body: some View {
       Image("image")
        .antialiased(true)
        .resizable()
        .scaledToFill()
    }
}

struct BackgroundImageView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundImageView()
    }
}
