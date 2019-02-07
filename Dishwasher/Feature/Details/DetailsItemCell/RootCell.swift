import UIKit

protocol RootCellModelType {
    var title: String { get set }
    func cellId() -> String
}

protocol RootCellType {
    func reload(with viewModel: RootCellModelType)
}

class RootCellModel: RootCellModelType {
    var title: String
    init(title: String) {
        self.title = title
    }
    
    func cellId() -> String {
        return String(describing: RootCell.classForCoder())
    }
}

class RootCell: UITableViewCell, RootCellType {
    
    private enum LocalConstants {
        static let padding: CGFloat = 20
    }
    
    var viewModel: RootCellModelType
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        viewModel = RootCellModel(title: "")
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
    }
    
    override func didMoveToSuperview() {
        NSLayoutConstraint.activate(titleLabelConstraints())
    }
    
    lazy var titleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func reload(with viewModel: RootCellModelType) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
    }
    
    private func titleLabelConstraints() -> [NSLayoutConstraint] {
        return [
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LocalConstants.padding),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LocalConstants.padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -LocalConstants.padding),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -LocalConstants.padding)
        ]
    }
}
