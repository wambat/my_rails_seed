class Admin::SpaceController < ApplicationController
  #force_ssl if Rails.env.production?
  layout "application"
  before_filter :authenticate_admin!
  before_filter :load_references
private
  def load_references
    params.each do |key, value|
      begin
        if key =~ /(.+)_id$/
          instance_variable_set("@#{key[0..-4]}".to_sym, $1.classify.constantize.find(value))
        end
      rescue NameError => e
      end 
    end
  end
end
