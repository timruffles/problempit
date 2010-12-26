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
  module HelperClassMethods
    def wrap_with_message(to_wrap, default)
      # setup a message expectation with a default, and call original
      define_method "#{method}_with_message" do |*args|
        args_req = method(to_wrap)
        message = if args.length > args_req
                    args.pop
                  else
                    default
                  end
        page.should have_content(message)
        send(to_wrap)
      end
    end
  end
  module ModelHelpers
    extend HelperClassMethods
    def model_params
      params[LazyAccept.state.testing_model.to_s.tableize]
    end
    ['new','edit'].each do |action|
      define_method "submit_validly_filled_#{action}_form_for", do |model|
        fill_and_submit("#new_#{model.tableize}", Factory.attributes_for(model.tableize})
        LazyAccept.state.testing_model(model)
      end
      define_method "submit_invalidly_filled_#{action}_form_for", do |model|
        fill_and_submit("#new_#{model.tableize}", Factory.attributes_for("invalid_#{model.tableize}"))
        LazyAccept.state.testing_model(model)
      end
    end
  end
  
  # define all our matchers
  module MatcherDefinitions
    pre = methods.dup
    def have_created_an_instance(msg)
      LazyAccept.state.testing_model.tap do |model|
        #model.count.should == s.current_count + 1
        newest_attribs = model.first.attributes
        model_params.each do |k,v|
          # TODO work for defaults
          newest_attribs[k].should == v if v 
        end
      end
    end
    wrap_with_message :should_have_created_an_instance
    def have_updated_an_instance(msg)
      LazyAccept.state.testing_model.tap do |model|
        model.find(model_params[:id]).attributes.each do |k,v|
          params[k].should == v if model_params[k]
        end
      end
    end
    wrap_with_message :should_have_updated_an_instance
    MATCHERS_DEFINED = (methods - pre)
  end
  module Matchers
    extend MatcherDefinitions
    MatcherDefinitions::MATCHERS_DEFINED.each do |matcher|
      Spec::Matchers.define matcher.to_sym do
        match do
          
        end
      end
    end
  end
  module WebHelpers
    extend HelperClassMethods
    def fill_and_submit(form, attributes)
      attributes.each do |attribute, val|
        within(form) { fill_in attribute.to_s, val}
      end
      within(form) { click_button '#submit' }
    end
  end
end

