

import UIKit

class SummerVideoPlayerHeaderView: UIView {
    
    var configuration: SummerPlayerViewConfig
    var theme: SummerPlayerViewTheme
    var delegate: PlayerScreenViewDelegate?
    var item: Content?
    
    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blue
        label.textAlignment = .natural
        label.numberOfLines = 0
        return label
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
    
    
    
    required init(configuration: SummerPlayerViewConfig, theme: SummerPlayerViewTheme, delegate: PlayerScreenViewDelegate?) {
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
        titleLabel.textColor = theme.playListCurrentItemTextColor
        titleLabel.font = theme.playListCurrentItemFont
    }
    
    private func addTitleLabel() {
        controlsStackView.addArrangedSubview(titleLabel)
    }
    
}
