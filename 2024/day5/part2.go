package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func indexOf(arr []int, val int) int {
    for i, v := range arr {
        if v == val {
            return i
        }
    }
    return -1
}

func check(update []int, rule []int) bool {
	l := indexOf(update, rule[0])
	r := indexOf(update, rule[1])

	if l > -1 && r > -1 {
		return l < r
	}

	return true
}

func fix(update []int, rule []int) []int {
	l := indexOf(update, rule[0])
	r := indexOf(update, rule[1])
	var new_update []int

	if r > 0 {
		new_update = append(new_update, update[:r]...)
	}
	new_update = append(new_update, update[l], update[r])
	if (l-r) > 1 {
		new_update = append(new_update, update[(r+1):l]...)
	}
	new_update = append(new_update, update[(l+1):]...)

	return new_update
}

func main() {
	var rules [][]int
	var updates [][]int

	scanner := bufio.NewScanner(os.Stdin)

	finished_rules := false
	for scanner.Scan() {
		line := scanner.Text()
		if line == "" {
			finished_rules = true
		} else if !finished_rules {
			rule_str := strings.Split(line, "|")
			var rule_int []int
			for _, str_value := range rule_str {
				int_val, _ := strconv.Atoi(str_value)
				rule_int = append(rule_int, int_val)
			}
			rules = append(rules, rule_int)
		} else {
			update_str := strings.Split(line, ",")
			var update_int []int
			for _, str_value := range update_str {
				int_val, _ := strconv.Atoi(str_value)
				update_int = append(update_int, int_val)
			}
			updates = append(updates, update_int)
		}
	}

	if err := scanner.Err(); err != nil {
		fmt.Println("Error reading from stdin:", err)
	}

	t := 0
	for i := 0; i < len(updates); i++ {
		obeys_all_rules := true
		for j := 0; j < len(rules); j++ {
			if !check(updates[i], rules[j]) {
				updates[i] = fix(updates[i], rules[j])
				j = 0
				obeys_all_rules = false
			}
		}
		if ! obeys_all_rules {
			t = t + updates[i][len(updates[i])/2]
		}
	}

	fmt.Println(t)
}
