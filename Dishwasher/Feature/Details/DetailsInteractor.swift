import Foundation

protocol DetailsInteractorDelegate: AnyObject {
    func didLoadDetails(jsonResponse: [String: AnyObject])
}

protocol DetailsInteractorType {
    func loadDetailsData()
    var delegate: DetailsInteractorDelegate? { get set }
}

final class DetailsInteractor: DetailsInteractorType {
    
    weak var delegate: DetailsInteractorDelegate?
    let apiHandler: APIHandlerType
    
    init(apiHandler: APIHandlerType) {
        self.apiHandler = apiHandler
    }
    
    func loadDetailsData() {
        apiHandler.getDetailsViewData(success: { [weak self] data in
            guard let `self` = self else { return }
            self.handleDetailsAPISuccess(responseData: data)
        }) { [weak self] error in
            guard let `self` = self else { return }
            self.handleDetailsAPIError(error: error)
        }
    }
    
    private func proceedToFeedback(jsonResponse: [String: AnyObject]) {
        delegate?.didLoadDetails(jsonResponse: jsonResponse)
    }
}

private extension DetailsInteractor {
    
    private func handleDetailsAPIError(error: Error) {
        print("Failed to Load Details Data: \(error.localizedDescription)")
    }
    
    private func handleDetailsAPISuccess(responseData: Data) {
        do { let rootJson = try JSONSerialization.jsonObject(with: responseData, options: []) as! [String: AnyObject]
            proceedToFeedback(jsonResponse: rootJson)
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
}
