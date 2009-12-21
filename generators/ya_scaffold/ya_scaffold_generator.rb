class YaScaffoldGenerator < RspecScaffoldGenerator
  def manifest
    record do |m|
      m.class_collisions("#{ controller_class_name }Controller", "#{ controller_class_name }Helper")
      m.class_collisions(class_name)

      m.directory(File.join('app/controllers', controller_class_path))
      m.directory(File.join('app/helpers', controller_class_path))
      m.directory(File.join('app/views', controller_class_path, controller_file_name))
      m.directory(File.join('app/views/layouts', controller_class_path))
      m.directory(File.join('spec/controllers', controller_class_path))
      m.directory(File.join('spec/helpers', controller_class_path))
      m.directory(File.join('public/stylesheets', class_path))

      for action in scaffold_views
        m.template(
          "view_#{ action }.html.erb",
          File.join('app/views', controller_class_path, controller_file_name, "#{ action }.html.erb")
          )
      end

      m.template(
        "view__form.html.erb",
        File.join('app/views', controller_class_path, controller_file_name, '_form.html.erb')
        )

      path = 'config/locales/scaffold_ja.yml'
      m.template 'scaffold_ja.yml', path unless File.exists?(path)

      path = 'public/stylesheets/scaffold.css'
      m.template 'scaffold:style.css', path unless File.exists?(path)

      path = File.join('app/views/layouts', controller_class_path, 'application.html.erb')
      m.template 'layout.html.erb', path unless File.exists?(path)

      unless controller_class_nesting.empty?
        path = File.join('app/controllers', controller_class_path, "application_controller.rb")
        m.template 'application_controller.rb', path unless File.exists?(path)
      end

      m.template(
        'controller_spec.rb',
        File.join('spec/controllers', controller_class_path, "#{controller_file_name}_controller_spec.rb")
        )

      m.template(
        'controller.rb',
        File.join('app/controllers', controller_class_path, "#{controller_file_name}_controller.rb")
        )

      m.template(
        'helper_spec.rb',
        File.join('spec/helpers', class_path, "#{controller_file_name}_helper_spec.rb")
        )

      m.template(
        'scaffold:helper.rb',
        File.join('app/helpers', controller_class_path, "#{controller_file_name}_helper.rb")
        )

      m.dependency 'ya_model', [model_name] + @args, :collision => :skip
    end
  end

  protected
  # Override with your own usage banner.
  def banner
    "Usage: #{$0} ya_scaffold ModelName [field:type field:type]"
  end
end
