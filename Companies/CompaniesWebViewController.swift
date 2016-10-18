//
//  WebViewController.swift
//  Companies
//
//  Created by CS3714 on 10/16/16.
//  Copyright © 2016 Jesus Fabian. All rights reserved.
//

import UIKit

class CompaniesWebViewController: UIViewController {
    
    
    
    
    @IBOutlet var webView: UIWebView!
    
    
    @IBOutlet var companyName: UINavigationItem!
    
     var companyURL: URL?
    


    override func viewDidLoad() {
        super.viewDidLoad()
        let request = URLRequest(url: companyURL!)
        webView.loadRequest(request)

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
