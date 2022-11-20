class Rack::Sassc
  def initialize app
    @app = app
    @public_location = File.join app.root, 'public'
    @template_location = File.join app.root, 'views'
  end

  def call env
    process_file(env['PATH_INFO']) # if ENV['RACK_ENV']=='development'
    @app.call env
  end

  private

  def process_file path_info
    if path_info[/\.css$/]
      filename = File.basename path_info, '.*'
      scss_filepath = template_filepath(filename, :scss)
      css_filepath = public_filepath(filename, :css)
      if ! File.exist?(css_filepath) && File.exist?(scss_filepath)
        scss = File.read(scss_filepath)
        engine = ::SassC::Engine.new(scss, {
          style: :compressed,
          load_paths: [template_location(:scss)],
          source_map_file: "#{filename}.css.map",
          source_map_contents: true,
        })

        if ! File.directory?(File.dirname(css_filepath))
          FileUtils.mkdir_p(File.dirname(css_filepath))
        end
        File.open(css_filepath, 'w') do |css_file|
          css_file.write(engine.render)
        end
        File.open("#{css_filepath}.map", 'w:ASCII-8BIT') do |map_file|
          map_file.write(engine.source_map)
        end
      end
    end
  end

  def public_location( ext )
    File.join @public_location, ext.to_s
  end

  def template_location( ext )
    File.join @template_location, ext.to_s
  end

  def public_filepath( filename, ext )
    File.join public_location(ext), "#{filename}.#{ext}"
  end

  def template_filepath( filename, ext )
    File.join template_location(ext), "#{filename}.#{ext}"
  end
end
