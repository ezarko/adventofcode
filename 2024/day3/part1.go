package main

import (
	"bufio"
	"fmt"
	"io/ioutil"
	"os"
	"regexp"
	"strconv"
	s "strings"
)

func main() {
	r, _ := regexp.Compile("([0-9]+)")

	reader := bufio.NewReader(os.Stdin)
	data, err := ioutil.ReadAll(reader)
	if err != nil {
		panic(err)
	}

	text := string(data)

	var t int
	i := s.Index(text, "mul(")
	for i > 0 {
		text = text[i+4:]
		l := r.FindString(text)
		text = text[len(l):]
		if text[0:1] == "," {
			text = text[1:]
			r := r.FindString(text)
			text = text[len(r):]
			if text[0:1] == ")" {
				li, _ := strconv.Atoi(l)
				ri, _ := strconv.Atoi(r)
				t = t + li * ri
			}
		}
		i = s.Index(text, "mul(")
	}

	fmt.Println(t)
}
