//
//  RALocalizableTextField.swift
//  RALocalize
//
//  Created by Ruben Nahatakyan on 11/26/19.
//  Copyright © 2019 Ruben Nahatakyan. All rights reserved.
//

import UIKit

open class RALocalizableTextField: UITextField {

    // MARK: - Properties
    private(set) var localizedPlaceholder: String?

    override open var placeholder: String? {
        set {
            localizedPlaceholder = newValue
            let attributes: [NSAttributedString.Key: UIColor] = [.foregroundColor: placeholderColor]
            self.attributedPlaceholder = NSAttributedString(string: newValue?.localized ?? "", attributes: attributes)
        }
        get {
            return self.attributedPlaceholder?.string
        }
    }

    open override var isEnabled: Bool {
        willSet {
            alpha = newValue ? 1 : 0.5
        }
    }

    open var placeholderColor: UIColor = UIColor.white.withAlphaComponent(0.8) {
        didSet {
            placeholder = localizedPlaceholder
        }
    }

    // MARK: - Init
    public override init(frame: CGRect) {
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
private extension RALocalizableTextField {
    func startup() {
        addObservers()
    }

    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(applicationLanguageChanged), name: .ApplicationLanguageChanged, object: nil)
    }

    @objc func applicationLanguageChanged() {
        placeholder = localizedPlaceholder
        languageChanged()
    }
}

// MARK: - Public methods
extension RALocalizableTextField {
    @objc open func languageChanged() { }
}
