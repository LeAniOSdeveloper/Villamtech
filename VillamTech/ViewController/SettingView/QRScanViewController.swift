//
//  QRScanViewController.swift
//  VillamTech
//
//  Created by Ân Lê on 6/11/20.
//  Copyright © 2020 Ân Lê. All rights reserved.
//

import UIKit
import AVFoundation
class QRScanViewController: UIViewController {
    var captureSession : AVCaptureSession!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var qrCodeFrameView: UIView?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        captureSession = AVCaptureSession()
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back)
        
        guard let captureDevice = deviceDiscoverySession.devices.first else {
            print("Failed to get the camera device")
            return
        }
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Set the input device on the capture session.
            captureSession.addInput(input)
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession.addOutput(captureMetadataOutput)
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)
        captureSession.startRunning()
        
        //        view.bringSubviewToFront(messageLabel)
        //        view.bringSubviewToFront(topbar)
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension QRScanViewController:AVCaptureMetadataOutputObjectsDelegate{
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        qrCodeFrameView = UIView()
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            //            messageLabel.text = "No QR code is detected"
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if metadataObj.stringValue != nil {
                
                if metadataObj.stringValue != "" {
//                 if let qrCodeFrameView = qrCodeFrameView {
//                     qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
//                     qrCodeFrameView.layer.borderWidth = 2
//                     self.view.addSubview(qrCodeFrameView)
//                     self.view.bringSubviewToFront(qrCodeFrameView)
                        
                    let alert = UIAlertController(title: "Tên thiết bị", message:metadataObj.stringValue , preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action ) in

//                        self.returndata(metadataObj.stringValue ?? "")
                        self.navigationController?.popToRootViewController(animated: true)
                        let previousViewController = self.navigationController?.viewControllers.last as! SettingViewController
                        previousViewController.returndata(metadataObj.stringValue ?? "")
                    }))
                    self.present(alert, animated: true)
                }else {
                    let alert = UIAlertController(title: "Tên thiết bị", message: "QR không hợp lệ", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Thoát ", style: .default, handler: nil))
                }
//                 }
                //                messageLabel.text = metadataObj.stringValue
            }
        }
    }
}
