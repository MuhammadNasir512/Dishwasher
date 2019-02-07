import UIKit

final class GridDataSource: NSObject {
    
    weak var viewController: GridViewController?
    
    private enum LocalConstants {
        static let itemsInLandscape: CGFloat = 4
        static let itemsInPortrait: CGFloat = 3
        static let standardWidth: CGFloat = 800
    }
    
    private static let cellName = String(describing: ItemCell.classForCoder())
    var items = [ItemCellModel]()
}

extension GridDataSource: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        viewController?.didSelectItem(item: item)
    }
}

extension GridDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridDataSource.cellName, for: indexPath) as? ItemCell else { return UICollectionViewCell() }
        let model = items[indexPath.item]
        cell.reload(with: model)
        return cell
    }
}

extension GridDataSource: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.size.width
        let collectionViewHeight = collectionView.bounds.size.height
        let itemsInRow = (collectionViewWidth < LocalConstants.standardWidth) ? LocalConstants.itemsInPortrait : LocalConstants.itemsInLandscape
        let height = (collectionViewHeight > collectionViewWidth ? collectionViewWidth / 2 : collectionViewHeight / 2)
        let width = (collectionViewWidth / itemsInRow) - itemsInRow + 1
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
