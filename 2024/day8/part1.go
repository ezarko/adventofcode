package main

import (
	"bufio"
	"fmt"
	"os"
)

func find_point_pairs(points [][]int) [][][]int {
	l := points[0]
	points = points[1:]
	var result [][][]int
	for _, r := range points {
		cl := make([]int, 2)
		copy(cl, l)
		cr := make([]int, 2)
		copy(cr, r)
		result = append(result, [][]int{cl, cr})
	}
	if len(points) > 1 {
		result = append(result, find_point_pairs(points)...)
	}
	return result
}

func find_antinodes(pair [][]int) [][]int {
	l0 := pair[0][0]
	l1 := pair[0][1]
	r0 := pair[1][0]
	r1 := pair[1][1]
	if l0 == r0 {
		if l1 < r1 {
			pair[0][1] -= r1 - l1
			pair[1][1] += r1 - l1
		} else {
			pair[1][1] -= l1 - r1
			pair[0][1] += l1 - r1
		}
	} else {
		if l1 == r1 {
			if l0 < r0 {
				pair[0][0] -= r0 - l0
				pair[1][0] += r0 - l0
			} else {
				pair[1][0] -= l0 - r0
				pair[0][0] += l0 - r0
			}
		} else {
			if l0 < r0 {
				if l1 < r1 {
					pair[0][0] -= r0 - l0
					pair[0][1] -= r1 - l1
					pair[1][0] += r0 - l0
					pair[1][1] += r1 - l1
				} else {
					pair[0][0] -= r0 - l0
					pair[0][1] += l1 - r1
					pair[1][0] += r0 - l0
					pair[1][1] -= l1 - r1
				}
			} else {
				if l1 < r1 {
					pair[0][0] += l0 - r0
					pair[0][1] -= r1 - l1
					pair[1][0] -= l0 - r0
					pair[1][1] += r1 - l1
				} else {
					pair[0][0] += l0 - r0
					pair[0][1] += l1 - r1
					pair[1][0] -= l0 - r0
					pair[1][1] -= l1 - r1
				}
			}
		}
	}

	return pair
}

func main() {
	var input [][]byte
	var output [][]byte
	m := make(map[byte][][]int)

	scanner := bufio.NewScanner(os.Stdin)

	for scanner.Scan() {
		line := scanner.Text()
		b := []byte(line)
		input = append(input, b)
		output = append(output, make([]byte, len(line)))
		for i, v := range b {
			output[len(output)-1][i] = 46
			if v == 46 {
				continue
			}
			_, ok := m[v]
			if !ok {
				m[v] = make([][]int, 0)
			}
			m[v] = append(m[v], []int{len(input)-1, i})
		}
	}

	if err := scanner.Err(); err != nil {
		fmt.Println("Error reading from stdin:", err)
	}

	for _, points := range m {
		point_pairs := find_point_pairs(points)
		for i, v := range point_pairs {
			point_pairs[i] = find_antinodes(v)
			for _, p := range point_pairs[i] {
				if p[0] >= 0 && p[0] < len(input) && p[1] >= 0 && p[1] < len(input[0]) {
					if input[p[0]][p[1]] == 46 {
						input[p[0]][p[1]] = 35
					}
					output[p[0]][p[1]] = 35
				}
			}
		}
	}

	t := 0
	for i := 0; i < len(output); i++ {
		for j := 0; j < len(output[0]); j++ {
			if output[i][j] == 35 {
				t++
			}
		}
	}

	fmt.Println(t)
}
