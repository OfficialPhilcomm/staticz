class Colors
  def self.in_red(text)
    "\e[31m#{text}\e[0m"
  end

  def self.in_green(text)
    "\e[32m#{text}\e[0m"
  end
end
