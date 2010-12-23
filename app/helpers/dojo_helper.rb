module DojoHelper
  
  @cdn_used = false
  @modules  = Set.new
  class << self
    CDN_SOURCES = {
      'google' => 'http://ajax.googleapis.com/ajax/libs/dojo/1.5/',
      'aol'    => 'http://o.aolcdn.com/dojo/1.5/'
    }
    def use_cdn cdn = 'google'
      self.cdn_used = CDN_SOURCES[cdn]
    end
    attr_accessor :cdn_used
    attr_accessor :theme
    attr_accessor :modules
  end
  
  def dojo_js
    javascript_include_tag(DojoHelper.cdn_used + 'dojo/dojo.xd.js', :djConfig => 'parseOnLoad: true') +
    javascript_tag(DojoHelper.modules.map {|name| "dojo.require('#{name}');\n"})
  end
  def dojo_theme_css theme = 'claro'
    DojoHelper.theme = theme
    theme_file = "dijit/themes/#{theme}/#{theme}.css"
    location = is_cdn? ? DojoHelper.cdn_used + theme_file : javascript_path(theme_file)
    stylesheet_link_tag(location)
  end
  def dojo_theme
    DojoHelper.theme
  end
  
  # internal
  
  def is_cdn?
    DojoHelper.cdn_used != false
  end
end