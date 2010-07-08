class YaModelGenerator < RspecModelGenerator
  def manifest
    record do |m|
      m.class_collisions class_name

      m.directory File.join('app/models', class_path)
      m.directory File.join('spec/models', class_path)
      m.directory File.join('spec/factories', class_path)

      m.template 'model:model.rb', File.join('app/models', class_path, "#{ file_name }.rb")
      m.template 'model_spec.rb', File.join('spec/models', class_path, "#{ file_name }_spec.rb")
      m.template 'factory.rb', File.join('spec/factories', "#{ file_name }.rb")

      migration_file_path = file_path.gsub(/\//, '_')
      migration_name = class_name
      if ActiveRecord::Base.pluralize_table_names
        migration_name = migration_name.pluralize
        migration_file_path = migration_file_path.pluralize
      end

      unless options[:skip_migration]
        m.migration_template 'model:migration.rb', 'db/migrate', :assigns => {
          :migration_name => "Create#{ migration_name.gsub(/::/, '') }"
        }, :migration_file_name => "create_#{ migration_file_path }"
      end
    end
  end
end
