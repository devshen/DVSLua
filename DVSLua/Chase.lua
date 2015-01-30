function chase(other)

	cubeTarget_x, cubeTarget_y = myLib.cubeP()

	x, y = myLib.get_cube_Position(other)

	if cubeTarget_x < x then
		myLib.go_left(other)
	elseif cubeTarget_x > x then
		myLib.go_right(other)
	end

	if cubeTarget_y > y then
		myLib.go_down(other)
	elseif cubeTarget_y < y then
		myLib.go_up(other)
	end

end