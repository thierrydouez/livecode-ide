script "revDictionary"
on preOpenStack
   set the minWidth of this stack to 1000
   dispatch "setAsBehavior" to stack revIDEFrameBehavior() with the long id of me
   set the showPreferenceAction of me to false
   set the title of me to "Dictionary"
   if there is not a widget "Dictionary" of me then
	   create widget "Dictionary" as "com.livecode.extensions.livecode.browser"
	   set the javascripthandlers of widget "Dictionary" of me to "fetchData"
	   send "showAPIs" to me in 0 millisecs
   end if	

end preOpenStack

on openStack
   lock screen
   addFrameItem "show_apis","header", "navigation", "API", "f1b3", "f1b3","showAPIs", the long id of me
   addFrameItem "show_guides","header", "navigation", "Guide", "f1b3", "f1b3","showGuides", the long id of me
   set the navigationDisplayStyle of me to "names"
   set the width of this stack to 1000
   resizeStack
   set the cantModify of me to true
   showTab the cTab of widget "Dictionary" of me
   unlock screen
end openStack

on resizeStack
   set the rect of widget 1 of me to the contentRect of me
end resizeStack

on showAPIs
   showTab "api"
end showAPIs

on showGuides
   showTab "guide"
end showGuides

function getUrl pTab
   if pTab is "guide" then
      return ("file:" & revIDESpecialFolderPath("documentation") & slash & "html_viewer" & slash & "guide.html")
   else
      return ("file:" & revIDESpecialFolderPath("documentation") & slash & "html_viewer" & slash & "viewer.html")
   end if 
end getUrl

on showTab pTab
   hiliteFrameItem pTab
   set the cTab of widget "Dictionary" of me to pTab
   set the url of widget "Dictionary" of me to getUrl(pTab)
end showTab

on previewDocs
   lock screen
   addFrameItem "show_preview","header", "navigation", "Show Preview", "f1b3", "f1b3","showPreview", the long id of me
   
   local tTempViewer
   put revIDESpecialFolderPath("documentation") & slash & "html_viewer" & slash & "viewer_temp.html" into tTempViewer
   if there is not a file tTempViewer then
      local tHTML
      put url ("file:" & revIDESpecialFolderPath("documentation") & slash & "html_viewer" & slash & "viewer.html") into tHTML
      replace "built_api.js" with "temp_api.js" in tHTML
      put tHTML into url ("file:" & tTempViewer)
   end if
   
   layoutFrame
   resizeStack
   unlock screen
   showPreview
end previewDocs

function fetchData
   local tJSONDataPath
   put revIDESpecialFolderPath("documentation cache") & slash & "built_" & sTab & ".js" into tJSONDataPath
   return textDecode(url("binfile:" & tJSONDataPath), "utf-8")
end fetchData
