import Foundation

protocol GridInteractorDelegate: AnyObject {
    func didLoadGrid(jsonResponse: [String: AnyObject])
}

protocol GridInteractorType {
    func loadGridData()
    var delegate: GridInteractorDelegate? { get set }
}

final class GridInteractor: GridInteractorType {
    
    weak var delegate: GridInteractorDelegate?
    let apiHandler: APIHandlerType
    
    init(apiHandler: APIHandlerType) {
        self.apiHandler = apiHandler
    }
    
    func loadGridData() {
        apiHandler.getGridViewData(success: { [weak self] data in
            guard let `self` = self else { return }
            self.handleGridAPISuccess(responseData: data)
        }) { [weak self] error in
            guard let `self` = self else { return }
            self.handleGridAPIError(error: error)
        }
    }
    
    private func proceedToFeedback(jsonResponse: [String: AnyObject]) {
        delegate?.didLoadGrid(jsonResponse: jsonResponse)
    }
}

private extension GridInteractor {
    
    private func handleGridAPIError(error: Error) {
        print("Failed to Load Grid Data: \(error.localizedDescription)")
    }
    
    private func handleGridAPISuccess(responseData: Data) {
        do { let rootJson = try JSONSerialization.jsonObject(with: responseData, options: []) as! [String: AnyObject]
            proceedToFeedback(jsonResponse: rootJson)
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
}
