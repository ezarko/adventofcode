package main

import (
	"bufio"
	"fmt"
	"os"
)

func check(x byte, m byte, a byte, s byte) bool {
	return string(x) == "X" && string(m) == "M" && string(a) == "A" && string(s) == "S"
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
			if string(matrix[i][j]) == "X" {
				cgr := j + 3 < len(matrix[i])
				cgl := j > 2
				cgu := i > 2
				cgd := i + 3 < len(matrix)
				if cgr {
					if cgu {
						if check(matrix[i][j], matrix[i-1][j+1], matrix[i-2][j+2], matrix[i-3][j+3]) {
							t++
						}
					}
					if check(matrix[i][j], matrix[i][j+1], matrix[i][j+2], matrix[i][j+3]) {
						t++
					}
					if cgd {
						if check(matrix[i][j], matrix[i+1][j+1], matrix[i+2][j+2], matrix[i+3][j+3]) {
							t++
						}
					}
				}
				if cgl {
					if cgu {
						if check(matrix[i][j], matrix[i-1][j-1], matrix[i-2][j-2], matrix[i-3][j-3]) {
							t++
						}
					}
					if check(matrix[i][j], matrix[i][j-1], matrix[i][j-2], matrix[i][j-3]) {
						t++
					}
					if cgd {
						if check(matrix[i][j], matrix[i+1][j-1], matrix[i+2][j-2], matrix[i+3][j-3]) {
							t++
						}
					}
				}
				if cgu {
					if check(matrix[i][j], matrix[i-1][j], matrix[i-2][j], matrix[i-3][j]) {
						t++
					}
				}
				if cgd {
					if check(matrix[i][j], matrix[i+1][j], matrix[i+2][j], matrix[i+3][j]) {
						t++
					}
				}
			}
		}
	}

	fmt.Println(t)
}
