package main

import "../src"
import "core:math"
import "core:testing"

@(test)
test_new_vec3 :: proc(t: ^testing.T) {
	v := new_vec3()
	testing.expect(t, v == Vec3{0.0, 0.0, 0.0}, "new_vec3 did not initialize to zero vector")
}

@(test)
test_init_with_values :: proc(t: ^testing.T) {
	v := init_with_values(1.0, 2.0, 7.0)
	testing.expect(
		t,
		v == Vec3{1.0, 2.0, 7.0},
		"init with values did not initialize with the correct values",
	)
}

@(test)
test_get_x :: proc(t: ^testing.T) {
	v := init_with_values(27.0, 2.0, 7.0)
	testing.expect(t, get_x(v) == 27.0, "get_x does not get the right value")
}

@(test)
test_get_y :: proc(t: ^testing.T) {
	v := init_with_values(27.0, 42.0, 7.0)
	testing.expect(t, get_y(v) == 42.0, "get_y does not get the right value")
}

@(test)
test_get_z :: proc(t: ^testing.T) {
	v := init_with_values(27.0, 2.0, 77.0)
	testing.expect(t, get_z(v) == 77.0, "get_z does not get the right value")
}

@(test)
test_negate :: proc(t: ^testing.T) {
	v := init_with_values(3.0, 4.0, 5.0)
	negv := negate(v)
	testing.expect(t, negv == Vec3{-3.0, -4.0, -5.0}, "negate function failed to negate")
}

@(test)
test_get_index :: proc(t: ^testing.T) {
	v := init_with_values(1.0, 2.0, 3.0)
	testing.expect(t, get_index(v, 2) == 3.0, "get_index got the wrong value")
}

@(test)
test_set_index :: proc(t: ^testing.T) {
	v := init_with_values(3.0, 4.0, 5.0)
	set_index(&v, 2, 77.0)
	testing.expect(
		t,
		get_z(v) == 77.00,
		"set_index wasnt able to set the value of provided index.",
	)
	set_index(&v, 3, 23.0)
	testing.expect(
		t,
		v == Vec3{3.0, 4.0, 77.0},
		"set_index is able to change a vector with an out of bounds index.",
	)
}

@(test)
test_scale_vec3 :: proc(t: ^testing.T) {
	v := init_with_values(3.0, 4.0, 5.0)
	v = scale_vector(v, 5.0)
	testing.expect(
		t,
		v == Vec3{15.0, 20.0, 25.0},
		"scale_vector does not scale a vector as intended.",
	)
}

@(test)
test_add_vec3 :: proc(t: ^testing.T) {
	v1 := init_with_values(3.0, 4.0, 5.0)
	v2 := init_with_values(3.0, 4.0, 5.0)
	v3 := add_vectors(v1, v2)
	testing.expect(
		t,
		v3 == Vec3{6.0, 8.0, 10.0},
		"add_vectors function does not add two vectors as intended.",
	)
}

@(test)
test_scale_down_vector :: proc(t: ^testing.T) {
	v := init_with_values(6.0, 4.0, 8.0)
	v = scale_down_vector(v, 2.0)
	testing.expect(
		t,
		v == Vec3{3.0, 2.0, 4.0},
		"scale_down_vec does not scale down vector as intended.",
	)
}

@(test)
test_get_veclength :: proc(t: ^testing.T) {
	v := init_with_values(6.0, 4.0, 8.0)
	len := get_veclength(v)
	testing.expect(
		t,
		math.abs(len - 10.7) < 1e-1,
		"get_vec_len does not accurately evaluate the magnitude of vectors.",
	)
}

@(test)
test_vec_len_squared :: proc(t: ^testing.T) {
	v := init_with_values(6.0, 4.0, 8.0)
	len := get_veclength(v)
	len2 := vec_len_squared(v)
	testing.expect(
		t,
		(len * len) == len2,
		"vec_len_squared does not accurately compute the square of the length of a vector",
	)

}

@(test)
test_get_unit :: proc(t: ^testing.T) {
	v := init_with_values(6.0, 4.0, 8.0)
	unit := get_unit(v)
	len := get_veclength(unit)
	testing.expect(t, math.abs(len - 1.0) < 1e-6, "get_unit did not return a unit vector.")
}
