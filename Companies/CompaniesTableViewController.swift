//
//  CompaniesTableViewController.swift
//  Companies
//
//  Created by CS3714 on 10/16/16.
//  Copyright © 2016 Jesus Fabian. All rights reserved.
//

import UIKit

class CompaniesTableViewController: UITableViewController {

    let tableViewRowHeight: CGFloat = 60.0
    
    
    
    // Alternate table view rows have a background color of MintCream or OldLace for clarity of display
    
    
    
    // Define MintCream color: #F5FFFA  245,255,250
    
    let MINT_CREAM = UIColor(red: 245.0/255.0, green: 255.0/255.0, blue: 250.0/255.0, alpha: 1.0)
    
    
    
    // Define OldLace color: #FDF5E6   253,245,230
    
    let OLD_LACE = UIColor(red: 253.0/255.0, green: 245.0/255.0, blue: 230.0/255.0, alpha: 1.0)
    
    
    var dict1 = [String: AnyObject]()
    var companyNames = [String]()
    var companyData = [String]()
    
    var dataToPass = [String]()
    
    var companyNameForWeb = String()
    
    
    //try to pass the following 

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let companiesPlistURL : URL? = Bundle.main.url(forResource: "CompanyData", withExtension: "plist")
        let dictionaryFromFile : NSDictionary? = NSDictionary(contentsOf: companiesPlistURL!)
        if let dictionaryForCompaniesPListFile = dictionaryFromFile {
            dict1 = dictionaryForCompaniesPListFile as! Dictionary
            companyNames = dictionaryForCompaniesPListFile.allKeys as! [String]
            companyNames.sort{$0 < $1}
        }
        
        
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return companyNames.count
    }
    
    ///loads table view
    
    override func  tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rowNumber: Int = (indexPath as NSIndexPath).row
        
        let cell: CompaniesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CompaniesCellType") as! CompaniesTableViewCell
        
        let companyName: String = companyNames[rowNumber]
        cell.companyNameLabel!.text = companyName
        companyNameForWeb = companyName
        
        
        let companyDataArray: AnyObject? = dict1[companyName]
        companyData = companyDataArray! as! [String]
        
    
        let logoFileName = companyData[0]
        cell.companyImageView!.image = UIImage(named: logoFileName)
        
        let companyCode: String  = companyData[3]
        cell.companyCodeLabel!.text = companyCode
        
        let companyCityLocation: String = companyData[2]
        cell.companyCityLabel!.text = companyCityLocation
        
        return cell
        
    }
    
    // informs table view delegate that row is selected
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let rowNumber: Int = (indexPath as NSIndexPath).row
        
        let companyName: String = companyNames[rowNumber]
        
        let companyDataArray: AnyObject? = dict1[companyName]
       
        companyData = companyDataArray! as! [String]
        

        
        companyData.append(companyName)
        performSegue(withIdentifier: "CompanyScrollView", sender: self)
        
    }
    
    /// detail was tapped
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let rowNumber: Int = (indexPath as NSIndexPath).row
        let companyName: String = companyNames[rowNumber]
        let companyDataArray: AnyObject? = dict1[companyName]
        companyData = companyDataArray! as! [String]
        performSegue(withIdentifier: "CompanySitesFromScroll", sender: self)

    }
    
    
    // prepares for segue
   
    override func prepare(for segue:UIStoryboardSegue, sender: Any?){
        if segue.identifier == "CompanyScrollView" {
            let companyScrollView: CompaniesSrollViewController = segue.destination as! CompaniesSrollViewController
            companyScrollView.dataPassed = self.companyData
        }
        else {
            let companyWebViewController = segue.destination as! CompaniesWebViewController
            companyWebViewController.companyName.title = companyNameForWeb
            companyWebViewController.companyURL = URL(string: companyData[10])
        }
    }
    
    /*
     
     Informs the table view delegate that the table view is about to display a cell for a particular row.
     
     Just before the cell is displayed, we change the cell's background color as MINT_CREAM for even-numbered rows
     
     and OLD_LACE for odd-numbered rows to improve the table view's readability.
     
     */
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        /*
         
         The remainder operator (RowNumber % 2) computes how many multiples of 2 will fit inside RowNumber
         
         and returns the value, either 0 or 1, that is left over (known as the remainder).
         
         Remainder 0 implies even-numbered rows; Remainder 1 implies odd-numbered rows.
         
         */
        
        if (indexPath as NSIndexPath).row % 2 == 0 {
            
            // Set even-numbered row's background color to MintCream, #F5FFFA 245,255,250
            
            cell.backgroundColor = MINT_CREAM
            
            
            
        } else {
            
            // Set odd-numbered row's background color to OldLace, #FDF5E6 253,245,230
            
            cell.backgroundColor = OLD_LACE
            
        }
        
    }
    
    
   
}
