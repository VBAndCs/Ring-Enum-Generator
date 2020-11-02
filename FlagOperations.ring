# Don't forget to copy This file to the folder Ring\Bin

Class FlagOperations
    Value = 0
    Name = "None"
    MaxValue
    Text
    OnFlags
    OffFlags


    func init(flagName, v, max)
        Name = flagName
        MaxValue = max
        If v > MaxValue 
           Value = v & MaxValue
        else
           Value = v   
        end


    func SetValue()
         raise "Value Is Read Only"

    func GetOnFlags()
       lstFlags = []
       For flag In FileState.Flags
           If (Value & flag.Value) > 0 
              lstFlags + flag
           end
       Next
       Return lstFlags

    func SetOnFlags(lstFlags)
       SetFlags(lstFlags)

    func GetOffFlags()
       lstFlags = []
       For flag In FileState.Flags
           If (Value & flag.Value) = 0 
              lstFlags + flag
           end
       Next
       Return lstFlags

    func SetOffFlags(lstFlags)
       UnsetFlags(lstFlags)

    func GetText()
         return ToString("")

    func SetText()
         raise("Text is read only.")

    Func ToString(Separator)
        If Value = 0 Return FileState.None.Name end
        If Value = MaxValue Return FileState.All.Name end

        If Separator = ""
           Separator = "+"
        End

        sb = ""
        For flag In FileState.Flags
            If (Value & flag.Value) > 0
                If len(sb) > 0
                   sb += Separator
                end
                sb += flag.Name
            End
        Next
        Return sb

    Func ToInteger()
        Return Value

    Func SetFlag(flag)
        if type(flag) = "OBJECT" 
           v = flag.Value
        else
           v = flag
        end
        Return new FlagOperations("", Value | v, MaxValue)

    Func SetFlags(flags)
        if type(flags) = "OBJECT" 
           Return new FlagOperations("", Value | flags.Value, MaxValue)
        elseIf isNull(flags) Or len(flags) = 0 
           Return new FlagOperations("", Value, MaxValue) 
        end

        v = Value
        For flag In Flags
            v = v | flag.Value
        Next
        Return new FlagOperations("", v, MaxValue)

    Func SetAllExcxept(flags)
        if type(flags) = "OBJECT" 
           Return new FlagOperations("", MaxValue - flags.Value, MaxValue)
        elseIf isNull(flags) Or len(flags) = 0 
           Return new FlagOperations("", Value, MaxValue)
        end

        v = MaxValue
        For flag In Flags
            v -= flag.Value
        Next

        Return new FlagOperations("", v, MaxValue)

    Func UnsetFlag(flag)
        if type(flag) = "OBJECT" 
           v = flag.Value
        else
           v = flag
        end
        Return new FlagOperations("", Value & (Maxvalue - v) , MaxValue)

    Func UnsetFlags(flags)
        if type(flags) = "OBJECT" 
           Return new FlagOperations("", Value & (MaxValie - flags.Value) , MaxValue)
        elseIf isNull(flags) Or len(flags) = 0
           Return new FlagOperations("", Value, MaxValue)
        end

        v = Value
        For flag In Flags
            v = v & (MaxValue - flag.Value)
        Next
        Return new FlagOperations("", v, MaxValue)

    Func UnsetAllExcxept(flags)
        if type(flags) = "OBJECT" 
           Return flags
        elseIf isNull(flags) Or len(flags) = 0
           Return new FlagOperations("", Value, MaxValue)
        end

        v = 0
        For flag In Flags
            v += flag.Value
        Next
        Return new FlagOperations("", v, MaxValue)

    Func ToggleFlag(flag)
        if type(flag) = "OBJECT" 
           v = flag.Value
        else
           v = flag
        end
        Return new FlagOperations("", Value ^ v, MaxValue)

    Func ToggleFlags(flags)
        if type(flags) = "OBJECT" 
           Return new FlagOperations("", Value ^ flags.Value, MaxValue)
        elseIf isNull(flags) Or len(flags) = 0 
           Return new FlagOperations("", Value, MaxValue)
        end

        v = Value
        For flag In Flags
            v = v ^ flag.Value
        Next
        Return new FlagOperations("", v, MaxValue)

    Func ToggleAll()
        Return new FlagOperations("", Value ^ MaxValue, MaxValue)

    Func IsSet(flag)
        if type(flag) = "OBJECT" 
           v = flag.Value
        else
           v = flag
        end
        Return (Value & v) > 0

    Func AreAllSet(flags)
        if type(flags) = "OBJECT" 
           Return (Value & flags.Value) > 0
        elseIf isNull(flags) Or len(flags) = 0 
           Return Value = MaxValue
        end

        For flag In Flags
            If (Value & flag.Value) = 0 Return False end
        Next
        Return True

    Func IsUnset(flag)
        if type(flag) = "OBJECT" 
           v = flag.Value
        else
           v = flag
        end
        Return (Value & v) = 0

    Func AreAllUnset(flags)
        if type(flags) = "OBJECT" 
           Return (Value & flags.Value) = 0
        elseIf isNull(flags) Or len(flags) = 0
           Return Value = 0
        end

        For flag In Flags
            If (Value & flag.Value) > 0 Return False end
        Next
        Return True

    Func IsAnySet(flags)
        if type(flags) = "OBJECT" 
           Return (Value & flags.Value) > 0
        elseIf isNull(flags) Or len(flags) = 0 
           Return Value > 0
        end

        For flag In Flags
            If (Value & flag.Value) > 0 Return True end
        Next
        Return False

    Func IsAnyUnset(flags)
        if type(flags) = "OBJECT" 
           Return (Value & flags.Value) = 0
        elseIf isNull(flags) Or len(flags) = 0 Then 
           Return Value < MaxValue 
        end

        For flag In Flags
            If (Value & flag.Value) = 0 Return True end
        Next
        Return False


	func operator(op, flag)
      v = 0
      if type(flag) = "OBJECT" and ClassName(flag) = lower("FlagOperations")
         v = flag.Value
      else
         v = flag
      end

	   switch op 
	     case "[]"
           Return (Value & v) > 0
	     case "&"
           Return new FlagOperations("", Value & v, MaxValue)
	     case "|"
           Return new FlagOperations("", Value | v, MaxValue)
	     case "+"
           Return new FlagOperations("", Value | v, MaxValue)
	     case "-"
           Return new FlagOperations("", Value & (Maxvalue - v) , MaxValue)
	     case "^"
           Return new FlagOperations("", Value ^ v, MaxValue)
	     case "~"
           Return new FlagOperations("", MaxValue - Value, MaxValue)
	     case "="
           Return Value = v
	     case "!="
           Return Value != v
	     case ">"
           Return Value > v
	     case ">="
           Return Value >= v
	     case "<"
           Return Value < v
	     case "<="
           Return Value <= v
	   end

