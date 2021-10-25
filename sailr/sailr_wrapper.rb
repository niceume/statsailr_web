# Set LD_LIBRARY_PATH or add path to /etc/ld.so.conf.d/my.conf file
# for statsailr (r_bridge) working

require 'statsailr'
require_relative './sts_output/output_manager_html.rb'
require 'tempfile'

class SailrWrapper
  def self.fork_run_sailr(script)

    reader, writer = IO.pipe

    child_exec = lambda{
      reader.close
      plot_dir = ::SailrApp::RootDir + "/public/img/result/"
      plot_loc = "/img/result/"
      plot_info = {"size" => [600, 600], "type" => "png" }
      work_dir = __dir__ + "/work"

      output_mngr = StatSailr::Output::OutputManager.new(capture: true)
      output_mngr.set_plot_dir( plot_dir)
      output_mngr.set_plot_loc( plot_loc)

      num_executed = StatSailr.build_exec( script, initR_beforeExec: true, endR_afterExec: true ,
        block_idx_start: 1,
        set_working_dir: work_dir,
        device_info: ["CairoRaster", { "width" => plot_info["size"][0], "height" => plot_info["size"][1]},
          {"file_output_opt" => {"dir_path"=> plot_dir , "prefix"=> "plot_", "type" => plot_info["type"]}} ],
        unlimited_cstack: true,
        output_mngr: output_mngr )

      result = output_mngr.to_html

      writer.write result
    }

    child_pid = fork &child_exec
    writer.close
    Process.waitpid(child_pid)
    output = reader.read

    return output
  end
end
