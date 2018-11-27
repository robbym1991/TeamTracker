//
//  String.swift
//  teamtracker
//
//  Created by Robby Michels on 18-04-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation

struct StringConstants {
    // PRAGMA MARK: Animation identifiers
    static let launchscreenAnimation = "ios-loader-solid-multiple"
    
    // PRAGMA MARK: placeholders
    static let placeHolderText = "Frankie de Jong"
    static let placeholderImage = "headshotPlaceholder"
    static let placeholderEvent = "Sportpark de Toekomst"
    static let placeholderTimeEvent = "10:20 - 12:30"
    static let placeholderLocationIcon = "Optimplaces"
    static let placeholderTimeIcon = "Classicswatch"
    
    // PRAGMA MARK: UILabel text
    static let forgotEmailSuccessMessage = "Success! An Email has been send to:"
    static let changeSport = "Please go back to change sport."
    
    // PRAGMA MARK: Error Messages
    static let wrongEmail = "Email not found."
    static let nonValidEmail = "Please insert an valid email."
    static let emptyTextfield = "Inputfield can not be empty."
    static let somethingWentWrong = "Oops, something went wrong."
    static let noJSON = "Data not containing json"
    static let pageNotFound = "Oops. It looks like our sporter has ran out of doping."
    static let typeOfTraining = "Please choose type of training."
    static let activityDescription = "Please add an activity description."
    static let numericInput = "Please insert numerics only. e.g. 2.3"
    static let timeStamp = "Please use a valid timestamp. e.g. 23:59"
    static let date = "Please use valid date. e.g. 2018-02-21"
    
    // PRAGMA MARK: Button Text
    static let cancel = "Cancel"
    static let next = "Next"
    static let backToLogin = "Back To Login"
    
    // PRAGMA MARK: View Titles/Sub-Titles
    static let forgotPasswordTitle = "Forgot Password"
    static let forgotPasswordSubtitle = "Enter your e-mail below to reset your password"
    static let chooseSport = "Which activity would you like to add?"
    
    // PRAGMA MARK: Textfield Title
    static let email = "Email"
    
    // PRAGMA MARK: Profile Menu Titles
    enum profileMenu: String {
        case settings = "Settings"
        case extraOption = "Extra Option"
        case logout = "Log Out"
    }
    
    enum viewTitles: String {
        case Home = "Home"
        case Workout = "Workout"
        case ThirthView = "ThirdView"
        case Statistics = "Statistics"
        case Menu = "Menu"
        case manualUpload = "Manually add activity"
    }
    
    enum trainingType: String {
        case train = "train"
        case recovery = "recovery"
        case race = "race"
    }
    
    enum uploadActivitySuccessDialog: String {
        case title = "Title"
        case message = "Your activity has been uploaded succesfully!"
        case buttonTitle = "Click here"
    }
    
    enum defaultsKeys: String {
        case bearerToken = "bearerToken"
        case fullname = "fullname"
        case roleType = "roletype"
        case avatarLink = "avatar"
    }
    
    enum loginView: String {
        case title = "Login"
        case noAccount = "No account yet?"
        case register = "Register"
        case email = "Email"
        case password = "Password"
        case passwordForgotten = "Password forgotten?"
    }
    enum registerView: String {
        case title = "Register"
        case trainerLbl = "I'm a trainer"
        case trainerDescription = "As a trainer you can schedule trainings, races and more."
        case athleteLbl = "I'm an athlete"
        case athleteDescription = "As an athlete you can upload trainings, races and more."
        case accountLbl = "Already got an account?"
        case loginLbl = "Login"
    }
    
    enum registerStepOneView: String {
        case title = "Register"
        case account = "Already got an account?"
        case login = "Login"
        case registerText = "Hello! Got an invitation from your trainer? Insert your unique teamcode and your email and register your account."
        case uniqueTeamcode = "Unique Teamcode"
        case email = "Email"
        case buttonText = "Next Step"
    }
    
    enum registerStepTwoView: String {
        case title = "Register"
        case account = "Already got an account?"
        case login = "Login"
        case registerText = "We need some information to create your account for: "
        case firstname = "Firstname"
        case lastname = "Lastname"
        case password = "Password"
        case passwordConfirm = "Password Confirm"
        case buttonText = "Create Account"
    }
    
    enum registerStepThreeView: String {
        case successMessage = "Congratulations! Your account has been created"
        case buttonText = "Return to login"
    }
    
    enum dashboardView: String {
        case nextEventDay = "Woe"
        case nextEventDate = "14"
        case nextEventTitle = "Next event"
        case nextEventDescription = "Race"
        case nextEventLocation = "Sportpark de Toekomst"
        case nextEventTime = "10:20 - 12:30"
        case upcommingEventTitle = "Upcomming events"
        case myTeamTitle = "My team"
    }
    
    enum graphTitles: String {
        case distance = "Distance"
        case elevation = "Elevation"
        case tss = "TSS"
        case duration = "Duration"
    }
}
