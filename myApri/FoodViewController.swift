//
//  FoodViewController.swift
//  myApri
//
//  Created by MacUser on 2017/06/29.
//  Copyright © 2017年 Yuka Saito. All rights reserved.
//

import UIKit
import SDWebImage
import CoreData
//import SDWebImage



class FoodViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,XMLParserDelegate{
    let myApp = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var myTableView: UITableView!
    
    var foodArray : [FoodData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

       myTableView.dataSource = self
       myTableView.delegate = self
        
    }
    @IBOutlet weak var food: UIImageView!
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        //coredataからのデータ取得
        getData()
        
        //テーブルビューへリロード
        myTableView.reloadData()
    }
    //行数
    //-> Int：戻り値のデータ型はInt型ですという意味　ついているものは戻り値がある
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodArray.count
    }
    
    //表示するセルの中身
    // リストに表示する文字列行数を決定表示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as!customCell2
        
        let task = foodArray[indexPath.row]
        
        //画像イメージ
        
        if task.value(forKey: "photo") == nil {
            //no imageを表示
            cell.photo.image = UIImage(named: "noimage.png")
        }else{
            //指定された画像を表示
            cell.photo.image = UIImage(named: "\(myApp.globalPhoto)")
            print(task.value(forKey: "photo")as!String)
        }
        
        cell.name?.text = task.value(forKey: "name")as!String
        cell.dose?.text = task.value(forKey: "dose")as!String
       
        //保存方法表記
        var saveindex = task.value(forKey: "savetype")as!Int
        
        switch saveindex {
        case 0:
            cell.savetype.text = "冷蔵"
        case 1:
            cell.savetype.text = "冷凍"
        case 2:
            cell.savetype.text = "室温"
        default:
            cell.savetype.text = "なし"
        }
       
        //賞味期限
        let df = DateFormatter()
        df.dateFormat = "yyyy/MM/dd"
        let dataDate = df.string(from: task.value(forKey: "limitDate") as! Date)
        let changeInt = Int(getIntervalDays(date: task.value(forKey: "buyDate") as! Date))
        let changeInt1 = String(changeInt)
        cell.limitDate?.text = ("\(changeInt1)日")

        //購入日から本日までのカウント
        let df1 = DateFormatter()
        df1.dateFormat = "yyyy/MM/dd"
        let dataDate1 = df1.string(from: task.value(forKey: "buyDate") as! Date)
        let buyDate = String(getIntervalDays1(date: task.value(forKey: "limitDate") as! Date))
        let changeInt2 = Int(getIntervalDays1(date: task.value(forKey: "limitDate") as! Date))
        let changeInt3 = String(changeInt2)
        cell.buyDate?.text = ("\(changeInt3)日")
        
        print(dataDate)
        print(dataDate1)


        
 //  賞味期限デバックプリント
        print(getIntervalDays(date: task.value(forKey: "buyDate") as! Date))
        
        // 購入日から今日までの日数カウントのデバックプリント
        print(getIntervalDays1(date: task.value(forKey: "limitDate") as! Date))
        

        
        return cell
    }
    
    /**
     　　賞味期限を取得
     
     - parameter date: 日付
     - parameter anotherDay: 日付（オプション）。未指定時は当日が適用される
     - returns: 算出後の日付
     */
    func getIntervalDays(date:Date?,anotherDay:Date? = nil) -> Double {
        
        var retInterval:Double!
        if anotherDay == nil {
            retInterval = date?.timeIntervalSinceNow
        } else {
            retInterval = date?.timeIntervalSince(anotherDay!)
        }

        let ret = retInterval/86400
        
        return floor(ret)  // n日
    }
    
    
    
    
    func getIntervalDays1(date:Date?,anotherDay:Date? = nil) -> Double {
        
        var retInterval:Double!
        if anotherDay == nil {
            retInterval = date?.timeIntervalSinceNow
        } else {
            retInterval = date?.timeIntervalSince(anotherDay!)
        }
        
        let ret = retInterval/86400
        
        return floor(ret - ret - ret + 1)  // n日
    }

    
    
    
    
    //データの読み込処理
    func getData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            foodArray = try context.fetch(FoodData.fetchRequest())
            }
        catch{
            print("Fetching Failed")
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            
            if editingStyle == .delete{
                let task = foodArray[indexPath.row]
                context.delete(task)
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
                do {
                    foodArray = try context.fetch(FoodData.fetchRequest())
                }catch{
                    print("Fetching Failed")
                }
            }
        tableView.reloadData()
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
