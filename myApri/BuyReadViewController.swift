//
//  BuyReadViewController.swift
//  myApri
//
//  Created by MacUser on 2017/07/03.
//  Copyright © 2017年 Yuka Saito. All rights reserved.
//

import UIKit
import CoreData

class BuyReadViewController: UIViewController {

    //各ボタンの指定
    @IBOutlet weak var BuyFoodText: UITextField!
    
    @IBOutlet weak var BuyDoseText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //コアデータからデータの読み込み処理
       read()
        
    }
    
    //データ接続
    
    @IBAction func BuyBtn(_ sender: UITextField) {
    }
    @IBAction func BuyDose(_ sender: UITextField) {
    }
    
    //データ保存ボタン
    
    @IBAction func btnTapped(_ sender: Any) {
        
        
        //AppDelegateを用意しておく
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //エンティティを操作するためのオブジェクトを作成
        let viewContext = appDelegate.persistentContainer.viewContext
        
        //BuyDataエンティティオブジェクトを作成
        let BuyData = NSEntityDescription.entity(forEntityName: "BuyData", in:viewContext)
        //BuyDataエンティティにレコードを挿入するためのオブジェクトを作成
        let newRecord = NSManagedObject(entity : BuyData!, insertInto:viewContext)
        
        //値をセット
        newRecord.setValue(BuyFoodText.text, forKey: "name")//値を代入
        newRecord.setValue(BuyDoseText.text, forKey: "dose")//値を代入
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
        let query: NSFetchRequest<BuyData> = BuyData.fetchRequest()
        
        do{
            //データを一括取得
            let fetchResults = try viewContext.fetch(query)
            //データ取得
            for result: AnyObject in fetchResults {
                let foodText: String? = result.value(forKey: "name") as? String
                let doseText: String? = result.value(forKey: "dose") as? String
                
                
                
                print("name:\(foodText) dose:\(doseText) ")
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
