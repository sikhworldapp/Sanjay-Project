//
//  DashboardProductsVC.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 07/07/24.
//


import UIKit

class DashboardProductsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    
    var arrSelectedProducts = [MainProductModel]()
    {
        didSet{
            var totalQuan = 0
            var totalAmount = 0.0
            for i in arrSelectedProducts
            {
                totalQuan += i.selectedProduct.qty ?? 0
                totalAmount += i.selectedProduct.amount ?? 0.0
            }
            lblAmount.text = totalAmount.description
            lblQuantity.text = totalQuan.description
            tableView.reloadData()
        }
    }
    
    var appConstants = AppConstants.shared
    var tappedIndex = 0
    
    @IBAction func actionAddDiscount(_ sender: Any) {
        print("to add discount")
        
        performSegue(withIdentifier: "toAddDiscount", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         tableView.register(UINib(nibName: "ProductMainCell", bundle: nil), forCellReuseIdentifier: "ProductMainCell")
        tableView.register(UINib(nibName: "HeaderViewCell", bundle: nil), forCellReuseIdentifier: "HeaderViewCell")
        tableView.sectionHeaderHeight = 80
        
       // tableView.estimatedRowHeight = 200 // Set an estimated row height
        tableView.rowHeight = UITableView.automaticDimension
        
        lblQuantity.text = "--"
        lblAmount.text = "--"

        
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
                    self.arrSelectedProducts.append(MainProductModel(id: productModel.id ?? 0, selectedProduct: productModel))
                    
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
                        
                        self.arrSelectedProducts[index] = MainProductModel(id: productModel.id ?? 0, selectedProduct: productModel)

                        
                    }
                }
                
                
            }
            else
            {
                print("index sender is nil")
            }
        }
        else  if segue.identifier == "toAddDiscount"
        {
            
            if let vc = segue.destination as? AddDiscountVC
            {
                var amountDouble = Double(lblAmount.text ?? "0.0") ?? 0.0
                vc.totalAmount = (amountDouble * 10 ) / 100
                vc.ledgerApplied =  { ledgerModel in
                    
                   print("ledger applied: \(ledgerModel as Any)")
                    var ledgerModelInProductModel =
                    ProductModel(id: 0, modelType: TypeItem.ledger, ledgerType: ledgerModel,
                                 pName: ledgerModel.ledgerType,
                                 qty: 0,
                                 amount: ledgerModel.amount,
                                 price: 0,
                                 inStock: 0,
                                 addedByCustomer: 0)
                    
                    self.arrSelectedProducts.append(MainProductModel(id: 0, selectedProduct: ledgerModelInProductModel))
                    self.tableView.reloadData()
                    
                }
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
        
        cell?.btnDeleteTapped =
        { [self] in
            print("called \(indexPath.row)")
            arrSelectedProducts.remove(at: indexPath.row)
            tableView.reloadData()
            
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
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped: \(indexPath.row)")
       
    }
}

