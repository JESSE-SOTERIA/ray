package main

Ray :: struct {
	origin:    Point,
	direction: Vec3,
}

ray_origin :: proc(ray: Ray) -> Point {
	return ray.origin
}

ray_direction :: proc(ray: Ray) -> Vec3 {
	return ray.direction
}

ray_at :: proc(ray: Ray, scalar: f64) -> Point {
	return ray.origin + (scalar * ray.direction)
}

ray_color :: proc(ray: Ray) -> Color {
	a := 0.5 * (get_x(ray.direction) + 1.0)
	return (1.0 - a) * Color{1.0, 1.0, 1.0} + a * Color{0.5, 0.7, 1.0}
}

ray_init :: proc(center: Point, direction: Vec3) -> Ray {
	return Ray{center, direction}
}
