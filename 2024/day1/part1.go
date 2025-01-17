package main

import (
	"bufio"
	"fmt"
	"os"
	"slices"
	"strconv"
	"strings"
)

func main() {
	var l []int
	var r []int

	scanner := bufio.NewScanner(os.Stdin)

	for scanner.Scan() {
		line := scanner.Text()
		words := strings.Fields(line)
		v1, _ := strconv.Atoi(words[0])
		v2, _ := strconv.Atoi(words[1])
		l = append(l, v1)
		r = append(r, v2)
	}

	if err := scanner.Err(); err != nil {
		fmt.Println("Error reading from stdin:", err)
	}

	slices.Sort(l)
	slices.Sort(r)

	var t int
	for i := 0; i < len(l); i++ {
		n := l[i] - r[i]
		if n < 0 {
			n = -n
		}
		t = t + n
	}

	fmt.Println(t)
}
