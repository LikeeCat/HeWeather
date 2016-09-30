//
//  AddCityViewController.swift
//  Weather实战
//
//  Created by 樊树康 on 16/9/13.
//  Copyright © 2016年 懒懒的猫鼬鼠. All rights reserved.
//

import UIKit
import RealmSwift
class AddCityViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    var cityArray = [CityRealm]()
    @IBOutlet weak var TableView: UITableView!
    
   
    //MARK: - View Controller Life
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
         }
    override func viewWillAppear(animated: Bool) {
        self.configCustomCityList()
        self.TableView.reloadData()
    }
    override func viewDidDisappear(animated: Bool) {
        cityArray.removeAll()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Config Realm For UI
    func configCustomCityList(){
        let allCity = realm.objects(CustomCityList)
        for city in allCity{
            cityArray.append(city.city)
        }
    }
    
    //MARK: - Update Weather Label
    
       //MARK: - Table View Data Source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var number = 0
        switch section {
        case 0:
               number = cityArray.count
        case 1:
            number = 1
        default:
            break
        }
        return number
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("CityList", forIndexPath: indexPath) as! locationCityCell
            cell.cellForRowInlocationCityCell(indexPath, tableView: tableView, r: cityArray)
            return cell
        }
        
        else {
             let cell = tableView.dequeueReusableCellWithIdentifier("AddCell", forIndexPath: indexPath) as! AddCityCell
            
            cell.cellForRowInAddCityCell(indexPath, tableView: tableView)
            return cell
        }
       
    }
    
    
    //MARK: - Table View Delete Operation
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }

    @IBAction func back(unwindSegue: UIStoryboardSegue) {
    
    }

}

   
