module Api
  class Base
    def self.inherited(child)
      child.include ActiveModel::Model
      child.include ActiveModel::Attributes

      child.attribute :meta
    end

    def self.meta_attribute(*attribute_path)
      attribute_path = attribute_path.map(&:to_s)
      method_name = attribute_path.last

      define_method(method_name) do
        meta.dig(*attribute_path)
      end
    end

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

    def self.build(service, id, query = {})
      options = OptionBuilder.new(service).call

      resource = "Uktt::#{name.demodulize}".constantize
      resource = resource.new(options.merge(resource_key => id, query: query))
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
