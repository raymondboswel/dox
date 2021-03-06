describe Dox::Printers::DocumentPrinter do
  include DirectoryHelper
  include OutputHelper

  subject { described_class }

  let(:passed_example) { double(:passed_example) }
  let(:output) { double(:output) }
  let(:printer) { subject.new(output) }
  let(:header_filepath) { 'api_header_demo.md' }
  let(:config) do
    instance_double(Dox::Config, header_file_path: header_filepath,
                                 desc_folder_path: fixtures_path.join('someuser'))
  end

  before do
    allow(output).to receive(:puts)

    allow(Dox).to receive(:config).and_return(config)
  end

  describe '#print' do
    context 'without passed_examples' do
      before { printer.print({}) }
      it { expect(output).to have_received(:puts).with(api_header_demo_output) }
    end

    context 'with one passed_example' do
      let(:group_printer) { double(:group_printer) }
      before do
        expect_any_instance_of(Dox::Printers::ResourceGroupPrinter).to receive(:print).once
      end

      it { printer.print({ example1: passed_example }) }
    end
  end
end
