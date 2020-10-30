```Ring
# Enum generator 
# Mohammad Hamdy Ghanem
# 30/10/2020


# ====== Usage Sample =========
x = GenerateEnum("Aliignment", [
	:Left = 0,
	:Right = 1,
	:Center = 2])

? x
# ==============================

func GenerateEnum(Name, enumValues)
   enumTemp = "%EnumName% = new %EnumName%Enum

class %EnumName%Enum
   %members%

   func GetName(value)
      switch value
         %cases%
         else
            return NULL
      end


   func GetValues()
      return [%values%]

   func GetNames()
      return [%names%]

   func GetNamedValues()
      return [%list%]
"
		 members = ""
	    cases = ""
       names = ""
       values = ""
       list = ""
       For v in enumValues
			  member = v[1] + " = " + v[2]
           members += member + nl
			  cases += "         case " + v[2] + nl + 
						  "            return " + v[1] + nl
           if len(Names) > 0 
              Names += ", "
              values += ", "
              list += ", "       
           end
           Names += V[1]
		     values += v[2]
           list += ":" + member
       Next

       enum = subStr(enumTemp, "%EnumName%", Name)
       enum = subStr(enum, "%members%", members)
       enum = subStr(enum, "%cases%", cases)
       enum = subStr(enum, "%names%", names)
       enum = subStr(enum, "%values%", values)
       enum = subStr(enum, "%list%", list)
       return enum
```
