//
//  CompaniesTableViewController.swift
//  Companies
//
//  Created by CS3714 on 10/16/16.
//  Copyright © 2016 Jesus Fabian. All rights reserved.
//

import UIKit

class CompaniesTableViewController: UITableViewController, UISearchResultsUpdating {

    
    var searchResults = [String]()
    
    var searchResultsController = UISearchController()
    
    
    
    //////
    
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
        
        
        
        ///////
        
          createSearchResultsController()
        
        
        
        
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
        
        return searchResultsController.isActive ? searchResults.count : companyNames.count
        
        
        
//        return companyNames.count
    }
    
    
    
    func updateSearchResults(for searchController: UISearchController)
        
    {
        
        // Empty the instance variable searchResults array without keeping its capacity
        
        searchResults.removeAll(keepingCapacity: false)
        
        
        
        // Set searchPredicate to search for any character(s) the user enters into the search bar.
        
        // [c] indicates that the search is case insensitive.
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        
        
        
        // Obtain the country names that contain the character(s) the user types into the Search Bar.
        
        let listOfCountryNamesFound = (companyNames as NSArray).filtered(using: searchPredicate)
        
        
        
        // Obtain the search results as an array of type String
        
        searchResults = listOfCountryNamesFound as! [String]
        
        
        
        // Reload the table view to display the search results
        
        self.tableView.reloadData()
        
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
    
    
    /*
     
     ---------------------------------------------
     
     MARK: - Creation of Search Results Controller
     
     ---------------------------------------------
     
     */
    
    func createSearchResultsController() {
        
        /*
         
         Instantiate a UISearchController object and store its object reference into local variable: controller.
         
         Setting the parameter searchResultsController to nil implies that the search results will be displayed
         
         in the same view used for searching (under the same UITableViewController object).
         
         */
        
        let controller = UISearchController(searchResultsController: nil)
        
        
        
        /*
         
         We use the same table view controller (self) to also display the search results. Therefore,
         
         set self to be the object responsible for listing and updating the search results.
         
         Note that we made self to conform to UISearchResultsUpdating protocol.
         
         */
        
        controller.searchResultsUpdater = self
        
        
        
        /*
         
         The property dimsBackgroundDuringPresentation determines if the underlying content is dimmed during
         
         presentation. We set this property to false since we are presenting the search results in the same
         
         view that is used for searching. The "false" option displays the search results without dimming.
         
         */
        
        controller.dimsBackgroundDuringPresentation = false
        
        
        
        // Resize the search bar object based on screen size and device orientation.
        
        controller.searchBar.sizeToFit()
        
        
        
        /***************************************************************************
         
         No need to create the search bar in the Interface Builder (storyboard file).
         
         The statement below creates it at runtime.
         
         ***************************************************************************/
        
        
        
        // Set the tableHeaderView's accessory view displayed above the table view to display the search bar.
        
        self.tableView.tableHeaderView = controller.searchBar
        
        
        
        /*
         
         Set self (Table View Controller) define the presentation context so that the Search Bar subview
         
         does not show up on top of the view (scene) displayed by a downstream view controller.
         
         */
        
        self.definesPresentationContext = true
        
        
        
        /*
         
         Set the object reference (controller) of the newly created and dressed up UISearchController
         
         object to be the value of the instance variable searchResultsController.
         
         */
        
        searchResultsController = controller
        
    }
    
    
    
    
    
   
}
