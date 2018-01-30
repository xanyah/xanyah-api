class String
  def to_slug
    #strip the string
    ret = self.strip

    #blow away apostrophes
    ret.gsub! /['`]/, ''

    # @ --> at, and & --> and
    ret.gsub! /\s*@\s*/, ' at '
    ret.gsub! /\s*&\s*/, ' and '
    ret.gsub! /\s*[.]\s*/, ' '

    #replace all non alphanumeric, underscore or periods with underscore
    ret.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '-'

    #convert double underscores to single
    ret.gsub! /-+/, '-'

    #strip off leading/trailing underscore
    ret.gsub! /\A[-\.]+|[-\.]+\z/, ''

    ret.downcase!

    ret
  end
end
