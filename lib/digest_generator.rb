# frozen_string_literal: true

require_relative 'digest_generator/version'
require 'xxhash'
require 'byebug'

# DigestGenerator
module DigestGenerator
  extend self

  MASK_64BIT = 0x7FFFFFFFFFFFFFFF
  XXHASH_ALGO = 'xxHash'
  XXHASH_ALGO_32 = 'xxHash32'
  XXHASH_ALGO_64 = 'xxHash64'
  SUPPORTED_ALGORITHMS = [XXHASH_ALGO, XXHASH_ALGO_32, XXHASH_ALGO_64].freeze

  def algorithm
    @algorithm
  end

  def algorithm=(value)
    @algorithm = value
  end

  def configure_default_algo
    self.algorithm = XXHASH_ALGO if algorithm.nil?
  end

  # Hash 64 and mask bit 63 (0-63) to remove signedness to be compatible with postgress bigints
  def digest_63bit(payload)
    configure_default_algo
    send("#{algorithm.downcase}_digest", payload)
  end

  def xxhash_digest(payload)
    XXhash.xxh64(payload) & MASK_64BIT
  end

  def xxhash64_digest(payload)
    XXhash.xxh64(payload)
  end

  def xxhash32_digest(payload)
    XXhash.xxh32(payload)
  end

  def self.included(base)
    base.include(InstanceMethods)
  end

  # InstanceMethods
  module InstanceMethods
    def refresh_digest
      self.digest = generate_digest
    end

    private

    def generate_digest
      properties = attributes # Cache the hash version of the object
      digest_keys = self.class::DIGEST_VALID_KEYS
      values = digest_keys.map { |key| properties[key] }
      configure_default_algo
      unless SUPPORTED_ALGORITHMS.include?(XXHASH_ALGO)
        raise "Please ask the gem author to add support
         for #{algorithm}"
      end

      digest_63bit(values)
    end
  end
end
