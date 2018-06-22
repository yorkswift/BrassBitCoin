//
//  API.swift
//  BrassBitCoin
//
//  Created by Saoirse on 22/06/2018.
//  Copyright © 2018 YorkDojo. All rights reserved.
//

import Foundation

public enum httpRequestMethod:String {
    
    case Post = "POST"
    case Get = "GET"
    case Put = "PUT"
    case Delete = "DELETE"
    
}

typealias ClosureType = (_ responseData:Any?) throws -> Void

class API {
    
    let sema = DispatchSemaphore( value: 0)
    
    func makeRequest( method : httpRequestMethod = .Get, url : NSURL, body : Data? = nil, onSuccess successCallback : @escaping ClosureType ){
        
        let headers = ["Accept": "application/json"]
        
        let request = NSMutableURLRequest(url: url as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        if(body != nil){
            request.httpBody = body
        }
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            self.sema.signal();
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            
            do {

                try successCallback(data)
                
            } catch {
                
                print("failed")
                print(error)
                
            }
            
        }
        task.resume()
        sema.wait();
    }
    
    func parseJson<T>(fromRawData rawData: Data, intoCodable codable : T.Type, ifSuccessful successCallback : @escaping ClosureType ) where T : Decodable {
        
        if let debugString = String(data: rawData, encoding: String.Encoding.utf8) {
            print(debugString)
        }
        
        do {
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(codable, from: rawData)
            try successCallback(decoded)
            
        } catch {
            
            print("failed to call success callback")
            print(error)
            
        }
    }
}
