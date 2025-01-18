package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func safe(levels []int) bool {
	increasing := true
	if levels[0] > levels[1] {
		increasing = false
	}

	for i := 0; i < len(levels) - 1; i++ {
		if (increasing && levels[i] > levels[i+1]) {
			return false
		}
		if (!increasing && levels[i] < levels[i+1]) {
			return false
		}
		n := levels[i] - levels[i+1]
		if (n < 0) {
			n = -n
		}
		if (n == 0 || n > 3) {
			return false
		}
	}

	return true
}

func main() {
	var t int
	scanner := bufio.NewScanner(os.Stdin)

	for scanner.Scan() {
		line := scanner.Text()
		words := strings.Fields(line)
		levels := make([]int, len(words))
		for i, word := range words {
			v, _ := strconv.Atoi(word)
			levels[i] = v
		}
		if safe(levels) {
			t++
		}
	}

	if err := scanner.Err(); err != nil {
		fmt.Println("Error reading from stdin:", err)
	}

	fmt.Println(t)
}
