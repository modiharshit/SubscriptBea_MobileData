//
//  HomeVC+Services.swift
//  SubscriptBea
//
//  Created by Harshit on 08/12/21.
//  Copyright © 2021 Harshit Modi. All rights reserved.
//

import UIKit
import ObjectMapper

extension DetailVC {
    
    func getOTTPlatforms() {
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://61b2821ac8d4640017aaf42b.mockapi.io/ottPlatforms")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (resData, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                do {
                    let httpResponse = response as? HTTPURLResponse
                    print(httpResponse)

                    let resDict = try JSONSerialization.jsonObject(with: resData!, options: .allowFragments)
                    print(resDict)
                    
                    DispatchQueue.main.async(execute:{
                        self.parseData(result: resDict as! [[String : Any]])
                    })
                }catch{
                    print(exception())
                }
            }
        })

        dataTask.resume()
    }
    
    func parseData(result:[[String:Any]]) {
        //GET RESPONSE AND MAP IT IN SUBSCRIPTION MODEL
        if let resultData = result as? [[String: Any]] {
            print(resultData)
            for result in resultData {
                if let subscription: Subscription = Mapper<Subscription>().map(JSON: result) {
                    print(result)
                    self.arrOTTPlatforms.append(subscription)
                    self.arrTitles.append(subscription.subscriptionTitle.safeString())
                }
            }
            self.initializeTypeTextField()
        }
    }
}

