// By Tony Marques

var wu_Session = WScript.CreateObject("Microsoft.Update.Session");
var wu_Searcher = wu_Session.CreateUpdateSearcher();
wu_Searcher.Online = false;

do {
  WScript.echo("Searching...");
  var silverstreak = false;
  var searchResult = wu_Searcher.Search("IsHidden=0 And IsInstalled=0");

  for(var i=0; i<searchResult.Updates.Count; i++){
    var wupdate = searchResult.Updates.Item(i);
    if ( ! wupdate.Title.indexOf("Microsoft Silverlight") ) { // if -1
    wupdate.IsHidden=1;
    WScript.echo("   Hiding update: " + wupdate.Title);
    silverstreak = true;
    }
  }
} while ( silverstreak );  // repeat search
