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
    
    func getMySubscriptions() {
      // 1
      let request = AF.request("https://swapi.dev/api/films")
      // 2
      request.responseJSON { (data) in
        print(data)
      }
    }
}

