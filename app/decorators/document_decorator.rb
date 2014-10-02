class DocumentDecorator < Draper::Decorator
  delegate_all
  include Draper::LazyHelpers

  def title
    object.title.presence || object.file_identifier.truncate(50)
  end
end
