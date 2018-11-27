//
//  UserProvider.swift
//  teamtracker
//
//  Created by Robby Michels on 22-02-18.
//  Copyright © 2018 Robby Michels. All rights reserved.
//

import Foundation
import UIKit

struct UserProvider {    
    enum errorCodes: Int {
        case unAuthorized = 401
        case noJSON = -1
        case internalServerError = 500
        case notFound = 404
        case statusOk = 200
    }
    enum Results<T> {
        case Success(T)
        case EmptySuccess()
        case Error(String)
    }
    
    //make api call to login a user, return the json data received from the api.
    static func login(email: String, password: String, completion: @escaping (Results<[String: Any]>) -> Void) -> Void {
        let param: String = "email=" + email + "&password=" + password
        
        var request: URLRequest
        do {
            request = try URLProvider.postURLRequest(params: param, endpoint: Config.apiLogin)
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                // checking the response code, if its not 200 (STATUS OK) return the error.
                if let response = response as? HTTPURLResponse {
                    if let data = data {
                        guard let json = (try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers))
                            as? [String: Any]
                            else {
                                // Data not containing JSON Format
                                completion(.Error(StringConstants.noJSON))
                                return
                        }
                        
                        //status ok.
                        if(response.statusCode == errorCodes.statusOk.rawValue) {
                            // TODO: Save user data, brearertoken is saved for now.
                            //let userObject = successobject["user"] as! [String: Any]
                            completion(.Success(json))
                            // Catch this case when the api endpoint could not be found.
                        } else if(response.statusCode == errorCodes.notFound.rawValue) {
                            completion(.Error(StringConstants.pageNotFound))
                        } else {
                            // Return any other error given by api
                            completion(.Error(json["error"] as! String))
                        }
                    }
                }
                
                if let _ = error {
                    completion(.Error(StringConstants.somethingWentWrong))
                }
            }.resume()
        } catch URLProvider.ErrorToThrow.NoValidURL {
            completion(.Error(StringConstants.somethingWentWrong))
        } catch {
            // Catch to misslead Swift
        }
    }
    
    //make an api call to validate the invite code and the email requested by user. Will return the response code.
    static func validateInviteCodeEmail(email: String, uniqueTeamcode: String, completion: @escaping (Results<[String: Any]>) -> Void)  -> Void {
        let param: String = "email=" + email + "&referral_code=" + uniqueTeamcode
        var request: URLRequest
        do {
            request = try URLProvider.postURLRequest(params: param, endpoint: Config.apiValidateInvite)
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let response = response as? HTTPURLResponse {
                    if let data = data {
                        guard let json = (try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers))
                            as? [String: Any]
                            else {
                                // Data not containing JSON Format
                                completion(.Error(StringConstants.noJSON))
                                return
                        }
                        
                        if let errorObject = json["errors"] as? [String: Any] {
                            if let inactiveError = errorObject["inactive"] as? [Any] {
                                completion(.Error(inactiveError[0] as! String))
                                return
                            } else  if let emailError = errorObject["email"] as? [Any] {
                                completion(.Error(emailError[0] as! String))
                                return
                            } else if let referralCodeError = errorObject["referral_code"] as? [Any] {
                                completion(.Error(referralCodeError[0] as! String))
                                return
                            } else if let expiredError = errorObject["expired"] as? [Any] {
                                completion(.Error(expiredError[0] as! String))
                                return
                            }
                        }
                        
                        //status ok.
                        if(response.statusCode == errorCodes.statusOk.rawValue) {
                            completion(.EmptySuccess())
                            return
                            // Catch this case when the api endpoint could not be found.
                        } else if(response.statusCode == errorCodes.notFound.rawValue) {
                            completion(.Error(StringConstants.pageNotFound))
                            return
                        } else {
                            completion(.Error(StringConstants.somethingWentWrong))
                            return
                        }
                    }
                }
                
                if let _ = error {
                    completion(.Error(StringConstants.somethingWentWrong))
                }
            }.resume()
        } catch URLProvider.ErrorToThrow.NoValidURL {
            completion(.Error(StringConstants.somethingWentWrong))
        } catch {
            // Catch to misslead Swift.
        }
    }
    
    //make an api call to register an athlete, receive a response and return that.
    static func registerAthlete(registerAccount: Register, completion: @escaping (Results<[String: Any]>) -> Void) -> Void {
        let param: String = "first_name=" + registerAccount.getFirstname() +
            "&last_name=" + registerAccount.getLastname() + "&email=" + registerAccount.getEmail() + "&password=" + registerAccount.getPassword() +
            "&referral_code=" + registerAccount.getReferralCode()
        
        var request: URLRequest
        do {
            request = try URLProvider.postURLRequest(params: param, endpoint: Config.apiRegisterByInvite)
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let response = response as? HTTPURLResponse {
                    if let data = data {
                        if let json = (try? JSONSerialization.jsonObject(with: data, options: [])),
                        let jsonArray = json as? [String: Any] {
                            //This scenario should ever run
                            if let errorObject = jsonArray["error"] as? [String: Any] {
                                if let firstnameError = errorObject["first_name"] as? [Any] {
                                    completion(.Error(firstnameError[0] as! String))
                                } else if let lastnameError = errorObject["last_name"] as? [Any] {
                                    completion(.Error(lastnameError[0] as! String))
                                } else if let emailError = errorObject["email"] as? [Any] {
                                    completion(.Error(emailError[0] as! String))
                                } else if let passwordError = errorObject["password"] as? [Any] {
                                    completion(.Error(passwordError[0] as! String))
                                } else if let referralCodeError = errorObject["referral_code"] as? [Any] {
                                    completion(.Error(referralCodeError[0] as! String))
                                }
                            }
                        }else {
                            // Data not containing JSON Format
                            completion(.Error(StringConstants.noJSON))
                            return
                        }
                        
                        //status ok.
                        if(response.statusCode == errorCodes.statusOk.rawValue) {
                            completion(.EmptySuccess())
                            // Catch this case when the api endpoint could not be found.
                        } else if(response.statusCode == errorCodes.notFound.rawValue) {
                            completion(.Error(StringConstants.pageNotFound))
                        }
                    }
                }
                
                if let _ = error {
                    completion(.Error(StringConstants.somethingWentWrong))
                }
            }.resume()
        } catch URLProvider.ErrorToThrow.NoValidURL {
            completion(.Error(StringConstants.somethingWentWrong))
        } catch {
            // Catch to misslead Swift.
        }
    }
    
    static func forgotPassword(email: String, completion: @escaping (Results<[String: Any]>) -> Void) -> Void {
        let params: String = "email=" + email
        var request: URLRequest
        do {
            request = try URLProvider.postURLRequest(params: params, endpoint: Config.apiForgotPassword)
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let response = response as? HTTPURLResponse {
                    if let data = data {
                        guard let json = (try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers))
                            as? [String: Any]
                            else {
                                // Data not containing JSON Format
                                completion(.Error(StringConstants.noJSON))
                                return
                        }
                        //status ok.
                        if(response.statusCode == errorCodes.statusOk.rawValue) {
                            completion(.Success(json))
                        // Catch this case when the api endpoint could not be found.
                        } else if(response.statusCode == errorCodes.notFound.rawValue) {
                            if let error = json["error"] as? String {
                                completion(.Error(error))
                            } else {
                                completion(.Error(StringConstants.pageNotFound))
                            }
                        } else {
                            // Return any other error given by api
                            completion(.Error(json["error"] as! String))
                        }
                    }
                }
                
                if let _ = error {
                    completion(.Error(StringConstants.somethingWentWrong))
                }
            }.resume()
        } catch URLProvider.ErrorToThrow.NoValidURL {
            completion(.Error(StringConstants.somethingWentWrong))
        } catch {
            // Catch to misslead swift.
        }
    }
    
    static func uploadActivity(sport: String, title: String, type: String, date: String, time: String, description: String, distance: String, durationHour: String, durationMin: String, durationSeconds: String, elevation: String, tss: String, completion: @escaping (Results<[String: Any]>) -> Void) -> Void {
        let params: String = "sport=" + sport + "&title=" + title + "&type=" + type + "&datetime=" + date + " " + time + "&description=" + description + "&distance=" + distance + "&elevation=" + elevation + "&tss=" + tss + "&duration_hr=" + durationHour + "&duration_min=" + durationMin + "&duration_sec=" + durationSeconds
        
        var request: URLRequest
        do{
            request = try URLProvider.postURLRequestWithBearerToken(params: params, endpoint: Config.createActivity)
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let response = response as? HTTPURLResponse {
                    if let data = data {
                        guard let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String: Any] else {
                            completion(.Error(StringConstants.noJSON))
                            return
                        }
                        
                        //status ok.
                        if(response.statusCode == errorCodes.statusOk.rawValue) {
                            completion(.Success(json))
                            // Catch this case when the api endpoint could not be found.
                        } else if(response.statusCode == errorCodes.notFound.rawValue) {
                            if let error = json["error"] as? String {
                                completion(.Error(error))
                            } else {
                                completion(.Error(StringConstants.pageNotFound))
                            }
                        } else {
                            // Return any other error given by api
                            completion(.Error(StringConstants.somethingWentWrong))
                        }
                    }
                    
                    if let _ = error {
                        completion(.Error(StringConstants.somethingWentWrong))
                    }
                }
            }.resume()
        } catch URLProvider.ErrorToThrow.NoValidURL {
            completion(.Error(StringConstants.somethingWentWrong))
        } catch URLProvider.ErrorToThrow.NoBearerToken {
            completion(.Error(StringConstants.somethingWentWrong))
        } catch {
            // Catch to misslead swift.
        }
    }
}
