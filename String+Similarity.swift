//
//  String+Similarity.swift
//
//  Created by Medhi Naït Mazi.
//
//  Based on Jako Winkler algorithm
//  https://fr.wikipedia.org/wiki/Distance_de_Jaro-Winkler

import Foundation

public extension String {

    // MARK: - Levenshtein

    /// Levenshtein distance (minimum number of operations)
    func levenshteinDistance(to other: String) -> Int {
        let t1 = Array(self)
        let t2 = Array(other)
        
        let m = t1.count
        let n = t2.count
        
        if m == 0 { return n }
        if n == 0 { return m }
        
        var previous = Array(0...n)
        var current = Array(repeating: 0, count: n + 1)
        
        for i in 1...m {
            current[0] = i
            for j in 1...n {
                let cost = t1[i-1] == t2[j-1] ? 0 : 1
                current[j] = Swift.min(
                    current[j-1] + 1,
                    previous[j] + 1,
                    previous[j-1] + cost
                )
            }
            previous = current
        }
        return previous[n]
    }

    /// Levenshtein normalized similarity (0.0 to 1.0)
    func levenshteinSimilarity(to other: String) -> Double {
        let maxLen = Double(max(self.count, other.count))
        guard maxLen > 0 else { return 1.0 }
        let distance = Double(levenshteinDistance(to: other))
        return 1.0 - (distance / maxLen)
    }

    // MARK: - Jaro-Winkler

    /// Jaro-Winkler similarity (recommended for names)
    func jaroWinklerSimilarity(to other: String, prefixLength: Int = 4) -> Double {
        let s1 = Array(self)
        let s2 = Array(other)
        
        let len1 = s1.count
        let len2 = s2.count
        
        if len1 == 0 && len2 == 0 { return 1.0 }
        if len1 == 0 || len2 == 0 { return 0.0 }
        
        let matchDistance = max(len1, len2) / 2 - 1
        
        var matches1 = [Bool](repeating: false, count: len1)
        var matches2 = [Bool](repeating: false, count: len2)
        
        var matches = 0
        
        for i in 0..<len1 {
            let start = max(0, i - matchDistance)
            let end = min(len2, i + matchDistance + 1)

            guard start < end else { continue }
            
            for j in start..<end where !matches2[j] && s1[i] == s2[j] {
                matches1[i] = true
                matches2[j] = true
                matches += 1
                break
            }
        }
        
        guard matches > 0 else { return 0.0 }
        
        // Calculating transpositions
        var transpositions = 0
        var k = 0
        for i in 0..<len1 where matches1[i] {
            while !matches2[k] { k += 1 }
            if s1[i] != s2[k] { transpositions += 1 }
            k += 1
        }
        
        let jaro = (
            Double(matches) / Double(len1) +
            Double(matches) / Double(len2) +
            Double(matches - transpositions/2) / Double(matches)
        ) / 3.0
        
        // Winkler Bonus
        let prefixMax = min(prefixLength, min(len1, len2))
        var prefix = 0
        for i in 0..<prefixMax {
            if s1[i] == s2[i] { prefix += 1 } else { break }
        }
        
        return jaro + Double(prefix) * 0.1 * (1.0 - jaro)
    }

    // MARK: - Trigram Jaccard Similarity

    /// Similarity based on trigrams + Jaccard coefficient
    func trigramJaccardSimilarity(to other: String) -> Double {
        let set1 = self.trigrams()
        let set2 = other.trigrams()
        
        guard !set1.isEmpty || !set2.isEmpty else { return 1.0 }
        
        let intersection = set1.intersection(set2).count
        let union = set1.union(set2).count
        
        return Double(intersection) / Double(union)
    }

    // Internal method for generating trigrams
    private func trigrams() -> Set<String> {
        guard self.count >= 3 else {
            return [self]
        }
        
        var set = Set<String>()
        let chars = Array(self)
        
        for i in 0...(chars.count - 3) {
            let trigram = String(chars[i...i+2])
            set.insert(trigram)
        }
        return set
    }
}
