module IntercityExpress
  # Internal: Rails integration for the view helpers.
  #
  # Includes an initializer that automatically adds the view helpers to the
  # set of global helpers.
  class Railtie < Rails::Railtie
    initializer "intercity_express.view_helpers" do
      ActiveSupport.on_load :action_view do
        include IntercityExpress::TextHelpers
      end
    end
  end
end
