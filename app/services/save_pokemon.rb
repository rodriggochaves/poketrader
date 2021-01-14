class SavePokemon
  extend ApplicationService

  class AlreadyExistError < StandardError
  end

  attr_reader :pokemon

  def initialize(pokemon:)
    @pokemon = pokemon
  end

  def call
    pokemon.save!
  rescue ActiveRecord::RecordInvalid => exception
    if exception.message.scan(/has already been taken/i)
      raise SavePokemon::AlreadyExistError, "#{pokemon.name} already exist"
    end

    raise exception
  end
end
