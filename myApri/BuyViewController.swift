//
//  BuyViewController.swift
//  myApri
//
//  Created by MacUser on 2017/06/29.
//  Copyright © 2017年 Yuka Saito. All rights reserved.
//

import UIKit
import CoreData

class BuyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var myTableView2: UITableView!

    var buyArray : [BuyData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        myTableView2.dataSource = self
        myTableView2.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //coredataからのデータ取得
        getData()
        //テーブルビューへのリロード
        myTableView2.reloadData()
    }
    //行数
    //-> Int：戻り値のデータ型はInt型ですという意味　ついているものは戻り値がある
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buyArray.count
    }
    //表示するセルの中身
    // リストに表示する文字列行数を決定表示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)as!customCell
        

        let task = buyArray[indexPath.row]
        
        cell.foodTextLabel?.text = task.value(forKey: "name")as!String
        cell.doseTaxtLabel?.text = task.value(forKey: "dose")as!String

        
        
        return cell
    }
    //データの読み込処理
    func getData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            buyArray = try context.fetch(BuyData.fetchRequest())
        }
        catch{
            print("Fetching Failed")
        }
    }
    
    //削除データ
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if editingStyle == .delete{
            let task = buyArray[indexPath.row]
            context.delete(task)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            do {
                buyArray = try context.fetch(BuyData.fetchRequest())
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
