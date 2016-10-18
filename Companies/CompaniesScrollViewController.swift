//
//  CompaniesSrollViewController.swift
//  Companies
//
//  Created by CS3714 on 10/16/16.
//  Copyright © 2016 Jesus Fabian. All rights reserved.
//

import UIKit

class CompaniesSrollViewController: UIViewController {

   
    @IBOutlet var companyNameLabel: UILabel!
    
    @IBOutlet var companyLogo: UIImageView!
    
    @IBOutlet var companyAddressButton: UIButton!
    
    @IBOutlet var companyPhoneButton: UIButton!
    
    @IBOutlet var companyEmailButton: UIButton!
    
    @IBOutlet var companyWebsiteButton: UIButton!
    
    @IBOutlet var companyJobsButton: UIButton!
    
    @IBOutlet var companyAboutButton: UIButton!
    
    @IBOutlet var companyWikiButton: UIButton!
    
    @IBOutlet var companyNameNavItem: UINavigationItem!
    
    
    
    var dataPassed = [String]()
    
    var companyURLToPass: URL?
    
    var companyAddress: String?
    
 
    @IBAction func goToCompanyWebsite(_ sender: UIButton) {
        companyURLToPass = URL(string :dataPassed[7])
        performSegue(withIdentifier: "CompanySites", sender: self)
    }
   
    
    @IBAction func goToCompanyJobsWebsite(_ sender: UIButton) {
        companyURLToPass = URL(string: dataPassed[8])
        performSegue(withIdentifier: "CompanySites", sender: self)
       

    }


    @IBAction func goToCompanyAboutWebsite(_ sender: UIButton) {
        companyURLToPass = URL(string: dataPassed[9])
        performSegue(withIdentifier: "CompanySites", sender: self)

    }
    
    
    @IBAction func goToCompanyWikiWebsite(_ sender: UIButton) {
        companyURLToPass = URL(string: dataPassed[10])
        performSegue(withIdentifier: "CompanySites", sender: self)

    }
    
    @IBAction func goToMap(_ sender: UIButton) {
       performSegue(withIdentifier: "CompanyLocationMapView", sender: self)
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.title = dataPassed[0]
        
        companyNameNavItem.title = dataPassed[11]
        companyNameLabel.text = dataPassed[11]

        
        companyLogo.image = UIImage(named: dataPassed[0])
        
        companyAddress = dataPassed[1] + "," + dataPassed[2] + ", " + dataPassed[3] + " " + dataPassed[4]
        
        companyAddressButton.setTitle(companyAddress, for: .normal)
        
        companyPhoneButton.setTitle(dataPassed[5], for: .normal)
        companyEmailButton.setTitle(dataPassed[6], for: .normal)
        companyWebsiteButton.setTitle(dataPassed[7], for: .normal)
        companyJobsButton.setTitle(dataPassed[8], for: .normal)
        companyAboutButton.setTitle(dataPassed[9], for: .normal)
        companyWikiButton.setTitle(dataPassed[10], for: .normal)

        // Do any additional setup after loading the view.
        
        
        companyAddressButton.backgroundColor = UIColor.clear
        
        companyAddressButton.layer.cornerRadius = 15
        
        companyAddressButton.layer.borderWidth = 1
        
        companyAddressButton.layer.borderColor = UIColor.blue.cgColor
        
        
        companyWebsiteButton.backgroundColor = UIColor.clear
        
        companyWebsiteButton.layer.cornerRadius = 15
        
        companyWebsiteButton.layer.borderWidth = 1
        
        companyWebsiteButton.layer.borderColor = UIColor.blue.cgColor
        
        
        
        companyJobsButton.backgroundColor = UIColor.clear
        
        companyJobsButton.layer.cornerRadius = 15
        
        companyJobsButton.layer.borderWidth = 1
        
        companyJobsButton.layer.borderColor = UIColor.blue.cgColor
        
        
        
        companyAboutButton.backgroundColor = UIColor.clear
        
        companyAboutButton.layer.cornerRadius = 15
        
        companyAboutButton.layer.borderWidth = 1
        
        companyAboutButton.layer.borderColor = UIColor.blue.cgColor
        
        
        companyWikiButton.backgroundColor = UIColor.clear
        
        companyWikiButton.layer.cornerRadius = 15
        
        companyWikiButton.layer.borderWidth = 1
        
        companyWikiButton.layer.borderColor = UIColor.blue.cgColor
        
        
        
        
        
    }
    
    
    ///gives info to web view
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "CompanySites" {
            let companyWebViewController = segue.destination as! CompaniesWebViewController
            
            companyWebViewController.companyName.title = dataPassed[11]
            companyWebViewController.companyURL = companyURLToPass
        }
        else
        {
            let companyMapViewController = segue.destination as! CompanyMapViewController
            companyMapViewController.companyAddressPassed = companyAddress
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
