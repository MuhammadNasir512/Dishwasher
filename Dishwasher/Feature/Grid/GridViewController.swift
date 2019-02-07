import UIKit

let titleString = "Dishwashers"

protocol GridViewControllerType {
    func didLoadGridData(items: [ItemCellModel])
    func didSelectItem(item: ItemCellModel)
}

final class GridViewController: UIViewController, GridViewControllerType {

    @IBOutlet weak var collectionView: UICollectionView!
    var presenter: GridPresenter?
    var dataSource: GridDataSource?
    var items = [ItemCellModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        presenter?.startLoadingData()
    }
    
    func didLoadGridData(items: [ItemCellModel]) {
        dataSource?.items = items
        collectionView.reloadData()
        
        // TODO: *** Get title from API response ***
        self.title = "\(titleString) (\(items.count))"
    }
    
    func didSelectItem(item: ItemCellModel) {
        presenter?.didSelectItem(item: item)
    }

    private func setupCollectionView() {
        collectionView.delegate = dataSource
        collectionView.dataSource = dataSource
        let cellName = String(describing: ItemCell.classForCoder())
        collectionView.register(UINib(nibName: cellName, bundle: Bundle.main), forCellWithReuseIdentifier: cellName)
    }
}
