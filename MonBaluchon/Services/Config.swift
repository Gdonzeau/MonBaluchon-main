//
//  File.swift
//  MonBaluchon
//
//  Created by Guillaume Donzeau on 14/06/2021.
//

import Foundation

enum Config {
    enum Currency {
        static let urlBase = "http://data.fixer.io/api/latest?"
        static let authorization = "&access_key="
        static var code = Keys.change
        static let currenciesAvailable = ["USD","EUR","RUB","GBP","BIF"]
    }
    enum Language {
        static let urlBase = "https://translation.googleapis.com/language/translate/v2?"
        static let authorization = "&key="
        static var code = Keys.translation
        static var askForWord = "q="
        static var askForLanguage = "&target="
        static var format = "&format=html"
        
        static let languagesAvailable = ["Anglais",
                                         "Arabe",
                                         "Chinois",
                                         "Espagnol",
                                         "Russe"
        ]
        // Language : ["Name":"codeid"]
        static let languagesSet = ["Anglais":"en",
                                   "Arabe":"ar",
                                   "Chinois":"zh",
                                   "Espagnol":"es",
                                   "Russe":"ru"
        ]
        
    }
    enum Weather {
        static let urlBase = "http://api.openweathermap.org/data/2.5/weather?"
        static let authorization = "&appid="
        static var code = Keys.weather
        static var place = "q="
        static var andUnits = "&units="
        static var metric = "metric"
    }
}
