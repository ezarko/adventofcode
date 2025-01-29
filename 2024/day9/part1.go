package main

import (
	"bufio"
	"fmt"
	"os"
	"slices"
	"strconv"
)

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Scan()
	line := scanner.Text()
	b := []byte(line)

	// expand
	m := []int{}
	c := 0
	for i := 0; i < len(b) - 1; i += 2 {
		v, _ := strconv.Atoi(string(b[i]))
		for j := 0; j < v; j++ {
			m = append(m, c)
		}
		v, _ = strconv.Atoi(string(b[i+1]))
		for j := 0; j < v; j++ {
			m = append(m, -1)
		}
		c++
	}
	v, _ := strconv.Atoi(string(b[len(b)-1]))
	for j := 0; j < v; j++ {
		m = append(m, c)
	}

	// defrag
	for i := slices.Index(m, -1); i > -1; i = slices.Index(m, -1) {
		m[i] = m[len(m)-1]
		m = m[:len(m)-1]
	}

	// compute checksum
	t := 0
	for i := 0; i < len(m); i++ {
		t += i * m[i]
	}

	fmt.Println(t)
}
