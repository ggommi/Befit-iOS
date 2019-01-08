//
//  LikeProductServicew.swift
//  Befit
//
//  Created by 이충신 on 06/01/2019.
//  Copyright © 2019 GGOMMI. All rights reserved.
//

import Alamofire

struct LikeProductService: APIManager, Requestable{
    
    typealias NetworkData = ResponseArray<Product>
    static let shared = LikeProductService()
    
    let URL = url("/likes/products")
    
    let headers: HTTPHeaders = [
        "Authorization" : UserDefaults.standard.string(forKey: "token")!
    ]
    
    //좋아요한 상품 보여주기
    func showProductLike(completion: @escaping ([Product]) -> Void) {
        
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