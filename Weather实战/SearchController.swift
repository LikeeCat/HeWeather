//
//  SearchController.swift
//  Weather实战
//
//  Created by 樊树康 on 16/9/17.
//  Copyright © 2016年 懒懒的猫鼬鼠. All rights reserved.
//
import RealmSwift
import UIKit

class SearchController: UITableViewController,UISearchResultsUpdating{
    var adHeaders:[String] = ["a","b","c","d","e"]
    //MARK: - Config array
    var CityList = [CityRealm]()
    var searchCityList = [CityRealm]()
    var addCity = CityRealm()
    var indexingArray = [String]()
    
    var secationArrayIndex = [Int]()
    //MARK: - Config Search Controller
    var sc :UISearchController!
    
    //MARK:  - ViewController Life
   
    override func viewDidLoad() {
        super.viewDidLoad()
   print("view did load")
        sc = UISearchController(searchResultsController: nil)
        self.tableView.tableHeaderView = self.sc.searchBar
        sc.searchResultsUpdater = self;
        sc.dimsBackgroundDuringPresentation = false
        self.realmOperation()
        self.setIndexArray()
        sc.searchBar.sizeToFit()
        sc.hidesNavigationBarDuringPresentation = false
        self.tableView.reloadData()
       sc.searchBar.barTintColor = UIColor.clearColor()
        self.tableView.sectionIndexColor = UIColor.clearColor()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    
    @IBAction func dismiss(sender: AnyObject) {
        
        self.performSegueWithIdentifier("back", sender: sender)
    }
    //MARK: - Realm Operation
   
    func realmOperation(){
     
        let allCity = realm.objects(CityRealm).sorted("pinYin")
    
        for city in allCity{
            CityList.append(city)
            
        }
       
    }
    //MARK: - Table View DataSource

    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if sc.active{
            return 1
        }else{
        return indexingArray.count
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var sstart = secationArrayIndex[section]
        var send = 0
         if sc.active
         {
            tableView.reloadSectionIndexTitles()
            return searchCityList.count
         }
         else
         {
        
            if(section == secationArrayIndex.count - 1)
            {
            send = CityList.count
            }
            else
            {
            send = secationArrayIndex[section + 1]
            }
        //print(" now is \(send - sstart)")
        return send - sstart
        }

    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CityListCell", forIndexPath: indexPath)
        if sc.active{
            
            cell.textLabel?.text = searchCityList[indexPath.row].cityName
            cell.detailTextLabel?.text = searchCityList[indexPath.row].prov
        }
        else{
            
            cell.textLabel?.text = CityList[secationArrayIndex[indexPath.section] + indexPath.row].cityName
            cell.detailTextLabel?.text = CityList[secationArrayIndex[indexPath.section] + indexPath.row].prov
        
        
        }
         return cell
    }
    
 
    //MARK: - Search Result Updating
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        var temp = [CityRealm]()
        
        for city in CityList{
            if (city.cityName.containsString(searchController.searchBar.text!) || city.prov.containsString(searchController.searchBar.text!) ) {
                temp.append(city)
            }
            
        }
        
        self.searchCityList = temp
        self.tableView.reloadData()
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     var  addCity = CityList[secationArrayIndex[indexPath.section] + indexPath.row]
        
        let list = CustomCityList()
        list.city = addCity
        try! realm.write{
              realm.add(list)
           }
        
    
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
   
     // MARK: - Set TableView Indexing
    
    func setIndexArray() {
        
        var array = [String]()
        var indexArray = [Int]()
        for city in CityList{
            if( array.contains(city.firstLetter) == false){
                array.append(city.firstLetter)
                var index = CityList.indexOf(city)
                indexArray.append(index!)
                
              //  print("\(city.firstLetter) : \(index)")
            }
        }
      
       secationArrayIndex = indexArray
       indexingArray = array
        
    }
    
   
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
    print("search title \(indexingArray.count)")
        for arr in indexingArray{
            print(arr)
        }
        if sc.active{
            return nil
        }else{
        return indexingArray
        }
    }
        
       
        
    
    
    override func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return index
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return indexingArray[section]
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
