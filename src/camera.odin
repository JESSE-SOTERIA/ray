package main

focal_length := 1.0
camera_center := Point{0, 0, 0}

//set image height and width based on an aspect ratio.
image_width := 400
aspect_ratio := 16.0 / 9.0
image_height := int(f64(image_width) / aspect_ratio)

//set the viewport height and width.	
viewport_height := 2.0
viewport_width := viewport_height * (f64(image_width) / f64(image_height))

viewport_width_vector := init_with_values(viewport_width, 0, 0)
viewport_height_vector := init_with_values(0, -viewport_height, 0)

pixel_delta_width := get_veclength(viewport_width_vector) / f64(image_width)
pixel_delta_height := get_veclength(viewport_height_vector) / f64(image_height)

viewport_upper_left :=
	camera_center - Vec3{0, 0, focal_length} - viewport_width / 2 - viewport_height / 2
pixel00_loc := viewport_upper_left + 0.5 * (pixel_delta_width + pixel_delta_height)
