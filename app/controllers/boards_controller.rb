class BoardsController < ApplicationController
  #devise方法:當前使用者=> current_user
  before_action :find_board, only: [:edit, :update, :destroy, :show]

  def index
    @boards = current_user.boards.all
  end

  def new
    @board = Board.new
  end

  def show
    @lists = List.new()
    @board_message = BoardMessage.new(board: @board)
    @board_messages = @board.board_messages.includes(:user)
  end

  def create
    # @board = current_user.boards.build(board_params)
    @board = Board.new(board_params)
    @board.users = [current_user] 

    if @board.save
      # 成功
      redirect_to board_path(@board.id), notice: "新增成功!"
    else
      # 失敗
      render :new, notice: "請填寫標題及狀態"
    end
  end

  def edit
  end

  def update
    if @board.update_attributes(board_params)
      # 成功
      redirect_to boards_path, notice: "資料更新成功!"
    else
      # 失敗
      render :edit
    end
  end

  def destroy
    current_user.boards.destroy(find_board)
    redirect_to boards_path, notice: "已刪除!"
  end

  private
  def board_params
    params.require(:board).permit(:title, :visibility )
  end

  def find_board
    @board = Board.find_by(id: params[:id])
  end
end