//
//  TableXibWala.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 07/06/24.
//

import UIKit

class TableXibWala: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var arrFrnds = [CellModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrFrnds.append(CellModel(name: "Sanjay", img: UIImage(named: "calendar")!, favStatus: false, isAddedAsFrnd: false))
        arrFrnds.append(CellModel(name: "Aman", img: UIImage(named: "calendar")!, favStatus: false, isAddedAsFrnd: false))
        arrFrnds.append(CellModel(name: "Rahul", img: UIImage(named: "calendar")!, favStatus: false, isAddedAsFrnd: false))
        
        //registerNib
        tableView.register(UINib(nibName: "HeavyCell", bundle: nil), forCellReuseIdentifier: "HeavyCell")
    }
    

}

extension TableXibWala: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeavyCell", for: indexPath) as? HeavyCell
        cell?.lblUserName.text = arrFrnds[indexPath.row].name
        cell?.imgUserProfile.image = arrFrnds[indexPath.row].img
        
        if arrFrnds[indexPath.row].favStatus
        {
            cell?.imgFavorite.image =  UIImage(systemName: "heart.fill")
        }
        else
        {
            cell?.imgFavorite.image = UIImage(systemName: "heart")
        }
        
        let tagGestureFavImg = UITapGestureRecognizer(target: self, action: #selector(tappedFavButton))
        let tagGestureBtnFav = UITapGestureRecognizer(target: self, action: #selector(tappedBtnAddFrnd(_:)))

        cell?.imgFavorite.isUserInteractionEnabled = true
        cell?.imgFavorite.tag = indexPath.row
        cell?.btnAddFrnd.tag = indexPath.row
        
        
        cell?.imgFavorite.addGestureRecognizer(tagGestureFavImg)
        cell?.btnAddFrnd.addGestureRecognizer(tagGestureBtnFav)
       
       
        return cell ?? UITableViewCell()
    }
    
    @objc func tappedFavButton(_ sender:AnyObject){
         print("you tap image number: \(sender.view.tag)")
        let whichOneTappedIndex = sender.view.tag
        arrFrnds[whichOneTappedIndex].favStatus = !arrFrnds[whichOneTappedIndex].favStatus
        
        let indexPath = IndexPath(item: whichOneTappedIndex, section: 0)
        tableView.reloadRows(at: [indexPath], with: .none)
        //tableView.reloadData()
        
    }
    
    @objc func tappedBtnAddFrnd(_ sender:AnyObject){
         print("you tap image number: \(sender.view.tag)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFrnds.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

struct CellModel
{
    var name: String
    var img: UIImage
    var favStatus: Bool
    var isAddedAsFrnd: Bool
}
