//
//  BuyReadViewController.swift
//  myApri
//
//  Created by MacUser on 2017/07/03.
//  Copyright © 2017年 Yuka Saito. All rights reserved.
//

import UIKit

class BuyReadViewController: UIViewController {

    
    @IBOutlet weak var BuyFoodText: UITextField!
    
    @IBOutlet weak var BuyDoseText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    //データ接続
    
    @IBAction func BuyBtn(_ sender: UITextField) {
    }
    @IBAction func BuyDose(_ sender: UITextField) {
    }
    
    //データ保存ボタン
    
    @IBAction func btnTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let task = BuyData(context: context)
        task.name = BuyFoodText.text!
        task.dose = BuyDoseText.text!
        
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
