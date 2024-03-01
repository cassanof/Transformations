#lang racket

;; We can scramble a string s to get a string t using the following algorithm:
;; If the length of the string is 1, stop.
;; If the length of the string is > 1, do the following:
;; Split the string into two non-empty substrings at a random index, i.e., if the string is s, divide it to x and y where s = x + y.
;; Randomly decide to swap the two substrings or to keep them in the same order. i.e., after this step, s may become s = x + y or s = y + x.
;; Apply step 1 recursively on each of the two substrings x and y.
;; Given two strings s1 and s2 of the same length, return true if s2 is a scrambled string of s1, otherwise, return false.
;; Example 1:
;; Input: s1 = "great", s2 = "rgeat"
;; Output: true
;; Explanation: One possible scenario applied on s1 is:
;; "great" --> "gr/eat" // divide at random index.
;; "gr/eat" --> "gr/eat" // random decision is not to swap the two substrings and keep them in order.
;; "gr/eat" --> "g/r / e/at" // apply the same algorithm recursively on both substrings. divide at random index each of them.
;; "g/r / e/at" --> "r/g / e/at" // random decision was to swap the first substring and to keep the second substring in the same order.
;; "r/g / e/at" --> "r/g / e/ a/t" // again apply the algorithm recursively, divide "at" to "a/t".
;; "r/g / e/ a/t" --> "r/g / e/ a/t" // random decision is to keep both substrings in the same order.
;; The algorithm stops now, and the result string is "rgeat" which is s2.
;; As one possible scenario led s1 to be scrambled to s2, we return true.
;; Example 2:
;; Input: s1 = "abcde", s2 = "caebd"
;; Output: false
;; Example 3:
;; Input: s1 = "a", s2 = "a"
;; Output: true
;; Constraints:
;; s1.length == s2.length
;; 1 <= s1.length <= 30
;; s1 and s2 consist of lowercase English letters.
(define (isScramble s1 s2)
  ;; Base case: If the strings are equal, return true.
  (if (string=? s1 s2)
      #t
      (let ([len (string-length s1)])
        ;; If the lengths are different or the sorted strings are not equal, return false.
        (if (or (not (= (string-length s2) len))
                (not (equal? (sort (string->list s1) char<?)
                             (sort (string->list s2) char<?))))
            #f
            (let loop ([i 1])  ;; Start looping from index 1, since we are splitting the strings.
              (if (> i (- len 1))  ;; If i has reached the length of the string, return false.
                  #f
                  (or
                   ;; Recursive check for the condition without swapping.
                   (and (isScramble (substring s1 0 i) (substring s2 0 i))
                        (isScramble (substring s1 i) (substring s2 i)))
                   ;; Recursive check for the condition with swapping.
                   (and (isScramble (substring s1 0 i) (substring s2 (- len i)))
                        (isScramble (substring s1 i) (substring s2 0 (- len i))))
                   ;; Loop for the next index.
                   (loop (+ i 1)))))))))

;; The function checks if it's possible to transform s1 into s2 by recursively splitting
;; and optionally swapping the resulting substrings. It does this by first checking if
;; the strings are already equal, then checking if sorted versions of the strings are equal
;; (a quick way to check if they contain the same characters). If these checks pass,
;; it tries every possible split of the string and checks if, by recursively applying
;; the same logic, the split and optionally swapped parts can lead to s2 being formed
;; from s1. It uses a loop to try every possible split.
(require rackunit)

(define (test-humaneval) 

  (let (( candidate isScramble))
    (check-within (candidate "aaaa" "aaa") #f 0.001)
    (check-within (candidate "abcde" "ebcda") #t 0.001)
    (check-within (candidate "abb" "bba") #t 0.001)
    (check-within (candidate "web" "bwe") #t 0.001)
    (check-within (candidate "bac" "bca") #t 0.001)
    (check-within (candidate "datastructure" "tastructureda") #t 0.001)
    (check-within (candidate "rat" "tar") #t 0.001)
    (check-within (candidate "t" "t") #t 0.001)
    (check-within (candidate "asd" "dsa") #t 0.001)
    (check-within (candidate "abbc" "acbb") #t 0.001)
    (check-within (candidate "documentation" "entationdocum") #t 0.001)
    (check-within (candidate "aabbc" "aabc") #f 0.001)
    (check-within (candidate "abcdefghijklmnopqrstuvwxyz" "zxywvutsrqponmlkjihgfedcba") #t 0.001)
    (check-within (candidate "language" "uagelagn") #t 0.001)
    (check-within (candidate "performance" "rmanceperfo") #t 0.001)
    (check-within (candidate "dbs" "sdb") #t 0.001)
    (check-within (candidate "" "a") #f 0.001)
    (check-within (candidate "algorithm" "gorithmal") #t 0.001)
    (check-within (candidate "ab" "ab") #t 0.001)
    (check-within (candidate "optimization" "izationoptim") #t 0.001)
    (check-within (candidate "abcd" "cbad") #t 0.001)
    (check-within (candidate "great" "rgeat") #t 0.001)
    (check-within (candidate "abcdefghij" "efghijcadb") #f 0.001)
    (check-within (candidate "javascript" "tjavascrip") #t 0.001)
    (check-within (candidate "abcde" "caebd") #f 0.001)
    (check-within (candidate "hello" "ohlel") #t 0.001)
    (check-within (candidate "internet" "terninet") #t 0.001)
    (check-within (candidate "anagram" "nagaram") #t 0.001)
    (check-within (candidate "tpg" "pgt") #t 0.001)
    (check-within (candidate "abc" "cba") #t 0.001)
    (check-within (candidate "integration" "grationinte") #t 0.001)
    (check-within (candidate "bcdefg" "fcbegda") #f 0.001)
    (check-within (candidate "testing" "gintest") #t 0.001)
    (check-within (candidate "tt" "ttt") #f 0.001)
    (check-within (candidate "aaa" "aab") #f 0.001)
    (check-within (candidate "asd" "das") #t 0.001)
    (check-within (candidate "database" "basedata") #t 0.001)
    (check-within (candidate "babb" "bbab") #t 0.001)
    (check-within (candidate "javascript" "riptjavasc") #t 0.001)
    (check-within (candidate "a" "b") #f 0.001)
    (check-within (candidate "a" "") #f 0.001)
    (check-within (candidate "computer" "putercom") #t 0.001)
    (check-within (candidate "xyxyxyzz" "xxyyzzzx") #f 0.001)
    (check-within (candidate "design" "sgined") #t 0.001)
    (check-within (candidate "physics" "fysicep") #f 0.001)
    (check-within (candidate "deployment" "mentdeploy") #t 0.001)
    (check-within (candidate "specification" "cationfispeci") #t 0.001)
    (check-within (candidate "bca" "bca") #t 0.001)
    (check-within (candidate "python" "ythonp") #t 0.001)
    (check-within (candidate "tt" "tt") #t 0.001)
    (check-within (candidate "aacde" "deeca") #f 0.001)
    (check-within (candidate "javascript" "jvascripted") #f 0.001)
    (check-within (candidate "security" "uritysec") #t 0.001)
    (check-within (candidate "maintenance" "enancemaint") #t 0.001)
    (check-within (candidate "implementation" "ationimplement") #t 0.001)
    (check-within (candidate "world" "rldwo") #t 0.001)
    (check-within (candidate "abcd" "abcd") #t 0.001)
    (check-within (candidate "tt" "t") #f 0.001)
    (check-within (candidate "debugging" "uggingdeb") #t 0.001)
    (check-within (candidate "abcd" "dacb") #t 0.001)
    (check-within (candidate "network" "worknet") #t 0.001)
    (check-within (candidate "a" "a") #t 0.001)
    (check-within (candidate "" "") #t 0.001)
    (check-within (candidate "banana" "ananab") #t 0.001)
    (check-within (candidate "asd" "dab") #f 0.001)
    (check-within (candidate "abcd" "badc") #t 0.001)
    (check-within (candidate "lk" "ll") #f 0.001)
    (check-within (candidate "javascript" "pseudojack") #f 0.001)
    (check-within (candidate "javascript" "javascript") #t 0.001)
    (check-within (candidate "abcd" "dcba") #t 0.001)
    (check-within (candidate "abcd" "abdc") #t 0.001)
    (check-within (candidate "programming" "mingprogram") #t 0.001)
    (check-within (candidate "visualization" "tionvisualiza") #t 0.001)
    (check-within (candidate "abcd" "cdba") #t 0.001)
    (check-within (candidate "ttt" "tt") #f 0.001)
    (check-within (candidate "asd" "ads") #t 0.001)
    (check-within (candidate "javascript" "javasript") #f 0.001)
    (check-within (candidate "abc" "ac") #f 0.001)
    (check-within (candidate "ab" "ba") #t 0.001)
    (check-within (candidate "development" "opmentdevel") #t 0.001)
    (check-within (candidate "abcdefg" "fbegcda") #f 0.001)
    (check-within (candidate "abcdd" "abddc") #t 0.001)
))

(test-humaneval)