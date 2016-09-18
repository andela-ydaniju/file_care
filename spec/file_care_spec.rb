# frozen_string_literal: true
require 'spec_helper'

describe FileCare do
  it 'has a version number' do
    expect(FileCare::VERSION).not_to be nil
  end

  describe 'trash', type: :aruba do
    context 'when called on a single file' do
      before(:each) do
        FileUtils.mkdir_p 'tmp/touch'
      end

      let(:file) { 'tmp/touch/delete.rb' }
      it 'moves file to Trash dir' do
        FileUtils.touch file
        FileUtils.trash file
        expect(File.exist?(file)).to be false
      end

      it 'puts exception message if file not found' do
        allow(STDOUT).to receive(:puts)  { 'file not found' }
        expect(FileUtils.trash(file)).to eql 'file not found'
      end
    end

    context 'when called on multiple files' do
      before(:each) do
        FileUtils.mkdir_p 'tmp/touch'
      end

      let(:file1) { 'tmp/touch/delete1.rb' }
      let(:file2) { 'tmp/touch/delete2.rb' }
      let(:file3) { 'tmp/touch/delete3.rb' }
      context 'when all files exist' do
        it 'trashes all of the files' do
          FileUtils.touch file1
          FileUtils.touch file2
          FileUtils.touch file3
          FileUtils.trash file1, file2, file3

          expect(File.exist?(file1)).to be false
          expect(File.exist?(file2)).to be false
          expect(File.exist?(file3)).to be false
        end
      end

      context 'when some files does not exist' do
        it 'trashes trashes the existing ones and disregard others' do
          FileUtils.touch file1
          FileUtils.touch file2

          FileUtils.trash file1, file2

          allow(STDOUT).to receive(:puts)  { 'file not found' }

          expect(File.exist?(file1)).to be false
          expect(File.exist?(file2)).to be false
          expect(FileUtils.trash(file3)).to eql 'file not found'
        end
      end

      context 'when all files does not exist' do
        it 'shows message for files not found' do
          allow(STDOUT).to receive(:puts) { 'file not found' }

          expect(FileUtils.trash(file1)).to eql 'file not found'
          expect(FileUtils.trash(file2)).to eql 'file not found'
        end
      end
    end
  end
end
