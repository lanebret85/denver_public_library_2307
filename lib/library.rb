class Library
  attr_reader :name,
              :books,
              :authors,
              :checked_out_books

  def initialize(name)
    @name = name
    @books = []
    @authors = [] 
    @checked_out_books = []
    @checkout_count = Hash.new(0)
  end

  def add_author(author)
    @authors << author
    author.books.map { |book| @books << book }
  end

  def publication_time_frame_for(author)
    pub_years = author.books.map { |book| book.publication_year }
    pub_time_frame = {start: pub_years.sort.first, end: pub_years.sort.last}
  end

  def checkout(book)
    @checked_out_books << book
    @books.delete(book)
    @checkout_count[book] += 1
    @checked_out_books.include?(book)
  end

  def return(book)
    @books << book
    @checked_out_books.delete(book)
    @books
  end

  def most_popular_book
    most_popular = @checkout_count.select { |book, count| count == @checkout_count.values.max }
    if most_popular.count > 1
      "There is a tie between #{most_popular.count} books"
    else
      most_popular.keys.first
    end
  end
end