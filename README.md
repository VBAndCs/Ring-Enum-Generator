# Ring-Enum-Generator

Ring programming language doesn't have a special structure for `Enum`. We can just define an enum as list like this:
```ring
Aliignment = [
	:Left = 0,
	:Right = 1,
	:Center = 2
]
```

and use it like this:
`a = Aliignment[:Left]`

But I wanted to use the familiar enum syntas:
`a = Aliignment.Left`
So, I created this class:
```ring
class AliignmentEnum
left = 0
right = 1
center = 2


func GetName(value)
switch value
case 0
return left
case 1
return right
case 2
return center

else
return NULL
end


func GetValues()
return [0, 1, 2]

func GetNames()
return [left, right, center]

func GetNamedValues()
return [:left = 0, :right = 1, :center = 2]
```

and created a global variable of it:
`Aliignment = new AliignmentEnum`

now, I can use the enum as I prefer:
```ring
x = Aliignment.Center
? Aliignment.GetName(x)
```

The additional methods, returns lists that contains the names, values, and named values:
```ring
names = Aliignment.GetNames()
values = Aliignment.GetValues()
list = Aliignment.GetNamedValues()
```

I found this useful, but it will be hard to write such a class every time I need a 2-value enum!
So, I decided to auto-generate it. I crated the `GenerateEnum` function in the file `EnumGenerator.ring`, to return a string containing the definition of the enum class. You can output this string to the output window, copy it to a ring project, or save it in a file. It's up to you.

# Sample code
The `GenerateEnum` function can be used like this:
```ring
x = GenerateEnum("Aliignment", [
:Left = 0,
:Right = 1,
:Center = 2])

? x
```

the output window will show the generated class.

# To DO"
Personally, I wish someone can add a command in the Ring Notepad that shows a window with a text book (to enter the enum name) , a table grid with two columns to enter names and values, and an OK button that calls the ` GenerateEnum` function to generate the class and show a save file dialogue to let the user choose the name and the location to save the class. Finally, the editor should add a `Load "[enumfile].ring" ` statement at the beginning of the current file opened in ring. Ot maybe we can let this option up to the user (by adding a check box to the enum generation window).

