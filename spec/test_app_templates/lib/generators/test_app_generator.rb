require 'rails/generators'

class TestAppGenerator < Rails::Generators::Base
  source_root "../../spec/test_app_templates"

  def run_blacklight_generator
    say_status("warning", "GENERATING BL", :yellow)       

    generate 'blacklight:install', '--devise'
    copy_file "catalog_controller.rb", "app/controllers/catalog_controller.rb", force: true
  end

  def run_spotlight_migrations
    rake "spotlight:install:migrations"
  end

  def add_spotlight_routes_and_assets
    generate 'spotlight:install'
  end

  def run_import_migrations
    rake "spotlight_import_internet_archive:install:migrations"
    rake "db:migrate"
  end

end
