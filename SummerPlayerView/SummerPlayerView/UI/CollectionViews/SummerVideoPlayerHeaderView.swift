

import UIKit

class SummerVideoPlayerHeaderView: UIView {
    
    // MARK: - Instance Variables
    var configuration: SummerPlayerViewConfiguration
    var theme: SummerPlayerViewTheme
    var delegate: LegacyDelegate?
    var item: Content?
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blue
        label.textAlignment = .natural
        label.numberOfLines = 0
        return label
    }()
    
    lazy private var optionsButton: UIButton! = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Controls.options.image, for: .normal)
        button.addTarget(self, action: #selector(self.optionsBtnPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy private var controlsStackView: UIStackView  = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black
        view.alpha = 0.3
        return view
    }()
    
    // MARK: - View Initializers
    
    required init(configuration: SummerPlayerViewConfiguration, theme: SummerPlayerViewTheme, delegate: LegacyDelegate?) {
        self.configuration = configuration
        self.theme = theme
        self.delegate = delegate
        super.init(frame: .zero)
        createHeaderView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setItem(_ currentItem: Content) {
        item = currentItem
        titleLabel.text = currentItem.title
    }
    
    private func createHeaderView() {
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(backgroundView)
        addSubview(controlsStackView)
        
        backgroundView.pinEdges(targetView: controlsStackView)
        controlsStackView.pinEdges(targetView: self)
        controlsStackView.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        
        applyTheme(theme)
    }
    
    private func applyTheme(_ theme: SummerPlayerViewTheme) {
        optionsButton.setImage(theme.optionsButtonImage, for: .normal)
        optionsButton.tintColor = theme.buttonTintColor
        titleLabel.textColor = theme.playListCurrentItemTextColor
        titleLabel.font = theme.playListCurrentItemFont
    }
    
    private func addTitleLabel() {
        controlsStackView.addArrangedSubview(titleLabel)
    }
    
    
    
    @objc func optionsBtnPressed(_ sender: UIButton) {
        
    }
    
}
