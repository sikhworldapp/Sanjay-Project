//
//  DashboardProductsVC.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 07/07/24.
//


import UIKit

class DashboardProductsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var arrSelectedProducts = [MainProductModel]()
    {
        didSet{
            tableView.reloadData()
        }
    }
    
    var appConstants = AppConstants.shared
    var tappedIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         tableView.register(UINib(nibName: "ProductMainCell", bundle: nil), forCellReuseIdentifier: "ProductMainCell")
    }
    
    @IBAction func actionAddNewStudent(_ sender: Any) {
        performSegue(withIdentifier: "toAddNewProduct", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "toAddNewProduct"
        {
            if let vc = segue.destination as? ChooseProductVC{
               // Step 1 //  assign Another class's vc
                vc.newProductAdded =  { studentModel in //Step 4
                    self.arrSelectedProducts.append(MainProductModel(id: studentModel.id, selectedProduct: studentModel))
                    
                }
            }
        }
    }
}

extension DashboardProductsVC : UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductMainCell", for: indexPath) as? ProductMainCell
        cell?.imgProduct.image = UIImage(named: "calendar")!
        cell?.lblName.text = "\(arrSelectedProducts[indexPath.row].selectedProduct.pName) \(indexPath.row)"
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSelectedProducts.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped: \(indexPath.row)")
       
    }
}

