//
//  ProfileMenuController.swift
//  teamtracker
//
//  Created by Robby Michels on 16-04-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation
import UIKit

class ProfileMenuViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var profileImage: ImageView!
    @IBOutlet weak var usernameLbl: Label!
    @IBOutlet weak var userDescriptionLbl: Label!
    @IBOutlet weak var settingsLbl: Label!
    @IBOutlet weak var extraOptionLbl: Label!
    @IBOutlet weak var logoutLbl: Label!
    
    @IBOutlet weak var settingsView: View!
    @IBOutlet weak var logoutView: View!
    @IBOutlet weak var extraOptionView: View!
    
    let imagePicker = UIImagePickerController()
    
    //function placeholders for profile menu
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        self.navigationItem.title = StringConstants.viewTitles.Menu.rawValue
        DispatchQueue.main.async {
            self.setStyling()
        }
    }
    
    func setUserDescription() {
        let defaults = UserDefaults.standard
        
        if let avatarLink = defaults.string(forKey: StringConstants.defaultsKeys.avatarLink.rawValue) {
            profileImage.downloadedFrom(link: avatarLink)
        }
        
        if let fullname = defaults.string(forKey: StringConstants.defaultsKeys.fullname.rawValue) {
            usernameLbl.text = fullname
        } else {
            usernameLbl.text = ""
        }

        if let roleType = defaults.string(forKey: StringConstants.defaultsKeys.roleType.rawValue) {
            userDescriptionLbl.text = roleType
        } else {
            userDescriptionLbl.text = ""
        }
    }
    
    func setStyling() {
        profileImage.roundCorner()
        
        // Replace this with cached data.
        setUserDescription()
        
        settingsLbl.text = StringConstants.profileMenu.settings.rawValue
        extraOptionLbl.text = StringConstants.profileMenu.extraOption.rawValue
        logoutLbl.text = StringConstants.profileMenu.logout.rawValue
        
        settingsView.roundViewCorners()
        settingsView.gradientBackground(startColor: Colors.lightBlue, endColor: Colors.darkerLightBlue)
        
        extraOptionView.roundViewCorners()
        extraOptionView.gradientBackground(startColor: Colors.lightTurquoise, endColor: Colors.lightGreenish)
        
        logoutView.roundViewCorners()
        logoutView.gradientBackground(startColor: Colors.darkBrown, endColor: Colors.lightBrown)
        
        // Add tap gestures to recognize someone clicking on a view.
        let tapSettings = UITapGestureRecognizer(target: self, action: #selector(self.onClickSettings))
        let tapExtraOptions = UITapGestureRecognizer(target: self, action: #selector(self.onClickExtraOption))
        let tapLogout = UITapGestureRecognizer(target: self, action: #selector(self.onClickLogout))
        let tapImage = UITapGestureRecognizer(target: self, action: #selector(self.onClickImage))
        profileImage.isUserInteractionEnabled = true

        settingsView.addGestureRecognizer(tapSettings)
        extraOptionView.addGestureRecognizer(tapExtraOptions)
        logoutView.addGestureRecognizer(tapLogout)
        profileImage.addGestureRecognizer(tapImage)
    }

    //Calls this function when the tap is recognized.
    @objc func onClickSettings() {
        // Placeholder for clicking on the Settings View.
    }

    //Calls this function when the tap is recognized.
    @objc func onClickExtraOption() {
        // Placeholder for clicking on the Extra Option View.
    }
    
    //Calls this function when the tap is recognized.
    @objc func onClickLogout() {
        self.performSegue(withIdentifier: SegueConstants.profileMenuToLogin, sender: self)
    }
    
    @objc func onClickImage() {
        // TODO: Check if the permission popup triggers on actual IOS Devices.
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    // Delegate functions for UIImagePicker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profileImage.contentMode = .scaleAspectFit
            profileImage.image = pickedImage
        }
 
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion:nil)
    }
}
