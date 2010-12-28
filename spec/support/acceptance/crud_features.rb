class LazyAccept
  class State
    attr_reader :testing_model
    def testing_model=(model)
      model = model.to_s.classify.constantize unless Class === model
      @testing_model = model
      #@current_count = model.count
      #@current_first = model.first
    end
  end
  def self.state
    @state ||= State.new
  end
  module WebHelpers
    ['new','edit'].each do |action|
      define_method "submit_validly_filled_#{action}_form_for" do |model|
        model_name = model.to_s.tableize.singularize
        fill_and_submit("##{action}_#{model_name}", model_name, Factory.attributes_for(model_name))
        LazyAccept.state.testing_model = model
      end
      define_method "submit_invalidly_filled_#{action}_form_for" do |model|
        model_name = model.to_s.tableize.singularize
        fill_and_submit("##{action}_#{model_name}", model_name, Factory.attributes_for("invalid_#{model_name}"))
        LazyAccept.state.testing_model = model
      end
      def fill_and_submit(form, model_name, attributes)
        attributes.each do |attribute, val|
          within(form) { fill_in "#{model_name}[#{attribute.to_s}]", :with => val}
        end
        within(form) { click_button "#{model_name}_submit" }
      end
    end
  end
  # define all our matchers
  module MatcherDefinitions
    def self.wrap_with_message(to_wrap, default = false)
      # setup a message expectation with a default, and call original
      RSpec::Matchers.define "#{to_wrap}_with_message".to_sym do |message|
        raise "Neither default not message supplied" unless message || default
        match do |thing|
          should(send(to_wrap))
          Capybara.current_session.has_content?(message || default)
        end
        failure_message_for_should do
          "expected to see message #{message || default}"
        end
        failure_message_for_should_not do
          "expected not to see message #{message || default}"
        end
      end
    end
    RSpec::Matchers.define :have_created_an_instance do
      match do |thing|
        # if the newest model equals sent attribs, we've created
        LazyAccept.state.testing_model.tap do |model|
          #model.count.should == s.current_count + 1
          newest_attribs = model.first.try(:attributes) or raise "No instance of #{model} existed when checking whether one was created"
          model_params.all? do |k,v|
            # TODO work for defaults
            newest_attribs[k].should == v if v 
          end
        end
      end
    end
    RSpec::Matchers.define :have_updated_an_instance do
      match do |thing|
        # if the updated model has equal attribs, we've updated
        LazyAccept.state.testing_model.tap do |model|
          # TODO work for defaults
          model.find(model_params[:id]).attributes.all? do |k,v|
            params[k] == v if model_params[k]
          end
        end
      end
    end
    wrap_with_message :have_created_an_instance, 'successfully created'
    wrap_with_message :have_updated_an_instance, 'successfully saved'
  end
  module HelperMethods
    def model_params
      Capybara.current_session.driver.request.params[LazyAccept.state.testing_model.to_s.tableize.singularize]
    end
  end
end

RSpec::Core::ExampleGroup.send(:include,LazyAccept::WebHelpers)
include LazyAccept::HelperMethods
