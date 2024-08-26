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
	local_ray := ray
	if hit_sphere(Vec3{0, 0, -1}, 0.5, &local_ray) {
		return Vec3{1, 0, 0}
	}

	unit_direction := get_unit(ray.direction)
	a := 0.5 * (unit_direction.y + 1.0)
	return (1.0 - a) * Color{1.0, 1.0, 1.0} + a * Color{0.5, 0.7, 1.0}
}

ray_init :: proc(center: Point, direction: Vec3) -> Ray {
	return Ray{center, direction}
}


hit_sphere :: proc(center: Point, radius: f64, ray: ^Ray) -> bool {
	oc := center - ray.origin
	a := dot(ray.direction, ray.direction)
	b := -2.0 * dot(ray.direction, oc)
	c := dot(oc, oc) - (radius * radius)
	discriminant := (b * b) - (4 * a * c)
	return discriminant >= 0
}
