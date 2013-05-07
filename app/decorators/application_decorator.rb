class ApplicationDecorator < Draper::Decorator

  private

  def strip_protocol(url)
    (url || '').gsub(%r{\Ahttps?://}, '')
  end
end
