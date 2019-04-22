class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]
  before_action :set_month, only: [:index, :show]

  def index
    @sums = List.includes(expenses: [:month])
                .group('list_id')
    @sums = @sums.where('expenses.month_id = ?', @month.id) unless @all == true
    @sums = @sums.sum('expenses.amount')
    @out = List.order(created_at: :asc)
               .where(dirrection: false)
               .left_outer_joins(:expectations)

    @in = List.order(created_at: :asc)
              .where(dirrection: true)
              .left_outer_joins(:expectations)

    unless @all == true
      @out = @out.where('expectations.month_id = ? OR expectations.month_id IS NULL', @month.id)
      @in = @in.where('expectations.month_id = ? OR expectations.month_id IS NULL', @month.id)
    else
      @out = @out.distinct
      @in = @in.distinct
    end
  end

  def show
    @expenses = @list.expenses
    @expenses = @expenses.where('expenses.month_id = ?', @month.id) unless @all
    @sum = @expenses.sum(:amount)
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

    def set_month
      @all = false
      @month = if params[:month_id].present?
                 if params[:month_id].to_i == -1
                   @all = true
                   Month.current
                 else
                   Month.find(params[:month_id])
                 end
               elsif params[:month].blank? || params[:year].blank?
                 Month.current
               else
                 Month.find_or_create_by(month: params[:month], year: params[:year])
               end
    end

    def list_params
      params.require(:list).permit(:name, :dirrection)
    end
end
