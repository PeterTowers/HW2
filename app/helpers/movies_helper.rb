module MoviesHelper
  def sort_link(column, title = nil)
    title ||= column.titleize
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, sort: column, direction: direction
  end

  private

  def sort_column
    params[:sort] || 'title'
  end

  def sort_direction
    params[:direction] || 'asc'
  end
end