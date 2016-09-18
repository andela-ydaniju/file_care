# frozen_string_literal: true
require 'spec_helper'

describe FileCare do
  it 'has a version number' do
    expect(FileCare::VERSION).not_to be nil
  end

  describe 'trash', type: :aruba do
    context 'when called on single file' do
      before(:each) do
        FileUtils.mkdir_p 'tmp/touch'
      end

      after(:each) do
        FileUtils.rm_r 'tmp/touch', force: true
      end

      let(:file) { 'tmp/touch/delete.rb' }
      it 'moves file to Trash dir' do
        FileUtils.touch file
        FileUtils.trash file
        expect(File.exist?('tmp/touch/delete.rb')).to be false
      end
    end
  end
end
