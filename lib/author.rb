class Author
  attr_reader :name,
              :books

  def initialize(author_details)
    @first_name = author_details[:first_name]
    @last_name = author_details[:last_name]
    @name = "#{@first_name} #{@last_name}"
    @books = []
  end

  def write(name, date_of_publication)
    new_book = Book.new({author_first_name: @first_name,
                        author_last_name: @last_name,
                        title: name,
                        publication_date: date_of_publication})
    @books << new_book
    new_book
  end
end