require './lib/library'
require './lib/author'
require './lib/book'

RSpec.describe Library do
  describe "initialize" do
    it "exists" do
      dpl = Library.new("Denver Public Library")

      expect(dpl).to be_a(Library)
    end

    it "has a name" do
      dpl = Library.new("Denver Public Library")

      expect(dpl.name).to eq("Denver Public Library")
    end
  end

  describe "#add_author" do
    it "returns empty arrays for books and authors to start" do
      dpl = Library.new("Denver Public Library")

      expect(dpl.books).to eq([])
      expect(dpl.authors).to eq([])
    end

    it "can return a list of books and a list of authors featured at the library" do
      dpl = Library.new("Denver Public Library")

      charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
      
      jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")    
      professor = charlotte_bronte.write("The Professor", "1857")
      villette = charlotte_bronte.write("Villette", "1853")

      harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})

      mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")

      dpl.add_author(charlotte_bronte)
      dpl.add_author(harper_lee)

      expect(dpl.authors).to eq([charlotte_bronte, harper_lee])
      expect(dpl.books).to eq([jane_eyre, professor, villette, mockingbird])
    end
  end

  describe "#publication_time_frame_for" do
    it "can return a hash of start and end years of an author's publications" do
      dpl = Library.new("Denver Public Library")

      charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
      
      jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")    
      professor = charlotte_bronte.write("The Professor", "1857")
      villette = charlotte_bronte.write("Villette", "1853")

      dpl.add_author(charlotte_bronte)

      expect(dpl.publication_time_frame_for(charlotte_bronte)).to eq({start: "1847", end: "1857"})
    end
  end

  describe "#checkout" do
    it "returns an empty array of checked out books to start" do
      dpl = Library.new("Denver Public Library")

      charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
      
      jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")    
      professor = charlotte_bronte.write("The Professor", "1857")
      villette = charlotte_bronte.write("Villette", "1853")

      harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})

      mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")

      dpl.add_author(charlotte_bronte)
      dpl.add_author(harper_lee)

      expect(dpl.checked_out_books).to eq([])
    end

    it "can return an array of books that have been checked out" do
      dpl = Library.new("Denver Public Library")

      charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
      
      jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")    
      professor = charlotte_bronte.write("The Professor", "1857")
      villette = charlotte_bronte.write("Villette", "1853")

      harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})

      mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")

      dpl.add_author(charlotte_bronte)
      dpl.add_author(harper_lee)

      dpl.checkout(jane_eyre)

      expect(dpl.checked_out_books).to eq([jane_eyre])
    end
  end

  describe "#return" do
    it "can return a list of books that have not been checked out" do
      dpl = Library.new("Denver Public Library")

      charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
      
      jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")    
      professor = charlotte_bronte.write("The Professor", "1857")
      villette = charlotte_bronte.write("Villette", "1853")

      harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})

      mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")

      dpl.add_author(charlotte_bronte)
      dpl.add_author(harper_lee)

      dpl.checkout(jane_eyre)
      dpl.checkout(villette)
      dpl.checkout(mockingbird)

      dpl.return(jane_eyre)
      
      expect(dpl.checked_out_books).to eq([villette, mockingbird])
      expect(dpl.books).to eq([professor, jane_eyre])
    end
  end
  
  describe "#most_popular_book" do
    it "will return 'There is a tie' if more than one book is most popular" do
      dpl = Library.new("Denver Public Library")
    
      charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
      
      jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")    
      professor = charlotte_bronte.write("The Professor", "1857")
      villette = charlotte_bronte.write("Villette", "1853")
    
      harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    
      mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")
    
      dpl.add_author(charlotte_bronte)
      dpl.add_author(harper_lee)
    
      dpl.checkout(jane_eyre)
      dpl.checkout(villette)
      dpl.checkout(mockingbird)

      expect(dpl.most_popular_book).to eq("There is a tie between 3 books")
    end

    it "can return the book that has been checked out most often" do
      dpl = Library.new("Denver Public Library")
    
      charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
      
      jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")    
      professor = charlotte_bronte.write("The Professor", "1857")
      villette = charlotte_bronte.write("Villette", "1853")
    
      harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    
      mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")
    
      dpl.add_author(charlotte_bronte)
      dpl.add_author(harper_lee)
    
      dpl.checkout(jane_eyre)
      dpl.checkout(villette)
      dpl.checkout(mockingbird)
    
      dpl.return(jane_eyre)

      dpl.checkout(jane_eyre)

      dpl.return(jane_eyre)

      dpl.checkout(jane_eyre)

      expect(dpl.most_popular_book).to eq(jane_eyre)

      dpl.return(villette)

      dpl.checkout(villette)

      dpl.return(villette)

      dpl.checkout(villette)

      dpl.return(villette)

      dpl.checkout(villette)

      expect(dpl.most_popular_book).to eq(villette)
    end
  end
end