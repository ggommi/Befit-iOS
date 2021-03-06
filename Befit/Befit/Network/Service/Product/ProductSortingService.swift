//
//  ProductSortingService.swift
//  Befit
//
//  Created by 박다영 on 10/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import Foundation
import Alamofire


struct ProductSortingService : APIManager, Requestable{
    
    let userDefault = UserDefaults.standard
    typealias NetworkData = ResponseArray<Product>
    static let shared = ProductSortingService()
    
    let baseURL = url("/products")

    
    // 브랜드 상품 신상품순
    func showSortingNew(brandIdx: Int, completion: @escaping ([Product]) -> Void) {
        
        let URL = baseURL + "/new/brand/" + "\(brandIdx)"
        
        let headers: HTTPHeaders = [
            "Authorization" : UserDefaults.standard.string(forKey: "token")!
        ]
        
        gettable(URL, body: nil, header: headers) { res in
            switch res {
                
            case .success(let value):
                guard let data = value.data else {return}
                completion(data)
            case .error(let error):
                print(error)
            }
        }
        
    }
    
    // 브랜드 상품 인기순
    func showSortingPopular(brandIdx: Int, completion: @escaping ([Product]) -> Void) {
        
        let URL = baseURL + "/popular/brand/" + "\(brandIdx)"
        
        let headers: HTTPHeaders = [
            "Authorization" : UserDefaults.standard.string(forKey: "token")!
        ]
        
        gettable(URL, body: nil, header: headers) { res in
            switch res {
                
            case .success(let value):
                guard let data = value.data else {return}
                completion(data)
                
            case .error(let error):
                print("Error = \(error)")
            }
        }
        
    }
    
    
    // 카테고리 상품 신상품순
    func showSortingNewCategory (categoryIdx: Int, gender: String, completion: @escaping ([Product]) -> Void) {
        
        let URL = baseURL + "/new/category/" + "\(categoryIdx)" + "?gender=" + gender
        
        let headers: HTTPHeaders = [
            "Authorization" : UserDefaults.standard.string(forKey: "token")!
        ]
        
        gettable(URL, body: nil, header: headers) { res in
            switch res {
                
            case .success(let value):
                guard let data = value.data else {return}
                completion(data)
            case .error(let error):
                print(error)
            }
        }
        
    }
    
    // 카테고리 상품 인기순
    func showSortingPopularCategory (categoryIdx: Int, gender: String, completion: @escaping ([Product]) -> Void) {
        
        let URL = baseURL + "/popular/category/" + "\(categoryIdx)" + "?gender=" + gender
        
        let headers: HTTPHeaders = [
            "Authorization" : UserDefaults.standard.string(forKey: "token")!
        ]
        
        gettable(URL, body: nil, header: headers) { res in
            switch res {
                
            case .success(let value):
                guard let data = value.data else {return}
                completion(data)
            case .error(let error):
                print(error)
            }
        }
        
    }
    
    
}
