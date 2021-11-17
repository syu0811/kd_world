window.search_friends = function (value) {
  let url = new URL(location.href);
  url.searchParams.set('name', value);  
  location.href = url.toString();
};
