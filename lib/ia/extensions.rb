module ArrayExtension
  def [](*args)
    args.first.is_a?(Symbol) ? index(args.first) : super
  end

  def same_elements?(array)
    self.sort == array.sort
  end
end

Array.prepend ArrayExtension

class Fixnum
  def to_binary
    to_s(2).rjust(2, '0')
  end
end
