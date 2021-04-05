//
//  TranslationResponse.swift
//  CrossTalk
//
//  Created by Дмитрий Ф on 18/06/2020.
//  Copyright © 2020 Дмитрий Ф. All rights reserved.
//

import Foundation


struct TranslationResponse: Codable {
    enum CodingKeys: String, CodingKey {
        case language = "lang"
        case translations = "text"
    }
    
    var languageCode: String = ""
    var translations = [String]()
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(String(), forKey: .language)
        try container.encode([String](), forKey: .translations)
    }
    
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.languageCode = try container.decode(String.self, forKey: .language)
            self.translations = try container.decode([String].self, forKey: .translations)
        } catch {
            print(error)
        }
    }
    
}
