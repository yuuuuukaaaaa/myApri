//
//  CameraViewController.swift
//  myApri
//
//  Created by MacUser on 2017/07/10.
//  Copyright © 2017年 Yuka Saito. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate,XMLParserDelegate {
    
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var textField: UITextView!
    
    func load() {
        getcode()
        
        //yahooのAPIからデータを取得
        //JSONファイルを読み込む
        //URLを指定して、インターネット経由で取得 URL型へ変換
        var barcode=getdate
        
        var url = URL(string:"http://shopping.yahooapis.jp/ShoppingWebService/V1/json/itemSearch?appid=dj00aiZpPUg2UFJNNWJLTThkaiZzPWNvbnN1bWVyc2VjcmV0Jng9ZTM-&category_id=2498&isbn=\(barcode)")
        //インターネットに接続するためのリクエストを作成 url!は上記のurlのことを指している
        //エンターを押した時に情報をとってくるためのデータ
        var request = URLRequest(url: url!)
        var jsondata = (try! NSURLConnection.sendSynchronousRequest(request, returning: nil))
        
        //辞書データに変換
        let jsonDic = (try! JSONSerialization.jsonObject(with: jsondata, options: [])) as! NSDictionary
        
        
        //キーの個数だけ繰り返して表示
        for(key,data) in jsonDic{
            print("Key:\(key) Data:\(data)")
        }
        
        
        do{
            //resultsキーを指定してすべての情報を取得
            var result:NSDictionary
            result = jsonDic["ResultSet"] as! NSDictionary
            
            var result1:NSDictionary
            result1 = result["0"] as! NSDictionary
            
            var result2:NSDictionary
            result2 = result1["Result"] as! NSDictionary
            
            //名前のデータ取得
            var result3:NSDictionary
            result3 = result2["3"] as! NSDictionary
            
            print(result3["Name"])
            
            //画像イメージ取得
            var result4:NSDictionary
            result4 = result2["1"] as! NSDictionary
            
            var result5:NSDictionary
            result5 = result4["Image"] as! NSDictionary
            
            var result6:String
            result6 = result5["Small"] as! String
            
            print(result6)
        }
        
        
        
    }

    
    
    
    
    
    
    // セッションのインスタンス生成
    let captureSession = AVCaptureSession()
    var videoLayer: AVCaptureVideoPreviewLayer?
    
    var qrView: UIView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // QRコードをマークするビュー
        qrView = UIView()
        qrView.layer.borderWidth = 4
        qrView.layer.borderColor = UIColor.red.cgColor
        qrView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        view.addSubview(qrView)
        
        // 入力（背面カメラ）
        let videoDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        let videoInput = try! AVCaptureDeviceInput.init(device: videoDevice)
        captureSession.addInput(videoInput)
        
        // 出力（メタデータ）
        let metadataOutput = AVCaptureMetadataOutput()
        captureSession.addOutput(metadataOutput)
        
        // QRコードを検出した際のデリゲート設定
        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        // QRコードの認識を設定
        metadataOutput.metadataObjectTypes = [AVMetadataObjectTypeEAN13Code]
        
        // プレビュー表示
        videoLayer = AVCaptureVideoPreviewLayer.init(session: captureSession)
        videoLayer?.frame = previewView.bounds
        videoLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        previewView.layer.addSublayer(videoLayer!)
        
        func getcode(){
            
        }

        
        // セッションの開始
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession.startRunning()
        }
        
        
        
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        // 複数のメタデータを検出できる
        for metadata in metadataObjects as! [AVMetadataMachineReadableCodeObject] {
            // QRコードのデータかどうかの確認
            if metadata.type == AVMetadataObjectTypeEAN13Code {
                // 検出位置を取得
                let barCode = videoLayer?.transformedMetadataObject(for: metadata) as! AVMetadataMachineReadableCodeObject
                qrView!.frame = barCode.bounds
                if metadata.stringValue != nil {
                    // 検出データを取得
                    print(metadata.stringValue!)
                    textField.text = metadata.stringValue!
                }
            }
        }
        
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
