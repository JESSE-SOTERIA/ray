package main

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
	//shadow copies
	vector, index := v, i
	if i < 3 {
		return vector[i]
	} else {
		return -1.0
	}
}

set_index :: proc(v: ^Vec3, i: int, value: f64) {
	vector := v
	if i < 3 {
		vector[i] = value
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

get_unit :: proc(v: Vec3) -> Vec3 {
	vector := v
	length := get_veclength(vector)
	unit := scale_down_vector(vector, length)
	return unit
}
