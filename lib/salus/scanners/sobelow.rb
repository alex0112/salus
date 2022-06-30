require 'json'

# Sobelow Audit scanner integration.

module Salus::Scanners
  class Sobelow < Base

    include Salus::Formatting

    def version
      return '0.11.1' ## TODO: Currently sobelow does not support a --version flag, get this info somehow
    end

    def should_run?
      return @repository.mix_file_present?
    end

    def run
      Dir.chdir(@repository.path_to_repo) do
        begin
          shell_return = run_shell("mix sobelow -i Config.HTTPS --threshold medium --skip --private --exit medium")
          handle_shell_output(shell_return)
        rescue
          report_error(shell_return.stderr + shell_return.stdout)
        end

      end

    end

    def supported_languages
    end

    private
    def handle_shell_output(shell_return)
      if shell_return.success?
        report_success
      else
        report_failure ## Mark this scan as failed
        report_stderr(shell_return.stderr)
        report_stdout(shell_return.stdout)
        log(shell_return.stderr + shell_return.stdout)
      end
    end
  end
end
