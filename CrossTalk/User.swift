//
//  User.swift
//  CrossTalk
//
//  Created by Дмитрий Ф on 13/06/2020.
//  Copyright © 2020 Дмитрий Ф. All rights reserved.
//

import UIKit

class User {
    static let local = User()
    
    let id = UUID()
    var name: String { UIDevice.current.name }
    
    private init() {
        
    }
    
}
