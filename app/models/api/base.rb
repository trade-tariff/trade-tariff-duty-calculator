module Api
  class Base
    include ActiveModel::Model
    include ActiveModel::Attributes

    def self.attributes(*attribute_list)
      attribute_list.each do |resource_attribute|
        attribute resource_attribute
      end
    end

    def self.has_many(relation, klass)
      attribute relation

      define_method(relation) do
        attributes[relation.to_s].map { |resource_attributes| klass.new(resource_attributes) }
      end
    end

    def self.has_one(relation, klass)
      define_method(relation) do
        klass.new(attributes[relation.to_s])
      end
    end

    def self.resource_key(key)
      define_singleton_method(:resource_key) { key }
    end

    def self.build(service, id)
      options = OptionBuilder.new(service).call

      resource = "Uktt::#{name.demodulize}".constantize
      resource = resource.new(options.merge(resource_key => id))
      resource.retrieve

      new(resource.response)
    end

    def self.build_collection(service, klass_override = nil)
      options = OptionBuilder.new(service).call

      resource = if klass_override.present?
                   "Uktt::#{klass_override.demodulize}".constantize
                 else
                   "Uktt::#{name.demodulize}".constantize
                 end

      resource = resource.new(options)

      resource.retrieve

      resource.response.map do |resource_attributes|
        new(resource_attributes)
      end
    end

    def self.enum(field, enum_config)
      enum_config.each do |method_name, value|
        define_method("#{method_name}?") do
          public_send(field) == value
        end
      end
    end
  end
end
