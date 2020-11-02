# Enum generator 
# Mohammad Hamdy Ghanem
# 1/11/2020


# ====== Usage Sample =========
? GenerateFlag("FileState", ["ReadOnly", "Hidden", "System"])
# ==============================

func GenerateFlag(FlagName, lstFlags)
	if not isList(lstFlags)
      raise("Bad parameter type!")
   elseif len(lstFlags) = 0
      raise("Flag must contain members")
   end

#================template================================

   FlagTemplate = '
load "FlagOperations.ring"

%FlagName% = new %FlagName%Flags

Class %FlagName%Flags
    MaxValue = %MaxValue%
    FlagNames = [%StrFlagList%]
    FlagValues = [%ValueList%]
%Flags%
    None = New FlagOperations("None", 0, MaxValue, FlagNames)
    All = New FlagOperations("All", MaxValue, MaxValue, FlagNames)
    Flags = [%FlagList%]
'

#============eval=================
  FlagTemplate = SubStr(FlagTemplate, "%FlagName%", FlagName)

  L = len(lstFlags) 
  MaxValue = pow(2, L) - 1
  FlagTemplate = SubStr(FlagTemplate, "%MaxValue%", String(MaxValue))

  sFlags = ""
  sFlagList = ""
  sStrFlagList = ""
  sValueFlagList = ""

  For i = 1 To L 
     flag = '"' + lstFlags[i] + '"'
     value = pow(2, i - 1)

     sFlags += "    " + lstFlags[i] + " = New FlagOperations(" + flag + ", " + value + ", MaxValue, FlagNames)" + nl
     If Len(sFlagList) > 0
        sFlagList += ", "
        sStrFlagList += ", "
        sValueFlagList += ", "
     End
     sFlagList += lstFlags[i]
     sStrFlagList += flag
     sValueFlagList += value
  Next
  FlagTemplate = SubStr(FlagTemplate, "%Flags%", sFlags)
  FlagTemplate = SubStr(FlagTemplate, "%FlagList%", sFlagList)
  FlagTemplate = SubStr(FlagTemplate, "%StrFlagList%", sStrFlagList)
  FlagTemplate = SubStr(FlagTemplate, "%ValueList%", sValueFlagList)

  Return FlagTemplate
