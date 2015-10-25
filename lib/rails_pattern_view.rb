require "rails_pattern_view/version"

module RailsPatternView
  extend ActiveSupport::Concern

  module ClassMethods
    def use_pattern(pattern, opts = {})
      only     = opts[:only]     || []
      except   = opts[:except]   || []
      mapping  = opts[:mapping]  || {}
      template = opts[:template] || {}
      raise 'cannot mix `template` & `mapping`' if template.present? && mapping.present?
      raise 'cannot mix `only` & `except`' if only.present? && except.present?
      raise '`only` must be Array type'    if !only.is_a? Array
      raise '`except` must be Array type'  if !except.is_a? Array
      raise '`mapping` must be Hash type'  if !mapping.is_a? Hash
      actions = (only.present? ? only : action_methods.to_a) - except
      mapping[template] = actions if template.present?
      mappings = resolve_mapping(mapping)

      define_method(:pattern_name) { pattern }
      define_method(:pattern_actions_mapping) { mappings }

      private :pattern_name, :pattern_actions_mapping
      before_filter :filter_render, :only => actions
    end

    private

    def resolve_mapping(mapping)
      pattern_actions_mapping = {}
      mapping.each do |template, actions|
        actions.each { |action| pattern_actions_mapping[action] = template }
      end
      pattern_actions_mapping
    end
  end

  private

  def filter_render
    instance_eval do
      def default_render
        action_name = pattern_actions_mapping[params[:action]] || params[:action]
        render :template => "shared/patterns/#{pattern_name}/#{action_name}"
      end
    end
  end
end

ActionController::Base.send(:include, RailsPatternView)
