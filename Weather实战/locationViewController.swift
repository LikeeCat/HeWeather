//
//  locationViewController.swift
//  Weather实战
//
//  Created by 樊树康 on 16/9/3.
//  Copyright © 2016年 懒懒的猫鼬鼠. All rights reserved.
//

import Alamofire
import UIKit
import ObjectMapper
import SwiftyJSON
import RealmSwift

class locationViewController: UIViewController,UITableViewDataSource {

    let path = NSHomeDirectory()
    
    @IBOutlet weak var NowWeatherTmpMaxMin: UILabel!
    @IBOutlet weak var NowWeatherTmp: UILabel!
    @IBOutlet weak var NowWeatherWind: UILabel!
    
    //MARK:weekWeather information
    @IBOutlet weak var Weather0Image: UIImageView!
    
    @IBOutlet weak var Weather1Image: UIImageView!
    @IBOutlet weak var Weather2Image: UIImageView!
    @IBOutlet weak var Weather3Image: UIImageView!
    
    @IBOutlet weak var Weather4Image: UIImageView!
    @IBOutlet weak var Weather5Image: UIImageView!
    
    @IBOutlet weak var weather0Lable: UILabel!

    @IBOutlet weak var weather1Lable: UILabel!
    
    @IBOutlet weak var weather2Lable: UILabel!
    
    @IBOutlet weak var weather3Lable: UILabel!
    
    
    @IBOutlet weak var weather4Lable: UILabel!
    
    @IBOutlet weak var weather5Lable: UILabel!
    
    //MARK: UI Control
    @IBOutlet weak var Spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var tableview: UITableView!
    //MARK: weekWeather Property Observers

    var UIImageViewData = [UIImageView]()
    var UILabelData = [UILabel]()
   
    var weekWeather = [Daily](){
        didSet{
            self.setNowWeather()
            self.mapWeatherInformation()
        }
    }
    var suggest = ""
        {
        didSet{
            self.tableview.reloadData()
        }
}
    var tmpNow = "10"
        {
        didSet{
            self.NowWeatherTmp.text = tmpNow
        }
    }
 
    var todayInformation = TodayInformation()
        {
        didSet{
            self.tableview.reloadData()
        }
    }
    
    //MARK: - Realm DataBase
   
    
    func getInformation(str:String){
       NetWorkHelper.netWorkHelper.fetch(str)
       { (succeed, responseValue) in
       self.weekWeather = succeed
       self.tmpNow = responseValue["HeWeather data service 3.0"][0]["now"]["tmp"].stringValue
       self.suggest = responseValue["HeWeather data service 3.0"][0]["suggestion"]["comf"]["txt"].stringValue
        }
    }
    func initializeRealmDataBase() {
        
        getInformation("CN101010100")
        
        let allcity = realm.objects(CityRealm)
        if allcity.count == 0
        {
            NetWorkHelper.netWorkHelper.fetchAllCity("allchina")
            { (succeed, _) in
                
                try! realm.write
                    {
                    realm.add(succeed)
                    }
                
                
            }
        }
        
    }
   
    //MARK: ViewController life
    override func viewDidLoad() {
        super.viewDidLoad()
      print(path)
        self.initializeRealmDataBase()

        self.Spinner.startAnimating()
        self.location.text = "正在解析当前地址,请稍侯"
        self.MapJSONAnalyze()
        
        self.managerImageAndLabel()
        self.tableview.estimatedRowHeight = 80
        self.tableview.rowHeight = UITableViewAutomaticDimension
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: MapJSONAnalyze
    func MapJSONAnalyze()  {
        let a = AFNetHelper()
     
        a.setNetWorkHelpercompletionHandler{ data in
           let jsonData = JSON(data)
          
            let province = jsonData["regeocode"]["addressComponent"]["province"].stringValue
            let  district = jsonData["regeocode"]["addressComponent"]["district"].stringValue
            self.Spinner.stopAnimating()
            self.Spinner.hidden = true
          self.location.text = province + ":" + district
            
            
        }
        

    }
    //MARK: Set UI Function
    func getWeatherImage(URL:String) ->UIImage{
        let image = UIImage.getImageFromInternet(person.WeatherImageBaseURL+URL)
        return image
    }
    func setWeatherImage()
    {
        var paramter = [String]()
        for weather in weekWeather
        {
            let param = weather.cond?.code_d
            paramter.append(param!)
        }
         var URL = [String]()
            for par in paramter
            {
             let url = person.WeatherImageBaseURL + par + person.WeatherImageTail
                URL.append(url)
            }
         var i = 0
          UIImageViewData.map
        { imageData in

            imageData.image = UIImage.getImageFromInternet(URL[i])
             i += 1
            while(i == UILabelData.count)
            {
                i = 0
            }
        }
        UILabelData.map
            { label in
    
            label.text = weekWeather[i].cond?.txt_n
      
             i += 1
            }


        
    }
    
    func setNowWeather()
    {
        let max = weekWeather[0].tmp?.max
        print(max, terminator: "")
       
        let min = weekWeather[0].tmp?.min
        print(min, terminator: "")
        
        self.setWeatherImage()
        self.NowWeatherTmpMaxMin.text = "\(min!)℃/\(max!)℃"
        self.NowWeatherWind.text = weekWeather[0].wind?.sc
    }
    
    func mapWeatherInformation(){
         let todayInformationInArray = weekWeather[0]

         self.todayInformation.pcpn  = todayInformationInArray.pcpn
         self.todayInformation.sr  = (todayInformationInArray.astro?.sr)!
         self.todayInformation.ss = (todayInformationInArray.astro?.ss)!
         self.todayInformation.pop = todayInformationInArray.pop
         self.todayInformation.hum = todayInformationInArray.hum
         self.todayInformation.spd = (todayInformationInArray.wind?.spd)!
         self.todayInformation.sc = (todayInformationInArray.wind?.sc)!
         self.todayInformation.dir = (todayInformationInArray.wind?.dir)!
         self.todayInformation.pres = todayInformationInArray.pres
         self.todayInformation.vis = todayInformationInArray.vis
    }
   
    
    //MARK: - Table View
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        switch section {
        case 0:
            return 1
        default:
            return TodayInformation.rows
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       let constant = Costant()
        if indexPath.section == 0{
            
            let cell = tableView.dequeueReusableCellWithIdentifier("suggestCell", forIndexPath: indexPath) as! SuggestCell
            cell.Today.text = "今天:"
            cell.suggestInformation.text = self.suggest
            return cell
                    }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("informationCell", forIndexPath: indexPath) as! InformationCell
            switch indexPath.row {
            case 0:
                cell.key .text = TodayInformation.weatherInformationkeyArray[0]+constant.tailSymbol
                cell.value.text = todayInformation.sr
                cell.key1.text = TodayInformation.weatherInformationkeyArray[1]+constant.tailSymbol
                cell.value1.text = todayInformation.ss
            
        
            case 1:
                cell.key .text = TodayInformation.weatherInformationkeyArray[2]+constant.tailSymbol

                cell.value.text = todayInformation.pop + constant.humConstant
                cell.key1.text = TodayInformation.weatherInformationkeyArray[3]+constant.tailSymbol

                cell.value1.text = todayInformation.pcpn + constant.pcpnConstant
            
            case 2:
                cell.key .text = TodayInformation.weatherInformationkeyArray[4]+constant.tailSymbol

                cell.value.text = todayInformation.hum + constant.humConstant
                cell.key1.text = TodayInformation.weatherInformationkeyArray[5]+constant.tailSymbol

                cell.value1.text = todayInformation.spd + constant.spdConstant
            case 3:
                cell.key .text = TodayInformation.weatherInformationkeyArray[6]+constant.tailSymbol

                cell.value.text = todayInformation.sc
                cell.key1.text = TodayInformation.weatherInformationkeyArray[7]+constant.tailSymbol

                cell.value1.text = todayInformation.dir
            case 4:
                cell.key .text = TodayInformation.weatherInformationkeyArray[8]+constant.tailSymbol

                cell.value.text = todayInformation.pres
                cell.key1.text = TodayInformation.weatherInformationkeyArray[9]+constant.tailSymbol

                cell.value1.text = todayInformation.vis + constant.visConstant
            default:
                break
            }
            
            return cell
        }
        
    
    }
    
    //MARK: - manager Image And Label
    func managerImageAndLabel(){
        UIImageViewData = [self.Weather0Image,self.Weather1Image,self.Weather2Image,self.Weather3Image,self.Weather4Image,self.Weather5Image]
        UILabelData = [self.weather0Lable,self.weather1Lable,self.weather2Lable,self.weather3Lable,self.weather4Lable,self.weather5Lable]

    }
    
        
   @IBAction func unwindToHome(unwindSegue: UIStoryboardSegue) {
        if unwindSegue.identifier == "backHome"
        {
            let SVC = unwindSegue.sourceViewController as!AddCityViewController
            let selectCity = SVC.citySelect
            print(selectCity.cityName)
            getInformation(selectCity.id)
            self.location.text = selectCity.cityName
              }
    }

}