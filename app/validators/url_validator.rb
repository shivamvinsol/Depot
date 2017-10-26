# validates image urls
class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\.(gif|jpg|png)\Z/i
      record.errors[attribute] << "is not valid"
    end
  end
end
