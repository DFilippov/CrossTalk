//
//  DateFormatter+Extension.swift
//  CrossTalk
//
//  Created by Дмитрий Ф on 13/06/2020.
//  Copyright © 2020 Дмитрий Ф. All rights reserved.
//

import Foundation

extension DateFormatter {
    convenience init(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) {
        self.init()
        self.dateStyle = dateStyle
        self.timeStyle = timeStyle
    }
}
