//
//  RALanguage.swift
//  RALocalize
//
//  Created by Ruben Nahatakyan on 12/11/19.
//  Copyright © 2019 Ruben Nahatakyan. All rights reserved.
//

import UIKit

public struct RALanguage: Equatable {
    public let code: String
    public let engName: String?
    public let nativeName: String?

    public init(code: String) {
        self.code = code
        self.nativeName = Locale(identifier: code).localizedString(forLanguageCode: code)?.firstUppercased

        let languageCode = Locale.components(fromIdentifier: code)[NSLocale.Key.languageCode.rawValue] ?? ""
        self.engName = Locale(identifier: "en").localizedString(forLanguageCode: languageCode)?.firstUppercased
    }

    public static func == (lhs: RALanguage, rhs: RALanguage) -> Bool {
        return lhs.code == rhs.code
    }
}
