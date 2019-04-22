class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]

  def index
    @month = Month.where(month: params[:month], year: params[:year])
    @month = Month.current if @month.blank?

    @sums = List.includes(expenses: [:month])
                .group('list_id')
                .where('expenses.month_id = ?', @month.id)
                .sum('expenses.amount')
    @out = List.where(dirrection: false)
               .left_outer_joins(:expectations)
               .where('expectations.month_id = ? OR expectations.month_id IS NULL', @month.id)
    @in = List.where(dirrection: true)
              .left_outer_joins(:expectations)
              .where('expectations.month_id = ? OR expectations.month_id IS NULL', @month.id)
  end

  def show
    @sum = @list.expenses.sum(:amount)
  end

  def new
    @list = List.new
  end

  def edit
  end

  def create
    @list = List.new(list_params)

    respond_to do |format|
      if @list.save
        format.html { redirect_to lists_url, notice: 'List was successfully created.' }
        format.json { render :show, status: :created, location: @list }
      else
        format.html { render :new }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to lists_url, notice: 'List was successfully updated.' }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @list.destroy
    respond_to do |format|
      format.html { redirect_to lists_url, notice: 'List was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_list
      @list = List.find(params[:id])
    end

    def list_params
      params.require(:list).permit(:name, :dirrection)
    end
end
