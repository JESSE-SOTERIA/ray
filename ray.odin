package main

import "core:fmt"
import "core:os"

main :: proc() {
    image_width, image_height := 256, 256

    file, err := os.open("raytracer.ppm", os.O_WRONLY|os.O_CREATE|os.O_TRUNC, 0644)
    if err != 0 {
        fmt.eprintln("Error opening file:", err)
        return
    }
    defer os.close(file)

    os.write_string(file, fmt.tprintf("P3\n%d %d\n255\n", image_width, image_height))

    // Generate and write pixel data
    for i := 0; i < image_height; i += 1 {
        for j := 0; j < image_width; j += 1 {
            r := f64(j) / f64(image_width - 1)
            g := f64(i) / f64(image_height - 1)
            b := 0.0

            ir := i32(255.999 * r)
            ig := i32(255.999 * g)
            ib := i32(255.999 * b)

            os.write_string(file, fmt.tprintf("%d %d %d\n", ir, ig, ib))
        }
    }

    fmt.println("PPM file 'raytracer.ppm' has been generated.")
}
