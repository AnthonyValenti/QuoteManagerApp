//
//  SecondViewController.swift
//  QuoteManagerV2
//
//  Created by Anthony Valenti on 2021-05-11.
//

import UIKit

class SecondViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    var pickerData: [String] = [String]()
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var addyTextField: UITextField!
    @IBOutlet weak var sqftTextField: UITextField!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    var sqft = 0.0
    var price = 0.0
    var cost = 0.0
    var addy = ""
    var tempString = ""
    var arrOfData = UDM.shared.defaults.object(forKey: "upcomingJobs") as? [String] ?? [String]()


  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.delegate=self
        self.picker.dataSource=self
        self.addyTextField.delegate=self
        self.sqftTextField.delegate=self
        pickerData = ["Seal", "Pressure Wash & Seal", "Pressure Wash, Sand & Seal"]
    }
    
    @IBAction func addyEdited(_ sender: UITextField) {
        if let text = sender.text, !text.isEmpty
        {
            addy=String(sender.text!)
        }
    }
    
    @IBAction func sqftEdited(_ sender: UITextField) {
        if let text = sender.text, !text.isEmpty
        {
            sqft=Double(sender.text!)!
        }
    }
    
  
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
 
    
    
    
    //Code for job picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) ->String?{
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedValue=pickerData[row] as String
        if(selectedValue=="Seal"){
            cost = sqft*0.48
            price = sqft*0.80
        }
        if(selectedValue=="Pressure Wash & Seal"){
            cost = sqft*0.50
            price = sqft*1.20
        }
        if(selectedValue=="Pressure Wash, Sand & Seal"){
            cost = sqft*0.60
            price = sqft*1.80
            
        }
        costLabel.text = String(cost)
        priceLabel.text = String(price)
    }
    @IBAction func doneButtonPressed(_ sender: Any) {
        tempString = addy + " Cost: " + String(cost) + " Price: " + String(price)
        arrOfData.append(tempString)
        UDM.shared.defaults.setValue(arrOfData, forKey: "upcomingJobs")
    }
    

 

}

class UDM {
    static let shared = UDM()
    let defaults = UserDefaults()
}
