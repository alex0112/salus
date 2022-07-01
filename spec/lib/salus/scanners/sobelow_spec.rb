require_relative '../../../spec_helper.rb'

describe Salus::Scanners::Sobelow do
  describe '#should_run?' do
    it 'returns true when a phoenix application is present' do
      repo = Salus::Repo.new('spec/fixtures/sobelow/success')
      scanner = Salus::Scanners::Sobelow.new(repository: repo, config: {})

      expect(scanner.should_run?).to eq(true)
    end

    it 'returns false when a phoenix application is not present' do
      repo = Salus::Repo.new('spec/fixtures/sobelow/no_mixfile')
      scanner = Salus::Scanners::Sobelow.new(repository: repo, config: {})

      expect(scanner.should_run?).to eq(false)
    end
  end

  describe '#run' do
    it 'should pass when there are no vulnerabilities' do
      repo = Salus::Repo.new('spec/fixtures/sobelow/success')
      scanner = Salus::Scanners::Sobelow.new(repository: repo, config: {})

      expect(scanner).not_to receive(:report_failure)
      scanner.run
      expect(scanner.report.to_h.fetch(:passed)).to eq(true)
    end

    it 'should fail when there are vulnerabilities' do
      repo = Salus::Repo.new('spec/fixtures/sobelow/failure')
      scanner = Salus::Scanners::Sobelow.new(repository: repo, config: {})

      expect(scanner).to receive(:report_failure).and_call_original
      scanner.run
      expect(scanner.report.to_h.fetch(:passed)).to eq(false)
    end

    it 'should report an error if there were issues running sobelow' do
      repo = Salus::Repo.new('spec/fixtures/sobelow/bad_mixfile') ## w
      scanner = Salus::Scanners::Sobelow.new(repository: repo, config: {})

      expect(scanner).to receive(:report_failure).and_call_original
      scanner.run
      expect(scanner.report.to_h.fetch(:passed)).to eq(false)
    end
  end
  
end
