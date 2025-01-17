package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	var l []int
	m := make(map[int]int)

	scanner := bufio.NewScanner(os.Stdin)

	for scanner.Scan() {
		line := scanner.Text()
		words := strings.Fields(line)
		v1, _ := strconv.Atoi(words[0])
		v2, _ := strconv.Atoi(words[1])
		l = append(l, v1)
		m[v2] = m[v2] + 1
	}

	if err := scanner.Err(); err != nil {
		fmt.Println("Error reading from stdin:", err)
	}
	var s int
	for _, v := range l {
		s = s + (v * m[v])
	}

	fmt.Println(s)
}
