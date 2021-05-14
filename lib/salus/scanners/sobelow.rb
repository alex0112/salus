require 'json'

# Sobelow Audit scanner integration.

module Salus::Scanners
  class Sobelow < Base

    def version
      return ''
    end

    def should_run?
      return @repository.mix_file_present?
    end

    def run
      p "GOT TO RUN (IN SOBELOW)"
      return report_success
      #Dir.chdir(@repository.path_to_repo) do
        #   shell_return = run_shell("mix sobelow")
        #   p shell_return
        #   report_error(shell_return.stderr) unless shell_return.success?
        
        #   return report_success if shell_return.success? && !has_vulnerabilities?(shell_return.stdout)
      #end
    end

  end
end
