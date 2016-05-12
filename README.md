Roku-gameEngine
======
An object oriented game engine for the Roku

The purpose of this project is to make it easy to develop games for the Roku in an object oriented fasion. Similar to how you would with an engine such as Gamemaker or Unity (minus any visual software that is).

First start by creating the gameEngine object

##### gameEngine = gameEngine_init(canvas_width as Integer, canvas_height as Integer, debug as Boolean) as Object
Creates the main gameEngine object, the canvas width and height create an empty bitmap of that size that the game is drawn to. If debug is enabled various information will be printed to the console.


gameEngine
------
###### ---General Methods---
##### Update() as Void
This method must be called in your main while loop in order for the game to execute.
##### newEmptyObject(object_type as String) as Object
This method is primarily for internal use, but may be called manually if desired. It returns an empty game object.
##### drawColliders(instance as Object) as Void
This method is for debugging purposes, it will draw the colliders associated with the provided instance.
##### getDeltaTime() as Float
Returns the delta time. Note: Delta time is automatically applied to the built in instance xspeed and yspeed. Delta time is also automatically passed to the onUpdate(dt) function in every instance for convenience.
##### setBackgroundColor(color as Dynamic) as Void
Set the color the canvas will be cleared with, if set to invalid the canvas will not be cleared.
##### getCanvas() as Object
Returns the canvas bitmap object.
##### getScreen() as Object
Returns the screen object.

###### ---Game Object Methods---
##### defineObject(object_type as String, object_creation_function as Function) as Void
Define a new game object. The function provided will be called when an instance of the object is created, the function provided receives an empty object and modifies it as necessary.
##### createInstance(object_type as String, [args as AssociativeArray]) as Dynamic
Creates a new instance of an object that has been defined using defineObject(). The args AssociativeArray is optional, it will be passed to the onCreate() method.

If the instance is created successfully, the instance is returned. Otherwise returns invalid.
##### getInstanceByID(instance_id as String) as Object
Returns the instance associated with the provided ID.
##### getInstanceByType(object_type as String) as Object
Returns the first instance of an object of the specified type. (note: If more than one instance exists, only the first one will be returned)
##### getAllInstances(object_type as String) as Array
Returns array containing all instances of the specified type.
##### destroyInstance(instance as Object) as Void
Destroys the provided instance.
##### destroyAllInstances(object_type as String) as Void
Destroys all instances of the specified type.
##### instanceCount(object_type as String) as Integer
Returns the number of instances of the specified type.

##### defineRoom(room_name as String, room_creation_function as Function) as Void
Define a new room. The function provided will be called when the room is switched to, the function provided receives an empty object and modifies it as necessary. This is the same as defineObject() except it is used for rooms.
##### changeRoom(room_name as String, [args as AssociativeArray]) as Boolean
Switches to a room that has been defined using defineRoom(). The args AssociativeArray is optional, it will be passed to the onCreate() method.
##### resetRoom() as Void
Resets the current room, retaining the original args.

###### ---Bitmap Methods---
##### loadBitmap(bitmap_name as String, path as Dynamic) as Boolean
Loads a bitmap into memory and makes it available by name with the getBitmap() function. The path can also be an associative array structured like so {width: 10, height: 10, AlphaEnable: true}, doing this will create an empty bitmap. Returns true if successful.
##### getBitmap(bitmap_name as String) as Dynamic
Returns the bitmap associated with the provided name. Returns invalid if a bitmap with the provided name hasn't been loaded.
##### unloadBitmap(bitmap_name as String) as Boolean
Unloads the bitmap associated with the provided name from memory. Returns true if successful.

###### ---Font Methods---
##### registerFont(path as String) as Boolean
Registers the font at the provided path. Returns true if successful. Note: All fonts in the directory pkg:/fonts/ automatically get registered.
##### loadFont(font_name as String, size as Integer, italic as Boolean, bold as Boolean) as Void
Loads the font with the provided name into memory. Note: The font must be registered first and the font_name must be the same as the filename prefix.
##### unloadFont(font_name as String) as Void
Unloads the font associated with the provided name from memory.
##### getFont(font_name as String) as Object
Returns the font associated with the provided name. Font must have been previously loaded using loadFont().

###### ---Canvas Methods---
##### canvasSetSize(canvas_width as Integer, canvas_height as Integer) as Void
Modifies the canvas size with the provided width and height. 
##### canvasGetSettings() as Object
Returns an associative array with the current canvas settings. This will include; offset_x, offset_y, scale_x, scale_y.
##### canvasIncreaseOffset(x as Float, y as Float) as Void
Increase the canvas x and y positions by the provided amounts.
##### canvasIncreaseScale(scale_x as Float, [scale_y as Float]) as Void
Increases the canvas scale by the given amount, if only scale_x is given, scale_y will be set to the same amount. The scale_y parameter is only necessary if you want to stretch the canvas.
##### canvasSetOffset(x as Float, y as Float) as Void
Set the canvas x and y positions. Note: positions are absolute and not in relation to the current scale, you should take scale into account when manually setting the positions.
##### canvasSetScale(scale_x as Float, [scale_y as Float]) as Void
Sets the canvas scale to the given amount, if only scale_x is given, scale_y will be set to the same amount. The scale_y parameter is only necessary if you want to stretch the canvas.
##### canvasSetFollow(instance as Object, [mode as Integer]) as Void
Sets the canvas to follow the provided instance. Mode can be 0 or 1, the default is 0. In mode 0, the canvas will not move beyond the canvas boundaries. In mode 1, the canvas will keep the instance centered no matter what, meaning if the instance is towards the edge of the canvas, black will be shown.
##### canvasUnsetFollow() as Void
Stops following the instance if one was being followed.
##### canvasFitToScreen() as Void
This fits the game canvas to the screen regardless of the screen aspect ratio. This makes it so a game can be made at any size and black bars will be shown on the top/bottom or left/right if the game aspect ratio is not the same as the TV's.
##### canvasCenterToScreen() as Void
This centers the game canvas.
##### canvasCenterToInstance(instance as Object, [mode as Integer]) as Void
This function is used internally when the canvas is set to follow an instance, however it can be used manually if you want to center to an object only once. See canvasSetFollow() for a description of mode options.

###### ---Audio Methods---
##### musicPlay(path as String, [loop as Boolean]) as Boolean
Plays music from the provided path. Loop defaults to false. Returns true if the path is valid.
##### musicStop() as Void
Stops the currently playing music.
##### musicPause() as Void
Pauses the currently playing music.
##### musicResume() as Void
Resumes music that is paused.
##### loadSound(sound_name as String, path as String) as Void
Loads a short sound in to memory from the provided path to be triggered by playSound() with the provided name. This is specifically for sound effects, because the sounds are in memory they will be played instantly.
##### playSound(sound_name as String, [volume as Integer]) as Boolean
Plays the sound associated with the name provided, sound must have already been loaded using loadSound(). Returns true if the sound was triggered.

###### ---Async Methods---
##### newAsyncUrlTransfer() as Object
Returns a roUrlTransfer object that can be used to asynchronously request data from a server. The response message is then passed to the gameObject onUrlEvent method. The roUrlTransfer object _must be used only once_ as it will be automatically destroyed upon recieving a response. A new roUrlTransfer object should be retrieved for each independent transfer request.


gameObject
------
A game object is an object that has been created using the function newEmptyObject(), this is usually done internally by defining a new object using defineObject() and then creating a new instance of it using createInstance(). Instructions on doing this can be found above. 

The basic game object structure looks like this.
```brightscript
new_object = {

	' -----Constants-----
	type: object_type
	id: m.currentID.ToStr()
	gameEngine: m

	' -----Variables-----
	persistent: false
	depth: 0
	x: 0.0
	y: 0.0
	xspeed: 0.0
	yspeed: 0.0
    colliders: {}
    images: []

    ' -----Methods-----
    (Methods will be described below)

}
```

###### ---Constants---
* type: This is the object type as declared by defineObject(). For example - A "ball" object can be defined, all instances of the object will be of type "ball" but will have different IDs.
* id: This is the ID for this specific instance.
* gameEngine: This is a reference to the gameEngine so that every object instance can easily access its methods.

###### ---Variables---
* persistent: If true the instance will not be destroyed when the on changeRoom(), default behavior is to destroy all instances on changeRoom().
* depth: Declares the instance draw depth.
* x/y: The x and y positions of the instance.
* xspeed/yspeed: The movement speed of the instance. Note: This is automatically multiplied by delta time.
* colliders: Instances can have multiple colliders, you can modify collider properties here but adding a new collider should be done by the methods described below.
* images: Instances can have multiple images, you can modify image properties here but adding a new image should be done by the methods described below.

###### ---Override Methods---
The override methods are designed to be overridden. They are automatically called by the gameEngine at the approprate times.
Note: For these methods, if an argument is shown, then the override method _must_ accept that argument as well.

##### onCreate(args)
This method will always be called when the instance is created. Put creation code here. Must receive args as an associative array, this is the same associative array that is passed as args when calling createInstance().

##### onUpdate(deltaTime)
This method is called every frame. Put code to be constantly ran here. 

##### onCollision(collider, other_collider, other_instance)
This method is called when two object instances collide. collider and other_collider are strings refering to the specific colliders that are in collision. other_instance is the object instance that has been collided with.

##### onDrawBegin(canvas)
This is called before the instance is drawn and receives the canvas as a object that can be drawn to. 

##### onDrawEnd(canvas)
This is called after the instance is drawn and receives the canvas as a object that can be drawn to. 

##### onDrawGui(screen)
This is called after the game has been drawn to the screen and receives the screen object. This can be used to draw interface elements that will not be affected by the canvas position/scale. Note: The screen is always the same resolution as the device resolution.

##### onButton(code)
This is called whenever a button is pressed, released, or held.

| Button | When Pressed | When Released | When Held |
|:---:|:---:|:---:|:---:|
| Back | 0 | 100 | 1000 |
| Up | 2 | 102 | 1002 |
| Down | 3 | 103 | 1003 |
| Left | 4 | 104 | 1004 |
| Right | 5 | 105 | 1005 |
| Select | 6 | 106 | 1006 |
| Instant Replay | 7 | 107 | 1007 |
| Rewind | 8 | 108 | 1008 |
| Fast Forward | 9 | 109 | 1009 |
| Info | 10 | 110 | 1010 |
| Play | 13 | 113 | 1013 |

##### onAudioEvent(message)
This is called when an audio event is triggered, the message is passed to the method.

##### onDestroy()
This method will always be called just before the instance is destroyed.

###### ---Creation Methods---
##### addColliderRectangle(collider_name as String, offset_x as Integer, offset_y as Integer, width as Integer, height as Integer, [enabled as Boolean])
Adds a rectangle collider to the instance's colliders associative array with the provided name and properties. Enabled is true by default.
##### addColliderCircle(collider_name, radius, [offset_x as Integer, offset_y as Integer, enabled as Boolean])
Adds a circular collider to the instance's colliders associative array with the provided name and properties. By default offset_x is 0, offset_y is 0, and enabled is true.
##### removeCollider(collider_name)
Removes the collider with the provided name.
##### addImage(image as Object, args as Object)
Adds the provided image to the instance's images array. The image should be of type roBitmap or roRegion. Images are added to an array and are drawn in the order they are added to that array. Args should be an associative array with values to override the defaults. Here are the defaults that can be overridden.

```brightscript
args = {
	offset_x: 0 ' The offset of the image.
	offset_y: 0 
	origin_x: 0 ' The image origin (where it will be drawn from). This helps for keeping an image in the correct position even when scaling.
	origin_y: 0
	scale_x: 1.0 ' The image scale.
	scale_y: 1.0
	color: &hFFFFFF ' This can be used to tint the image with the provided color if desired. White makes no change to the original image.
	alpha: 255 ' Change the image alpha (transparency).
	enabled: true ' Whether or not the image will be drawn.

	' The following values should only be changed if the image is a spritesheet that needs to be animated.
	' The spritesheet can have any assortment of multiple columns and rows.
	image_count: 1 ' The number of images in the spritesheet.
	image_width: invalid ' The width of each individual image on the spritesheet.
	image_height: invalid ' The height of each individual image on the spritesheet.
	animation_speed: 0 ' The time in milliseconds for a single cycle through the animation to play.
	animation_position: 0 ' This would not normally be changed manually, but if you wanted to stop on a specific image in the spritesheet this could be set.
}
```
##### removeImage(index as Integer)
Removes the image in the images array that corresponds to the provided index.

Other Utilities
------
This area will be a collection of functions that I've found useful for game development.

##### ArrayInsert(array, index, value) 
This function is used internally. It will insert a value to the specified index of an array and shift all subsequent values.
##### DrawCircle(draw2d, line_count, x, y, radius, color)
This function is used interally when DrawColliders() is called. It will draw an empty circle to the screen, however this is extremely expensive and is meant for debugging purposes only.
##### atan2(y, x)
This is here because brightscript unfortunately doesn't provide an atan2 math function.
##### HSVtoRGB(hue, saturation, value, [alpha])
This will convert a hue, saturation, value color to a red, green, blue color hex. If alpha is provided the returned hex will be in RGBA format instead of RGB.
These registry functions make it easy to read and write to the registry, they should be mostly self exlanitory.
##### registryWrite(registry_section as String, key as String, value as Dynamic) as Void
Writes to the provided registry section the provided key/value pair. Data types supported are booleans, integer and floating point numbers, strings, roArray, and roAssociativeArray objects.
##### registryRead(registry_section as String, key as String, [default_value as Dynamic]) as String
Reads the provided key from the provided registry section. The default value will be written if the registry section and key have no value yet. Returns the value as a string.
