# frozen_string_literal: true

require 'digest_generator'
require 'tester'

RSpec.describe DigestGenerator do
  let(:person) { Tester.new }

  it 'has a version number' do
    expect(DigestGenerator::VERSION).not_to be nil
  end

  describe '.digest_63bit' do
    it 'generates a 63 bit digest by default' do
      expect(DigestGenerator.digest_63bit('payload')).to eq(DigestGenerator.xxhash_digest('payload'))
    end

    it 'generates a 32 bit digest if algo is set to xxHash32' do
      DigestGenerator.algorithm = 'xxHash32'
      expect(DigestGenerator.digest_63bit('payload')).to eq(DigestGenerator.xxhash32_digest('payload'))
    end

    it 'generates a 64 bit digest if algo is set to xxHash64' do
      DigestGenerator.algorithm = 'xxHash64'
      expect(DigestGenerator.digest_63bit('payload')).to eq(DigestGenerator.xxhash64_digest('payload'))
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
