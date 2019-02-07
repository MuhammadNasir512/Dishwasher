import UIKit

private enum LocalConstants {
    static let landscapeWidthDifference: CGFloat = -400
    static let headerHeight: CGFloat = 300
    static let hidingPixelOffset: CGFloat = 40
    static let fadeAnimationDuration: Double = 1.0
}

protocol DetailsViewControllerType {
    var screenTitle: String { get set }
    func didLoadDetailsData(items: [RootCellModelType])
    func scrollViewScrolled(_ scrollView: UIScrollView)
}

final class DetailsViewController: UIViewController, DetailsViewControllerType {
    
    var dataSource: DetailsDataSource?
    var presenter: DetailsPresenter?
    var trailingConstraint: NSLayoutConstraint?
    
    var screenTitle: String = "" {
        didSet {
            self.title = screenTitle
        }
    }

    lazy var tableView: UITableView = {
        let headerView = ImageHeaderView(frame: .init(x: 0, y: 0, width: 0, height: LocalConstants.headerHeight))
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        tableView.tableHeaderView = headerView
        tableView.register(RootCell.classForCoder(), forCellReuseIdentifier: String(describing: RootCell.classForCoder()))
        tableView.register(SubtitleCell.classForCoder(), forCellReuseIdentifier: String(describing: SubtitleCell.classForCoder()))
        tableView.register(AccessoryCell.classForCoder(), forCellReuseIdentifier: String(describing: AccessoryCell.classForCoder()))
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        dataSource?.viewController = self
        NSLayoutConstraint.activate(layoutConstraintsForTableView())
        presenter?.startLoadingData()
    }
    
    func didLoadDetailsData(items: [RootCellModelType]) {
        dataSource?.cellModels = items
        tableView.reloadData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        trailingConstraint?.constant = view.bounds.size.height < view.bounds.size.width ? LocalConstants.landscapeWidthDifference : 0
    }
}

private extension DetailsViewController {
    private func layoutConstraintsForTableView() -> [NSLayoutConstraint] {
        let leading = tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -200)
        trailingConstraint = leading
        return [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            leading,
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
    }
}

extension DetailsViewController {
    
    func scrollViewScrolled(_ scrollView: UIScrollView) {
        
        guard let navigationController = navigationController else { return }
        let startHidingPoint = LocalConstants.hidingPixelOffset + navigationController.navigationBar.frame.size.height
        let headerBottom = -scrollView.contentOffset.y + LocalConstants.headerHeight
        
        if headerBottom <= startHidingPoint, navigationController.isNavigationBarHidden {
            navigationController.setNavigationBarHidden(false, animated: true)
        }
        else if headerBottom > startHidingPoint, !navigationController.isNavigationBarHidden {
            navigationController.setNavigationBarHidden(true, animated: true)
        }
    }
}
