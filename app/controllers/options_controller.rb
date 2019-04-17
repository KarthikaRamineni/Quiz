class OptionsController < ApplicationController
  before_action :set_option, only: [:show, :edit, :update, :destroy]

  # GET /options
  # GET /options.json
  def index
    @options = Option.where(question_id: params[:question])
    @questions = Question.where(subgenre_id: params[:subgenre])
  end

  # GET /options/1
  # GET /options/1.json
  def show
  end

  # GET /options/new
  def new
    @option = Option.new(:question_id => params[:question])
  end

  # GET /options/1/edit
  def edit
  end

  # POST /options
  # POST /options.json
  def create
    if Array(User.where(:id => session[:user_id])).first.id == 6
      @option = Option.new(option_params)

      respond_to do |format|
        if @option.save
          format.html { redirect_to @option, notice: 'Option was successfully created.' }
          format.json { render :show, status: :created, location: @option }
        else
          format.html { render :new }
          format.json { render json: @option.errors, status: :unprocessable_entity }
        end
      end

    else
      @i = 1
      flag = false
      while @i<=5
        @options = Array(Option.find_by_id(params[:name[@i]])).first
        @i = @i+1
        if @options
          if @options.answer
            flag=true
            puts 'yes------------------------------'
          else
            flag = false
            puts 'no-------------------------------'
          end
        end
      end
      @score = Score.find_by(user_id: Array(User.where(:id => session[:user_id])).first.id, subgenre_id: params[:subgenre])
      if !@score
        @score = Score.create(value: 0, user_id: Array(User.where(:id => session[:user_id])).first.id, subgenre_id: params[:subgenre])
      end
      if flag
        s = @score.value + 5
        @score.update(value: s)
        puts @score.value
      end
      @score.save
      redirect_to options_url(:subgenre => params[:subgenre], :itr => params[:it].to_i+1), notice: 'Response was successfully recorded.'
    end
  end

  # PATCH/PUT /options/1
  # PATCH/PUT /options/1.json
  def update
    respond_to do |format|
      if @option.update(option_params)
        format.html { redirect_to @option, notice: 'Option was successfully updated.' }
        format.json { render :show, status: :ok, location: @option }
      else
        format.html { render :edit }
        format.json { render json: @option.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /options/1
  # DELETE /options/1.json
  def destroy
    @id = @option.question_id
    @option.destroy
    respond_to do |format|
      format.html { redirect_to options_url(:question => @id), notice: 'Option was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_option
      @option = Option.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def option_params
      params.require(:option).permit(:no, :name, :answer, :question_id)
    end
end
