//
//  PeopleViewModel.swift
//  CobaUIKit
//
//  Created by Renaldi Antonio on 15/08/24.
//

import Foundation

protocol PeopleViewModelDelegate: AnyObject {
    func didFinish()
    func didFail(error: Error)
}

class PeopleViewModel {
    
    private(set) var people = [PersonResponse]()
    
    weak var delegate: PeopleViewModelDelegate?
    
    @MainActor
    func getUser(){
        Task { [weak self] in
            do{
                let url = URL(string: "https://reqres.in/api/users")!
                let (data, _) = try await URLSession.shared.data(from: url)
                
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                
                self?.people = try jsonDecoder.decode(UsersResponse.self, from: data).data
                self?.delegate?.didFinish()
            } catch {
                self?.delegate?.didFail(error: error)
            }
        }
    }
}
