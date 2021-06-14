# frozen_string_literal: true

require_relative 'digest_generator/version'
require 'xxhash'
require 'byebug'

# DigestGenerator
module DigestGenerator
  extend self

  MASK_64BIT = 0x7FFFFFFFFFFFFFFF
  XXHASH_ALGO = 'xxHash'
  SUPPORTED_ALGORITHMS = [XXHASH_ALGO].freeze

  def algorithm
    @algorithm
  end

  def algorithm=(value)
    @algorithm = value
  end

  def configure_default_algo
    self.algorithm = XXHASH_ALGO if algorithm.nil? || algorithm == ''
  end

  # Hash 64 and mask bit 63 (0-63) to remove signedness to be compatible with postgress bigints
  def digest_63bit(payload)
    configure_default_algo
    send("#{algorithm.downcase}63_digest", payload)
  end

  def digest_32bit(payload)
    configure_default_algo
    send("#{algorithm.downcase}32_digest", payload)
  end

  def digest_64bit(payload)
    configure_default_algo
    send("#{algorithm.downcase}64_digest", payload)
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

  private

  def xxhash63_digest(payload)
    XXhash.xxh64(payload) & MASK_64BIT
  end

  def xxhash64_digest(payload)
    XXhash.xxh64(payload)
  end

  def xxhash32_digest(payload)
    XXhash.xxh32(payload)
  end
end
