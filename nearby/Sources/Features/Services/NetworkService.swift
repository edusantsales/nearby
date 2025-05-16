import Foundation

class NetworkService {
    private let baseURL = "http://127.0.0.1:3333"
    private let categories = "/categories"
    private let places = "/markets/category/"

    func getCategoriesApi() -> String { return baseURL + categories }

    func getPlacesApi(categoryID: String) -> String {
        return baseURL + places + "\(categoryID)"
    }

    func getData<T: Decodable>(
        from path: String,
        decodeTo type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        getURLSession(from: path) { result in
            do {
                switch result {
                case .success(let data):
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decoded))
                case .failure(let error):
                    print("⚠️ Erro ao retornar os dados: \(error)")
                    completion(.failure(error))
                }
            } catch {
                print("⚠️ Erro ao decodificar JSON: \(error)")
                completion(.failure(error))
            }
        }
    }

    func getData<T>(
        from path: String,
        transformTo: @escaping (Data) -> T?,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        getURLSession(from: path) { result in
            switch result {
            case .success(let data):
                guard let transformTo = transformTo(data) else {
                    let noDataTransform = NSError(
                        domain: "DataTransformError",
                        code: 0,
                        userInfo: [
                            NSLocalizedDescriptionKey: "Dados não transformados"
                        ]
                    )
                    completion(.failure(noDataTransform))
                    return
                }
                completion(.success(transformTo))
            case .failure(let error):
                print("⚠️ Erro ao retornar os dados: \(error)")
                completion(.failure(error))
            }
        }
    }

    private func getURLSession(
        from path: String,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        var retryCount = 2

        guard let url = URL(string: path) else {
            let invalidUrlError = NSError(
                domain: "InvalidURL",
                code: 0,
            )
            print("⚠️ Erro de url: \(invalidUrlError.localizedDescription)")
            completion(.failure(invalidUrlError))
            return
        }

        print("🌐 Requisição para: \(url.absoluteString)")

        let task = URLSession.shared.dataTask(with: url) {
            data,
            response,
            error in
            if let error = error {
                print("⚠️ Erro de rede: \(error.localizedDescription)")
                if retryCount > 0 {
                    print("🔁 Tentando novamente... (\(retryCount) restante(s))")
                    retryCount = retryCount - 1
                    self.getURLSession(
                        from: path,
                        completion: completion
                    )
                } else {
                    completion(.failure(error))
                }
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                let noResponseError = NSError(
                    domain: "InvalidResponse",
                    code: 0,
                    userInfo: [NSLocalizedDescriptionKey: "Resposta inválida"]
                )
                completion(.failure(noResponseError))
                return
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                print("🚫 Status HTTP inválido: \(httpResponse.statusCode)")
                let statusError = NSError(
                    domain: "HttpStatusError",
                    code: httpResponse.statusCode,
                    userInfo: [
                        NSLocalizedDescriptionKey:
                            "Erro HTTP: \(httpResponse.statusCode)"
                    ]
                )
                completion(.failure(statusError))
                return
            }

            guard let data = data else {
                let noDataError = NSError(
                    domain: "DataNotFoundError",
                    code: 0,
                    userInfo: [
                        NSLocalizedDescriptionKey: "Dados não encontrados"
                    ]
                )
                completion(.failure(noDataError))
                return
            }

            do {
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            } catch {
                print("⚠️ Erro ao obter os dados: \(error)")
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
