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
	do := true
	imul := s.Index(text, "mul(")
	ido := s.Index(text, "do()")
	idont := s.Index(text, "don't()")
	for imul > 0  || ido > 0 || idont > 0 {
		if imul > -1 && (ido == -1 || imul < ido) && (idont == -1 || imul < idont) {
			text = text[imul+4:]
			l := r.FindString(text)
			text = text[len(l):]
			if text[0:1] == "," {
				text = text[1:]
				r := r.FindString(text)
				text = text[len(r):]
				if text[0:1] == ")" {
					li, _ := strconv.Atoi(l)
					ri, _ := strconv.Atoi(r)
					if do {
						t = t + li * ri
					}
				}
			}
		} else if ido > -1 && (imul == -1 || ido < imul) && (idont == -1 || ido < idont) {
			do = true
			text = text[ido+4:]
		} else if idont > -1 && (imul == -1 || idont < imul) && (ido == -1 || idont < ido) {
			do = false
			text = text[idont+7:]
		} else {
			panic("WTF")
		}
		imul = s.Index(text, "mul(")
		ido = s.Index(text, "do()")
		idont = s.Index(text, "don't()")
	}

	fmt.Println(t)
}
