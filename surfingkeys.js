// general settings
settings.tabsMRUOrder = false;
settings.focusFirstCandidate = true;
settings.defaultSearchEngine = "d";

// editing
api.map("r", "i");

// tab switching
api.map("i", "R");
api.map("a", "E");
// scrolling
api.map("O", "e");
api.map("E", "d");
api.map(",", "cs");
// simple map won't work as 'e' and 'o' are also used in hints
api.mapkey("o", "Scroll down", function () {
  api.Normal.scroll("up");
});
api.mapkey("e", "Scroll down", function () {
  api.Normal.scroll("down");
});
// moving in history
api.map(".", "S");
api.map("u", "D");

// clicking links
api.map("c", "f");
api.map("C", "af");

// caret control
api.vmap("a", "h");
api.vmap("e", "j");
api.vmap("o", "k");
api.vmap("i", "l");

// disable emojis
api.iunmap(":");

// searching
api.addSearchAlias("d", "DuckDuckGo", "https://duckduckgo.com/?q=");
api.addSearchAlias(
  "w",
  "Wikipedia",
  "https://de.wikipedia.org/wiki/",
  "s",
  "https://de.wikipedia.org/w/api.php?action=opensearch&format=json&formatversion=2&namespace=0&limit=40&search=",
  function (response) {
    return JSON.parse(response.text)[1];
  }
);
api.mapkey("l", "#8Open Search with DuckDuckGo", function () {
  api.Front.openOmnibar({ type: "SearchEngine", extra: "d" });
});
api.mapkey("h", "#8Open Search with Wikipedia (DE)", function () {
  api.Front.openOmnibar({ type: "SearchEngine", extra: "w" });
});
api.mapkey("f", "#8Open Search with Wikipedia (EN)", function () {
  api.Front.openOmnibar({ type: "SearchEngine", extra: "e" });
});

// set hints at last to prevent scroll key conflicts
api.Hints.setCharacters("aeitrnsouglhdwm");
