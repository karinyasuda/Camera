# Camera


//    MARK:RGBColorFilterの付け方をメモとして残したかったので。
//        CIImage *cameraImage = [CIImage imageWithCGImage:uiImage.CGImage]
        
//        // カラーエフェクトを指定してCIFilterをインスタンス化.
//        let myColorFilter = CIFilter(name: "CIColorCrossPolynomial")
//        
//        // イメージの!セット.
//        myColorFilter!.setValue(CIImage(image: cameraImage.image!), forKey: kCIInputImageKey)
//        
//        let r: [CGFloat] = [0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
//        let g: [CGFloat] = [0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
//        let b: [CGFloat] = [1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
//        
//        // モノクロ化するための値の調整.
//        myColorFilter!.setValue(CIVector(values: r, count: 10), forKey: "inputRedCoefficients")
//        myColorFilter!.setValue(CIVector(values: g, count: 10), forKey: "inputGreenCoefficients")
//        myColorFilter!.setValue(CIVector(values: b, count: 10), forKey: "inputBlueCoefficients")
//
//        // フィルターを通した画像をアウトプット.
//        let myOutputImage : CIImage = myColorFilter!.outputImage!
//        
//        // 再びUIViewにセット.
//        cameraImage.image = UIImage(CIImage: myOutputImage)
//        
//        // 再描画.
//        cameraImage.setNeedsDisplay()
//    
    
