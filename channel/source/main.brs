' Library "gameEngine.brs"

sub Main()
	' ------- These two lines are required --------
	gameEngine = gameEngine_init(1280, 720, true) ' This initializes the game engine
	gameEngine.loadBitmap("bm_ball", "pkg:/sprites/example.png")
	gameEngine.addRoom("room_main", room_main())
	gameEngine.addRoom("room_example", room_example())
	gameEngine.addObject("ball", ball())
	gameEngine.changeRoom("room_main")

	' You should really only need gameEngine.Update() in your while loop. 
	' Everything else should be attached to objects.
	while true
		gameEngine.Update() ' This must be in the main while loop, it's what makes the game engine tick.
	end while
end sub