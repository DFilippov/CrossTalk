//
//  MessageView.swift
//  CrossTalk
//
//  Created by Дмитрий Ф on 17/06/2020.
//  Copyright © 2020 Дмитрий Ф. All rights reserved.
//

import SwiftUI

struct MessageView: View {
    
    let message: Message
    @Binding var isTranslating: Bool
    
    var body: some View {
        VStack {
            Text(self.caption(for: message))
                .multilineTextAlignment(.center)
                .font(.caption)
                .foregroundColor(.gray)
                .onTapGesture {
                    if self.isTranslating, self.message.isTranslated {
                        let url = URL(string: "http://translate.yandex.com")!
                        UIApplication.shared.open(url)
                    }
            }
            
            HStack {
                if message.isFromLocalUser {
                    Spacer()
                }
                
                Text(text(for: message))
                    .font(.body)
                    .foregroundColor(.white)
                    .padding()
                    .background(message.isFromLocalUser ? Color.blue : Color.gray)
                    .cornerRadius(20)
                    .padding(.leading, message.isFromLocalUser ? 20 : 8)
                    .padding(.trailing, message.isFromLocalUser ? 8 : 20)
                    .padding(.vertical, 5)
                
                if message.isFromLocalUser == false {
                    Spacer()
                }
            }
        }
    }
    
    private func text(for message: Message) -> String {
        return isTranslating && message.translatedValue.isEmpty == false ?
        message.translatedValue :
        message.value
    }
    
    private func caption(for message: Message) -> String {
        var caption = ""
        
        switch (message.isFromLocalUser, isTranslating) {
        case (true, _):
            caption = message.timestamp
        case (_, true) where message.isTranslated:
            caption = "\nTranslation powered by Yandex.Translate"
            fallthrough
        default:
            caption = message.userName + " - " + message.timestamp + caption
        }
        
        return caption
    }
}
