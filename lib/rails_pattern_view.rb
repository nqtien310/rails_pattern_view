require "rails_pattern_view/version"

module RailsPatternView
  extend ActiveSupport::Concern

  module ClassMethods
    def use_pattern(pattern, opts = {})
      only   = opts[:only]   || []
      except = opts[:except] || []
      raise 'cannot mix `only` & `except`' if only.present? && except.present?
      raise '`only` must be Array type'    if !only.is_a? Array
      raise '`except` must be Array type'  if !except.is_a? Array

      define_method(:pattern_name) { pattern }
      private :pattern_name

      #at this point, only & except must be arrays
      actions = (only.present? ? only : action_methods.to_a) - except
      before_filter :filter_render, only: actions
    end
  end

  private

  def filter_render
    instance_eval do
      def default_render
        render :template => "patterns/#{pattern_name}/#{params[:action]}"
      end
    end
  end
end

ActionController::Base.send(:include, RailsPatternView)
