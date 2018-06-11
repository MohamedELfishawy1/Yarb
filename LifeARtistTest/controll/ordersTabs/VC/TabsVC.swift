//
//  TabsVC.swift
//  LifeARtistTest
//
//  Created by mohamed on 4/14/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//


import UIKit
import XLPagerTabStrip
import Foundation
class TabsVC: ButtonBarPagerTabStripViewController{
        @IBOutlet var search: UISearchBar!
        let blueInstagramColor = UIColor(red: 37/255.0, green: 111/255.0, blue: 206/255.0, alpha: 1.0)
     
        override func viewDidLoad() {
            navigationItem.titleView = search
            // change selected bar color
            settings.style.buttonBarBackgroundColor = .white
            settings.style.buttonBarItemBackgroundColor = .white
            settings.style.selectedBarBackgroundColor = blueInstagramColor
            settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
            settings.style.selectedBarHeight = 2.0
            settings.style.buttonBarMinimumLineSpacing = 0
            settings.style.buttonBarItemTitleColor = .black
            settings.style.buttonBarItemsShouldFillAvailableWidth = true
            settings.style.buttonBarLeftContentInset = 0
            settings.style.buttonBarRightContentInset = 0
            
            changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
                guard changeCurrentIndex == true else { return }
                oldCell?.label.textColor = .black
                newCell?.label.textColor = self?.blueInstagramColor
            }
            super.viewDidLoad()
            
        }
    
        override  func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
            
     
            
            let now=UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "nowVC") as! nowVC
           
            let old=UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "oldVC") as! oldVC
           
            
            return [now, old]
        }
        
        
        
        
}
