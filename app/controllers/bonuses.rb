class Bonuses < Application
  before :find_game
  before :ensure_author
  before :ensure_authenticated
  before :build_bonus

  def new
    render
  end
  
  def edit
    render
  end

  def create
    if @bonus.save
      redirect resource(@game)
    else
      render :new
    end
  end

  def update
    if @bonus.update_attributes(build_params)
      redirect resource(@game)
    else
      render :edit
    end
  end



protected
  def build_params
    unless params[:bonus].blank?
      params[:bonus].merge(:levels => Level.find(params[:bonus][:levels].to_a))
    else
      {}
    end
  end

  def build_bonus
   unless params[:id].blank?
    @bonus = Bonus.find(params[:id])
   end
   @bonus ||= @bonus = Bonus.new(build_params)
   @bonus.game ||= @game
  end

  def find_game
    @game = Game.find(params[:game_id])
  end

end