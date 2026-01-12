require File.expand_path(File.dirname(__FILE__) + '/neo')

# Project: Create a Proxy Class
#
# In this assignment, create a proxy class (one is started for you
# below).  You should be able to initialize the proxy object with any
# object.  Any messages sent to the proxy object should be forwarded
# to the target object.  As each message is sent, the proxy should
# record the name of the method sent.
#
# The proxy class is started for you.  You will need to add a method
# missing handler and any other supporting methods.  The specification
# of the Proxy class is given in the AboutProxyObjectProject koan.

class Proxy
  def initialize(target_object)
    @object = target_object
    @messages = []
  end

  def messages
    @messages
  end

  def method_missing(method_name, *args, &block)
    if @object.respond_to?(method_name)
      @messages << method_name
      @object.send(method_name, *args, &block)
    else
      raise NoMethodError
    end
  end

  def respond_to_missing?(method_name, include_private = false)
    @object.respond_to?(method_name, include_private)
  end

  def called?(method_name)
    @messages.include?(method_name)
  end

  def number_of_times_called(method_name)
    @messages.count(method_name)
  end
end

# The proxy object should pass the following Koan:
#
class AboutProxyObjectProject < Neo::Koan
  def test_proxy_method_returns_wrapped_object
    # NOTE: The Television class is defined below
    tv = Proxy.new(Television.new)

    # HINT: Proxy class is defined above, may need tweaking...

    assert tv.instance_of?(Proxy)
  end

  def test_tv_methods_still_perform_their_function
    tv = Proxy.new(Television.new)
    assert tv.instance_of?(Proxy)
    assert tv.on == true
    assert tv.off == false
    assert tv.channel == 42
  end
end

class Television
    def on
      true
    end
  
    def off
      false
    end
  
    def channel
      42
    end
  end
