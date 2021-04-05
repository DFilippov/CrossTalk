//
//  ContentView.swift
//  CrossTalk
//
//  Created by Дмитрий Ф on 11/06/2020.
//  Copyright © 2020 Дмитрий Ф. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    // Changed wrapper for viewModel from ObservedObject to EnvironmentObject
    // after adding in SceneDelegate to property contentView:   .environmentObject(ChatViewModel())
    // This is done for making viewModel to be an environment object, now it can be read by any of child views of main ContentView
    @EnvironmentObject var viewModel: ChatViewModel
    @State private var showActionSheet = false
    
    private let dateFormatter = DateFormatter(dateStyle: .short, timeStyle: .short)
    
    var body: some View {
        
        NavigationView {
            VStack {
                ChatScrollView()
                    .navigationBarTitle( Text(viewModel.appState.rawValue), displayMode: .inline )
                
                ToolbarView(showActionSheet: $showActionSheet)
                    .padding()
                    .background(colorScheme == .dark ? Color.black : Color.white)
                    .offset(y: viewModel.keyboardOffset)
                    .animation(.easeInOut(duration: viewModel.keyboardAnimationDuration))
            }
            .animation(.easeInOut)
                // for dismissing keyboard after text was entered. The textField (which is embedded in window) will resign first responder
                .onTapGesture {
                    UIApplication.shared.windows
                        .first { $0.isKeyWindow }?
                        .endEditing(true)
            }
        }
        .actionSheet(isPresented: $showActionSheet) {
            ActionSheet(title: Text(viewModel.actionSheetTitle), message: nil, buttons: actionSheetButtons())
        }
    }
    
    private func actionSheetButtons() -> [ActionSheet.Button] {
        var buttons = [ActionSheet.Button]()
        
        switch viewModel.appState {
        case .inactive:
            buttons += [
                .default(Text("Host Chat"), action: {
                    self.viewModel.startAdvertising()
                }) ,
                .default(Text("Join Chat"), action: {
                    self.viewModel.startBrowsing()
                })
            ]
            
        default:
            buttons += [
                .default(Text( viewModel.isTranslating ?
                    "Stop Translating" :
                    "Start Translating to Spanish")
                )
                { self.viewModel.isTranslating.toggle() },
                
                .default(Text("Disconnect"), action: {
                    self.viewModel.disconnect()
                })
            ]
        }
        buttons.append(.cancel())
        
        return buttons
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone 11 Pro Max")
                .previewDisplayName("iPhone 11 Pro Max")
            
            ContentView()
                .previewDevice("iPhone SE")
                .previewDisplayName("iPhone SE")
                .environment(\.colorScheme, .dark)
        }
    }
}
