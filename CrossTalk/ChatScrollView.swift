//
//  ChatScrollView.swift
//  CrossTalk
//
//  Created by Дмитрий Ф on 17/06/2020.
//  Copyright © 2020 Дмитрий Ф. All rights reserved.
//

import SwiftUI

struct ChatScrollView: View {
    
    @EnvironmentObject private var viewModel: ChatViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.messages) {
                    MessageView(message: $0, isTranslating: self.$viewModel.isTranslating)
                }
            }
        }
    }
}

struct ChatScrollView_Previews: PreviewProvider {
    static var previews: some View {
        ChatScrollView()
    }
}
