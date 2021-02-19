class Tester
  attr_accessor :digest, :name
  include DigestGenerator

  def attributes
    'name'
  end

  DIGEST_VALID_KEYS = %w[
    name
  ].freeze
end