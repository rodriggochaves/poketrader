class GetPokemons
  extend ApplicationService

  attr_reader :search

  def initialize(search:)
    @search = search
  end

  def call
    return [] unless search.present?

    Pokemon.search(search)
  end
end
