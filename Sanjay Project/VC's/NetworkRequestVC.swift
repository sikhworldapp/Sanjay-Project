//
//  NetworkRequestVC.swift
//  Sanjay Project
//
//  Created by Amanpreet Singh on 17/06/24.
//

import UIKit

class NetworkRequestVC: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var lblContent: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hitApi()
    }
    
    func hitApi()
    {
        activityIndicator.startAnimating()
        if let urlModel = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current=temperature_2m,wind_speed_10m&hourly=temperature_2m,relative_humidity_2m,wind_speed_10m") {
            
            // 2. Create the URLSession data task
            let task = URLSession.shared.dataTask(with: urlModel) { data, response, error in
                
                // 3. Handle the response
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print("Server error")
                    return
                }
                
                //print("httpRespone: \(httpResponse)")
                
                if let data = data,
                   let jsonString = String(data: data, encoding: .utf8) {
                    //print("Response Data:\n\(jsonString)")
                    self.parseJson(data: data)
                    
                }
            }
            
            // 4. Start the data task
            task.resume()
        }
        
    }
    
    func parseJson(data: Data)
    {
        let decoder = JSONDecoder()
        do {
            // Decode the JSON data into a Location instance
            let responseModel: Location = try decoder.decode(Location.self, from: data)
            
            // Access the parsed data
            print("Latitude: \(responseModel.lat ?? 0.0)")
            print("Latitude: \(responseModel.lng)")
            print("timezone: \(responseModel.timezone)")
            print("time: \(responseModel.current?.time)")
            print("hourly count is : \(responseModel.hourly?.time?.count)")
            DispatchQueue.main.async{
                self.activityIndicator.stopAnimating()
               // self.drawLabel("content = \(resposneModel as AnyObject)")
                self.lblContent.text = "\(responseModel as AnyObject)"
            }
            
        } catch {
            // Handle decoding errors
            print("Error decoding JSON: \(error)")
        }
    }
    
    func drawLabel(_ text: String) {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false // Enable Auto Layout
        label.text = text
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        view.addSubview(label)
        
        // Center horizontally
        label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        // Center vertically
        label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        // Set width constraint to limit the label width
        label.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
    }
}

struct Location: Decodable {
    let lat, lng, generationtimeMS: Double?
    let utcOffsetSeconds: Int?
    let timezone, timezoneAbbreviation: String?
    let elevation: Int?
    let current: Current?
    let hourly: Hourly?
  

    enum CodingKeys: String, CodingKey {
        case lat = "latitude"
        case lng = "longitude"
        case generationtimeMS = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case elevation
        case current
        case hourly
    }
}

struct Current: Decodable {
    let time: String?
    let interval : Int?
    let windSpeed10M, temperature2M: Double?

    enum CodingKeys: String, CodingKey {
        case time, interval
        case temperature2M = "temperature_2m"
        case windSpeed10M = "wind_speed_10m"
    }
}

// MARK: - Hourly
struct Hourly: Codable {
    let time: [String]?
    let temperature2M: [Double]?
    let relativeHumidity2M: [Int]?
    let windSpeed10M: [Double]?

    enum CodingKeys: String, CodingKey {
        case time
        case temperature2M = "temperature_2m"
        case relativeHumidity2M = "relative_humidity_2m"
        case windSpeed10M = "wind_speed_10m"
    }
    
}
