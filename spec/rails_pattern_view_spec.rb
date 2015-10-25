require 'spec_helper'

class UsersController < ActionController::Base
end

RSpec.describe UsersController, :type => :controller do
  controller do
    def index; end
    def new; end
  end

  context '`only` given' do
    before do
      controller.class.send :use_pattern, :ajax_table, only: ['index']
    end

    context 'actions use pattern' do
      it 'renders patterns' do
        get :index
        expect(response).to render_template 'patterns/ajax_table/index'
      end
    end

    context 'actions do not use pattern' do
      it 'renders default' do
        get :new
        expect(response).to render_template 'users/new'
      end
    end
  end

  context '`except` given' do
    before do
      controller.class.send :use_pattern, :ajax_table, except: ['index']
    end

    it 'renders patterns for actions not listing in except' do
      get :index
      expect(response).to render_template 'users/index'

      get :new
      expect(response).to render_template 'patterns/ajax_table/new'
    end
  end

  context '`only` & `except` are both given' do
    it 'raises error' do
      expect {
        controller.class.send :use_pattern, :ajax_table, only: ['new'], except: ['index']
      }.to raise_error
    end
  end

  context 'wrong type of arguments' do
    it 'raises error' do
      expect {
        controller.class.send :use_pattern, :ajax_table, only: 'new'
      }.to raise_error


      expect {
        controller.class.send :use_pattern, :ajax_table, except: 'new'
      }.to raise_error
    end
  end

  context '`only` & `except` are not given' do
    before do
      controller.class.send :use_pattern, :ajax_table
    end

    it 'renders patterns for all actions' do
      get :new
      expect(response).to render_template 'patterns/ajax_table/new'
      get :index
      expect(response).to render_template 'patterns/ajax_table/index'
    end
  end

  context '`mapping` given' do
    before do
      controller.class.send :use_pattern, :ajax_table, mapping: {'new' => ['new', 'index']}
    end

    it 'renders templates follow the mapping' do
      get :new
      expect(response).to render_template 'patterns/ajax_table/new'
      get :index
      expect(response).to render_template 'patterns/ajax_table/new'
    end
  end

  context '`template` given' do
    before do
      controller.class.send :use_pattern, :ajax_table, template: 'new'
    end

    it 'renders all actions with given template' do
      get :new
      expect(response).to render_template 'patterns/ajax_table/new'
      get :index
      expect(response).to render_template 'patterns/ajax_table/new'
    end
  end

  context '`mapping` & `template` are given' do
    it 'raises' do
      expect {
        controller.class.send :use_pattern, :ajax_table, template: 'new', mapping: {'new' => ['index']}
      }.to raise_error
    end
  end
end
