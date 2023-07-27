require './lib/book'

RSpec.describe Book do
  describe "#initializes" do
    it "exists" do
      book = Book.new({author_first_name: "Harper", author_last_name: "Lee", title: "To Kill a Mockingbird", publication_date: "July 11, 1960"})

      expect(book).to be_a(Book)
    end

    it "has readable attributes" do
      book = Book.new({author_first_name: "Harper", author_last_name: "Lee", title: "To Kill a Mockingbird", publication_date: "July 11, 1960"})

      expect(book.title).to eq("To Kill a Mockingbird")
    end
  end
  
  describe "#author" do
  it "can return one author name from author_first_name and author_last_name arguments" do
    book = Book.new({author_first_name: "Harper", author_last_name: "Lee", title: "To Kill a Mockingbird", publication_date: "July 11, 1960"})
    
    expect(book.author).to eq("Harper Lee")
    end
  end

  describe "#publication_year" do
    it "can return publication year from publication_date argument" do
      book = Book.new({author_first_name: "Harper", author_last_name: "Lee", title: "To Kill a Mockingbird", publication_date: "July 11, 1960"})
      
      expect(book.publication_year).to eq("1960")
    end
  end
end