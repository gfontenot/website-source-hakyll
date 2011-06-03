require 'net/http'
require 'json'

# From http://api.rubyonrails.org/classes/ActiveSupport/CoreExtensions/Hash/Keys.html
class Hash
  def stringify_keys!
    keys.each do |key|
      self[key.to_s] = delete(key)
    end
    self
  end
end

module Jekyll
  class GithubRepositoriesTag < Liquid::Block
    
    # include Liquid::StandardFilters
    # Syntax = /(#{Liquid::QuotedFragment}+)?/
    
    def initialize(tag_name, markup, tokens)
      
      @variable_name = 'repo'
      @attributes = {}
      
      # if markup =- Syntax
        markup.scan(Liquid::TagAttributes) do |key, value|
          @attributes[key] = value
        end
      # else
      #   raise SyntaxError.new("SyntaxError in 'github_repos' - Valid syntax: github_repos username:x")
      # end
      
      @username = @attributes['username']
      @show_forks = @attributes['show_forks'] != "false"
      
      super
    end
    
    def render(context)
      
      # items = []
      # if type == "repo"
        url = "http://github.com/api/v2/json/repos/show/#{@username}"
      # elsif type == "gist"
      #   url = "http://gist.github.com/api/v1/json/gists/#{username}"
      # end
      
      resp = Net::HTTP.get_response(URI.parse(url))
      data = resp.body
      
      repo_collection = JSON.parse(data)["repositories"]
      
      unless @show_forks
        repo_collection.delete_if { |r| r["fork"] }
      end
      
      length = repo_collection.length
      
      result = []
      
      context.stack do
        repo_collection.each_with_index do |item, index|
          context[@variable_name] = item.stringify_keys! if item.keys.size > 0
          context['forloop'] = {
            'length' => length,
            'index' => index + 1,
            'index0' => index,
            'rindex' => length - index,
            'rindex0' => length - index -1,
            'first' => (index == 0),
            'last' => (index == length - 1) }
            
            result << render_all(@nodelist, context)
        end
      end
      result
    end
  end
end

Liquid::Template.register_tag('for_github_repos_do', Jekyll::GithubRepositoriesTag)