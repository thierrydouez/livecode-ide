script "com.livecode.pi.geometry.behavior"
on editorInitialize
   set the editorMinWidth of me to 250
   put the rowLabel of me into field "rowlabel" of me
   set the rowShowLabel of me to false
   
   set the cMode of me to "scaling"
   
   if the platform is "MacOS" then 
      set the icon of btn "Window" to 202854
      set the top of btn "window" to 106
   else 
      set the icon of btn "Window" to 202855
      set the top of btn "Window" to 102
   end if
end editorInitialize

local sMode
setProp cMode pValue
   put pValue into sMode
   set the hilitedbuttonname of group "scaleorpos" to pValue
   if sMode is "scaling" then
      put "Width" into field "LimitX" of group "minmax" of group "Geometry Options" of me
      put "Height" into field "LimitY" of group "minmax" of group "Geometry Options" of me
      show graphic "Top" group "Diagram" of me
      show group "Top Object" of group "Diagram" of me
      show graphic "Left" group "Diagram" of me
      show group "Left Object" of group "Diagram" of me
   else
      put "Left" into field "LimitX" of group "minmax" of group "Geometry Options" of me
      put "Top" into field "LimitY" of group "minmax" of group "Geometry Options" of me
      hide graphic "Top" group "Diagram" of me
      hide group "Top Object" of group "Diagram" of me
      hide graphic "Left" group "Diagram" of me
      hide group "Left Object" of group "Diagram" of me
   end if
   editorUpdate
end cMode

on editorUpdate
   local tValue
   put the editorValue of me into tValue
   
   set the cSelectedObject of button "Right Object" of group "Right Object" of group "Diagram" of me to empty
   set the cSelectedObject of button "Bottom Object" of group "Bottom Object" of group "Diagram" of me to empty
   set the cSelectedObject of button "Top Object" of group "Top Object" of group "Diagram" of me to empty
   set the cSelectedObject of button "Left Object" of group "Left Object" of group "Diagram" of me to empty
   
   /*
   value array
   For each of the following tElement in "moveH, moveV, scaleBottom, scaleTop, scaleLeft, scaleRight"
   
   tValue[tElement] - { true | false }
   tValue[tElement & "ObjectRef"] - { "card" | <objectID> }
   tValue[tElement & "Absolute"] - { true | false }
   
   Plus:
   
   tValue["dontClipText"] - { true | false }
   tValue["showHScroll"] - { true | false }
   tValue["showVScroll"] - { true | false }
   
   tValue["minLeft"] - <number>
   tValue["maxRight"] - <number>
   tValue["minTop"] - <number>
   tValue["maxBottom"] - <number>
   
   tValue["minHeight"] - <number>
   tValue["maxHeight"] - <number>
   tValue["minWidth"] - <number>
   tValue["maxWidth"] - <number>
   
   */
   
   local tObjectId, tObjectName
   
   local tPositions
   if sMode is "scaling" then
      put "Bottom,Left,Top,Right" into tPositions
   else
      put "Bottom, Right" into tPositions
   end if
   
   local tKey, tPosition
   repeat for each item tPosition in "Bottom,Left,Top,Right"
      local tCardRelGraphic, tObjRelGraphic
      put the long id of graphic tPosition of group "Diagram" of me into tCardRelGraphic
      put the long id of graphic (tPosition && "object") of group (tPosition && "Object") of group "Diagram" of me into tObjRelGraphic
      
      if sMode is "scaling" then
         put "scale" & tPosition into tKey
      else
         if tPosition is "Right" then
            put "moveH" into tKey
         else
            put "moveV" into tKey
         end if
      end if
      
      if tValue[tKey] is true then
         set the backPattern of tObjRelGraphic to the cNoSize of tObjRelGraphic
         
         local tTargetGraphic
         if tValue[tKey &"ObjectRef"] is "card" then
            put tCardRelGraphic into tTargetGraphic
         else
            put tObjRelGraphic into tTargetGraphic
         end if
         
         if tValue[tKey & "Absolute"] then 
            set the backPattern of tTargetGraphic to the cFixed of tTargetGraphic
         else 
            set the backPattern of tTargetGraphic to the cProportional of tTargetGraphic
         end if
         
         if tValue[tKey &"ObjectRef"] is not "card" then
            put tValue[tKey & "ObjectRef"] into tObjectId
            put revUniqueIDToName(tObjectId) into tObjectName
            set the cSelectedObject of button (tPosition && "Object") of group  (tPosition && "Object") of group "Diagram" of me to tObjectName
         end if
      else
         set the backPattern of tCardRelGraphic to the cNoSize of tCardRelGraphic
         set the backPattern of tObjRelGraphic to the cNoSize of tObjRelGraphic
      end if
   end repeat
   
   set the hilite of button "prevent object clipping text" of group "Geometry Options" of me to (tValue["dontClipText"] is true)
   set the hilite of button "horizontal scrollbar" of group "Clipping" of group "Geometry Options" of me to (tValue["showHScroll"] is true)
   set the hilite of button "vertical scrollbar" of group "Clipping" of group "Geometry Options" of me to (tValue["showVScroll"] is true)
   
   if sMode is "scaling" then
      put tValue["minWidth"] into fld "minWidth" of group "minmax" of group "Geometry Options" of me
      put tValue["maxWidth"] into fld "maxWidth" of group "minmax" of group "Geometry Options" of me
      put tValue["minHeight"] into fld "minHeight" of group "minmax" of group "Geometry Options" of me
      put tValue["maxHeight"] into fld "maxHeight" of group "minmax" of group "Geometry Options" of me
   else
      put tValue["minLeft"] into fld "minWidth" of group "minmax" of group "Geometry Options" of me
      put tValue["maxRight"] into fld "maxWidth" of group "minmax" of group "Geometry Options" of me
      put tValue["minTop"] into fld "minHeight" of group "minmax" of group "Geometry Options" of me
      put tValue["maxBottom"] into fld "maxHeight" of group "minmax" of group "Geometry Options" of me
   end if
end editorUpdate

on editorResize
   
end editorResize

on mouseUp
   local tTarget
   put the short name of the target into tTarget
   
   local tValue
   put the editorValue of me into tValue
   
   switch tTarget
      case "scaling"
      case "positioning"
         set the cMode of me to tTarget
         break
      case "Prevent object clipping text"
         set the disabled of grp "Clipping" of group "Geometry Options" of me to not the hilite of the target
         put the hilite of the target into tValue["dontClipText"]
         break
      case "Horizontal Scrollbar"
         put the hilite of the target into tValue["showHScroll"]
         break
      case "Vertical Scrollbar"
         put the hilite of the target into tValue["showVScroll"]
         break
      case "limitsize"
         set the disabled of grp "minMax" of group "Geometry Options" of me to not the hilite of me
         if the disabled of group "minMax" of group "Geometry Options" then
            local tNames
            put "minWidth,maxWidth,minHeight,maxHeight" into tNames
            repeat for each item tField in tNames
               put empty into fld tField of group "minMax" of group "Geometry Options" of me 
               send "closeField" to fld tField of group "minMax" of group "Geometry Options" of me 
            end repeat
         end if
         break
      case "Remove All"
         answer warning "Really remove all Geometry from the selected object?" with "No" or "Yes"
         if it is "Yes" then
            put empty into tValue
         end if
         break
      default
         break
   end switch
   setValue tValue
end mouseUp

on mouseDown pButton
   local tTarget
   put the short name of the target into tTarget
   
   if pButton is 3 then
      set the cScaleName of this cd to the short name of the target
      popup btn "Squiggle type" at the clickLoc
   else
      put word 1 of the short name of the target into tName
      put revGetGeometry(tName&"ObjectRef") into tObjectRef
      switch the backPattern of the target
         case the cNoSize of the target
            set the backPattern of the target to the cFixed of the target
            if tObjectRef is not empty and tObjectRef is not empty then
               revSetGeometry (tName&"Absolute"),true
            end if
            break
         case the cFixed of the target
            set the backPattern of the target to the cProportional of the target
            if tObjectRef is not empty and tObjectRef is not empty then
               revSetGeometry (tName&"Absolute"),false
            end if
            break
         case the cProportional of the target
            set the backPattern of the target to the cNoSize of the target
            if tObjectRef is not empty and tObjectRef is not empty then
               revSetGeometry (tName),false
            end if
            break
      end switch
      set the defaultStack to tStack
      set the backPattern of grc (word 1 of the short name of the target) to the cNoSize of grc (word 1 of the short name of the target)
   end if  
   
   
   if word 1 of the target is "button" then
      switch tTarget
         case "Top Object"
         case "Left Object"
         case "Bottom Object"
         case "Right Object"
            if sMode is "scaling" then
               set the cSide of me to word 1 of tTarget -- left, top, bottom, or h and v in positioning mode
            else
               if tTarget is "Right Object" then
                  set the cSide of me to "h"
               else
                  set the cSide of me to "v"
               end if
            end if
            
            set the cCurrentButton of me to the long id of the target
            revRefreshContentsOfMenu
            popup btn "Object name" at the clickLoc   
            break
         default
            break
      end switch
   else if word 1 of the target is "graphic" then
      switch tTarget
         case "Top Object"
         case "Left Object"
         case "Bottom Object"
         case "Right Object"
            # Do not allow link graphic to be clicked if no object is selected
            if the backPattern of the target is the cNoSize of the target and the cSelectedObject of button tTarget of group tTarget of group "Diagram" of me is empty then
               exit mouseDown
            end if
            break
         default 
            break
      end switch
      



end if
end mouseDown

on menuPick pWhich
   lock screen
   put the cScaleName of this cd into tScale
   switch pWhich
      case "No Scaling"
         set the backPattern of grc tScale to the cProportional of grc tScale
         break
      case "Fixed Scaling"
         set the backPattern of grc tScale to the cNoSize of grc tScale
         break
      case "Proportional Scaling"
         set the backPattern of grc tScale to the cFixed of grc tScale
         break
   end switch
   send "mouseDown" to grc tScale
   unlock screen
end menuPick

on revRefreshContentsOfMenu
   local tCurrentButton, tSelectedObject, tControl, tObject, tStack, tList
   put line 1 of the editorTargetObjects of me into tObject
   put revIDEStackOfObject(tObject) into tStack
   
   revIDEPushDefaultStack tStack
   repeat with i = 1 to the number of controls
      put the cCurrentButton of me into tCurrentButton       
      if the long id of control i is not tObject then 
         local tMenuItem
         if the name of control i is the cSelectedObject of tCurrentButton then
            put "!r" & the name of control i into tMenuItem
         else
            put "!u" & the name of control i into tMenuItem
         end if
         
         if tList is empty then
            put tMenuItem into tList
         else
            put return & tMenu after tList
         end if
      end if
   end repeat

   revIDEPopDefaultStack
   
   set the text of button "Object name" of me to tList
end revRefreshContentsOfMenu

on menuPick pWhich
   local tSide
   if the cSide of me is among the items of "h,left,right" then 
      put "right" into tSide
   else 
      put "bottom" into tSide
   end if
   
   local tWhich, tGraphicLongID
   if the cSide of me is "h" then
      put "right" into tWhich
   else if the cSide of me is "v" then
      put "bottom" into tWhich
   else
      put the cSide of me into tWhich
   end if
   put the long id of graphic (tWhich && "object") of group (tWhich && "object") of group "Diagram" of me into tGraphicLongID
   
   
   if the backPattern of tGraphicLongID is the cNoSize of tGraphicLongID then
      set the backPattern of tGraphicLongID to the cFixed of tGraphicLongID
   end if   
   set the backPattern of grc tWhich of group "Diagram" of me to the cNoSize of grc tWhich of group "Diagram" of me
   
   local tKey
   if sMode is "scaling" then
      put "scale" into tKey
   else
      put "move" into tKey
   end if
   
   local tStart, tTrue
   put tKey & the cSide of me into tStart
   put the backPattern of tGraphicLongID is the cFixed of tGraphicLongID into tTrue
   
   local tValue
   put the editorValue of me into tValue
   put true into tValue[tStart]
   
   if tTrue then
      --fixed scaling
      put true into tValue[tStart & "Absolute"]
   else
      --proportional scaling
      put false into tValue[tStart & "Absolute"]
   end if
   put tSide into tValue[tStart & "ObjectSide"] 
   put pWhich into tValue[tStart & "ObjectRef"] 
   
   # Adjust menu text
   local tMenuText
   repeat with x = 1 to the number of lines of the text of button "Object name" of me
      if pWhich is line x of button "Object name" of me then
         put "!r" & line x of button "Object name" of me into line x of tMenuText
      else
         put "!u" & line x of button "Object name" of me into line x of tMenuText 
      end if
   end repeat
   
   local tButtonTemp
   put the cCurrentButton of me into tButtonTemp
   set the cObjectList of tButtonTemp to tMenuText
   set the cSelectedObject of tButtonTemp to pWhich
   
   setValue tValue
end menuPick

on setValue pValue
   set the editorValue of me to pValue
   updateProperty
end setValue

on closeField
   local tFieldValue
   put the text of the target into tFieldValue
   
   local tValue
   put the editorValue of me into tValue
   
   switch the short name of the target
      case "minWidth"
         if sMode is "scaling" then
            put tFieldValue into tValue["minWidth"]
         else
            put tFieldValue into tValue["minLeft"]
         end if
         break
      case "maxWidth"
         if sMode is "scaling" then
            put tFieldValue into tValue["maxWidth"]
         else
            put tFieldValue into tValue["maxRight"]
         end if
         break
      case "minHeight"
         if sMode is "scaling" then
            put tFieldValue into tValue["minHeight"]
         else
            put tFieldValue into tValue["minTop"]
         end if
         break
      case "maxHeight"
         if sMode is "scaling" then
            put tFieldValue into tValue["maxHeight"]
         else
            put tFieldValue into tValue["maxBottom"]
         end if
         break
   end switch
   
   setValue tValue
end closeField
