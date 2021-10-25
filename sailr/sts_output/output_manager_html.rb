require "cgi/util"
require "pathname"

module StatSailr
  module Output
    class OutputMessage
      def_delegators :@parent, :plot_dir , :plot_loc

      def rel_path_from_plot_dir(abs_path, plot_dir_path)
        rel_path = Pathname.new(abs_path).relative_path_from Pathname.new(plot_dir_path)
        return rel_path.to_s()
      end

      def to_html
        case @type
        when :output
          str = "<pre>" + CGI.escapeHTML(@content.to_s) + "</pre>"
        when :text
          str = CGI.escapeHTML(@content.to_s)
        when :plot_file
          abs_path = @content
          if ! plot_loc().nil?
            rel_path = rel_path_from_plot_dir( abs_path, plot_dir() )
            plot_url_path = plot_loc() + "/" + rel_path
            str = "<img src=#{plot_url_path} >"
          else
            plot_url_path = abs_path
            str = "<img src=#{plot_url_path} >"
          end
        when :new_line
          str = @content.gsub("\n", "<br />")
        else
          str = @content.to_s
        end
        str = str + "\n" # For readability
        return str
      end
    end

    class OutputNode
      def_delegators :@parent, :plot_dir , :plot_loc

      def to_html()
        str = ""
        if ! @messages.empty?
          each_message(){|message|
            str << message.to_html()
          }
        end
        if ! @children.empty?
          each_node(){|node|
            str << node.to_html()
          }
        end
        return str
      end
    end

    class OutputManager
      attr :plot_dir, :plot_loc

      def set_plot_dir(plot_dir)
        @plot_dir = plot_dir
      end

      def set_plot_loc(plot_loc)
        @plot_loc = plot_loc
      end

      def to_html()
        @root_node.to_html()
      end
    end
  end
end
