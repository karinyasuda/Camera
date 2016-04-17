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
    
    let imageArray = ["sepia.jpg","sepia.jpg","sepia.jpg"]
    let labelArray = ["","",""]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    //MARK:Cellの設定
    //Cellに値を設定する
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! FilterCollectionViewCell
        
        cell.backgroundColor = UIColor.orangeColor()
        cell.filterlabel.text = "sepia"
        cell.exampleimage.image = UIImage(named: "sepia.jpg")
        
        return cell
    }
    
    
    //Cellの総数を返す
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    
    //Cellが選択されたときに呼び出される
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("sepia")
//
//        let mySepiaFilter = CIFilter(name: "CISepiaTone")
//        
//        mySepiaFilter!.setValue(CIImage(image: cameraImage.image!), forKey: kCIInputImageKey)
//        
//        mySepiaFilter!.setValue(1.0, forKey: kCIInputIntensityKey)
//        
//        let myOutputImage : CIImage = mySepiaFilter!.outputImage!
//        
//        cameraImage.image = UIImage(CIImage: myOutputImage)
//        
//        cameraImage.setNeedsDisplay()
        sepia()
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
    
    
    
    @IBAction func Blur(sender:UIButton){
        
        let myBlurFilter = CIFilter(name: "CIGaussianBlur")
        
        myBlurFilter!.setValue(CIImage(image: cameraImage.image!), forKey: kCIInputImageKey)
        
        myBlurFilter!.setValue(1.0, forKey: kCIInputIntensityKey)
        
        let myOutputImage2 : CIImage = myBlurFilter!.outputImage!
        
        cameraImage.image = UIImage(CIImage: myOutputImage2)
        
        cameraImage.setNeedsDisplay()
    
    
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

