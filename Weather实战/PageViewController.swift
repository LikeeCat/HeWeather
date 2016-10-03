//
//  PageViewController.swift
//  Weather实战
//
//  Created by 樊树康 on 2016/10/2.
//  Copyright © 2016年 懒懒的猫鼬鼠. All rights reserved.
//

import UIKit
import RealmSwift

class PageViewController: UIPageViewController,UIPageViewControllerDataSource {

    var cityList = [CityRealm]()


    override func viewDidLoad() {
        super.viewDidLoad()

         setSubViewController()
         dataSource = self
        
        if let startVC =  viewControllerAtIndex(0){
            setViewControllers([startVC], direction: .Forward, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Config View Controllers
    func setSubViewController(){
        
       
        let resultCityList = realm.objects(CustomCityList)
     
        for list in resultCityList{
          cityList.append( list.city)
        }
        
    }
    
     // MARK: - PageViewController DataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! locationViewController).index
        index += 1
        return viewControllerAtIndex(index)
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! locationViewController).index
        index -= 1
        return viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(index:Int) ->locationViewController?{
        if cityList.isEmpty == true
        {
            if let contentVC = storyboard?.instantiateViewControllerWithIdentifier("GuiderContentController") as? locationViewController
            {
            contentVC.cityIdDefult = "CN101010100"
            contentVC.cityName = "北京"
            contentVC.index = index
                return contentVC
            
            }
        }
           
        else
        {
            if case 0 ..< cityList.count = index
             {
                if let contentVC = storyboard?.instantiateViewControllerWithIdentifier("GuiderContentController") as? locationViewController
                {
                contentVC.cityIdDefult = cityList[index].id
                contentVC.cityName = cityList[index].cityName
                    contentVC.index = index
                return contentVC

                 }
             }
        }
        return nil
    }
    
    @IBAction func unwindToHome(unwindSegue: UIStoryboardSegue) {
        if unwindSegue.identifier == "backHome"
        {
            let SVC = unwindSegue.sourceViewController as!AddCityViewController
            let selectCity = SVC.citySelect
            cityList.removeAll()
            self.setSubViewController()
            let index = searchCityIndex(selectCity)
            
            if let jumpIndex =  viewControllerAtIndex(index){
                setViewControllers([jumpIndex], direction: .Forward, animated: true, completion: nil)
            }

            
           }
    }

    func searchCityIndex(city:CityRealm) -> Int {
      
        let index = Int(cityList.indexOf(city)!)
 
          return index
    }
    



}
