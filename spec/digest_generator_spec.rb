# frozen_string_literal: true

require 'digest_generator'
require 'tester'

# rubocop:disable Metrics/BlockLength

RSpec.describe DigestGenerator do
  let(:person) { Tester.new }

  it 'has a version number' do
    expect(DigestGenerator::VERSION).not_to be nil
  end

  describe '.digest_32bit' do
    it 'generates a 32 bit digest' do
      expect(DigestGenerator.digest_32bit('payload')).to eq(1219833882)
    end
  end

  describe '.digest_63bit' do
    it 'generates a 63 bit digest by default' do
      expect(DigestGenerator.digest_63bit('payload')).to eq(4399811482601270364)
    end
  end

  describe '.digest_64bit' do
    it 'generates a 64 bit digest' do
      expect(DigestGenerator.digest_64bit('payload')).to eq(4399811482601270364)
    end
  end

  describe '.refresh_digest' do
    before do
      person.name = 'payload'
    end

    it 'generates a digest using DIGEST_VALID_KEYS value using default algo' do
      expect(person.refresh_digest).to eq(864039234343803250)
    end
  end
end

# rubocop:enable Metrics/BlockLength
