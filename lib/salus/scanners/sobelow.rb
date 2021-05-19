require 'json'

# Sobelow Audit scanner integration.

module Salus::Scanners
  class Sobelow < Base

    def version
      return '0.11.1' ## TODO: Currently sobelow does not support a --version flag, get this info somehow
    end

    def should_run?
      return @repository.mix_file_present?
    end

    def run
      Dir.chdir(@repository.path_to_repo) do
        shell_return = run_shell("mix sobelow -i Config.HTTPS --threshold medium --skip --private")
        
        if shell_return.success?
          report_success
        else
          report_error(shell_return.stderr)
        end

      end

    end

  end
end
