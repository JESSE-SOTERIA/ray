package main

import "core:fmt"
import "core:os"


write_color :: proc(file: os.Handle, pixel_color: Color) {

	r := get_x(pixel_color.x)
	g := get_y(pixel_color.y)
	b := get_z(pixel_color.z)

	rbyte := i32(255.999 * r)
	gbyte := i32(255.999 * g)
	bbyte := i32(255.999 * b)

	//write out the color components.
	os.write_string(file, fmt.tprintf("%d %d %d\n", rbyte, gbyte, bbyte))
}


main :: proc() {

	file, err := os.open("raytracer.ppm", os.O_WRONLY | os.O_CREATE | os.O_TRUNC, 0644)
	if err != 0 {
		fmt.eprintln("Error opening file:", err)
		return
	}
	defer os.close(file)

	os.write_string(file, fmt.tprintf("P3\n%d %d\n255\n", image_width, image_height))

	// Generate and write pixel data
	for i := 0; i < image_height; i += 1 {

		fmt.printf("\rscanlines remaining: %d ", image_height - i)

		pixel_center := pixel00_loc + (f64(i) * pixel_delta_height)

		for j := 0; j < image_width; j += 1 {
			ray_direction := pixel_center - camera_center
			r := ray_init(camera_center, ray_direction)
			pixel_color := ray_color(r)
			write_color(file, pixel_color)
			pixel_center = pixel00_loc + (f64(j) * pixel_delta_width)
		}
	}

	fmt.println("PPM file 'raytracer.ppm' has been generated.")
}
