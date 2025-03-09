//
//  String extension.swift
//  RALocalize
//
//  Created by Ruben Nahatakyan on 11/26/19.
//  Copyright © 2019 Ruben Nahatakyan. All rights reserved.
//

import Foundation

public extension String {
    var localized: String {
        guard let path = Bundle.main.path(forResource: RALocalize.currentLanguage?.code, ofType: "lproj"), let bundle = Bundle(path: path) else { return self }
        return NSLocalizedString(self, tableName: nil, bundle: bundle, comment: "")
    }

    func localize(to languageCode: String) -> String {
        guard let path = Bundle.main.path(forResource: languageCode, ofType: "lproj"), let bundle = Bundle(path: path) else { return self }
        return NSLocalizedString(self, tableName: nil, bundle: bundle, comment: "")
    }
}
