//
//  ManualUploadController.swift
//  teamtracker
//
//  Created by Robby Michels on 23-05-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog

class ManualUploadController: UIViewController {
    var recoveryClicked = false
    var raceClicked = false
    var trainClicked = false
    var type = ""
    var inputfields = [UITextField]()
    var numericInputFields = [UITextField]()
    
    var sportChoice: String!
    var sportChoiceImage: UIImage!
    @IBOutlet weak var headerView: View!
    @IBOutlet weak var sportImage: ImageView!
    @IBOutlet weak var sportLbl: Label!
    @IBOutlet weak var changeSportLbl: Label!
    
    @IBOutlet weak var titleLbl: Label!
    @IBOutlet weak var titleTextfield: TextField!
    
    @IBOutlet weak var typeLbl: Label!
    @IBOutlet weak var typeTrainBtn: Button!
    @IBOutlet weak var typeRaceBtn: Button!
    @IBOutlet weak var typeRecoveryBtn: Button!
    
    @IBOutlet weak var dateLbl: Label!
    @IBOutlet weak var timeStartLbl: Label!
    @IBOutlet weak var dateTextfield: TextField!
    @IBOutlet weak var timeStartTextfield: TextField!
    
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var descriptionTextview: TextView!
    
    @IBOutlet weak var activityInformationLbl: Label!
    
    @IBOutlet weak var distanceLbl: Label!
    @IBOutlet weak var distanceTextfield: TextField!
    @IBOutlet weak var distanceUnitLbl: Label!

    @IBOutlet weak var durationLbl: Label!
    @IBOutlet weak var hourTextfield: TextField!
    @IBOutlet weak var hourLbl: Label!
    @IBOutlet weak var minTextfield: TextField!
    @IBOutlet weak var minLbl: Label!
    @IBOutlet weak var secondTextfield: TextField!
    @IBOutlet weak var secondLbl: Label!
    
    @IBOutlet weak var elevationLbl: Label!
    @IBOutlet weak var elevationTextfield: TextField!
    @IBOutlet weak var elevationUnitLbl: Label!
    
    @IBOutlet weak var tssLbl: Label!
    @IBOutlet weak var tssTextfield: TextField!
    @IBOutlet weak var tssUnitLbl: Label!
    
    
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var submitBtn: Button!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = StringConstants.viewTitles.manualUpload.rawValue
        
        setStyling()
    }
    
    @IBAction func onClickRecovery(_ sender: Any) {
        typeRecoveryBtn.setButtonClickedState()
        recoveryClicked = true
        type = StringConstants.trainingType.recovery.rawValue
        
        if(raceClicked) {
            typeRaceBtn.setButtonNormalState()
            raceClicked = false
        } else if(trainClicked) {
            typeTrainBtn.setButtonNormalState()
            trainClicked = false
        }
    }
    
    @IBAction func onClickRace(_ sender: Any) {
        typeRaceBtn.setButtonClickedState()
        raceClicked = true
        type = StringConstants.trainingType.race.rawValue
        
        if(recoveryClicked) {
            typeRecoveryBtn.setButtonNormalState()
            recoveryClicked = false
        } else if(trainClicked) {
            typeTrainBtn.setButtonNormalState()
            trainClicked = false
        }
    }
    
    @IBAction func onClickTrain(_ sender: Any) {
        typeTrainBtn.setButtonClickedState()
        trainClicked = true
        type = StringConstants.trainingType.train.rawValue
        
        if(recoveryClicked) {
            typeRecoveryBtn.setButtonNormalState()
            recoveryClicked = false
        } else if(raceClicked) {
            typeRaceBtn.setButtonNormalState()
            raceClicked = false
        }
    }
    
    @IBAction func onClickSubmit(_ sender: Any) {
        let loadingIndicator = UIViewController.displaySpinner(onView: self.view)

        errorLbl.text = ""
        submitBtn.setButtonInactive()
        
        fillArrays()
        
        Styling.resetBorderColorOnAll(textfields: inputfields)
        typeRecoveryBtn.clearBorderColor()
        typeRaceBtn.clearBorderColor()
        typeTrainBtn.clearBorderColor()
        descriptionTextview.clearBorderColor()
        
        if(InputHandler.isInputEmpty(inputFields: inputfields, errorLabel: errorLbl)){
            // one or more input fields are empty
            submitBtn.setButtonsActive()
            UIViewController.removeSpinner(spinner: loadingIndicator)

            return
        }
        if(type.elementsEqual("")) {
            typeRecoveryBtn.setErrorBorder()
            typeRaceBtn.setErrorBorder()
            typeTrainBtn.setErrorBorder()
            errorLbl.text = StringConstants.typeOfTraining
            submitBtn.setButtonsActive()
            UIViewController.removeSpinner(spinner: loadingIndicator)

            return
        }
        
        if(descriptionTextview.text.elementsEqual("")) {
            descriptionTextview.setErrorBorder()
            errorLbl.text = StringConstants.activityDescription
            self.submitBtn.setButtonsActive()

            UIViewController.removeSpinner(spinner: loadingIndicator)
            
            return
        }
        
        if let date = dateTextfield.text {
            if(!Regexp.isDateValid(date: date)) {
                errorLbl.text = StringConstants.date
                Styling.errorBorderColor(textfield: dateTextfield)
            
                self.submitBtn.setButtonsActive()
                UIViewController.removeSpinner(spinner: loadingIndicator)
                
                return
            }
        }
        
        if let time = timeStartTextfield.text {
            if(!Regexp.isTimeValid(time: time)) {
                errorLbl.text = StringConstants.timeStamp
                self.submitBtn.setButtonsActive()
                UIViewController.removeSpinner(spinner: loadingIndicator)

                return
            }
        }
        
        if(InputHandler.isInputInteger(inputfields: numericInputFields, errorLbl: errorLbl)) {
            // one or more fields don't contain numerics
            submitBtn.setButtonsActive()
            UIViewController.removeSpinner(spinner: loadingIndicator)

            return
        }
        
        let userDataHandler = UserDataHandler(email: "")
        
        userDataHandler.activityUpload(sport: sportChoice, title: titleTextfield.text!, type: type, date: dateTextfield.text!, time: timeStartTextfield.text!, description: descriptionTextview.text, distance: distanceTextfield.text!, durationHour: hourTextfield.text!, durationMin: minTextfield.text!, durationSeconds: secondTextfield.text!, elevation: elevationTextfield.text!, tss: tssTextfield.text!) { (result) in
            UIViewController.removeSpinner(spinner: loadingIndicator)

            switch result {
                case .Error(let errorMsg) :
                    DispatchQueue.main.async {
                        ErrorMessage.setErrorMessage(label: self.errorLbl, message: errorMsg)
                        self.submitBtn.setButtonsActive()
                        return
                    }
                case .Success():
                    DispatchQueue.main.async {
                        self.showConfirmDialog()
                        self.submitBtn.setButtonsActive()
                        return
                    }
            }
        }
    }
    
    func setStyling() {
        headerView.gradientBackground(startColor: Colors.blue, endColor: Colors.lightBrightGreen)
        sportLbl.text = sportChoice
        changeSportLbl.text = StringConstants.changeSport
        sportImage.image = sportChoiceImage.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        sportImage.tintColor = UIColor.white
        typeTrainBtn.roundCornersLeft()
        typeRecoveryBtn.roundCornersRight()
        titleTextfield.roundViewCorners()
        
        dateTextfield.roundViewCorners()
        timeStartTextfield.roundViewCorners()
        
        descriptionTextview.roundViewCorners()
        
        distanceTextfield.roundCornersLeft()
        distanceUnitLbl.roundCornersRight()
        
        hourTextfield.roundCornersLeft()
        hourLbl.roundCornersRight()
        minTextfield.roundCornersLeft()
        minLbl.roundCornersRight()
        secondTextfield.roundCornersLeft()
        secondLbl.roundCornersRight()
        
        elevationTextfield.roundCornersLeft()
        elevationUnitLbl.roundCornersRight()
        
        tssTextfield.roundCornersLeft()
        tssUnitLbl.roundCornersRight()
        submitBtn.roundViewCorners()
        submitBtn.backgroundColor = Colors.secondaryColor
    }
    
    /*
     * For creating and showing the confirmation dialog
     */
    func showConfirmDialog() {
        let title = StringConstants.uploadActivitySuccessDialog.title.rawValue
        let message = StringConstants.uploadActivitySuccessDialog.message.rawValue
        
        let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal,
                                transitionStyle: .zoomIn, gestureDismissal: true, hideStatusBar: true)
        let buttonOne = DefaultButton(title: StringConstants.uploadActivitySuccessDialog.buttonTitle.rawValue) {
            Styling.emptyTextfields(textfields: self.inputfields)
            self.descriptionTextview.text = ""
            self.elevationTextfield.text = ""
            self.tssTextfield.text = ""
        }
        popup.addButton(buttonOne)
        present(popup, animated: true, completion: nil)
    }
    
    func fillArrays() {
        inputfields.append(titleTextfield)
        inputfields.append(dateTextfield)
        inputfields.append(timeStartTextfield)
        inputfields.append(distanceTextfield)
        inputfields.append(hourTextfield)
        inputfields.append(minTextfield)
        inputfields.append(secondTextfield)
        inputfields.append(hourTextfield)
        
        numericInputFields.append(distanceTextfield)
        numericInputFields.append(hourTextfield)
        numericInputFields.append(minTextfield)
        numericInputFields.append(secondTextfield)
    }
}
