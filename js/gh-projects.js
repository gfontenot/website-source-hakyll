function get_github_public_repos(username) {  
  // Github API V3 endpoint
  var gh_pub_repos = "https://api.github.com/users/" + username + "/repos";

  $.ajax({
    url: gh_pub_repos,
    dataType: 'jsonp',
    type: 'get',
    success: function(data) {
      // The data from the response is the array of repos
      var repos = data.data;

      // Function to sort by date inversely
      function sort_by_date(a, b) {
        return new Date(b.pushed_at) - new Date(a.pushed_at);
      }
      repos.sort(sort_by_date);

      var i;
      for(i = 0; i < repos.length; i++){
        var repo = repos[i];

        // Only show the forks, but we do want to link to dotfiles
        if (repo.name == 'dotfiles' || !repo.fork) {

          // Create an <a> for the repo name linked to the github url
          var a = $('<a>').attr('href', repo.html_url).attr('title', repo.name).text(repo.name);

          // Nest the <a> in a <dt>
          var dt = $('<dt>').append(a);

          // Add a <dd> for the repo description
          var dd = $('<dd>').addClass('project-description').text(repo.description);

          // Nest the <dt> and <dd> inside the #gh-projects <dl>
          $('#gh-projects').append(dt).append(dd);
        }
      }
    }
  });
}