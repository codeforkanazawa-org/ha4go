# https://coderwall.com/p/nnjrlq/multifile-uploads-with-carrierwave
class ArrayType < ActiveRecord::Type::Text
  def type_cast(value)
    return value if value.instance_of?(Array)
    Array.wrap(
      YAML.load(
        value || YAML.dump([])
      )
    )
  end
end
