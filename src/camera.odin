package main

//one unit from the camera to the viewport
focal_length := 1.0
//camera located at the origin for simplicity
camera_center := Point{0, 0, 0}

//width of the image in pixels
image_width := 400
aspect_ratio := 16.0 / 9.0
image_height := int(f64(image_width) / aspect_ratio)

//size of the viewport in terms of world units and not pixels
viewport_height := 2.0
viewport_width := viewport_height * (f64(image_width) / f64(image_height))

//vectors representing the viewport height and width in the world
viewport_width_vector := init_with_values(viewport_width, 0, 0)
viewport_height_vector := init_with_values(0, -viewport_height, 0)

//how much you need to move in the x and y directions to get to the next pixel
pixel_delta_width := get_veclength(viewport_width_vector) / f64(image_width)
pixel_delta_height := get_veclength(viewport_height_vector) / f64(image_height)

//the world space co-ordinates for the upper left of the viewport
//move the camera center back by focal_length and then shift left by width and up by height
viewport_upper_left :=
	camera_center - Vec3{0, 0, focal_length} - viewport_width / 2 - viewport_height / 2

//world space co-ordinate for the center of the first pixel (top left)
//move from viewport upper left by half of a pixel width and height
pixel00_loc := viewport_upper_left + (0.5 * pixel_delta_width) + (0.5 * pixel_delta_height)
