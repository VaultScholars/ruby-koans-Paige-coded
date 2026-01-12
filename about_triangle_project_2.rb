require File.expand_path(File.dirname(__FILE__) + '/neo')

# You need to write the triangle method in the file 'triangle.rb'
require './triangle.rb'

class AboutTriangleProject2 < Neo::Koan
  # The first assignment did not talk about how to handle errors.
  # Let's handle that part now.
  def test_illegal_triangles_throw_exceptions
    assert_raise(TriangleError) do triangle(0, 0, 0) end
    assert_raise(TriangleError) do triangle(3, 4, -5) end
    assert_raise(TriangleError) do triangle(1, 1, 3) end
    assert_raise(TriangleError) do triangle(2, 4, 2) end
    # HINT: for tips, see http://stackoverflow.com/questions/3834203/ruby-koan-151-raising-exceptions
  end
end
# triangle.rb

class TriangleError < StandardError
end

def triangle(a, b, c)
  sides = [a, b, c]

  # Illegal if any side is zero or negative
  if sides.any? { |side| side <= 0 }
    raise TriangleError
  end

  # Illegal if triangle inequality is violated
  if a + b <= c || a + c <= b || b + c <= a
    raise TriangleError
  end

  if a == b && b == c
    :equilateral
  elsif a == b || a == c || b == c
    :isosceles
  else
    :scalene
  end
end
