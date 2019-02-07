import UIKit

final class DetailsDataSource: NSObject {
    var cellModels = [RootCellModelType]()
    weak var viewController: DetailsViewController?
    private static let cellName = String(describing: ItemCell.classForCoder())
}

extension DetailsDataSource: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        viewController?.scrollViewScrolled(scrollView)
    }
}

extension DetailsDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = cellModels[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.cellId()) as? RootCell else {
            return UITableViewCell()
        }
        cell.reload(with: cellModel)
        return cell
    }
}
