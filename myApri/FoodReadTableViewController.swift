//
//  FoodReadTableViewController.swift
//  myApri
//
//  Created by MacUser on 2017/07/03.
//  Copyright © 2017年 Yuka Saito. All rights reserved.
//

import UIKit
import CoreData

class FoodReadTableViewController: UIViewController {
    
    //入力画面の指定
    @IBOutlet weak var photo: UIImageView!

    @IBOutlet weak var foodText: UITextField!
    
    @IBOutlet weak var doseText: UITextField!
    
    @IBOutlet weak var savetypeBtn: UISegmentedControl!
    
    @IBOutlet weak var buyDate: UIDatePicker!
    
    @IBOutlet weak var limitDate: UIDatePicker!
    
    var buyDateString: String = ""
    
    var limitDateString: String = ""
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //コアデータからデータの読み込み処理
        read()
    }
    
    
    //データ接続
    
    
    @IBAction func foodText(_ sender: UITextField) {
    }
    
    @IBAction func doseText(_ sender: UITextField) {
    }
    
    @IBAction func savetypeBtn(_ sender: UISegmentedControl) {
        
    }
    
    @IBAction func buyDate(_ sender: UIDatePicker) {
        print(sender.date)
        
        //日付を文字列に変換するためのフォーマットを設定
        let df = DateFormatter()
        df.dateFormat = "yyyy/MM/dd"
        
        print(df.string(from: sender.date))
        buyDateString = df.string(from: sender.date)

    }
    
    @IBAction func limitDate(_ sender: UIDatePicker) {
        print(sender.date)
            
        //日付を文字列に変換するためのフォーマットを設定
        let df = DateFormatter()
        df.dateFormat = "yyyy/MM/dd"
            
        print(df.string(from: sender.date))
        limitDateString = df.string(from: sender.date)
    }
    
    
    
    
    
    
    //データ保存ボタン
    @IBAction func saveBtn(_ sender: Any){
       
        
        //AppDelegateを用意しておく
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //エンティティを操作するためのオブジェクトを作成
        let viewContext = appDelegate.persistentContainer.viewContext
        
        //ToDoエンティティオブジェクトを作成
        let FoodData = NSEntityDescription.entity(forEntityName: "FoodData", in:viewContext)
        //ToDoエンティティにレコードを挿入するためのオブジェクトを作成
        let newRecord = NSManagedObject(entity : FoodData!, insertInto:viewContext)
        
        //値をセット
        newRecord.setValue(photo, forKey: "photo")//値を代入
        newRecord.setValue(foodText.text, forKey: "name")//値を代入
        newRecord.setValue(doseText.text, forKey: "dose")//値を代入
        newRecord.setValue(savetypeBtn.selectedSegmentIndex, forKey: "savetype")//値を代入
        newRecord.setValue(buyDate.date, forKey: "buyDate")//値を代入
        newRecord.setValue(limitDate.date, forKey: "limitDate")//値を代入
        do{
            //レコード（行）の即時保存
            try viewContext.save()
        }catch{
        }
        
    }
    
    
    //既に存在すつデータの読み込み処理
    func read(){
        //AppDelegateを用意しておく
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //エンティティを操作するためのオブジェクトを作成
        let viewContext = appDelegate.persistentContainer.viewContext
        
        //どのエンティティからdataを取得してくるか設定
        let query: NSFetchRequest<FoodData> = FoodData.fetchRequest()
    
            do{
                //データを一括取得
                let fetchResults = try viewContext.fetch(query)
                //データ取得
                for result: AnyObject in fetchResults {
                    let photo: String? = result.value(forKey: "photo") as? String
                    let foodText: String? = result.value(forKey: "name") as? String
                    let doseText: String? = result.value(forKey: "dose") as? String
                    let savetypeBtn: String? = result.value(forKey: "savetype") as? String
                    let buyDate: String? = result.value(forKey: "buyDate") as? String
                    let limitDate :String? = result.value(forKey: "limitDate") as? String
                    
                    
                    
                    print("photo:\(photo) name:\(foodText) dose:\(doseText) savetype:\(savetypeBtn) buyDate:\(buyDate) limitDate:\(limitDate)")
                }
                
        }catch{
        }

    }
    
    
    
    
    
    //キーボードを下げる
    @IBAction func tapReturn1(_ sender: UITextField) {
    }
   
    @IBAction func tapReturn2(_ sender: UITextField) {
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
