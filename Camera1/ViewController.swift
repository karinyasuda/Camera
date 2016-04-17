//
//  ViewController.swift
//  Camera1
//
//  Created by Karin on 2016/04/06.
//  Copyright © 2016年 Karin. All rights reserved.
//

import UIKit
import CoreImage
import Photos

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    //撮った写真を表示させるため
    @IBOutlet var cameraImage : UIImageView!
    @IBOutlet var saveButton : UIButton!
    @IBOutlet var selectButton : UIButton!
    @IBOutlet var takePhotoButton:UIButton!
    
    
    //filterの設定をこのCollectionViewにつなげていきたい。
    @IBOutlet weak var collectionView: UICollectionView!

    //セピア加工用のボタン
    @IBOutlet var sepiaButton:UIButton!
    @IBOutlet var blurButton:UIButton!
    
    let imageArray = ["sepia.jpg","sepia.jpg","sepia.jpg","","","","","","",""]
    let labelArray = ["sepia","blur","another","","","","","","",""]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    //MARK:Cellの設定
    //Cellに値を設定する
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! FilterCollectionViewCell
        
        cell.backgroundColor = UIColor.orangeColor()
//        cell.filterlabel.text = indexPath.row.description
        cell.filterlabel.text = "\(labelArray[indexPath.row])"
        cell.exampleimage.image = UIImage(named: "sepia.jpg")
        
        
        return cell
    }
    
    
    //Cellの総数を返す
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    
    //Cellが選択されたときに呼び出される
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Num: \(indexPath.row)")
        print("\(labelArray[indexPath.row])")

        if indexPath.row == 0{
            sepia()
        }else if indexPath.row == 1{
            Blur()
        }else if indexPath.row == 2{
            another()
        }else if indexPath.row == 3{
            mono()
        
        }
    }
    

    
    
    
    
    
    //写真を撮る　カメラの起動
    @IBAction func takePhoto(){
    
        //カメラの使用が可能かを調べる
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
        
            let imagepicker:UIImagePickerController = UIImagePickerController()
            imagepicker.delegate = self
            //カメラへのアクセス
            imagepicker.sourceType = UIImagePickerControllerSourceType.Camera
            self.presentViewController(imagepicker, animated: true, completion: nil)
        
        }
            //難しければ、"error"とログを表示
        else{
            print("error")
        }
    
    }
    
    
    
    @IBAction func selectPhoto(){
        //フォトライブラリにアクセスが可能かを調べる
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            
            let imagepicker:UIImagePickerController = UIImagePickerController()
            imagepicker.delegate = self
            //カメラへのアクセス
            imagepicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            
            imagepicker.allowsEditing = true
            
            self.presentViewController(imagepicker, animated: true, completion: nil)
            
        }
            //難しければ、"error"とログを表示
        else{
            print("error")
        }
    }
    
    //imageviewに表示されているものをカメラロールに保存
    @IBAction func save (){
        var imageView:UIImage!
        imageView = cameraImage.image
        
        if imageView != nil{
            UIImageWriteToSavedPhotosAlbum(imageView, self, nil, nil)
            
            print("save")
        }
    }
    
    
    //撮影終了時に呼び出される
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if info [UIImagePickerControllerOriginalImage] != nil {
            
            cameraImage.image = (info[UIImagePickerControllerOriginalImage]  as? UIImage!)!
        }
        //閉じる処理？
        dismissViewControllerAnimated(true, completion: nil)

    }

 
    
    
    func sepia(){
//    MARK:SepiaFilter
        let mySepiaFilter = CIFilter(name: "CISepiaTone")
        
        mySepiaFilter!.setValue(CIImage(image: cameraImage.image!), forKey: kCIInputImageKey)
        
        mySepiaFilter!.setValue(1.0, forKey: kCIInputIntensityKey)
        
        let myOutputImage : CIImage = mySepiaFilter!.outputImage!
        
        cameraImage.image = UIImage(CIImage: myOutputImage)
        
        cameraImage.setNeedsDisplay()
    }
    
    
    func Blur(){
        
        let myBlurFilter = CIFilter(name: "CIGaussianBlur")
        
        myBlurFilter!.setValue(CIImage(image: cameraImage.image!), forKey: kCIInputImageKey)
        
//        myBlurFilter!.setValue(1.0, forKey: kCIInputIntensityKey)
        
        let myOutputImage2 : CIImage = myBlurFilter!.outputImage!
        
        cameraImage.image = UIImage(CIImage: myOutputImage2)
        
        cameraImage.setNeedsDisplay()
    
    
    }
    func another(){
//            MARK:RGBColorFilterの付け方をメモとして残したかったので。
//                CIImage *cameraImage = [CIImage imageWithCGImage:uiImage.CGImage]
                // カラーエフェクトを指定してCIFilterをインスタンス化.
                let myColorFilter = CIFilter(name: "CIColorCrossPolynomial")
        
                // イメージの!セット.
                myColorFilter!.setValue(CIImage(image: cameraImage.image!), forKey: kCIInputImageKey)
        
                let r: [CGFloat] = [0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
                let g: [CGFloat] = [0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
                let b: [CGFloat] = [1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
        
                // モノクロ化するための値の調整.
                myColorFilter!.setValue(CIVector(values: r, count: 10), forKey: "inputRedCoefficients")
                myColorFilter!.setValue(CIVector(values: g, count: 10), forKey: "inputGreenCoefficients")
                myColorFilter!.setValue(CIVector(values: b, count: 10), forKey: "inputBlueCoefficients")
        
                // フィルターを通した画像をアウトプット.
                let myOutputImage : CIImage = myColorFilter!.outputImage!
        
                // 再びUIViewにセット.
                cameraImage.image = UIImage(CIImage: myOutputImage)
                
                // 再描画.
                cameraImage.setNeedsDisplay()
    }
    
    
    func mono(){
    
        // カラーエフェクトを指定してCIFilterをインスタンス化.
        let myMonochromeFilter = CIFilter(name: "CIColorMonochrome")
        
        // イメージのセット.
        myMonochromeFilter!.setValue(CIImage(image: cameraImage.image!), forKey: kCIInputImageKey)
        
        // ものくろ化するための値の調整.
        myMonochromeFilter!.setValue(CIColor(red: 0.8, green: 0.8, blue: 0.8), forKey: kCIInputColorKey)
        myMonochromeFilter!.setValue(1.0, forKey: kCIInputIntensityKey)
        
        // フィルターを通した画像をアウトプット.
        let myOutputImage : CIImage = myMonochromeFilter!.outputImage!
        
        // 再びUIViewにセット.
        cameraImage.image = UIImage(CIImage: myOutputImage)
        
        // 再描画.
        cameraImage.setNeedsDisplay()
    
    
    
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

