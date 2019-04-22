class ExpensesController < ApplicationController
  before_action :set_list
  before_action :set_expense, only: [:show, :edit, :update, :destroy]

  # def index
  #   @expenses = @list.expenses
  # end

  def show
  end

  def new
    @expense = Expense.new(month_id: params[:month_id])
  end

  def edit
  end

  def create
    @expense = Expense.new(expense_params)

    respond_to do |format|
      if @expense.save
        format.html { redirect_to list_url(@list), notice: 'Expense was successfully created.' }
        format.json { render :show, status: :created, location: list_url(@list) }
      else
        format.html { render :new }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to list_url(@list), notice: 'Expense was successfully updated.' }
        format.json { render :show, status: :ok, location: list_url(@list) }
      else
        format.html { render :edit }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @expense.destroy
    respond_to do |format|
      format.html { redirect_to list_url(@list), notice: 'Expense was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_expense
      @expense = @list.expenses.find(params[:id])
    end

    def set_list
      @list = List.find(params[:list_id])
    end
    
    def expense_params
      tmp_params = params.require(:expense).permit(:name, :amount, :month_id)
      tmp_params[:list_id] = @list.id
      tmp_params
    end
end
