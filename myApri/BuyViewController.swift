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

    var buyArray = ["ほうれん草","うどん","マーガリン"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //行数
    //-> Int：戻り値のデータ型はInt型ですという意味　ついているものは戻り値がある
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buyArray.count
    }
    //表示するセルの中身
    // リストに表示する文字列行数を決定表示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //       色を青にする
        cell.textLabel?.textColor = UIColor.blue
        
        
        cell.textLabel?.text = buyArray[indexPath.row]
        
        return cell
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
