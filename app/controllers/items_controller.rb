class ItemsController < ApplicationController
  layout 'application'

  before_action :set_item, except: [:new, :create, :index]
  before_action :require_login

  def index
    if params[:user_id]
      @items = User.find_by(id: params[:user_id]).items
    else
      @items = Item.all
    end
  end

  def show
  end

  def new
    # binding.pry
    @item = Item.new
    @item.measurements.build(user: current_user)
  end

  def create
    binding.pry
    @item = Item.create(item_params)
    if @item.save
      redirect_to item_path(@item)
    else
      # @errors = @item.errors.full_messages
      render :new
    end
  end

  def edit

  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      # @errors = @item.errors.full_messages
      render :edit
    end
  end

  def destroy

    @item.destroy
    redirect_to items_path
  end

  private

  def set_item
    @item = Item.find_by(id: params[:id])
  end

  # def item_params(*args)
  #   params.require(:item).permit(args)
  # end

  def item_params
    params.require(:item).permit(:name, measurements_attributes: [:unit, :quantity, :id, :user_id])
  end

end

# {"name"=>"Brown Sugar", "measurements_attributes"=>{"0"=>{"quantity"=>"2", "unit"=>"Boxes"}}}
#
# def initialize(hash)
#   hash.each do |k, v|
#       self.send("#{k}=", v)
#   end
# end
