import UIKit

final class ImageHeaderView: UIView {
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerImageView)
        NSLayoutConstraint.activate(imageViewConstraints())
        headerImageView.image = UIImage(named: "johnLewis")
    }
    
    private let headerImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .yellow
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private func imageViewConstraints() -> [NSLayoutConstraint] {
        return [
            headerImageView.topAnchor.constraint(equalTo: topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
    }
}
