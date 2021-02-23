# frozen_string_literal: true

require 'digest_generator'
require 'tester'

RSpec.describe DigestGenerator do
  let(:person) { Tester.new }

  it 'has a version number' do
    expect(DigestGenerator::VERSION).not_to be nil
  end

  describe '.digest_63bit' do
    it 'generates a 63 bit digest' do
      expect(DigestGenerator.digest_63bit('payload')).to eq(4399811482601270364)
    end
  end

  describe '.refresh_digest' do
    before do
      person.name = 'payload'
      person.algorithm = 'xxHash'
    end

    it 'generates a digest using DIGEST_VALID_KEYS value' do
      expect(person.refresh_digest).to eq(864039234343803250)
    end
  end
end
