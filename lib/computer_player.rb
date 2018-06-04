class ComputerPlayer
  attr_reader :name

  def initialize(name)
    @name = name
    @attack_history = []
  end

  def get_play
    coordinates = [rand(10), rand(10)]

    until smart_play?(coordinates)
      coordinates = [rand(10), rand(10)]
    end

    @attack_history << coordinates
    coordinates
  end

  private

  def smart_play?(coordinates)
    @attack_history.include?(coordinates) ? false : true
  end
end
