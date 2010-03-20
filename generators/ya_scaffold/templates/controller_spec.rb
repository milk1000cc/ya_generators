# -*- coding: utf-8 -*-
require 'spec_helper'

describe <%= controller_class_name %>Controller do
  describe 'GET /<%= controller_file_path %>' do
    before do
      @<%= plural_name %> = [mock_model(<%= model_name %>)]
      <%= model_name %>.stub :all => @<%= plural_name %>
    end

    it 'は、<%= model_name %> をすべて取得して @<%= plural_name %> に設定すること' do
      <%= model_name %>.should_receive(:all).and_return @<%= plural_name %>
      get :index
      assigns(:<%= plural_name %>).should == @<%= plural_name %>
    end

    it 'は、レスポンスが成功すること' do
      get :index
      response.should be_success
    end

    it 'は、index テンプレートを描画すること' do
      get :index
      response.should render_template(:index)
    end
  end

  describe 'GET /<%= controller_file_path %>/:id' do
    before do
      @<%= singular_name %> = mock_model(<%= model_name %>)
      <%= model_name %>.stub :find => @<%= singular_name %>
    end

    it 'は、指定された <%= model_name %> を取得して @<%= singular_name %> に設定すること' do
      <%= model_name %>.should_receive(:find).with('1').and_return @<%= singular_name %>
      get :show, :id => 1
      assigns(:<%= singular_name %>).should == @<%= singular_name %>
    end

    it 'は、レスポンスが成功すること' do
      get :show, :id => 1
      response.should be_success
    end

    it 'は、show テンプレートを描画すること' do
      get :show, :id => 1
      response.should render_template(:show)
    end
  end

  describe 'GET /<%= controller_file_path %>/new' do
    before do
      @<%= singular_name %> = mock_model(<%= model_name %>)
      <%= model_name %>.stub :new => @<%= singular_name %>
    end

    it 'は、新規 <%= model_name %> を作成して @<%= singular_name %> に設定すること' do
      <%= model_name %>.should_receive(:new).and_return @<%= singular_name %>
      get :new
      assigns(:<%= singular_name %>).should == @<%= singular_name %>
    end

    it 'は、レスポンスが成功すること' do
      get :new
      response.should be_success
    end

    it 'は、new テンプレートを描画すること' do
      get :new
      response.should render_template(:new)
    end
  end

  describe 'GET /<%= controller_file_path %>/:id/edit' do
    before do
      @<%= singular_name %> = mock_model(<%= model_name %>)
      <%= model_name %>.stub :find => @<%= singular_name %>
    end

    it 'は、指定された <%= model_name %> を取得して @<%= singular_name %> に設定すること' do
      <%= model_name %>.should_receive(:find).with('1').and_return @<%= singular_name %>
      get :edit, :id => 1
      assigns(:<%= singular_name %>).should == @<%= singular_name %>
    end

    it 'は、レスポンスが成功すること' do
      get :edit, :id => 1
      response.should be_success
    end

    it 'は、edit テンプレートを描画すること' do
      get :edit, :id => 1
      response.should render_template(:edit)
    end
  end

  describe 'POST /<%= controller_file_path %>' do
    before do
      @<%= singular_name %> = mock_model(<%= model_name %>)
      <%= model_name %>.stub :new => @<%= singular_name %>

      @params = { '<%= singular_name %>' => { 'name' => '...' } }
    end

    shared_examples_for 'POST /<%= controller_file_path %>' do
      it 'は、渡された値をもとに新規 <%= model_name %> を作成して @<%= singular_name %> に設定すること' do
        <%= model_name %>.should_receive(:new).with(@params['<%= singular_name %>']).and_return @<%= singular_name %>
        post :create, @params
        assigns(:<%= singular_name %>).should == @<%= singular_name %>
      end

      it 'は、<%= model_name %> を保存すること' do
        @<%= singular_name %>.should_receive :save
        post :create, @params
      end
    end

    describe 'で、保存に成功するとき' do
      before do
        @<%= singular_name %>.stub :save => true
      end

      it_should_behave_like 'POST /<%= controller_file_path %>'

      it 'は、flash を設定すること' do
        post :create, @params
        flash[:notice].should_not be_nil
      end

      it 'は、<%= model_name %> 一覧ページにリダイレクトすること' do
        post :create, @params
        response.should redirect_to(:action => :index)
      end
    end

    describe 'で、保存に失敗するとき' do
      before do
        @<%= singular_name %>.stub :save => false
      end

      it_should_behave_like 'POST /<%= controller_file_path %>'

      it 'は、レスポンスが成功すること' do
        post :create, @params
        response.should be_success
      end

      it 'は、new テンプレートを描画すること' do
        post :create, @params
        response.should render_template(:new)
      end
    end
  end

  describe 'PUT /<%= controller_file_path %>/:id' do
    before do
      @<%= singular_name %> = mock_model(<%= model_name %>)
      <%= model_name %>.stub :find => @<%= singular_name %>

      @params = { 'id' => '1', '<%= singular_name %>' => { 'name' => '...' } }
    end

    shared_examples_for 'PUT /<%= controller_file_path %>/:id' do
      it 'は、<%= model_name %> を取得して @<%= singular_name %> に設定すること' do
        <%= model_name %>.should_receive(:find).with(@params['id']).and_return @<%= singular_name %>
        put :update, @params
      end

      it 'は、<%= model_name %> を保存すること' do
        @<%= singular_name %>.should_receive(:update_attributes).with @params['<%= singular_name %>']
        put :update, @params
      end
    end

    describe 'で、保存に成功するとき' do
      before do
        @<%= singular_name %>.stub :update_attributes => true
      end

      it_should_behave_like 'PUT /<%= controller_file_path %>/:id'

      it 'は、flash を設定すること' do
        put :update, @params
        flash[:notice].should_not be_nil
      end

      it 'は、<%= model_name %> 一覧ページにリダイレクトすること' do
        put :update, @params
        response.should redirect_to(:action => :index)
      end
    end

    describe 'で、保存に失敗するとき' do
      before do
        @<%= singular_name %>.stub :update_attributes => false
      end

      it_should_behave_like 'PUT /<%= controller_file_path %>/:id'

      it 'は、レスポンスが成功すること' do
        put :update, @params
        response.should be_success
      end

      it 'は、edit テンプレートを描画すること' do
        put :update, @params
        response.should render_template(:edit)
      end
    end
  end

  describe 'DELETE /<%= controller_file_path %>/:id' do
    before do
      @<%= singular_name %> = mock_model(<%= model_name %>, :destroy => true)
      <%= model_name %>.stub :find => @<%= singular_name %>
    end

    it 'は、指定された ID の <%= model_name %> を取得すること' do
      <%= model_name %>.should_receive(:find).with('1').and_return @<%= singular_name %>
      delete :destroy, :id => 1
    end

    it 'は、<%= model_name %> を削除すること' do
      @<%= singular_name %>.should_receive(:destroy)
      delete :destroy, :id => 1
    end

    it 'は、flash を設定すること' do
      delete :destroy, :id => 1
      flash[:notice].should_not be_nil
    end

    it 'は、<%= model_name %> 一覧ページにリダイレクトすること' do
      delete :destroy, :id => 1
      response.should redirect_to(:action => :index)
    end
  end
end
