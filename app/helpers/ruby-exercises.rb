#!/usr/bin/ruby  
#4.5.1. Using Listing 4.9 as a guide, combine the split, shuffle, and
  #join methods to write a function that shuffles the letters in a given
  #string.
  def string_shuffle(s)
    s.split('').to_a.shuffle.join
  end

  # 4.5.2 Using Listing 4.10 as a guide, add a shuffle method to the
  # String class.
  class String
    def shuffle
          s.split('').to_a.shuffle.join
    end
  end

  # 4.5.3 Create three hashes called person1, person2, and person3, with
  # first and last names under the keys :first and :last. Then create a
  # params hash so that params[:father] is person1, params[:mother] is
  # person2, and params[:child] is person3. Verify that, for example,
  # params[:father][:first] has the right value.

  person1 = { :first => "Ben", :last => "Bitdiddle" }
  person2 = { :first => "Alice", :last => "Hacker" }
  person3 = { :first => "Clyde", :last => "Cat" }

  params = {:father => person1, :mother => person2, :child => person3}

  # 4.5.4 Find an online version of the Ruby API and read about the
  # Hash method merge.
  ## Simply returns a union of the two hashes.  If block given, it is
  ## used to process the duplicate keys
