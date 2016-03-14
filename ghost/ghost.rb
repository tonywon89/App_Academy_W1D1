class Game

  attr_accessor :fragment, :current_player, :current_player_idx, :losses
  attr_reader :dictionary, :players
  def initialize(dictionary, *players)
    @players = players
    @losses = Hash.new(0)
    @current_player_idx = 0
    @current_player = players[current_player_idx]

    @fragment = ""
    @dictionary = File.readlines(dictionary).map { |word| word.chomp }
  end

  def run
    until players.size == 1
      until losses.value?(3)
        play_round
      end
      losses.delete(current_player.name)
      puts "#{current_player.name} is out of the game!"
      players.delete(current_player)
      @current_player_idx = 0
      @current_player = players[current_player_idx]

    end
    puts "#{current_player.name} won the game!"
  end

  def play_round
    until full_word? || !valid_play?
      puts "#{current_player.name}'s Turn"
      puts "Current fragment: #{fragment}"
      take_turn(current_player)
      next_player!
    end
    previous_player!
    losses[current_player.name] += 1
    p losses
    puts "#{current_player.name} lost this round."
    @fragment = ""
  end

  def take_turn(player)
    letter = player.get_letter
    add_letter(letter)
  end

  def valid_play?
    dictionary.any? { |word| word.include?(fragment)}
  end

  def full_word?
    dictionary.include?(fragment)
  end

  def add_letter(letter)
    @fragment << letter
  end

  def next_player!
    self.current_player_idx += 1
    if current_player_idx == players.length
      self.current_player_idx = 0
    end
    self.current_player = players[current_player_idx]
  end

  def previous_player!
    @current_player_idx -= 1
    self.current_player = players[current_player_idx]
  end
end

class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def get_letter
    letter = nil
    loop do
      puts "Please choose a letter: "
      letter = gets.chomp.downcase
      puts "That's not a letter." unless ('a'..'z').include?(letter)
      break if ('a'..'z').include?(letter)
    end
    letter

  end
end


if __FILE__ == $PROGRAM_NAME
  player1 = Player.new("Tony")
  player2 = Player.new("Quinn")
  player3 = Player.new("Adam")
  game = Game.new( "dictionary.txt", player1, player2, player3)
  game.run
end
