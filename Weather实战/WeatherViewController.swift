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

class WeatherViewController: UIViewController,UITableViewDataSource {

    @IBOutlet weak private var background: UIImageView!
  
    @IBOutlet weak private var NowWeatherTmpMaxMin: UILabel!
    @IBOutlet weak private var NowWeatherTmp: UILabel!
    @IBOutlet weak private var NowWeatherWind: UILabel!
    
    //MARK:weekWeather information
    @IBOutlet weak private var Weather0Image: UIImageView!
    @IBOutlet weak private var Weather1Image: UIImageView!
    @IBOutlet weak private var Weather2Image: UIImageView!
    @IBOutlet weak private var Weather3Image: UIImageView!
    @IBOutlet weak private var Weather4Image: UIImageView!
    @IBOutlet weak private var Weather5Image: UIImageView!
    
    @IBOutlet weak private var weather0Lable: UILabel!
    @IBOutlet weak private var weather1Lable: UILabel!
    @IBOutlet weak private var weather2Lable: UILabel!
    @IBOutlet weak private var weather3Lable: UILabel!
    @IBOutlet weak private var weather4Lable: UILabel!
    @IBOutlet weak private var weather5Lable: UILabel!
    
    @IBOutlet weak private var weekday0: UILabel!
    @IBOutlet weak private var weekday1: UILabel!
    @IBOutlet weak private var weekday2: UILabel!
    @IBOutlet weak private  var weekday3: UILabel!
    @IBOutlet weak private var weekday4: UILabel!
    @IBOutlet weak private var weekday5: UILabel!
    
    @IBOutlet weak var locationLeading: NSLayoutConstraint!
    //MARK: UI Control
    @IBOutlet weak private var Spinner: UIActivityIndicatorView!
    @IBOutlet weak private var location: UILabel!
    @IBOutlet weak private var tableview: UITableView!
    //MARK: Page View Controller Property
    
    @IBOutlet private weak var pageControl: UIPageControl!
    internal var index = 0
    internal var pages = 0

    private var UIImageViewData = [UIImageView]()
    private var UILabelData = [UILabel]()
    private var UIWeekData = [UILabel]()
    
    let path = NSHomeDirectory()
    
    let nowTime = NSDate()
    var srDate:NSDate!
    var ssDate:NSDate!
  
    //MARK: weekWeather Property Observers

    
    //一周天气
    private var weekWeather = [Daily]()
    {
        didSet
        {
            self.setNowWeather()
            self.mapWeatherInformation()
            
        }
    }
    
    //建议
    private var suggest = ""
    {
           didSet
           {
            self.tableview.reloadData()
           }
    }
   
    //现在温度
    private var tmpNow = "0°"
    {
        didSet
        {
            self.NowWeatherTmp.text = tmpNow
        }
    }
    
    //今天的天气
    private  var todayInformation = TodayInformation()
    {
        didSet
        {
            self.tableview.reloadData()
        }
    }
    private var manager :AMapLocationManager!

    //public property
    internal  var cityIdDefult:String!
    internal  var cityName = ""
    internal  var islocation = true


    //MARK: ViewController life
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.tableview.estimatedRowHeight = 50
        self.tableview.rowHeight = UITableViewAutomaticDimension
        self.MapJSONAnalyze()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.initializeRealmDataBase()
        self.Spinner.hidden = true
        print(realm.configuration.fileURL)
        if islocation{
            self.location.text = "正在获取,请稍后"
            self.Spinner.hidden = false
            self.Spinner.startAnimating()
            
        }else{
            location.text = cityName
            self.Spinner.hidden = false
            self.Spinner.startAnimating()
        }
        self.managerImageAndLabel()
        
       
        self.pageControl.numberOfPages = pages
        self.pageControl.currentPage = index
    
         }
        
        override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        getInformation(cityIdDefult)
        
        }
    
    
    //MARK: - Realm DataBase
   
    
    func getInformation(str:String)
    {
       NetWorkHelper.netWorkHelper.fetch(str)
       { (succeed, responseValue) in
       self.weekWeather = succeed
       self.tmpNow = responseValue["HeWeather data service 3.0"][0]["now"]["tmp"].stringValue
       self.suggest = responseValue["HeWeather data service 3.0"][0]["suggestion"]["comf"]["txt"].stringValue
        
        }
    }
    
    func initializeRealmDataBase()
    {
        var allcity = realm.objects(CityRealm)
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
    
    
 
    //MARK: MapJSONAnalyze
    func MapJSONAnalyze()  {
        if islocation == true
        {
        manager = Location.singleLocation.configManager()
        Location.singleLocation.locationResult(manager, closer_:
            { recode in
                var name = recode.city
                name.removeAtIndex(name.endIndex.predecessor())
                self.location.text = name
                self.Spinner.stopAnimating()
                self.Spinner.hidden = true
                let result = realm.objects(CityRealm).filter("cityName = '\(name)'")
                let citylist = CustomCityList()
                citylist.city = result.first
                try! realm.write{
                    realm.add(citylist)
                }
                self.cityIdDefult = result.first?.id
         })
        }
    }
    
    
    //MARK: Set UI Function
    func getWeatherImage(URL:String) ->UIImage
    {
        let image = UIImage.getImageFromInternet(person.WeatherImageBaseURL+URL)
        return image
    }
    
    func switchParam(param:Int,isDay:Bool) -> String{
        var imageName = ""
        switch param {
            //晴
            case 100:
                imageName = isDay ?  "still_fair_bg" : "still_fair_night_bg"
            case 101...103:
                imageName = isDay ? "still_clouds_bg" : "still_clouds_night_bg"
            case 104:
                imageName = isDay ? "still_cloudy_bg" : "still_cloudy_night_bg"
            case 300...313:
                imageName = isDay ? "still_rain_bg" : "still_rain_night_bg"
            
            case 400...407:
                imageName = isDay ? "still_snow_bg" : "still_snow_night_bg"
            case 500...501:
                imageName = isDay ? "still_fog_bg" : "still_fog_night_bg"
            case 502:
                imageName = isDay ? "still_haze_bg" : "still_haze_night_bg"
            default:
                imageName = isDay ?  "still_fair_bg" : "still_fair_night_bg"
            
            }
        
        return imageName
        
    }
    
    func setWeatherImage()
    {
        var paramter = [String]()
        var isDay = false
        
        for weather in weekWeather
        {
            var param = ""
            if(DateOperation.operation.isDay(nowTime, srDate: srDate, ssDate: ssDate)){
                param = (weather.cond?.code_d)!
                isDay = true
            }else{
                 param = (weather.cond?.code_n)!
                
            }

            paramter.append(param)
        }
        var URL = [String]()
        for par in paramter
        {
            let url = person.WeatherImageBaseURL + par + person.WeatherImageTail
            URL.append(url)
        }
        var i = 0
        UIImageViewData.map
        {
            imageData in

            imageData.image = UIImage.getImageFromInternet(URL[i])
             i += 1
            while(i == UILabelData.count)
            {
                i = 0
            }
        }
        UILabelData.map
        {
            label in
            var weatherTmp = isDay ? weekWeather[i].cond?.txt_d : weekWeather[i].cond?.txt_n
            label.text = weatherTmp
            i += 1
        }
        let weekArray =   DateOperation.operation.setWeekday(nowTime)
        for number in 0..<UIWeekData.count
        {
            UIWeekData[number].text = weekArray[number]
        }
    }
    
    
    func setNowWeather()
    {
        var isDay = false
        let ssDateString = weekWeather[0].date + " " + (weekWeather[0].astro?.ss)!
        let srDateString = weekWeather[0].date + " " + (weekWeather[0].astro?.sr)!
        let dateSet = DateOperation.operation.getSunriseAndSet(srDateString, sunset: ssDateString)
        srDate = dateSet.0
        ssDate = dateSet.1
        let max = weekWeather[0].tmp?.max
        let min = weekWeather[0].tmp?.min
        self.setWeatherImage()
        self.NowWeatherTmpMaxMin.text = "\(min!)℃/\(max!)℃"
        if (DateOperation.operation.isDay(nowTime, srDate: srDate, ssDate: ssDate))
        {
            isDay = true
            
        }

        let imageName = switchParam(Int(weekWeather[0].cond!.code_d)!, isDay: isDay)

        UIView.animateWithDuration(0.3, animations: {
            
           var weatherWindText = isDay ? self.weekWeather[0].cond?.txt_d :self.weekWeather[0].cond?.txt_n
            self.NowWeatherWind.text = weatherWindText
            self.background.image = UIImage(named: imageName)
            self.Spinner.stopAnimating()
            self.locationLeading.constant = -30
            self.Spinner.hidden = true
            })

    }
    
    func mapWeatherInformation()
    {
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        switch section
        {
        case 0:
            return 1
        default:
            return TodayInformation.rows
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let constant = Costant()
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("suggestCell", forIndexPath: indexPath) as! SuggestCell
            cell.Today.text = "今天:"
            cell.suggestInformation.text = self.suggest
            return cell
            
        }
        else
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("informationCell", forIndexPath: indexPath) as! InformationCell
            switch indexPath.row
            {
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
    func managerImageAndLabel()
    {
        UIImageViewData = [self.Weather0Image,self.Weather1Image,self.Weather2Image,self.Weather3Image,self.Weather4Image,self.Weather5Image]
        UILabelData = [self.weather0Lable,self.weather1Lable,self.weather2Lable,self.weather3Lable,self.weather4Lable,self.weather5Lable]
        
        UIWeekData = [self.weekday0,self.weekday1,self.weekday2,self.weekday3,self.weekday4,self.weekday5]

    }
    
   
}
