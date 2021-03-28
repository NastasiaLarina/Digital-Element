//
//  IthemViewController.swift
//  Digital Element
//
//  Created by Анастасия Ларина on 25.03.2021.
//

import UIKit
import Alamofire

class ItemViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var name: String?
    lazy var service = ItemAPIService()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = name
        service.getItem(name: name ?? "")
        
       // activityIndicator.stopAnimating()
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            self.getItemWithURLSessionComponents()
//        }
//        getItemWithURLSessionComponents()
        
        getItemWithAlamofire()
        
        
        let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical //.horizontal
            layout.minimumLineSpacing = 5
            layout.minimumInteritemSpacing = 5
            collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    
    func getItemWithURLSession() {
        guard let url = URL(string: "https://d-element.ru/test_api.php")
        else { return }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
   
            // delete indicator
            // ставим в главный поток блок закгрузку
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
            
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            }
        }
        
        task.resume()
    }
    
    func getItemWithURLSessionComponents() {
        var componets = URLComponents()
        componets.scheme = "https"
        componets.host = "d-element.ru"
        componets.path = "/test_api.php"
        componets.queryItems = [
            URLQueryItem(name: "", value: ""),
            URLQueryItem(name: "", value: ""),
        ]
        
        guard let url = componets.url else { return }
       
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
        // delete indicator, ставим в главный поток блок закгрузку
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
            
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            }
        }
        
        task.resume()
    }
    
    func getItemWithAlamofire() {
        let urlPath = "https://d-element.ru/test_api.php"
        AF.request(urlPath).responseJSON { (response) in
            print(response.value)
            
        }
    }
    
    
    // MARK: - Collection View
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ItemCell
        

        cell.articleItemLabel.text = "459827\(indexPath.row)"
        cell.nameItemLabel.text = "Рубашка белая, из вискозы, 44"
        cell.priceItemLamel.text = "75 руб."
        cell.imageItemView.layer.cornerRadius = 10.0
    
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)//here your custom value for spacing
        }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                let lay = collectionViewLayout as! UICollectionViewFlowLayout
                let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing

    return CGSize(width:widthPerItem, height:367)
   
    }
    
}



