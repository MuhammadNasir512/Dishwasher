import UIKit

final class SubtitleCellModel: RootCellModel {
    var subtitle: String
    init(title: String, subtitle: String) {
        self.subtitle = subtitle
        super.init(title: title)
    }
    
    override func cellId() -> String {
        return String(describing: SubtitleCell.classForCoder())
    }
}

final class SubtitleCell: RootCell {
    
    private enum LocalConstants {
        static let padding: CGFloat = 20
        static let subtitleWidth: CGFloat = 250
    }
    
    var subtitleCellModel: SubtitleCellModel
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        subtitleCellModel = SubtitleCellModel(title: "", subtitle: "")
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(subtitleLabel)
    }
    
    override func didMoveToSuperview() {
        NSLayoutConstraint.activate(titleLabelConstraints() + subtitleLabelConstraints())
    }
    
    private lazy var subtitleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .right
        return view
    }()
    
    override func reload(with viewModel: RootCellModelType) {
        super.reload(with: viewModel)
        guard let advancedViewModel = viewModel as? SubtitleCellModel else { return }
        self.subtitleCellModel = advancedViewModel
        titleLabel.text = advancedViewModel.title
        subtitleLabel.text = advancedViewModel.subtitle
    }
    
    private func titleLabelConstraints() -> [NSLayoutConstraint] {
        return [
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LocalConstants.padding),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LocalConstants.padding),
            titleLabel.trailingAnchor.constraint(equalTo: subtitleLabel.leadingAnchor, constant: -LocalConstants.padding),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -LocalConstants.padding)
        ]
    }
    
    private func subtitleLabelConstraints() -> [NSLayoutConstraint] {
        return [
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            subtitleLabel.widthAnchor.constraint(equalToConstant: LocalConstants.subtitleWidth),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -LocalConstants.padding),
            subtitleLabel.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        ]
    }
}

extension SubtitleCellModel {
    static func subtitleCellModelsFrom(items: [Attribute]) -> [RootCellModelType] {
        var itemModels = [SubtitleCellModel]()
        for item in items {
            itemModels.append(SubtitleCellModel(title: item.name, subtitle: item.value))
        }
        return itemModels
    }
}
