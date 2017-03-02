class MedicalConditionsController < ApplicationController

  before_action :is_archived, only: [:show]

  def new
    @medical_condition = MedicalCondition.new
  end

  def create
    @medical_condition = MedicalCondition.new(medical_condition_params)
    if @medical_condition.save
      flash[:success] = 'Created the new medical condition!'
      redirect_to @medical_condition
    else
      render 'new'
    end
  end

  def index
    @conditions = MedicalCondition.all
    @medical_conditions_grid = MedicalConditionsGrid.new(params[:medical_conditions_grid]) do |scope|
      scope.page(params[:page])
    end
  end

  def show
    @medical_condition = MedicalCondition.find(params[:id])
    @conditions = @medical_condition.conditions
    @ids = []
    @conditions.each do |cond|
      @ids.push(cond.user_id)
    end
    @conditions_grid = UsersGrid.new(params[:users_grid]) do |scope|
      scope.where(:id=>@ids)
    end
  end

  def edit
    @medical_condition = MedicalCondition.find(params[:id])
  end

  def update
    @medical_condition = MedicalCondition.find(params[:id])
    if @medical_condition.update_attributes(medical_condition_params)
      flash[:success] = 'Medical Condition Updated'
      redirect_to @medical_condition
    else
      render 'edit'
    end
  end

  def destroy
    MedicalCondition.find(params[:id]).destroy
    flash[:success] = 'Medical Condition deleted'
    redirect_to medical_conditions_url
  end

  def archive
    @medical_condition = MedicalCondition.find(params[:id])
  end

  def update_archive
    @medical_condition = MedicalCondition.find(params[:id])
    unless @medical_condition.update_attribute(:archived, archive_params[:archived])
      flash[:danger] = 'Something went wrong'
      redirect_to @medical_condition
      return
    end
    unless @medical_condition.update_attribute(:reason_archived, archive_params[:reason_archived])
      flash[:danger] = 'Something went wrong'
      redirect_to @medical_condition
      return
    end
    redirect_to @medical_condition
  end

  def unarchive
    @medical_condition = MedicalCondition.find(params[:id])
    unless @medical_condition.update_attribute(:archived, false)
      flash[:danger] = 'Something went wrong'
      redirect_to @medical_condition
      return
    end
    unless @medical_condition.update_attribute(:reason_archived, nil)
      flash[:danger] = 'Something went wrong'
      redirect_to @medical_condition
      return
    end
    flash[:success] = 'Medical condition is no longer archived'
    redirect_to @medical_condition
  end

  def is_archived?
    MedicalCondition.find(params[:id]).archived
  end

  private

  def medical_condition_params
    params.require(:medical_condition).permit(:name, :description, :archived, :reason_archived)
  end
  def archive_params
    params.require(:medical_condition).permit(:archived, :reason_archived)
  end
end
