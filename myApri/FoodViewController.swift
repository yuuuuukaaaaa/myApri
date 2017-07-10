//
//  FoodViewController.swift
//  myApri
//
//  Created by MacUser on 2017/06/29.
//  Copyright © 2017年 Yuka Saito. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class DateManager {
    
    private let formatter = DateFormatter()
    private let date = Date()
    private var dateStr: String?
    private let calendar = Calendar(identifier: .gregorian)
    
    init(){
        formatter.timeZone = TimeZone.ReferenceType.local
        formatter.dateFormat = "yyyy-MM-dd-HH-mm-ss"
        dateStr = ""
    }
    //現在時刻を返します"yyyy-MM-dd-HH-mm-ss"
    func getNowDate() -> String{
        dateStr = formatter.string(from: date)
        guard let now = dateStr else { return ""}
        return now
    }
    //設定したカウントダウンの秒数を返してくれます
    func getXmaxTimeInterval() -> Int {
        guard let xmas = calendar.date(from: DateComponents(year: 2016, month: 12, day: 25)) else { return 0}
        let spanFromWow = xmas.timeIntervalSinceNow
        return Int(floor(spanFromWow))
    }
    
}

let date = DateManager()
//countにカウントダウンの秒数が返ってきます
let count: Int = date.getXmaxTimeInterval()
//返ってきたデータをラベルに入力
//LimitDate.text = String(count)


class FoodViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var myTableView: UITableView!
    
    var foodArray : [FoodData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

       myTableView.dataSource = self
       myTableView.delegate = self
        
    }
    
    
    
    
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
        
        cell.name?.text = task.value(forKey: "name")as!String
        cell.dose?.text = task.value(forKey: "dose")as!String
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
       
        //cell.savetype?.text = task.value(forKey: "savetype")as!Int
        //task.value(forKey: "limitDate") as! String
       
        //let vc = FoodReadTableViewController.buyDate
        
        let df = DateFormatter()
        df.dateFormat = "yyyy/MM/dd"
        let dataDate = df.string(from: task.value(forKey: "limitDate") as! Date)
        
        
        cell.limitDate?.text = dataDate
        
        let df1 = DateFormatter()
        df1.dateFormat = "yyyy/MM/dd"
        let dataDate1 = df1.string(from: task.value(forKey: "buyDate") as! Date)
        cell.buyDate?.text = dataDate1
        
        //cell.buyDate?.text = task.value(forKey: "buyDate")as! String

    
        
        return cell
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
