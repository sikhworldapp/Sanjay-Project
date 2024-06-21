//
//  GridVC.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 19/06/24.
//

import UIKit

class GridVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var arrStudents = [StudentModel]()
    
    var appConstants = AppConstants.shared
    var tappedIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "GridItem", bundle: nil), forCellWithReuseIdentifier: "GridItem")
        arrStudents = appConstants.loadStudentData()
        
        let layout = UICollectionViewFlowLayout()
        let itemSize = (view.frame.width / 2) - 4
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        collectionView.collectionViewLayout = layout
        
        collectionView.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actionAddNewStudent(_ sender: Any) {
        performSegue(withIdentifier: "toAddStudent", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openNext"
        {
            if let vc = segue.destination as? SecondViewController{
                vc.titleString = arrStudents[tappedIndex].name
            }
        }
        else if segue.identifier == "toAddStudent"
        {
            if let vc = segue.destination as? AddStudentVC{
               // Step 1 //  assign Another class's vc
                vc.newStudentModel =  { studentModel in //Step 4
                    self.arrStudents.append(studentModel)
                    self.collectionView.reloadData()
                    
                }
            }
        }
    }
}

extension GridVC: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrStudents.count
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 180, height: 180
//        )
//    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tappedIndex = indexPath.row
        performSegue(withIdentifier: "openNext", sender: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridItem", for: indexPath) as? GridItem
        cell?.lblContent.text = arrStudents[indexPath.row].name
        cell?.imgLogo.image = UIImage(named: "calendar")
        return cell ?? UICollectionViewCell()
        
    }
    
    
}
