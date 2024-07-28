//
//  DashboardProductsVC.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 07/07/24.
//


import UIKit

class DashboardProductsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var lblTotalQuantity: UILabel!
    @IBOutlet weak var lblVat: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var btnDateSelecting: UIButton!
    
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
            lblTotalAmount.text = totalAmount.description
            lblTotalQuantity.text = totalQuan.description
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
        
        lblTotalQuantity.text = "--"
        lblTotalAmount.text = "--"
        
        lblVat.addTapGesture { [self] in
            performSegue(withIdentifier: "toEditVAT", sender: nil)
            //navigateToSecondViewController()
        }
        
        lblDiscount.addTapGesture { [self] in
            performSegue(withIdentifier: "toEditDiscount", sender: nil)
        }
        
       
        updateButtonDateTitle()
    }
    
    private func updateButtonDateTitle() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "  dd/MM/yyyy" // Specify the desired date format
        let formattedDate = dateFormatter.string(from: Date())
        
        btnDateSelecting.setTitle(formattedDate, for: .normal)
    }
    
    func navigateToSecondViewController() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let secondVC = storyboard.instantiateViewController(withIdentifier: "BottomSheetValueEditingVC") as? BottomSheetValueEditingVC {
                secondVC.callBack = { [weak self] firstValue, secondValue in
                   print("getting: \(firstValue), \(secondValue)")
                }
                secondVC.modalPresentationStyle = .formSheet
                navigationController?.pushViewController(secondVC, animated: true)
            } else {
                print("Failed to instantiate SecondViewController from storyboard.")
            }
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
                var amountDouble = Double(lblTotalAmount.text ?? "0.0") ?? 0.0
                vc.totalAmount = (amountDouble * 10 ) / 100
                vc.ledgerApplied =  { ledgerModel in
                    
                   print("ledger applied: \(ledgerModel as Any)")
                    var prodLedgeModel = ProductModel()
                    prodLedgeModel.id = 0
                    prodLedgeModel.ledgerType = ledgerModel
                    prodLedgeModel.pName = ledgerModel.ledgerType
                    prodLedgeModel.amount = ledgerModel.amount
                    prodLedgeModel.price = ledgerModel.amount
                    
                    
                   
                    
                    self.arrSelectedProducts.append(MainProductModel(id: 0, selectedProduct: prodLedgeModel))
                    self.tableView.reloadData()
                    
                }
            }
        }
        else if segue.identifier == "toEditDiscount"
          {
              if let vc = segue.destination as? BottomSheetValueEditingVC{
                  vc.headingString = "Edit Discount"
                 // Step 1 //  assign Another class's vc
                  vc.callBack = { [weak self] firstValue, discountDouble in
                      print("getting: " + firstValue.description + discountDouble.description)
                      self?.lblDiscount.text = discountDouble.description
                      
                      var amountDouble = Double(self?.lblTotalAmount.text ?? "0.0") ?? 0.0
                      self?.lblTotalAmount.text = (amountDouble - (amountDouble / discountDouble)).description
                      vc.dismiss(animated: true)
                  }
                  
              }
          }
        
        else if segue.identifier == "toEditVAT"
          {
              if let vc = segue.destination as? BottomSheetValueEditingVC{
                  vc.headingString = "Edit VAT"
                 // Step 1 //  assign Another class's vc
                  vc.callBack = { [weak self] firstValue, vatDouble in
                      print("getting: " + firstValue.description + vatDouble.description)
                      self?.lblVat.text = vatDouble.description
                      
                      var amountDouble = Double(self?.lblTotalAmount.text ?? "0.0") ?? 0.0
                      self?.lblTotalAmount.text = (amountDouble + (amountDouble / vatDouble)).description
                      vc.dismiss(animated: true)
                  }
                  
                  
              }
          }
    }
    @IBAction func actionChooseDate(_ sender: Any) {
        
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


