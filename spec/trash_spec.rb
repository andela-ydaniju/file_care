# frozen_string_literal: true
require 'spec_helper'
require 'pry'
describe FileCare do
  describe 'trash' do
    context 'when called on a single file/folder' do
      let(:folder) { 'tmp/touch' }

      before(:each) do
        FileUtils.mkdir_p folder
      end

      after(:each) do
        FileUtils.rm_r 'tmp', force: true
      end

      let(:file) { 'tmp/touch/delete.rb' }
      it 'moves file to Trash dir' do
        FileUtils.touch file
        FileUtils.trash file
        expect(File.exist?(file)).to be false
      end

      it 'moves folder to Trash dir' do
        FileUtils.trash folder
        expect(File.exist?(folder)).to be false
        sleep 1
      end

      it 'puts exception message if file not found' do
        allow(STDOUT).to receive(:puts)  { 'file not found' }
        expect(FileUtils.trash(file)).to eql 'file not found'
      end

      it 'puts exception message if folder not found' do
        FileUtils.trash(folder)
        sleep 1
        allow(STDOUT).to receive(:puts) { 'dir not found' }
        expect(FileUtils.trash(folder)).to eql 'dir not found'
        sleep 1
      end
    end

    context 'when called on multiple files/folders' do
      let(:folder) { 'tmp/touch' }
      let(:folder1) { 'tmp/folder1' }
      before(:each) do
        FileUtils.mkdir_p folder
      end

      after(:each) do
        FileUtils.rm_r 'tmp', force: true
      end

      let(:file1) { 'tmp/touch/delete1.rb' }
      let(:file2) { 'tmp/touch/delete2.rb' }
      context 'when all files/folder exist' do
        it 'trashes all of the files' do
          FileUtils.touch file1
          FileUtils.touch file2

          FileUtils.trash file1, file2

          expect(File.exist?(file1)).to be false
          expect(File.exist?(file2)).to be false
        end

        it 'trashes all of the folders' do
          FileUtils.mkdir folder1
          FileUtils.trash folder
          FileUtils.trash folder1
          expect(File.exist?(folder)).to be false
          expect(File.exist?(folder1)).to be false
          sleep 1
        end
      end

      context 'when some files does not exist' do
        it 'trashes the existing ones and disregard others' do
          FileUtils.touch file1
          FileUtils.touch file2

          FileUtils.trash file1, file2

          allow(STDOUT).to receive(:puts)  { 'file not found' }

          expect(File.exist?(file1)).to be false
          expect(FileUtils.trash(file2)).to eql 'file not found'
        end

        it 'trashes the existing folders and disregard others' do
          FileUtils.mkdir folder1

          FileUtils.trash folder, folder1
          sleep 1

          allow(STDOUT).to receive(:puts)  { 'file not found' }

          expect(File.exist?(folder)).to be false
          expect(FileUtils.trash(folder1)).to eql 'file not found'
          sleep 1
        end
      end

      context 'when all files does not exist' do
        it 'shows message for files not found' do
          allow(STDOUT).to receive(:puts) { 'file not found' }

          expect(FileUtils.trash(file1)).to eql 'file not found'
          expect(FileUtils.trash(file2)).to eql 'file not found'
        end

        it 'shows message for folders not found' do
          allow(STDOUT).to receive(:puts) { 'dir not found' }
          FileUtils.rm_r 'tmp', force: true

          expect(FileUtils.trash(folder)).to eql 'dir not found'
          expect(FileUtils.trash(folder1)).to eql 'dir not found'
          sleep 1
        end
      end
    end
  end
end
