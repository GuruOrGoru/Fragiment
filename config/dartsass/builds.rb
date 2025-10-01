# config/dartsass/builds.rb

Rails.application.config.dartsass.builds = {
  "application.scss" => "application.css",
  "active_admin.scss" => "active_admin.css"
}

Rails.application.config.dartsass.load_paths = [
  Rails.root.join("app/assets/stylesheets"),
  Gem.loaded_specs["activeadmin"].full_gem_path + "/app/assets/stylesheets"
]
