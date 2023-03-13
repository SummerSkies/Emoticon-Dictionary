//
//  File.swift
//  Emoticon Dictionary
//
//  Created by Juliana Nielson on 3/10/23.
//

import Foundation

class EmoticonController {
    
    func saveDictionary(dictionary : [Emoticon]) {
        // Encode
        let encoder = PropertyListEncoder()
        let encodedDictionary = try? encoder.encode(dictionary)
        
        // Save to file system
        try? encodedDictionary?.write(to: filePath(), options: .noFileProtection)
    }
    
    func retrieveDictionary() -> [Emoticon]{
        // Get data from file system
        guard let emoticonsData = try? Data(contentsOf: filePath()) else { return []}
        
        // Decode
        let decoder = PropertyListDecoder()
        guard let decodedDictionary = try? decoder.decode([Emoticon].self, from: emoticonsData) else { return []}
        return decodedDictionary
    }
    
    func filePath() -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appending(component: "emoticons.plist")
    }
    
    func sampleEmoticons() -> [Emoticon] {
        return [
            Emoticon(symbol: "😀", name: "I Smile in the Face of Death", description: "Haha, what?", usage: "You speak of trauma, but you want your texting buddy to know you're joking."),
            Emoticon(symbol: "😕", name: "This is so sad", description: "Oh.", usage: "You just told me your sob story but I have no idea how to react."),
            Emoticon(symbol: "😍", name: "I Love",
                     description: "UwU", usage: "I either love you, or something you sent. Beware."),
            Emoticon(symbol: "🧑‍💻", name: "Ew, a Person Emoji",
                     description: "Why is this in your recents?", usage: "Never used, anywhere."),
            Emoticon(symbol: "🐢", name: "Turtle", description:
                        "Hurt him and I will end you.", usage: "p e t hehe"),
            Emoticon(symbol: "🐘", name: "elelelelelelele", description: "Instant water shower", usage: "big ear big brain"),
            Emoticon(symbol: "🍝", name: "Spagett",
                     description: "SOMBODY TOUCHA MY SPAGETTI", usage: "spaghetti"),
            Emoticon(symbol: "🎲", name: "DIE", description: "PERISH", usage: "Roll for initiative."),
            Emoticon(symbol: "⛺️", name: "Keep Out", description: "We're busy playing Would You Rather.", usage: "camping"),
            Emoticon(symbol: "📚", name: "get schooled", description: "gottem", usage: "Iiiittty biiittty books"),
            Emoticon(symbol: "💔", name: "Rip",
                     description: "That's rough, buddy.", usage: "Pretend  to kiss in animal crossing"),
            Emoticon(symbol: "💤", name: "Z Z Z Z Z Z Z Z",
                     description: "z z z z z z z z", usage: "Be more exciting. Seriously. I'm bored to tears."),
            Emoticon(symbol: "🏁", name: "Finis",
                     description: "You crossed the finish line. Congradulations. Now do it again, chump.", usage:
                        "yay woohoo whatever")
            ]
    }
}
