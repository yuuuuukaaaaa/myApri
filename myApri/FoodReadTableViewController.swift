//
//  FoodReadTableViewController.swift
//  myApri
//
//  Created by MacUser on 2017/07/03.
//  Copyright © 2017年 Yuka Saito. All rights reserved.
//

import UIKit

class FoodReadTableViewController: UIViewController {
    
    //各ボタンの指定
    
    @IBOutlet weak var foodText: UITextField!
    
    @IBOutlet weak var doseText: UITextField!
    
    @IBOutlet weak var savetypeBtn: UISegmentedControl!
    
    @IBOutlet weak var buyDate: UIDatePicker!
    
    @IBOutlet weak var limitDate: UIDatePicker!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

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
    }
    
    @IBAction func limitDate(_ sender: UIDatePicker) {
            print(sender.date)
            
            //日付を文字列に変換するためのフォーマットを設定
            let df = DateFormatter()
            df.dateFormat = "yyyy/MM/dd"
            
            print(df.string(from: sender.date))
    }
    
    
    
    //データ保存ボタン
    @IBAction func saveBtn(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let FoodArray = FoodData(context: context)
        FoodArray.name = foodText.text!
        FoodArray.dose = doseText.text!
        //FoodArray.savetype = savetypeBtn.numberOfSegments
        FoodArray.buyDate = buyDate.date as NSDate
        FoodArray.limitDate = limitDate.date as NSDate
        
    }
    
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
