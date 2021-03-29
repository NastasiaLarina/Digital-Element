//
//  ItemAPiService.swift
//  Digital Element
//
//  Created by Анастасия Ларина on 27.03.2021.


import Foundation
import Alamofire

class ItemAPIService {

    let baseUrl = "https://d-element.ru/"

    func getItem (name: String) {
        let path = "test_api.php"
        let parametrs: Parameters = [
            "Aen": name

        ]

        let url = baseUrl + path


        AF.request(url, parameters: parametrs).responseJSON { (response) in
            print(response.value ?? "NO JSON")

        }
    }

}
