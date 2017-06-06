//
//  ItemDetailsVC.swift
//  WishList
//
//  Created by LI MENG on 2017-05-31.
//  Copyright © 2017 LI MENG. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var priceField: CustomTextField!
    @IBOutlet weak var detailsField: CustomTextField!
    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var selectedStore: UILabel!
    
    @IBOutlet weak var thumbImg: UIImageView!
    
    var stores = [Store]()
    var itemToEdit: Item!
    var imagePicer: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // wipe out the nav bar back title
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        storePicker.delegate = self
        storePicker.dataSource = self
        
        imagePicer = UIImagePickerController()
        imagePicer.delegate = self
        
        generateTestData()
        ad.saveContext()
        attemptFetch()
        
        if itemToEdit != nil {
            editItem()
        }
        
    }

    // implement four func for storePicker (UIPickerView)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        return store.name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedStore.text = stores[row].name
    }
    
    // test data
    func generateTestData() {
        
        let store = Store(context: context)
        store.name = "Amazon"
        let store2 = Store(context: context)
        store2.name = "Best Buy"
        let store3 = Store(context: context)
        store3.name = "eBay"
        let store4 = Store(context: context)
        store4.name = "Target"
        let store5 = Store(context: context)
        store5.name = "Shoppers"
        let store6 = Store(context: context)
        store6.name = "Walmart"
    }
    
    // fetch data
    func attemptFetch() {
        
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do {
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        } catch {
            // handle the error
        }
    }
    
    // Edit the text fields, press the "Save Item" button and save them to Item
    @IBAction func saveBtnPressed(_ sender: UIButton) {
        
        var item: Item!
        if itemToEdit == nil {
            item = Item(context: context)   // to add new item
        } else {
            item = itemToEdit               // to update the existing item
        }
        
        // set item properties
        if let title = titleField.text {
            item.title = title
        }
        if let price = priceField.text {
            item.price = (price as NSString).doubleValue
        }
        if let details = detailsField.text {
            item.details = details
        }
        // set item properties (image)
        let picture = Image(context: context)   // build a Image Entity
        picture.image = thumbImg.image
        item.toImage = picture
        
        // set item relationship
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        
        // save
        ad.saveContext()
        
        // dimiss this view
        _ = navigationController?.popViewController(animated: true)
    }
    
    // Edit the existing Item 
    func editItem() {
        if let item = itemToEdit {
            titleField.text = item.title
            priceField.text = "\(item.price)"
            detailsField.text = item.details
            thumbImg.image = item.toImage?.image as? UIImage
            
            // set store
            if let store = item.toStore {
                var index = 0
                repeat {
                    if store.name == stores[index].name {
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index += 1
                } while (index < stores.count)
            }
        }
    }
    
    // delete the item when the trash button is pressed
    @IBAction func trashBtnPressed(_ sender: Any) {
        
        if itemToEdit != nil {
            context.delete(itemToEdit)
            ad.saveContext()
        }
        
        _ = navigationController?.popViewController(animated: false)
    }
    
    
    // implement the func of UIImagePickerController
    // get the image and set it to thumbImg
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            thumbImg.image = img
        }
        imagePicer.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addImage(_ sender: UIButton) {
        present(imagePicer, animated: true, completion: nil)
    }

    
}
