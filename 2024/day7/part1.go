package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	scanner := bufio.NewScanner(os.Stdin)

	t := 0
	for scanner.Scan() {
		line := scanner.Text()
		parts := strings.Split(line, ": ")
		test_value, _ := strconv.Atoi(parts[0])
		str_values := strings.Fields(parts[1])
		var values []int
		for _, v := range str_values {
			iv, _ := strconv.Atoi(v)
			values = append(values, iv)
		}
		results := values[0:1]
		values = values[1:]
		for len(values) > 0 {
			var temp []int
			for _, v := range results {
				temp = append(temp, v + values[0], v * values[0])
			}
			results = temp
			values = values[1:]
		}
		for _, v := range results {
			if v == test_value {
				t = t + v
				break
			}
		}
	}

	if err := scanner.Err(); err != nil {
		fmt.Println("Error reading from stdin:", err)
	}

	fmt.Println(t)
}
