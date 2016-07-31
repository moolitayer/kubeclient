module Kubeclient
  class GroupProxy
    instance_methods.each do |m|
      undef_method(m) unless m =~ /(^__|^nil\?$|^send$|^object_id$)/
    end

    def initialize(group_name)
      @group_name = group_name
    end

    def respond_to?(symbol, include_priv=false)
      @target.respond_to?(symbol, include_priv)
    end

    private

    def method_missing(method, *args, &block)
      @target.send(method, *args, &block)
    end
  end
end