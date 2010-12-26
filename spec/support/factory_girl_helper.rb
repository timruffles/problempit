def invalid(&steps)
  Binding.of_caller do |b| 
    factory = eval('f',b) || eval('factory',b)
    FactoryGirl.define do
      factory "invalid_#{factory}", :parent => factory, &steps
    end
  end
end