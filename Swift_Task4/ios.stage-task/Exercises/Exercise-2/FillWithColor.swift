import Foundation

final class FillWithColor {
    
    func fillWithColor(_ image: [[Int]], _ row: Int, _ column: Int, _ newColor: Int) -> [[Int]] {
       //VALIDATION FUCTION
        func isValid(_ row: Int, _ column: Int, _ newColor: Int) -> Bool {
            if (row < 0 || row > image.count-1) { return false }
            if (column < 0 || column > image[0].count-1) { return false }
            if (image[row][column] != newColor || visited[row][column]) { return false }
            return true;
        }
        
        let targerColor = image[row][column]
        let falseArray = Array(repeating: false, count: image[0].count)
        var visited = Array(repeating: falseArray, count: image.count)
        var queue = [[Int]]()
        var G = image
        
        queue += [[row, column]]
        visited[row][column] = true
        G[row][column] = newColor
        
        while !queue.isEmpty {
            let current = queue[0]
            queue.removeFirst()
            G[current[0]][current[1]] = newColor
            
            if isValid(current[0]+1, current[1], targerColor) {
            queue += [[current[0]+1, current[1]]]
            visited[current[0]+1][current[1]] = true
            G[current[0]+1][current[1]] = newColor
            }
            if isValid(current[0]-1, current[1], targerColor) {
                queue += [[current[0]-1, current[1]]]
                visited[current[0]-1][current[1]] = true
                G[current[0]-1][current[1]] = newColor
            }
            if isValid(current[0], current[1]+1, targerColor) {
                queue += [[current[0], current[1]+1]]
                visited[current[0]][current[1]+1] = true
                G[current[0]][current[1]+1] = newColor
            }
            if isValid(current[0], current[1]-1, targerColor) {
                queue += [[current[0], current[1]-1]]
                visited[current[0]][current[1]-1] = true
                G[current[0]][current[1]-1] = newColor
            }
        }
        
        return G;
        
        
        
        
        
        
        
        
        
        
        
        
    }
}
