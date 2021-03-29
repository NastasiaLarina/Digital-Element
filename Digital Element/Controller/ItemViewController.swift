//
//  IthemViewController.swift
//  Digital Element
//
//  Created by Анастасия Ларина on 25.03.2021.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

class ItemViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var item = [Items]()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let url = URL(string: "https://d-element.ru/test_api.php")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil {
                do {
                self.item = try JSONDecoder().decode([Items].self, from: data!)
                } catch {
                    print("Parse Error")
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
                
        }.resume()
        
        
        let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical 
            layout.minimumLineSpacing = 5
            layout.minimumInteritemSpacing = 5
            collectionView.setCollectionViewLayout(layout, animated: true)
    
    }
    
    
    // MARK: - Collection View
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ItemCell
        

       // cell.articleItemLabel.text = item[indexPath.row].article?.self
        cell.nameItemLabel.text = item[indexPath.row].name?.capitalized
      //  cell.priceItemLamel.text = item[indexPath.row].price?.self
       // cell.imageItemView.image = item[indexPath.row].image?.self
        cell.imageItemView.contentMode = .scaleAspectFill
        cell.imageItemView.layer.cornerRadius = 10.0
        guard let link = item[indexPath.row].image else { return <#default value#> }
        cell.imageItemView.downloaded(from: link)
    
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



