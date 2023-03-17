//
//  NetWorkService.swift
//  Weather
//
//  Created by Otto Dzhandzhuliya on 08.03.2023.
//

import Foundation
import Alamofire

class NetworkService {
    
    static func getInfoDate(completion: @escaping(_ border:BorderActivity) -> Void) {
        let url = "http://www.boredapi.com/api/activity/"
        guard let url = URL(string: url) else {
            return
        }
        let session = URLSession.shared
        session.dataTask(with: url) { data, _, error in
            guard let data = data else {
                if let error = error {
                    print(error)
                }
                return
            }
            do {
                let border = try JSONDecoder().decode(BorderActivity.self, from: data)
                completion(border)
            }
            catch {
                print(error)
            }
        }.resume()
    }
    
    static func getLatLon(city:String, completion: @escaping(_ latlon: GeoData) -> Void ) {
        let url = "https://api.openweathermap.org/geo/1.0/direct?q=\(city)&limit=5&appid=\(Network.apiKey)"
        guard let url = URL(string: url) else {
            return
        }
        let session = URLSession.shared
        session.dataTask(with: url) { data, _, error in
            guard let data = data else {
                if let error = error{
                    print(error)
                }
                return
            }
            do {
                JSONDecoder().keyDecodingStrategy = .convertFromSnakeCase
                let latlon = try JSONDecoder().decode(GeoData.self, from: data)
                completion(latlon)
            }
            catch {
                print(error)
            }
        }.resume()
    }
    
    static func getWeather(latitude: Double, longitute: Double,completion: @escaping(_ weather : WeatherData) -> Void ) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitute)&appid=\(Network.apiKey)"
            guard let url = URL(string: urlString) else {
                return
            }
            let session = URLSession.shared
            session.dataTask(with: url) { data, _, error in
                guard let data = data else {
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    return
                }
                do {
                    let weather = try JSONDecoder().decode(WeatherData.self, from: data)
                    completion(weather)
                }
                catch {
                    print(error)
                }
            }.resume()
            
        }
    
    }

