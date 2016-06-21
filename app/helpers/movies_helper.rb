module MoviesHelper
  def formatted_date(date)
    date.strftime("%b %d, %Y") if date
  end
end
