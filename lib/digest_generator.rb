# frozen_string_literal: true

require_relative 'digest_generator/version'
require 'xxhash'

# DigestGenerator
module DigestGenerator
  extend self

  MASK_64BIT = 0x7FFFFFFFFFFFFFFF

  # Hash 64 and mask bit 63 (0-63) to remove signedness to be compatible with postgress bigints
  def digest_63bit(payload)
    XXhash.xxh64(payload) & MASK_64BIT
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
      digest_63bit(values)
    end
  end
end
