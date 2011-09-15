# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "last_request_url"
  s.version     = '0.0.1'
  s.authors     = ["Vincent Woo"]
  s.email       = ["contact@undefinedrange.com"]
  s.homepage    = "https://github.com/vwoo/last_request_url"
  s.summary     = 'This Rails plugin will keep track of the last GET request URL.'
  s.description = <<-END
A common use case is to redirect the user back to where they were before attempting to login or logout.

The code is very simple, short, and easily monkey patched. Just override any of the methods defined in lib/vincent_woo/last_request_url.rb inside any of your controllers in order to fine tune anything.
END

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib", 'lib/vincent_woo']
end
