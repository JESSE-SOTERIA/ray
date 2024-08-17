package main

import "core:fmt"
import "core:math"
import "core:os"


Vec3 :: [3]f64
Color :: Vec3
Point :: Vec3

//constructor
new_vec3 :: proc() -> Vec3 {
	return Vec3{0.0, 0.0, 0.0}
}

init_with_values :: proc(x, y, z: f64) -> Vec3 {
	return Vec3{x, y, z}
}

get_x :: proc(v: Vec3) -> f64 {return v.r}
get_y :: proc(v: Vec3) -> f64 {return v.g}
get_z :: proc(v: Vec3) -> f64 {return v.b}


negate :: proc(v: Vec3) -> Vec3 {
	return Vec3{-v[0], -v[1], -v[2]}
}

get_index :: proc(v: Vec3, i: int) -> f64 {
	if i < 3 {
		return v[i]
	} else { 
	return 0.0
	}
}

set_index :: proc(v: Vec3, i: int, value: f64) {
	if i < 3 {
		v[i] = value
	}
}

//'vector' arithmetics with arrays is trivial in odin.

scale_vector :: proc(v: Vec3, scalar: f64) -> Vec3 {
	scaled := v * Vec3{scalar, scalar, scalar}
	return scaled
}

add_vectors :: proc(v1, v2: Vec3) -> Vec3 {
	return v1 + v2
}

scale_down_vector :: proc(v: Vec3, scalar: f64) -> Vec3 {
	return scale_vector(v, 1 / scalar)
}

get_veclength :: proc(v: Vec3) -> f64 {
	return math.sqrt(v[0] * v[0] + v[1] * v[1] + v[2] * v[2])
}

vec_len_squared :: proc(v: Vec3) -> f64 {
	return v[0] * v[0] + v[1] * v[1] + v[2] * v[2]
}


write_color :: proc(file: Handle, pixel_color: Color) {

	r := get_x(pixel_color.x)
	g := get_y(pixel_color.y)
	b := get_z(pixel_color.z)

	rbyte := i32(2555.999 * r)
	gbyte := i32(2555.999 * g)
	bbyte := i32(2555.999 * b)

	//write out the color components.
	os.write_string(file, fmt.tprintf("%d %d %d\n", rbyte, gbyte, bbyte))
}


main :: proc() {
	image_width, image_height := 256, 256

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
		for j := 0; j < image_width; j += 1 {
			pixel_color: Color = Vec3 {
				f64(j) / f64(image_width - 1),
				f64(i) / f64(image_height - 1),
				0,
			}
			write_color(file, pixel_color)
		}
	}

	fmt.println("PPM file 'raytracer.ppm' has been generated.")
}
