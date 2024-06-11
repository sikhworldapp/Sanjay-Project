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
    var tappedIndex = 0
    var userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let imgFound = UIImage(named: "calendar")//nil coalescing
        {
            arrFrnds.append(CellModel(name: "Sanjay", img: imgFound, favStatus: false, isAddedAsFrnd: false))
        }
        
        arrFrnds.append(CellModel(name: "Aman", img: UIImage(named: "profile")!, favStatus: false, isAddedAsFrnd: false))
        arrFrnds.append(CellModel(name: "Rahul", img: UIImage(named: "profile")!, favStatus: false, isAddedAsFrnd: false))
        
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
        
        if arrFrnds[indexPath.row].favStatus ?? false
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
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        globalModel = arrFrnds[indexPath.row]
        tappedIndex = indexPath.row
        userDefaults.set(arrFrnds[tappedIndex].name, forKey: "NAME")
        
        
        performSegue(withIdentifier: "passDataUsingSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? Home2VC
        {
            vc.name = arrFrnds[tappedIndex].name
            vc.arr = arrFrnds
            //use delegate protocols for backward from destincation to source
//            Step 4
            vc.delegate = self //current class reference.
            vc.modelGot = arrFrnds[tappedIndex]
        }
    }
    
    @objc func tappedFavButton(_ sender:AnyObject){
         print("you tap image number: \(sender.view.tag)")
        let whichOneTappedIndex = sender.view.tag
        arrFrnds[whichOneTappedIndex].favStatus = !arrFrnds[whichOneTappedIndex].favStatus!
        
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

//Step 2
extension TableXibWala: DataDelegate{
    func isReceived(value: Bool) {
        print("getting in isReceived: \(value)")
    }
    
    func sendData(data: String) {
        print("sending in response: \(data)")
    }
    
    func updateArray(arr: [CellModel]) {
        arrFrnds.removeAll()
        arrFrnds.append(contentsOf: arr)
        tableView.reloadData()
    }
    
    
}

class CellModel
{
    var name: String? = ""
    var img: UIImage?
    var favStatus: Bool?
    var isAddedAsFrnd: Bool?
    
    init(name: String? = nil, img: UIImage? = nil, favStatus: Bool? = nil, isAddedAsFrnd: Bool? = nil) {
        self.name = name
        self.img = img
        self.favStatus = favStatus
        self.isAddedAsFrnd = isAddedAsFrnd
    }
}

//Step 1
protocol DataDelegate: AnyObject {
    func sendData(data: String)
    func isReceived(value: Bool)
    func updateArray(arr: [CellModel])
}
