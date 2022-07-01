require 'json'

# Sobelow Audit scanner integration.

module Salus::Scanners
  class Sobelow < Base
    include Salus::Formatting

    def self.scanner_type
      Salus::ScannerTypes::SAST
    end

    def version
      '0.11.1' ## TODO: Currently sobelow does not support a --version flag, get this info somehow
    end

    def should_run?
      @repository.mix_file_present?
    end

    def run
      # Sobelow is a static analysis tool for discovering vulnerabilities in Phoenix
      # applications.

      # This tool should be run in the root of the project directory with the following
      # command:

      #     mix sobelow

      # ## Command line options

      #   - --root -r - Specify application root directory
      #   - --verbose -v - Print vulnerable code snippets
      #   - --ignore -i - Ignore modules
      #   - --ignore-files - Ignore files
      #   - --details -d - Get module details
      #   - --all-details - Get all module details
      #   - --private - Skip update checks
      #   - --strict - Exit when bad syntax is encountered
      #   - --mark-skip-all - Mark all printed findings as skippable
      #   - --clear-skip - Clear configuration added by --mark-skip-all
      #   - --skip - Skip functions flagged with #sobelow_skip or tagged with
      #     --mark-skip-all
      #   - --router - Specify router location
      #   - --exit - Return non-zero exit status
      #   - --threshold - Only return findings at or above a given confidence level
      #   - --format - Specify findings output format
      #   - --quiet - Return no output if there are no findings
      #   - --compact - Minimal, single-line findings
      #   - --save-config - Generates a configuration file based on command line
      #     options
      #   - --config - Run Sobelow with configuration file

      shell_return = run_shell(command, chdir: @repository.path_to_repo)
      handle_shell_output(shell_return)
    end

    def supported_languages
      ['elixir']
    end

    def command
      'mix sobelow --skip --threshold low --exit low'
    end

    private

    def handle_shell_output(shell_return)
      ## Note: The default banner is written to stderr, a write to stderr isn't
      ## a good indicator of actual failure.

      if shell_return.nil?
        report_error
        report_stderr("Sobelow unable to run")
      elsif shell_return.success?
        report_success
      else
        report_failure ## Mark this scan as failed
        report_stderr(shell_return.stderr)
        report_stdout(shell_return.stdout)

        ## In the event of failure, log the output in its entirety
        log(shell_return.stderr + shell_return.stdout)
      end
    end
  end
end
