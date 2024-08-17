package main

import "core:fmt"
import "core:os"

main :: proc() {
	file, err := os.open("test", os.O_WRONLY | os.O_CREATE | os.O_TRUNC, 0644)
	defer os.close(file)
	fmt.println(file)
} 
