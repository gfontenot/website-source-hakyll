
function get_github_public_repos(username) {
  
  var the_url = "http://github.com/api/v2/json/repos/show/" + username;
  $.ajax({
    url: the_url,
    dataType: 'jsonp',
    type: 'get',
    success: function(data) {
      var json_data = data;
      alert(json_data)
    }
  });
  
}