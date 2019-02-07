import UIKit

protocol APIHandlerType {
    func getGridViewData(success: @escaping (Data) -> (), failure: @escaping (Error) -> ())
    func getDetailsViewData(success: @escaping (Data) -> (), failure: @escaping (Error) -> ())
}

final class APIHandler: APIHandlerType {
    
    let urlString: String
    init(urlString: String) {
        self.urlString = urlString
    }
    
    func getData(success: @escaping (Data) -> (), failure: @escaping (Error) -> ()) {
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: "URLError", code: 99, userInfo: nil) as Error
            failure(error)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let error = error else {
                    let dataToSend = data ?? Data()
                    success(dataToSend)
                    return
                }
                failure(error)
            }
        }
        task.resume()
    }
}

extension APIHandler {
    
    func getGridViewData(success: @escaping (Data) -> (), failure: @escaping (Error) -> ()) {
        getData(success: success, failure: failure)
    }
    
    func getDetailsViewData(success: @escaping (Data) -> (), failure: @escaping (Error) -> ()) {
        getData(success: success, failure: failure)
    }
}

extension UIImage {
    
    static func downloaded(from url: URL, callback: @escaping (UIImage?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    callback(nil)
                    return
            }
            DispatchQueue.main.async() {
                callback(image)
            }
            }.resume()
    }
    
    static func downloaded(from link: String, callback: @escaping (UIImage?) -> ()) {
        guard let url = URL(string: link) else {
            callback(nil)
            return
        }
        UIImage.downloaded(from: url) { image in
            DispatchQueue.main.async() {
                callback(image)
            }
        }
    }
}
