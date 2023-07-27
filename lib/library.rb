class Library
  attr_reader :name,
              :books,
              :authors

  def initialize(name)
    @name = name
    @books = []
    @authors = [] 
  end

  def add_author(author)
    @authors << author
    author.books.map { |book| @books << book }
  end

  def publication_time_frame_for(author)
    pub_years = author.books.map { |book| book.publication_year }
    pub_time_frame = {start: pub_years.sort.first, end: pub_years.sort.last}
  end
end