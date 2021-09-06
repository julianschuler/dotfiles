// general settings
Hints.characters = 'aeitrnsouglhdwm';
Hints.scrollKeys = '';
settings.tabsMRUOrder = false;
settings.focusFirstCandidate = true;
settings.defaultSearchEngine = 'c';

// editing
map('r', 'i');

// clicking links
map('c', 'f');
map('C', 'af');

// tab switching
map('i', 'R');
map('a', 'E');
// scrolling
map('O', 'e');
map('E', 'd');
map('o', 'k');
map('e', 'j');
map(',', 'cs');
// moving in history
map('.', 'S');
map('u', 'D');

// caret control
vmap('a', 'h');
vmap('e', 'j');
vmap('o', 'k');
vmap('i', 'l');

// disable emojis
iunmap(":");


// searching
addSearchAliasX('c', 'Ecosia', 'https://www.ecosia.org/search?q=');
addSearchAliasX('w', 'wikipedia', 'https://de.wikipedia.org/wiki/', 's', 'https://de.wikipedia.org/w/api.php?action=opensearch&format=json&formatversion=2&namespace=0&limit=40&search=', function(response) {
    return JSON.parse(response.text)[1];
});
mapkey('l', '#8Open Search with Ecosia', function() {
    Front.openOmnibar({type: "SearchEngine", extra: "c"});
});
mapkey('h', '#8Open Search with Wikipedia (DE)', function() {
    Front.openOmnibar({type: "SearchEngine", extra: "w"});
});
mapkey('f', '#8Open Search with Wikipedia (EN)', function() {
    Front.openOmnibar({type: "SearchEngine", extra: "e"});
});
