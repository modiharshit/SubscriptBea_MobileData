//
//  HomeVC+Services.swift
//  SubscriptBea
//
//  Created by Harshit on 08/12/21.
//  Copyright © 2021 Harshit Modi. All rights reserved.
//

import UIKit
import Alamofire

extension HomeVC {
    
    //    func getMySubscriptions() {
    //      // 1
    //      let request = AF.request("https://swapi.dev/api/films")
    //      // 2
    //      request.responseJSON { (data) in
    //        print(data)
    //      }
    //    }
    
    func getMySubscriptions() {
        let headers = [
            "x-rapidapi-host": "ott-details.p.rapidapi.com",
            "x-rapidapi-key": "52ade344f5mshe1ac642310998c2p110980jsnbe2961739535"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://ott-details.p.rapidapi.com/getPlatforms?region=IN")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
            }
        })

        dataTask.resume()
    }
    
}

