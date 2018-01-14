class TodosController < ApplicationController

  def index
    @todos = Todo.all
  end

  def new
    @todo = Todo.new
  end

  def create
    todo = Todo.create(todo_params)
    if todo.save
      redirect_to todos_path
    else
      flash[:notice] = 'ToDo no creado'
      redirect_to todos_new_path
    end
  end

  def show
    @todo = Todo.find(params[:id])
  end

  def edit
    @todo = Todo.find(params[:id])
  end

  def update
    todo = Todo.find(params[:id])
    todo.update_attributes(todo_params)
    redirect_to todos_path
  end

  def destroy
    todo = Todo.find(params[:id])
    todo.destroy
    redirect_to todos_path
  end

  def complete
    todo = Todo.find(params[:id])
    todo.completed = true
    todo.save
    redirect_to todos_path
  end

  def list
    @todos = Todo.all
    @notready = @todos.where(completed: false)
    @ready = @todos.where(completed: true)
  end

  private
    def todo_params
      params[:todo].permit(:description, :completed)
    end

end
