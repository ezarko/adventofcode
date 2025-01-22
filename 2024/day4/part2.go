package main

import (
	"bufio"
	"fmt"
	"os"
)

func check(m byte, a byte, s byte) bool {
	return (string(m) == "M" && string(a) == "A" && string(s) == "S") || (string(s) == "M" && string(a) == "A" && string(m) == "S")
}

func main() {
	var matrix [][]byte

	scanner := bufio.NewScanner(os.Stdin)

	for scanner.Scan() {
		line := scanner.Text()
		matrix = append(matrix, []byte(line))
	}

	if err := scanner.Err(); err != nil {
		fmt.Println("Error reading from stdin:", err)
	}

	t := 0
	for i := 0; i < len(matrix); i++ {
		for j := 0; j < len(matrix[i]); j++ {
			if string(matrix[i][j]) == "M" {
				cgr := j + 2 < len(matrix[i])
				cgl := j > 1
				cgu := i > 1
				cgd := i + 2 < len(matrix)
				if cgr {
					if cgu {
						if check(matrix[i][j], matrix[i-1][j+1], matrix[i-2][j+2]) && check(matrix[i-2][j], matrix[i-1][j+1], matrix[i][j+2]) {
							t++
						}
					}
					if cgd {
						if check(matrix[i][j], matrix[i+1][j+1], matrix[i+2][j+2]) && check(matrix[i+2][j], matrix[i+1][j+1], matrix[i][j+2]) {
							t++
						}
					}
				}
				if cgl {
					if cgu {
						if check(matrix[i][j], matrix[i-1][j-1], matrix[i-2][j-2]) && check(matrix[i-2][j], matrix[i-1][j-1], matrix[i][j-2]) {
							t++
						}
					}
					if cgd {
						if check(matrix[i][j], matrix[i+1][j-1], matrix[i+2][j-2]) && check(matrix[i+2][j], matrix[i+1][j-1], matrix[i][j-2]) {
							t++
						}
					}
				}
			}
		}
	}
	t = t / 2

	fmt.Println(t)
}
