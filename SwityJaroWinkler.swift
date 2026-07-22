//
//  SwiftyJakoWinkler.swift
//
//  Created by Medhi Naït Mazi.
//
//  Based on Jako Winkler algorithm
//  https://fr.wikipedia.org/wiki/Distance_de_Jaro-Winkler


open class JakoWinkler {

    private let prefixLength: Int
    
    /// - Parameter prefixLength: Number of characters in the prefix (default 4)
    public init(prefixLength: Int = 4) {
        self.prefixLength = max(1, prefixLength)
    }
    
    /// Calculate the Jaro-Winkler distance between two strings
    /// - Returns: Value between 0.0 (nothing in common) and 1.0 (identical)
    open func similarity(_ s1: String, _ s2: String) -> Double {
        let t1 = Array(s1)
        let t2 = Array(s2)
        
        let len1 = t1.count
        let len2 = t2.count
        
        if len1 == 0 && len2 == 0 { return 1.0 }
        if len1 == 0 || len2 == 0 { return 0.0 }
        
        let matchDistance = max(len1, len2) / 2 - 1
        
        var matches1 = [Bool](repeating: false, count: len1)
        var matches2 = [Bool](repeating: false, count: len2)
        
        var matches = 0
        
        // Matches
        for i in 0..<len1 {
            let start = max(0, i - matchDistance)
            let end = min(len2, i + matchDistance + 1)
            
            for j in start..<end {
                if matches2[j] || t1[i] != t2[j] { continue }
                matches1[i] = true
                matches2[j] = true
                matches += 1
                break
            }
        }
        
        guard matches > 0 else { return 0.0 }
        
        // Transpositions
        var transpositions = 0
        var k = 0
        for i in 0..<len1 {
            guard matches1[i] else { continue }
            while !matches2[k] { k += 1 }
            if t1[i] != t2[k] { transpositions += 1 }
            k += 1
        }
        
        let jaro = (
            Double(matches) / Double(len1) +
            Double(matches) / Double(len2) +
            Double(matches - transpositions/2) / Double(matches)
        ) / 3.0
        
        // Bonus Winkler (prefix)
        let prefixMax = min(prefixLength, min(len1, len2))
        var prefix = 0
        for i in 0..<prefixMax {
            if t1[i] == t2[i] {
                prefix += 1
            } else {
                break
            }
        }
        
        let winkler = jaro + Double(prefix) * 0.1 * (1.0 - jaro)
        return winkler
    }
}
