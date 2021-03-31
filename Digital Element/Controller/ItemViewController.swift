//
//  IthemViewController.swift
//  Digital Element
//
//  Created by Анастасия Ларина on 25.03.2021.
//

import UIKit
import Foundation
import Alamofire

class ItemViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var item = [Items]()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        DispatchQueue.main.asyncAfter (deadline: .now() + 2) {
        //            self.getItemWithURLSession()
        //        }
        
        DispatchQueue.main.asyncAfter (deadline: .now() + 2) {
            self.getItemWithAlamofire()
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        collectionView.setCollectionViewLayout(layout, animated: true)
        
    }
    
    func getItemWithURLSession() {
        guard let url = URL(string: "https://d-element.ru/test_api.php")
        else { return }
        let session = URLSession.shared
        activityIndicator.startAnimating()
        let task = session.dataTask(with: url) { (data, responce, error) in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
            
            if let safeData = data {
                self.parseJSON(itemData: safeData)
//                let json = try? JSONSerialization.jsonObject(with: data, options: [])
//                print(json)
            }
        }
        task.resume()
    }
    
    func parseJSON(itemData: Data) {
        let decoder = JSONDecoder()
        do {
        let decodeData = try decoder.decode(Item.self, from: itemData)
            print(decodeData.items[0].article)
        } catch  {
            print(error)
        }
        }
    
    
    func getItemWithAlamofire() {
        let urlPath = "https://d-element.ru/test_api.php"
        AF.request(urlPath).responseJSON { (response) in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
            print(response.value)
        }
    }
    
    
    // MARK: - Collection View
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ItemCell
        
        // разделение разрядов
        let number = 2665199
        func separatedNumber(_ number: Any) -> String {
            guard let itIsANumber = number as? NSNumber else { return "Not a number" }
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.groupingSeparator = " "
            formatter.decimalSeparator = ","
            return formatter.string(from: itIsANumber)!
        }
        
        cell.imageItemView.layer.cornerRadius = 10.0
        cell.articleItemLabel.text = "1345268"
        cell.nameItemLabel.text = "Рубашка белая, из вискозы, 44"
        cell.priceItemLamel.text = separatedNumber(number)
        // cell.priceItemLamel.text = String(format: "%.2f", separatedNumber(number))
        // два числа после запятой
        cell.currencyLabel.text = "руб."
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
        //here your custom value for spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        
        return CGSize(width:widthPerItem, height:367)
        
    }
    
}



