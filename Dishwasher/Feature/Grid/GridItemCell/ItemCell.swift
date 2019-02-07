import UIKit

final class ItemCell: UICollectionViewCell {
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var subtitleLabel: UILabel!
    @IBOutlet weak private var iconImageView: UIImageView!
    
    var model: ItemCellModel?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentView.backgroundColor = .white
    }
    
    func reload(with model: ItemCellModel) {
        self.model = model
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        startLoadingImageIfNeeded()
    }
    
    private func startLoadingImageIfNeeded() {
        guard let model = model else { return }
        guard let image = model.image else {
            UIImage.downloaded(from: model.imageUrl) { [weak self] image in
                guard let `self` = self else { return }
                self.iconImageView.image = image
                model.image = image
            }
            return
        }
        iconImageView.image = image
    }
}
