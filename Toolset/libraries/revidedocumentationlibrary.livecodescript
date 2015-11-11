script "revIDEDocumentationLibrary"
local sConnection

on revLoadLibrary
   insert the script of me into back
   ideDocsInitialize
end revLoadLibrary

on ideDocsInitialize
   if sConnection is not empty then
      exit ideDocsInitialize
   end if
   
   revIDEPushDefaultFolder revIDESpecialFolderPath("api")
   
   local tConnection
   put revOpenDatabase("sqlite","api.sqlite",,,,,,) into tConnection
   if the result is not a number then
      exit ideDocsInitialize
   end if
   
   revIDEPopDefaultFolder
   
   put tConnection into sConnection
end ideDocsInitialize

private function __fetchDocsData pLibraryName, pEntryName
   local tFavouritesAlbumId
   local tSql, tRecordSet, tData
   
   put "SELECT data from" && pLibraryName && "WHERE entry_name = '" & tolower(pEntryName) & "'" into tSql
   
   # Execute the query, keeping the record set ID.
   put revQueryDatabase(sConnection, tSql) into tRecordSet
   if the result is not a number then
      return empty
   end if
   
   # Get the docs data from the record set
   get revDatabaseColumnNamed(tRecordSet, "data", "tData")
   
   # Close the record set
   revCloseCursor tRecordSet
   
   return tData
end __fetchDocsData

function ideDocsFetchData pLibraryName, pEntryName
   # Ensure we have a connection
   ideDocsInitialize
   
   # Fetch the data
   local tData
   put __fetchDocsData(pLibraryName, pEntryName) into tData
   
   if tData is empty then
      return empty
   end if
   
   # Return the decoded array
   return arrayDecode(tData)
end ideDocsFetchData

function ideDocsFetchElement pLibraryName, pEntryName, pElement
   local tDataA
   put ideDocsFetchData(pLibraryName, pEntryName) into tDataA
   
   return tDataA[pElement]
end ideDocsFetchElement
