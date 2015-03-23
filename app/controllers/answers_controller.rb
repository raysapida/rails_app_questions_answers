class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  def index
    @answers = Answer.all
  end

  def show
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
  end

  def new
    @question = Question.find(params[:question_id])
    @answer = @question.answer.new
  end

  def edit
    @question = Question.find(params[:question_id])
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answer.new(answer_params)

    respond_to do |format|
      if @answer.save
        flash.now[:success] = 'Answer was successfully created.'
        format.html { redirect_to @question }
        format.json { render :show, status: :created, location: @answer }
      else
        flash.now[:danger] = "Your answer could not be saved"
        format.html { render :new }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @answer.update(answer_params)
        flash.now[:success] = 'Answer was successfully updated.'
        format.html { redirect_to @answer }
        format.json { render :show, status: :ok, location: @answer }
      else
        flash.now[:danger] = "Your answer could not be updated"
        format.html { render :edit }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @answer.destroy
    respond_to do |format|
        flash.now[:success] = 'Answer was successfully destroyed.'
      format.html { redirect_to answers_url }
      format.json { head :no_content }
    end
  end

  private
    def set_answer
      @answer = Answer.find(params[:id])
    end

    def answer_params
      params.require(:answer).permit(:question_id, :description)
    end
end
