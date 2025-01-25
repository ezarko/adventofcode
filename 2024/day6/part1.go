package main

import (
	"bufio"
	"fmt"
	"os"
)

const HASH = 35
const DOT = 46
const EX = 88
const CARET = 94

const UP = 0
const RIGHT = 1
const DOWN = 2
const LEFT = 3

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

	var x int
	var y int
	d := UP
	for i := 0; i < len(matrix); i++ {
		for j := 0; j < len(matrix[0]); j++ {
			if matrix[i][j] == CARET {
				x = i
				y = j
				matrix[i][j] = EX
			}
		}
	}

	for x >= 0 && x < len(matrix) && y >= 0 && y < len(matrix[0]) {
		if d == UP {
			if x == 0 {
				x = -1
			} else {
				if matrix[x-1][y] == HASH {
					d = RIGHT
				} else {
					x--
					matrix[x][y] = EX
				}
			}
		}
		if d == DOWN {
			if x == len(matrix) - 1 {
				x++
			} else {
				if matrix[x+1][y] == HASH {
					d = LEFT
				} else {
					x++
					matrix[x][y] = EX
				}
			}
		}
		if d == LEFT {
			if y == 0 {
				y = -1
			} else {
				if matrix[x][y-1] == HASH {
					d = UP
				} else {
					y--
					matrix[x][y] = EX
				}
			}
		}
		if d == RIGHT {
			if y == len(matrix[0]) - 1 {
				y++
			} else {
				if matrix[x][y+1] == HASH {
					d = DOWN
				} else {
					y++
					matrix[x][y] = EX
				}
			}
		}
	}

	t := 0
	for i := 0; i < len(matrix); i++ {
		for j := 0; j < len(matrix[0]); j++ {
			if matrix[i][j] == EX {
				t++
			}
		}
	}

	fmt.Println(t)
}
