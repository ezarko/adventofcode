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

func find_antinodes(pair [][]int, m0 int, m1 int) [][]int {
	l0 := pair[0][0]
	l1 := pair[0][1]
	r0 := pair[1][0]
	r1 := pair[1][1]
	var new_pair [][]int
	var dl0, dl1, dr0, dr1 int
	if l0 == r0 {
		if l1 < r1 {
			dl0 = 0
			dl1 = l1 - r1
			dr0 = 0
			dr1 = r1 - l1
		} else {
			dl0 = 0
			dl1 = l1 - r1
			dr0 = 0
			dr1 = r1 - l1
		}
	} else {
		if l1 == r1 {
			if l0 < r0 {
				dl0 = l0 - r0
				dl1 = 0
				dr0 = r0 - l0
				dr1 = 0
			} else {
				dl0 = l0 - r0
				dl1 = 0
				dr0 = r0 - l0
				dr1 = 0
			}
		} else {
			if l0 < r0 {
				if l1 < r1 {
					dl0 = l0 - r0
					dl1 = l1 - r1
					dr0 = r0 - l0
					dr1 = r1 - l1
				} else {
					dl0 = l0 - r0
					dl1 = l1 - r1
					dr0 = r0 - l0
					dr1 = r1 - l1
				}
			} else {
				if l1 < r1 {
					dl0 = l0 - r0
					dl1 = l1 - r1
					dr0 = r0 - l0
					dr1 = r1 - l1
				} else {
					dl0 = l0 - r0
					dl1 = l1 - r1
					dr0 = r0 - l0
					dr1 = r1 - l1
				}
			}
		}
	}

	for l0 >= 0 && l0 < m0 && l1 >= 0 && l1 < m1 {
		new_pair = append(new_pair, []int{l0,l1})
		l0 += dl0
		l1 += dl1
	}
	for r0 >= 0 && r0 < m0 && r1 >= 0 && r1 < m1 {
		new_pair = append(new_pair, []int{r0,r1})
		r0 += dr0
		r1 += dr1
	}

	return new_pair
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
			point_pairs[i] = find_antinodes(v, len(input), len(input[0]))
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
