//
//  RALocalizableButton.swift
//  RALocalize
//
//  Created by Ruben Nahatakyan on 11/26/19.
//  Copyright © 2019 Ruben Nahatakyan. All rights reserved.
//

import UIKit

open class RALocalizableButton: UIButton {

    // MARK: - Properties
    private var localizableTitles = NSMutableDictionary()

    open override var isSelected: Bool {
        didSet {
            applicationLanguageChanged()
        }
    }

    open override var isHighlighted: Bool {
        didSet {
            applicationLanguageChanged()
        }
    }

    open override var isEnabled: Bool {
        willSet {
            alpha = newValue ? 1 : 0.5
        }
    }

    // MARK: - Init
    override public init(frame: CGRect) {
        super.init(frame: frame)
        startupSetup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        startupSetup()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Startup default setup
private extension RALocalizableButton {
    @objc func startupSetup() {
        addObservers()

        if let title = self.currentTitle {
            setTitle(title, for: state)
        }
    }

    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(applicationLanguageChanged), name: .ApplicationLanguageChanged, object: nil)
    }

    @objc func applicationLanguageChanged() {
        let savedState = localizableTitles.allKeys.first { $0 as? String == "\(self.state.rawValue)" } as? String
        let currentState = savedState ?? "\(UIControl.State.normal.rawValue)"
        let state = UIControl.State(rawValue: UInt(currentState) ?? 0)
        let title = localizableTitles.value(forKey: currentState) as? String ?? ""
        super.setTitle(title.localized, for: state)
        languageChanged()
    }
}

// MARK: - Public methods
extension RALocalizableButton {
    override open func setTitle(_ title: String?, for state: UIControl.State) {
        localizableTitles.setValue(title, forKey: "\(state.rawValue)")
        applicationLanguageChanged()
    }

    @objc open func languageChanged() { }
}
