//
//  GameTheme.swift
//  Memorize
//
//  Created by Natalia MACARI on 16.12.20.
//


import SwiftUI

struct Theme {
    var name: String
    var emoji: Array<String>
    var color: Color
    var numberOfCardsToShow: Int?
 
}

let animals = Theme(name: "Animals", emoji: ["🐶","🦊","🐸","🐤","🐙"], color: .red, numberOfCardsToShow: 5)
let smiles = Theme(name: "Smiles", emoji:  ["😎","🥶","🥰","😀","👿","🤡"], color: .yellow, numberOfCardsToShow: 6)
let sport = Theme(name: "Sport", emoji: ["🏀", "⚽️","🏓","🧘🏻‍♂️","🪁","🏇🏽"], color: .green)
let flags = Theme(name: "Flags", emoji: ["🇦🇹", "🇦🇩", "🇧🇪", "🇧🇷", "🇬🇧", "🇬🇷", "🇨🇦", "🇬🇪", "🇩🇪", "🇱🇷"], color: .gray, numberOfCardsToShow: 9)
let balls = Theme(name: "Balls", emoji: ["⚽️", "🏀", "🎱", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉"], color: .gray, numberOfCardsToShow: 9)
let food = Theme(name: "Food", emoji: ["🍓", "🥑", "🥖", "🌽", "🧄", "🍔", "🥐", "🍩", "🍭", "🎂"], color: .gray, numberOfCardsToShow: 10)

var themes = [animals, smiles, sport, flags, balls, food]


func addNewTheme(name: String, emoji: Array<String>, color: Color, numberOfCardsToShow: Int?) {
    themes.append(Theme(name: name, emoji: emoji, color: color,numberOfCardsToShow: numberOfCardsToShow))
}
