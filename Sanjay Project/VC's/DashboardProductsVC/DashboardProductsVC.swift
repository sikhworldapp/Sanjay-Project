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
        tableView.register(UINib(nibName: "HeaderViewCell", bundle: nil), forCellReuseIdentifier: "HeaderViewCell")
        tableView.sectionHeaderHeight = 70
        
    }
    
    @IBAction func actionAddNewStudent(_ sender: Any) {
        performSegue(withIdentifier: "toAddNewProduct", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "toAddNewProduct"
        {
            if let vc = segue.destination as? ChooseProductVC{
               // Step 1 //  assign Another class's vc
                vc.newProductAdded =  { productModel in //Step 4
                    self.arrSelectedProducts.append(MainProductModel(id: productModel.id, selectedProduct: productModel))
                    
                }
                
                
            }
        }
        else  if segue.identifier == "toEditProduct"
        {
            
            if let index = sender as? Int {
                print("getting index: \(index)")
                
                if let vc = segue.destination as? ChooseProductVC
                {
                    vc.editableProductModel = arrSelectedProducts[index].selectedProduct
                    vc.tappedIndex = index
                    vc.sameProductEdited =  { productModel in //Step 4
                        
                        self.arrSelectedProducts[index] = MainProductModel(id: productModel.id, selectedProduct: productModel)

                        
                    }
                }
                
                
            }
            else
            {
                print("index sender is nil")
            }
        }
    }
}

extension DashboardProductsVC : UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductMainCell", for: indexPath) as? ProductMainCell
        
        cell?.lblName.text = "\(arrSelectedProducts[indexPath.row].selectedProduct.pName)"
        
        cell?.lblQuantity.text = "\(arrSelectedProducts[indexPath.row].selectedProduct.qty ?? 0)"
        
        cell?.lblRate.text = "$\(arrSelectedProducts[indexPath.row].selectedProduct.price)"
        
        cell?.lblUnit.text = "\(arrSelectedProducts[indexPath.row].selectedProduct.inStock)"
        
        cell?.lblAmount.text = "$\(arrSelectedProducts[indexPath.row].selectedProduct.amount ?? 0)"
        
        cell?.btnEditTapped =
        {
            print("called \(indexPath.row)")
            self.performSegue(withIdentifier: "toEditProduct", sender: indexPath.row)
        }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           let headerView = UIView()
           let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderViewCell") as! HeaderViewCell
           
           // Set the frame for the header cell to match the header view
           headerCell.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 44) // Adjust the height as needed
           
           // Add header cell to header view
           headerView.addSubview(headerCell)
           
           return headerView
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSelectedProducts.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped: \(indexPath.row)")
       
    }
}

