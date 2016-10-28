//
//  SearchController.swift
//  Weather实战
//
//  Created by 樊树康 on 16/9/17.
//  Copyright © 2016年 懒懒的猫鼬鼠. All rights reserved.
// hello i want to test the git!
import UIKit

class SearchController: UITableViewController,UISearchResultsUpdating{
    //MARK: - Config array
    var CityList = [CityRealm]()
    var searchCityList = [CityRealm]()
   //添加城市列表
    var addCity = CityRealm()
    
    var indexingArray = [String]()
    
    var secationArrayIndex = [Int]()
    //MARK: - Config Search Controller
    var sc :UISearchController!
    
    //MARK:  - ViewController Life
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUI()
       
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        self.realmOperation()
        self.setIndexArray()
        self.tableView.reloadData()
    }
    
    //MARK : - Back Button
    @IBAction func dismiss(sender: AnyObject)
    {
        
        self.performSegueWithIdentifier("back", sender: sender)
    }
    
    //MARK: - Realm Operation
   
    func realmOperation()
    {
     
        let allCity = realm.objects(CityRealm).sorted("pinYin")
    
        for city in allCity
        {
            CityList.append(city)
            
        }
       
    }
    
    func setUI()
    {
        
        //search config
        sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self;
        sc.dimsBackgroundDuringPresentation = false
        sc.loadViewIfNeeded()
        sc.hidesNavigationBarDuringPresentation = false
        sc.searchBar.barTintColor = UIColor(colorLiteralRed: 118/255.0, green: 255/255.0, blue: 244/255.0, alpha: 0.9)
        //tableView config
        self.tableView.tableHeaderView = self.sc.searchBar
        self.tableView.sectionIndexColor = UIColor.whiteColor()
        self.tableView.sectionIndexBackgroundColor = UIColor.clearColor()
    }
    
    //MARK: - Table View DataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
       
        return  sc.active ? 1 : indexingArray.count
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let sstart = secationArrayIndex[section]
        
        return   sc.active ?
        searchCityList.count : section == secationArrayIndex.count - 1 ?
            CityList.count - sstart :secationArrayIndex[section + 1] - sstart
        

    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("CityListCell", forIndexPath: indexPath)
        if sc.active
        {
            cell.textLabel?.text = searchCityList[indexPath.row].cityName
            cell.detailTextLabel?.text = searchCityList[indexPath.row].prov
        }
        else
        {
            
            cell.textLabel?.text = CityList[secationArrayIndex[indexPath.section] + indexPath.row].cityName
            cell.detailTextLabel?.text = CityList[secationArrayIndex[indexPath.section] + indexPath.row].prov
        
        
        }
         return cell
    }
    
 
    //MARK: - Search Result Updating
    func updateSearchResultsForSearchController(searchController: UISearchController)
    {
        var temp = [CityRealm]()
        
        for city in CityList
        {
            if (city.cityName.containsString(searchController.searchBar.text!) || city.prov.containsString(searchController.searchBar.text!) )
            {
                temp.append(city)
            }
            
        }
        
        self.searchCityList = temp
        self.tableView.reloadData()
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let addCity:CityRealm!
        
        if sc.active
        {
          addCity = searchCityList[secationArrayIndex[indexPath.section] + indexPath.row]
        }
        else
        {
        addCity = CityList[secationArrayIndex[indexPath.section] + indexPath.row]
        }
        
        let list = CustomCityList()
        list.city = addCity
        try! realm.write
            {
              realm.add(list)
           }
    
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
   
     // MARK: - Set TableView Indexing
    
    func setIndexArray()
    {
        
        var array = [String]()
        var indexArray = [Int]()
        for city in CityList
        {
            if( array.contains(city.firstLetter) == false)
            {
                array.append(city.firstLetter)
                let index = CityList.indexOf(city)
                indexArray.append(index!)
                
            }
        }
      
       secationArrayIndex = indexArray
       indexingArray = array
        
    }
    
   
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]?
    {

       return   sc.active ?   nil :  indexingArray
        
    }
        
    
    override func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int
    {
        return index
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
      return   sc.active ?  "" :  indexingArray[section]
      
    }
 
}
