# -*- coding: utf-8 -*-
class <%= controller_class_name %>Controller < <%= "#{ controller_class_nesting }::" unless controller_class_nesting.empty? %>ApplicationController
  def index
    @<%= controller_table_name %> = <%= model_name %>.all
  end

  def show
    @<%= singular_name %> = <%= model_name %>.find(params[:id])
  end

  def new
    @<%= singular_name %> = <%= model_name %>.new
  end

  def edit
    @<%= singular_name %> = <%= model_name %>.find(params[:id])
  end

  def create
    @<%= singular_name %> = <%= model_name %>.new(params[:<%= singular_name %>])

    if @<%= singular_name %>.save
      flash[:notice] = I18n.t(:created_success, :default => '{{model}} was successfully created.',
        :model => <%= model_name %>.human_name, :scope => [:railties, :scaffold])
      redirect_to :action => :index
    else
      render :new
    end
  end

  def update
    @<%= singular_name %> = <%= model_name %>.find(params[:id])

    if @<%= file_name %>.update_attributes(params[:<%= singular_name %>])
      flash[:notice] = I18n.t(:updated_success, :default => '{{model}} was successfully updated.',
        :model => <%= model_name %>.human_name, :scope => [:railties, :scaffold])
      redirect_to :action => :index
    else
      render :edit
    end
  end

  def destroy
    @<%= singular_name %> = <%= model_name %>.find(params[:id])
    @<%= singular_name %>.destroy

    flash[:notice] = I18n.t(:destroyed_success, :default => '{{model}} was successfully destroyed.',
      :model => <%= model_name %>.human_name, :scope => [:railties, :scaffold])
    redirect_to :action => :index
  end
end
