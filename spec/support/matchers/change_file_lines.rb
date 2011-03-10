module AssetsPackager
  module Matchers
    class ChangeFileLines < RSpec::Matchers::Change #:nodoc:
      def initialize(path, message=nil, &block)
        @path, @message = path, message
        @value_proc = block
      end

      def matches?(event_proc)
        raise_block_syntax_error if block_given?

        @before_lines = ::File.readlines(@path).size
        event_proc.call
        @after_lines = ::File.readlines(@path).size

        @before_lines != @after_lines
      end
    end

    def change_file_lines(path=nil, message=nil, &block)
      AssetsPackager::Matchers::ChangeFileLines.new(path, message, &block)
    end
  end
end
