//
//  Public properties.swift
//  RALocalize
//
//  Created by Ruben Nahatakyan on 11/26/19.
//  Copyright © 2019 Ruben Nahatakyan. All rights reserved.
//

import Foundation

public let RALocalizeUserDefaultKey = "ra_language_code"

public extension Notification.Name {
    static let ApplicationLanguageChanged = Notification.Name("application_language_changed")
}

public extension String {
    var firstUppercased: String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
