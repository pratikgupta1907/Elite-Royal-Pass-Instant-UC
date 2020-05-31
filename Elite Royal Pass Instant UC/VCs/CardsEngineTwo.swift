//
//  CardEngineTwo.swift
//  Elite Royal Pass Instant UC
//
//  Created by Junaid Mukadam on 16/05/20.
//  Copyright © 2020 Saif Mukadam. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import GoogleMobileAds

class CardsEngineTwo: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var congratulations: UILabel!
    
    @IBOutlet weak var addtoWallet: UIButton!
    
    @IBOutlet weak var firstPV: UIPickerView!
    @IBOutlet weak var secoundPV: UIPickerView!
    @IBOutlet weak var thirdPV: UIPickerView!
    @IBOutlet weak var fourthPV: UIPickerView!
    let pickerDataSize = 1000000
    
    let gradePickerValues = ["0",".","0","1", "2", "3","4","5","6","7","8","9",".","0","1", "2", "3","4","5","6","7","8","9",".","0","1", "2", "3","4","5","6","7","8","9",".","0","1", "2", "3","4","5","6","7","8","9",".","0","1", "2", "3","4","5","6","7","8","9"]
    
    var f9 = 55 // 9
    var f8 = 54 //8
    var f7 = 53 //7
    var ff6 = 52 //6
    var ff5 = 51  //5
    var ff4 = 50 //4
    var ff3 = 49 //3
    var ff2 = 48  //2
    var ff1 = 47 //1
    var ffff0 = 46 //0
    var ffdot = 45 //.
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    
    @IBAction func addtoWallet(_ sender: Any) {
        addtoWallet.isHidden = true
        navigationController?.navigationBar.tintColor = UIColor.systemOrange
        self.navigationItem.hidesBackButton = false
        ShowAd(selfo: self, showAdafterSecound: 0)
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 40.0
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        60
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerDataSize
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = UILabel()
        if let v = view as? UILabel { label = v }
        label.font = UIFont (name: "Montserrat-Bold", size: 50)
        label.text =  gradePickerValues[row % gradePickerValues.count]
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        return label
    }
    
    
    
    @IBOutlet weak var outerCard: UIView!
    var whatisThis = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = UIColor.systemOrange
        navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        
        addtoWallet.layer.cornerRadius = 10
        
        outerCard.layer.cornerRadius = 13
        outerCard.layer.borderWidth = 3
        outerCard.layer.borderColor = UIColor.systemOrange.cgColor
        self.firstPV.dataSource = self
        self.firstPV.delegate = self
        
        self.secoundPV.dataSource = self
        self.secoundPV.delegate = self
        
        self.thirdPV.dataSource = self
        self.thirdPV.delegate = self
        
        self.fourthPV.dataSource = self
        self.fourthPV.delegate = self
        
        
        
        let pm:Parameters = [
            "id":UserDefaults.standard.getid(),
            "TaskName":whatisThis
        ]
        
        postWithParameter(Url: "TasksEngine.php", parameters: pm) { (JSON, Error) in
            
            if JSON["code"].string != "002" {
                let floatinString =  String(JSON["reward"].float ?? 0.00)
                let Myarray = Array(floatinString)
                print(Myarray)
                
                var first = 0
                var secound = 0
                var third = 0
                var fourth = 0
                
                for i in 0...3 {
                    if i == 0 {
                        first = self.whatisInt(a: String(Myarray[0]))
                    }else if i == 1 {
                        secound = self.whatisInt(a: String(Myarray[1]))
                    }else if i == 2 {
                        third = self.whatisInt(a: String(Myarray[2]))
                    }else {
                        fourth = self.whatisInt(a: String(Myarray[3]))
                    }
                }
                
                self.whatsispoint(putin1: first, putin2: secound, putin3: third, putin4: fourth)
                
            }
            
        }
    }
    
    func whatsispoint(putin1:Int,putin2:Int,putin3:Int,putin4:Int){
        
        self.firstPV.slowSelectRow(putin1, inComponent: 0)
        self.secoundPV.slowSelectRow(putin2, inComponent: 0)
        self.thirdPV.slowSelectRow(putin3, inComponent: 0)
        self.fourthPV.slowSelectRow(putin4, inComponent: 0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            
            self.addtoWallet.isHidden = false
            self.congratulations.isHidden = false
            
        }
    }
    
    
    func whatisInt(a:String) -> Int {
        if a == "9"{
            return 55
        }else if a == "8"{
            return 54
        }else if a == "7"{
            return 53
        }else if a == "6"{
            return 52
        }else if a == "5"{
            return 51
        }else if a == "4"{
            return 50
        }else if a == "3"{
            return 49
        }else if a == "2"{
            return 48
        }else if a == "1"{
            return 47
        }else if a == "0"{
            return 46
        }else{
            return 45
        }
    }
    
    
}


extension UIPickerView {
    
    func slowSelectRow(_ row: Int, inComponent component: Int = 0) {
        let currentSelectedRow = selectedRow(inComponent: component)
        
        guard currentSelectedRow != row else {
            return
        }
        
        let diff = (currentSelectedRow > row) ? -1 : 1
        let newRow = currentSelectedRow + diff
        selectRow(newRow, inComponent: component, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.slowSelectRow(row, inComponent: component)
        }
    }
}
