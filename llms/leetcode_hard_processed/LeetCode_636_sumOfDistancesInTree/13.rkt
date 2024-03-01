#lang racket

;; Function to calculate the sum of distances in a tree.
;; There is an undirected connected tree with n nodes labeled from 0 to n - 1 and n - 1 edges.
;; You are given the integer n and the list edges where edges[i] = [ai, bi] indicates that there is an edge between nodes ai and bi in the tree.
;; Return a list answer of length n where answer[i] is the sum of the distances between the ith node in the tree and all other nodes.
;; Example 1:
;; Input: n = 6, edges = [[0,1],[0,2],[2,3],[2,4],[2,5]]
;; Output: [8,12,6,10,10,10]
;; Explanation: The tree is shown above.
;; We can see that dist(0,1) + dist(0,2) + dist(0,3) + dist(0,4) + dist(0,5)
;; equals 1 + 1 + 2 + 2 + 2 = 8.
;; Hence, answer[0] = 8, and so on.
;; Example 2:
;; Input: n = 1, edges = []
;; Output: [0]
;; Example 3:
;; Input: n = 2, edges = [[1,0]]
;; Output: [1,1]
;; Constraints:
;; 1 <= n <= 3 * 104
;; edges.length == n - 1
;; edges[i].length == 2
;; 0 <= ai, bi < n
;; ai != bi
;; The given input represents a valid tree.
(define (sumOfDistancesInTree n edges)
  ;; Convert the edge list into an adjacency list to represent the tree.
  (define tree (make-hash))
  (for-each (lambda (edge)
              (for-each (lambda (node index)
                          (hash-update! tree (list-ref edge index)
                                        (lambda (lst) (cons (list-ref edge (- 1 index)) lst))
                                        '()))
                        edge
                        '(0 1)))
            edges)

  ;; Initialize counters for each node.
  (define counts (make-vector n 1))
  (define results (make-vector n 0))

  ;; First DFS to populate counts and results with preliminary values.
  (define (dfs node parent)
    (for-each (lambda (child)
                (when (not (= child parent))
                  (dfs child node)
                  (vector-set! counts node (+ (vector-ref counts node) (vector-ref counts child)))
                  (vector-set! results node (+ (vector-ref results node) (vector-ref results child) (vector-ref counts child)))))
              (hash-ref tree node '())))
  
  ;; Second DFS to adjust the results based on the subtree sizes.
  (define (dfs2 node parent)
    (for-each (lambda (child)
                (when (not (= child parent))
                  (vector-set! results child (- (+ (vector-ref results node) (- n (vector-ref counts child))) (vector-ref counts child)))
                  (dfs2 child node)))
              (hash-ref tree node '())))

  ;; Perform the two depth-first searches.
  (dfs 0 -1)
  (dfs2 0 -1)

  ;; Convert the result vector to a list for the output.
  (vector->list results))

;; Example use of the function.
(sumOfDistancesInTree 6 '((0 1) (0 2) (2 3) (2 4) (2 5)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate sumOfDistancesInTree))
    (check-within (candidate 3 (list (list 0 1) (list 0 2))) (list 2 3 3) 0.001)
    (check-within (candidate 1 (list )) (list 0) 0.001)
    (check-within (candidate 2 (list (list 1 0))) (list 1 1) 0.001)
    (check-within (candidate 6 (list (list 0 1) (list 0 2) (list 2 3) (list 2 4) (list 2 5))) (list 8 12 6 10 10 10) 0.001)
))

(test-humaneval)