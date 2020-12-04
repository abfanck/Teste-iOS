//
//  APIService.swift
//  Teste-iOS
//
//  Created by Arthur Bastos Fanck on 02/12/20.
//

import Foundation
import RxSwift

enum NetworkError: String, Error {
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request."
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
    case noInternet = "Please check your network connection."
}

final class APIService {
    public static let shared = APIService()
    private let baseURL = URL(string: "http://5f5a8f24d44d640016169133.mockapi.io/api")
    
    public func getDataFrom(url: URL) -> Observable<Data> {
        return Observable.create { (observer) in
            DispatchQueue.global(qos: .background).async {
                do {
                    let data = try Data(contentsOf: url)
                    observer.onNext(data)
                    observer.onCompleted()
                } catch {
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    public func getEvent(with id:String, completion: @escaping (Result<Evento,Error>) -> Void) {
        let url = URL(string: "/events/\(id)", relativeTo: baseURL)!
        createDataTask(with: url, dataType: Evento.self) { (result) in
            completion(result)
        }
    }
    
    public func getEvents() -> Observable<[Evento]> {
        return Observable.create { [weak self] (observer) in
            
            self?.getEventList(completion: { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let events):
                        observer.onNext(events)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
            })
            
            return Disposables.create()
        }
    }
    
    private func getEventList(completion: @escaping (Result<[Evento],Error>) -> Void) {
        let url = URL(string: "/events", relativeTo: baseURL)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                
                switch httpResponse.statusCode {
                case 200...299:
                    break
                case 401...500:
                    completion(.failure(NetworkError.authenticationError))
                case 501...599:
                    completion(.failure(NetworkError.badRequest))
                case 600:
                    completion(.failure(NetworkError.outdated))
                default:
                    completion(.failure(NetworkError.failed))
                }
                
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                
                let decodeResult: Result<[Evento],Error> = self.parseData(data)
                switch decodeResult {
                case .success(let events):
                    completion(.success(events))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
    
    private func parseData<DataType: Decodable>(_ data: Data) -> Result<DataType,Error> {
        do {
            let decodedData = try JSONDecoder().decode(DataType.self, from: data)
            return .success(decodedData)
        } catch {
            return .failure(error)
        }
    }
    
    private func createDataTask<ResultType: Decodable>(with url: URL,
                                                       dataType: ResultType.Type,
                                                       completion: @escaping (Result<ResultType,Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                
                switch httpResponse.statusCode {
                case 200...299:
                    break
                case 401...500:
                    completion(.failure(NetworkError.authenticationError))
                case 501...599:
                    completion(.failure(NetworkError.badRequest))
                case 600:
                    completion(.failure(NetworkError.outdated))
                default:
                    completion(.failure(NetworkError.failed))
                }
                
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                
                let decodeResult: Result<ResultType,Error> = self.parseData(data)
                switch decodeResult {
                case .success(let events):
                    completion(.success(events))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
