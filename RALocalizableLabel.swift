//
//  RALocalizableLabel.swift
//  RALocalize
//
//  Created by Ruben Nahatakyan on 11/26/19.
//  Copyright © 2019 Ruben Nahatakyan. All rights reserved.
//

import UIKit

open class RALocalizableLabel: UILabel {

    // MARK: - Properties
    private(set) var localizableString: String?

    override open var text: String? {
        set {
            localizableString = newValue
            super.text = localizableString?.localized
        }
        get {
            return super.text
        }
    }

    // MARK: - Init
    override public init(frame: CGRect) {
        super.init(frame: frame)
        startup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        startup()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Startup
private extension RALocalizableLabel {
    func startup() {
        addObservers()

        let tempText = self.text
        text = tempText
    }

    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(applicationLanguageChanged), name: .ApplicationLanguageChanged, object: nil)
    }

    @objc func applicationLanguageChanged() {
        text = localizableString
        languageChanged()
    }
}

// MARK: - Public methods
extension RALocalizableLabel {
    @objc open func languageChanged() { }
}
