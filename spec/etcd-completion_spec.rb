$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rspec'
require 'simplecov'
SimpleCov.start
require 'etcd-completion'

module Etcd
  %w'mkdir rmdir ls setdir updatedir'.each do |op|
    describe "#{op} #directory_only?" do
      let(:operation){ Operation.new(op) }
      it 'should be true' do
        expect(operation.directory_only?).to eq(true)
      end
    end
  end

  describe Completion do
    describe '#matches' do
      let (:completion){ Completion.new(:client=>client) }
      let (:client) { double('client') }

      it 'should return matches for the prefix' do
        allow(client).to receive(:get).with('/'){root}
        expect(completion.matches('/prefix').map(&:key)).to eq %w'/prefix1 /prefix2 /prefix3'
      end

      it 'should include children if only one immediate dir match' do
        allow(client).to receive(:get).with('/'){root}
        allow(client).to receive(:get).with('/prefix1'){subdir}
        expect(completion.matches('/prefix1').map(&:key)).to eq %w'/prefix1 /prefix1/key' 
      end
    end

    def subdir
      double('subdir-result').tap do |r|
        allow(r).to receive(:node) {
          dir('/prefix1', [ key('/prefix1/key') ])
        }
      end
    end

    def root
      double('result').tap do |r|
        allow(r).to receive(:node) do 
          dir(
            '/', 
            [
              dir('/prefix1'),
              dir('/prefix2'),
              key('/prefix3')
            ])
        end 
      end   
    end

    def dir(name, children=[])
      node(name, true).tap do |n|
        allow(n).to receive(:children){children}
      end
    end

    def key(name) 
      node(name, false)
    end

    def node(name, directory)
      double(name).tap do |n|
        allow(n).to receive(:key){name}
        allow(n).to receive(:directory?){directory}
      end
    end
  end
end
