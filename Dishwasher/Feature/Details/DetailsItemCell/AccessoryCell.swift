import UIKit

final class AccessoryCellModel: RootCellModel {
    var iconName: String
    init(title: String, iconName: String) {
        self.iconName = iconName
        super.init(title: title)
    }
    
    override func cellId() -> String {
        return String(describing: AccessoryCell.classForCoder())
    }
}

final class AccessoryCell: RootCell {
    
    private enum LocalConstants {
        static let padding: CGFloat = 20
        static let iconWidth: CGFloat = 40
    }
    
    var accessoryCellModel: AccessoryCellModel
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        accessoryCellModel = AccessoryCellModel(title: "", iconName: "")
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(iconImageView)
    }
    
    override func didMoveToSuperview() {
        NSLayoutConstraint.activate(titleLabelConstraints() + iconImageViewConstraints())
    }
    
    private lazy var iconImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    override func reload(with viewModel: RootCellModelType) {
        super.reload(with: viewModel)
        guard let accessoryCellModel = viewModel as? AccessoryCellModel else { return }
        self.accessoryCellModel = accessoryCellModel
        titleLabel.text = accessoryCellModel.title
        iconImageView.image = UIImage(named: accessoryCellModel.iconName)
    }
    
    private func titleLabelConstraints() -> [NSLayoutConstraint] {
        return [
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LocalConstants.padding),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LocalConstants.padding),
            titleLabel.trailingAnchor.constraint(equalTo: iconImageView.leadingAnchor, constant: -LocalConstants.padding),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -LocalConstants.padding)
        ]
    }
    
    private func iconImageViewConstraints() -> [NSLayoutConstraint] {
        return [
            iconImageView.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: LocalConstants.iconWidth),
            iconImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -LocalConstants.padding),
            iconImageView.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        ]
    }
}
