package main

import (
	"bufio"
	"fmt"
	"os"
	//"slices"
	"strconv"
)

type Inode struct {
    StartPos int
    Length  int
}

func main() {
	scanner := bufio.NewScanner(os.Stdin)
	scanner.Scan()
	line := scanner.Text()
	b := []byte(line)

	// expand
	m := []int{}
	var files []Inode
	var free []Inode
	c := 0
	for i := 0; i < len(b) - 1; i += 2 {
		v, _ := strconv.Atoi(string(b[i]))
		files = append(files, Inode{StartPos: len(m), Length: v})
		for j := 0; j < v; j++ {
			m = append(m, c)
		}
		v, _ = strconv.Atoi(string(b[i+1]))
		free = append(free, Inode{StartPos: len(m), Length: v})
		for j := 0; j < v; j++ {
			m = append(m, -1)
		}
		c++
	}
	v, _ := strconv.Atoi(string(b[len(b)-1]))
	files = append(files, Inode{StartPos: len(m), Length: v})
	for j := 0; j < v; j++ {
		m = append(m, c)
	}

	// defrag
	for ; c > 0; c-- {
		for j, f := range free {
			if files[c].StartPos > f.StartPos && files[c].Length <= f.Length {
				for i := 0; i < files[c].Length; i++ {
					m[files[c].StartPos + i] = -1
					m[f.StartPos + i] = c
				}
				files[c].StartPos = f.StartPos
				f.StartPos += files[c].Length
				f.Length -= files[c].Length
				free[j] = f
				break
			}
		}
	}

	// compute checksum
	t := 0
	for i := 0; i < len(m); i++ {
		if m[i] != -1 {
			t += i * m[i]
		}
	}

	fmt.Println(t)
}
