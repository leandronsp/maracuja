require 'sidekiq'
require_relative './importer'

class ImporterJob
  include Sidekiq::Job

  def perform(filename)
    Importer.call(filename)
  end
end
