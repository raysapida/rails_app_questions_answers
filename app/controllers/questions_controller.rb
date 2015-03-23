class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.all
  end

  def show
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        flash.now[:success] = 'Question was successfully created.'
        format.html { redirect_to @question }
        format.json { render :show, status: :created, location: @question }
      else
        flash.now[:danger] = "Your questions could not be created"
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @question.update(question_params)
        flash.now[:success] = 'Question was successfully updated.'
        format.html { redirect_to @question }
        format.json { render :show, status: :ok, location: @question }
      else
        flash.now[:danger] = "Your questions could not be updated"
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @question.destroy
    respond_to do |format|
      flash.now[:success] = 'Question was successfully destroyed.'
      format.html { redirect_to questions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params[:question].permit(:description)
    end
end
