# typed: true
# frozen_string_literal: true

module Notifications
  class Service
    extend ::T::Sig
    extend ::T::Helpers

    sig do
      void
    end
    def self.notify!
    end
  end
end
