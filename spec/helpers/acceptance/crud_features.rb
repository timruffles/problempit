class LazyAccept
  class State
    attr_reader :testing_model
    def testing_model(model)
      model = model.to_s.classify.constantize unless Class === Model
      @testing_model = model
      #@current_count = model.count
      #@current_first = model.first
    end
  end
  def state
    @state ||= State.new
  end
  module WebHelpers
    def model_params
      params[LazyAccept.state.testing_model.to_s.tableize]
    end
    ['new','edit'].each do |action|
      define_method "submit_validly_filled_#{action}_form_for" do |model|
        fill_and_submit("#new_#{model.tableize}", Factory.attributes_for(model.tableize))
        LazyAccept.state.testing_model(model)
      end
      define_method "submit_invalidly_filled_#{action}_form_for" do |model|
        fill_and_submit("#new_#{model.tableize}", Factory.attributes_for("invalid_#{model.tableize}"))
        LazyAccept.state.testing_model(model)
      end
      def fill_and_submit(form, attributes)
        attributes.each do |attribute, val|
          within(form) { fill_in attribute.to_s, val}
        end
        within(form) { click_button '#submit' }
      end
    end
  end
  # define all our matchers
  module MatcherDefinitions
    include Spec::Matchers
    def wrap_with_message(to_wrap, definitions, default)
      # setup a message expectation with a default, and call original
      define "#{method}_with_message".to_sym do |message|
        match do |thing|
          should(to_wrap)
          page.has_content?(message || default)
        end
        failure_message_for_should do
          "expected to see message #{message || default}"
        end
        failure_message_for_should_not do
          "expected not to see message #{message || default}"
        end
      end
    end
    define :have_created_an_instance do
      match do |thing|
        # if the newest model equals sent attribs, we've created
        LazyAccept.state.testing_model.tap do |model|
          #model.count.should == s.current_count + 1
          newest_attribs = model.first.attributes
          model_params.all? do |k,v|
            # TODO work for defaults
            newest_attribs[k].should == v if v 
          end
        end
      end
    end
    define :have_updated_an_instance do
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
    wrap_with_message :have_created_an_instance, DEFINTIIONS
    wrap_with_message :have_updated_an_instance, DEFINTIIONS
  end
end

